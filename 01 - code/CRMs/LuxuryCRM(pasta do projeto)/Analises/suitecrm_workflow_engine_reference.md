# SuiteCRM Workflow Engine (AOW_WorkFlow) - Technical Reference

> Reverse-engineered from the SuiteCRM open-source codebase at
> https://github.com/salesagility/SuiteCRM (master branch).
> Intended as a specification for reimplementation in TypeScript/NestJS.

---

## 1. Architecture Overview

The workflow engine consists of four tightly coupled modules and a scheduler function:

| Module | DB Table | Purpose |
|---|---|---|
| `AOW_WorkFlow` | `aow_workflow` | Workflow definitions (target module, trigger mode, status) |
| `AOW_Conditions` | `aow_conditions` | Per-workflow condition rows (field, operator, value, order) |
| `AOW_Actions` | `aow_actions` | Per-workflow action rows (action type, order, serialized params) |
| `AOW_Processed` | `aow_processed` | Execution log -- one row per (workflow, record) pair |

Relationships:
- `aow_workflow` 1--N `aow_conditions`
- `aow_workflow` 1--N `aow_actions`
- `aow_workflow` 1--N `aow_processed`
- `aow_processed` N--N `aow_actions` (join table `aow_processed_aow_actions` with extra column `status`)

### Entry Points

There are exactly **two** entry points into the engine:

1. **`after_save` logic hook** -- registered as a global application-level hook at priority 99:
   ```php
   // custom/Extension/application/Ext/LogicHooks/AOW_WorkFlow_Hook.php
   $hook_array['after_save'][] = Array(
       99,                                    // sort order (runs late)
       'AOW_Workflow',                        // description
       'modules/AOW_WorkFlow/AOW_WorkFlow.php', // file
       'AOW_WorkFlow',                        // class
       'run_bean_flows'                       // method
   );
   ```
   Called on **every** bean save across the entire application. The method `run_bean_flows($bean)` then filters to only active workflows whose `flow_module` matches the saved bean.

2. **Scheduler job** -- the cron function `processAOW_Workflow()`:
   ```php
   // modules/Schedulers/_AddJobsHere.php
   function processAOW_Workflow() {
       $workflow = BeanFactory::newBean('AOW_WorkFlow');
       return $workflow->run_flows();
   }
   ```
   `run_flows()` loads all active workflows and for each one calls `run_flow()`, which builds a SQL query from the conditions, retrieves matching beans, and executes actions.

---

## 2. Database Schema

### aow_workflow

| Column | Type | Notes |
|---|---|---|
| id | char(36) | UUID primary key |
| name | varchar(254) | Workflow name |
| flow_module | varchar(100) | Target module (e.g. 'Accounts', 'Contacts') |
| status | varchar(100) | 'Active' or 'Inactive' |
| run_when | varchar(100) | Trigger mode: 'Always', 'On_Save', 'In_Scheduler', 'Create' |
| flow_run_on | varchar(100) | Record scope: 'New_Records', 'Modified_Records', or empty (all) |
| multiple_runs | tinyint(1) | 0 = run once per record, 1 = allow repeated runs |
| run_on_import | tinyint(1) | Whether to trigger during module imports |
| assigned_user_id | char(36) | Owner |
| date_entered | datetime | Creation timestamp |
| date_modified | datetime | Last modified |
| deleted | tinyint(1) | Soft delete flag |

### aow_conditions

| Column | Type | Notes |
|---|---|---|
| id | char(36) | UUID |
| aow_workflow_id | char(36) | FK to aow_workflow |
| condition_order | int | Execution/evaluation order |
| module_path | longtext | base64-encoded serialized array of relationship path (e.g., `['contacts']` to traverse from Accounts to Contacts) |
| field | varchar(100) | Field name to evaluate |
| operator | varchar(100) | Comparison operator key |
| value_type | varchar(100) | How to interpret the value |
| value | varchar(255) | The comparison value (may be base64-encoded for complex types) |
| deleted | tinyint(1) | |

### aow_actions

| Column | Type | Notes |
|---|---|---|
| id | char(36) | UUID |
| aow_workflow_id | char(36) | FK to aow_workflow |
| action_order | int | Execution order |
| action | varchar(100) | Action type key (e.g., 'CreateRecord', 'ModifyRecord', 'SendEmail', 'ComputeField') |
| parameters | longtext | base64-encoded serialized PHP array of action parameters |
| deleted | tinyint(1) | |

### aow_processed

| Column | Type | Notes |
|---|---|---|
| id | char(36) | UUID |
| aow_workflow_id | char(36) | FK to aow_workflow |
| parent_id | char(36) | The record ID that was processed |
| parent_type | varchar(100) | Module name of the processed record |
| status | varchar(100) | 'Pending', 'Running', 'Complete', 'Failed' |
| deleted | tinyint(1) | |

### aow_processed_aow_actions (join table)

| Column | Type | Notes |
|---|---|---|
| aow_processed_id | char(36) | FK to aow_processed |
| aow_action_id | char(36) | FK to aow_actions |
| status | varchar(100) | 'Complete' or 'Failed' |

---

## 3. Trigger Types & Processing Flow

### 3.1 Trigger Modes (`run_when`)

| Value | On Save | On Scheduler |
|---|---|---|
| `Always` | Yes | Yes |
| `On_Save` | Yes | No |
| `In_Scheduler` | No | Yes |
| `Create` | Yes | Yes |

### 3.2 Record Scope (`flow_run_on`)

| Value | Meaning |
|---|---|
| (empty/null) | All records |
| `New_Records` | Only records whose `date_entered` is after the workflow's `date_entered` |
| `Modified_Records` | Only records whose `date_modified` > workflow `date_entered` AND `date_entered` != `date_modified` |

### 3.3 Multiple Runs (`multiple_runs`)

When `multiple_runs = 0` (default):
- Before running actions, the engine checks `aow_processed` for a row with `status = 'Complete'` for this (workflow_id, record_id) pair
- If found, the record is **skipped**
- In scheduler mode, a `NOT EXISTS` subquery is added to the SQL to exclude already-processed records

When `multiple_runs = 1`:
- The processed check is skipped
- A new `aow_processed` row is created each time

### 3.4 Complete Execution Flow

#### Path A: On Save (after_save hook)

```
1. Any SugarBean::save()
2. SugarBean calls call_custom_logic('after_save')
3. LogicHook system invokes AOW_WorkFlow::run_bean_flows($bean)
4. Guard: if AOW_WorkFlow::$doNotRunInSaveLogic is true, return immediately
   (this static flag prevents recursive workflow triggering)
5. SQL query: SELECT active workflows where flow_module = bean's module
   AND run_when IN ('Always', 'On_Save', 'Create')
6. For each matching workflow:
   a. check_valid_bean($bean):
      i.   Check multiple_runs / aow_processed status
      ii.  Check flow_run_on (new/modified record filters)
      iii. Load all aow_conditions ordered by condition_order
      iv.  For each condition:
           - If module_path points to the current bean's module:
             Evaluate condition in-memory against bean field values
           - If module_path traverses a relationship:
             Build SQL JOIN + WHERE clause, execute query to verify
      v.   All conditions must pass (AND logic)
   b. If valid: run_actions($bean, in_save=true)
```

#### Path B: Scheduler (cron)

```
1. Scheduler calls processAOW_Workflow()
2. AOW_WorkFlow::run_flows()
3. Load all active workflows where run_when IN ('Always', 'In_Scheduler', 'Create')
4. For each workflow, call run_flow():
   a. Set AOW_WorkFlow::$doNotRunInSaveLogic = true
   b. get_flow_beans():
      i.   Build SQL query from conditions (build_flow_query_where)
      ii.  Add flow_run_on filters (new/modified)
      iii. Add NOT EXISTS processed check (if !multiple_runs)
      iv.  Add deleted=0 filter
      v.   Execute query to get matching record IDs
   c. For each matching bean:
      i.   Retrieve full bean
      ii.  run_actions($bean, in_save=false)
   d. Set AOW_WorkFlow::$doNotRunInSaveLogic = false
```

#### run_actions($bean, $in_save)

```
1. Create AOW_Processed record with status='Running'
2. Load relationship to aow_actions
3. Query all aow_actions for this workflow, ordered by action_order
4. For each action:
   a. Check if already completed (via aow_processed_aow_actions join)
   b. Load action class file: modules/AOW_Actions/actions/action{ActionType}.php
      (custom override: custom/modules/AOW_Actions/actions/...)
   c. Deserialize parameters: unserialize(base64_decode($action->parameters))
   d. Instantiate action class, call run_action($bean, $params, $in_save)
   e. Record result in aow_processed_aow_actions ('Complete' or 'Failed')
5. Set AOW_Processed status to 'Complete' or 'Failed'
```

### 3.5 Infinite Loop Prevention

The static flag `AOW_WorkFlow::$doNotRunInSaveLogic` is set to `true` during scheduler execution of `run_flow()`. This prevents the after_save hook from triggering nested workflow runs when an action saves a bean.

---

## 4. Conditions System

### 4.1 Condition Data Model

Each condition row contains:
- `module_path`: A serialized array defining the relationship traversal path. If empty or `[module_dir]`, the condition applies to the workflow's target bean directly. If it contains relationship names, the engine JOINs across relationships.
- `field`: The field name to evaluate
- `operator`: The comparison operator
- `value_type`: How to interpret `value`
- `value`: The comparison value

### 4.2 Operators

| Key | SQL Equivalent | In-Memory Implementation |
|---|---|---|
| `Equal_To` | `=` | `$var1 == $var2` |
| `Not_Equal_To` | `!=` | `$var1 != $var2` |
| `Greater_Than` | `>` | `$var1 > $var2` |
| `Less_Than` | `<` | `$var1 < $var2` |
| `Greater_Than_or_Equal_To` | `>=` | `$var1 >= $var2` |
| `Less_Than_or_Equal_To` | `<=` | `$var1 <= $var2` |
| `Contains` | `LIKE '%val%'` | `strpos(lower(var1), lower(var2)) !== false` |
| `Starts_With` | `LIKE 'val%'` | `substr(lower(var1), 0, len) === lower(var2)` |
| `Ends_With` | `LIKE '%val'` | `substr(lower(var1), -len) === lower(var2)` |
| `is_null` | `IS NULL OR = ''` | `$var1 == ''` |
| `One_of` | (multi-value) | `in_array($var1, $var2)` |
| `Not_One_of` | (multi-value) | `!in_array($var1, $var2)` |

Operators available per field type (enforced in the UI controller):
- **Numeric** (int, float, currency, decimal): Equal_To, Not_Equal_To, Greater_Than, Less_Than, >=, <=, is_null
- **Date/DateTime**: Same as numeric
- **Enum/Multienum**: Equal_To, Not_Equal_To, is_null
- **Text/Default**: Equal_To, Not_Equal_To, Contains, Starts_With, Ends_With, is_null

### 4.3 Value Types

| Value Type | Description | Storage |
|---|---|---|
| `Value` | Literal value | Plain string in `value` column |
| `Field` | Compare against another field on the same record | Field name in `value` column |
| `Any_Change` | True if the field changed from its previous value | No value needed. Operator is inverted: Equal_To becomes Not_Equal_To (checking current != previous). **Only works on-save, not in scheduler.** |
| `Date` | Date arithmetic expression | base64-encoded serialized array: `[base_date, operator, amount, unit]` |
| `Multi` | Multiple value selection (for enum/multienum) | Encoded multienum value |
| `SecurityGroup` | Check if the record's relate field belongs to a security group | Security group ID in `value` |

### 4.4 Date Value Type Detail

The Date value type supports complex date expressions stored as a serialized array of 4 elements:

```
[0] = base_date: 'now', 'today', or a field name
[1] = operator: 'plus' or 'minus' (mapped via aow_date_operator to '+' or '-')
[2] = amount: integer
[3] = unit: 'minute', 'hour', 'day', 'week', 'month', 'year', 'business_hours'
```

In SQL mode (scheduler), this translates to:
```sql
DATE_FORMAT(field, '%Y-%m-%d %H:%i') = DATE_FORMAT(DATE_ADD(base, INTERVAL +/- N unit), '%Y-%m-%d %H:%i')
```

In in-memory mode (on-save), it uses PHP `strtotime()` arithmetic.

Special: `business_hours` unit requires the `AOBH_BusinessHours` module and uses a custom business hours calculator.

### 4.5 Any_Change Detection

The `Any_Change` value type works by comparing the current field value against `$bean->fetched_row[$field]` (the value before the save). For relate fields, it uses `$bean->rel_fields_before_value[$field]`.

The operator is **inverted**: if the user selects "Equal_To" with "Any_Change", the engine checks `current != previous` (the field DID change). If the user selects "Not_Equal_To" with "Any_Change", it checks `current == previous` (the field did NOT change).

This value type **returns an empty query array in scheduler mode**, effectively disabling the condition for scheduler-triggered workflows (since there is no "before" state to compare against).

### 4.6 Condition Evaluation - All Must Pass (AND)

All conditions are combined with AND logic. There is no OR grouping. If any condition fails, `check_valid_bean()` returns `false`.

For conditions that reference relationships (module_path traverses to a different module), the engine builds SQL JOINs and WHERE clauses rather than evaluating in-memory. These relationship conditions are collected into a `$query_array` and executed as a single SQL query at the end of `check_valid_bean()`.

---

## 5. Actions System

### 5.1 Action Architecture

Each action type is implemented as a separate PHP class in `modules/AOW_Actions/actions/`:

| Action Key | Class File | Class Name | Extends |
|---|---|---|---|
| `CreateRecord` | `actionCreateRecord.php` | `actionCreateRecord` | `actionBase` |
| `ModifyRecord` | `actionModifyRecord.php` | `actionModifyRecord` | `actionCreateRecord` |
| `SendEmail` | `actionSendEmail.php` | `actionSendEmail` | `actionBase` |
| `ComputeField` | `actionComputeField.php` | `actionComputeField` | `actionBase` |

The `actionBase` class provides the interface:
```
class actionBase {
    public $id;
    __construct($id = '')
    loadJS() -> array       // JS files for the edit UI
    edit_display($line, $bean, $params) -> string  // HTML for the action configuration UI
    run_action($bean, $params, $in_save) -> bool   // Execute the action
}
```

Custom overrides are supported: if `custom/modules/AOW_Actions/actions/action{Type}.php` exists, it is loaded instead. If a class `customaction{Type}` exists, it is used.

### 5.2 Action: Create Record

**Class**: `actionCreateRecord extends actionBase`

**Parameters** (stored in `aow_actions.parameters` as serialized array):
```
{
  record_type: string,         // Target module name (e.g., 'Tasks', 'Calls')
  relate_to_workflow: bool,    // Create a relationship link back to the triggering bean
  copy_email_addresses: bool,  // Copy email addresses from source bean
  field: string[],             // Array of field names to set
  value: mixed[],              // Corresponding values
  value_type: string[],        // Value type for each field
  rel: string[],               // Relationship field names to set
  rel_value: mixed[],          // Relationship target IDs
  rel_value_type: string[],    // Value type for relationships
}
```

**Value Types for Fields**:
- `Value`: Direct literal value
- `Field`: Copy value from the triggering bean's field. Handles relate fields (copies id_name), numeric types (format_number), and defaults.
- `Date`: Date arithmetic, same 4-element array as conditions. Supports 'now', 'today', 'field' (use the target field's current value), or a source bean field name. Includes business hours support.
- `Round_Robin`: User assignment by cycling through a list. Users can be filtered by security group and/or role. Uses session/cache to track last assigned user.
- `Least_Busy`: Assigns to the user with fewest records (queries `assigned_user_id` counts).
- `Random`: Random user from the filtered list.

**Execution** (`run_action`):
1. Create a new bean of `record_type`
2. Call `set_record()` to populate fields
3. Call `set_relationships()` to link related records
4. Optionally copy email addresses
5. If `relate_to_workflow`, find the relationship between source and target modules and link them
6. Save the new bean

**Relate-to-Workflow Logic**:
Uses `Relationship::retrieve_by_modules()` to find the relationship key between the source bean's module and the new record's module. Then loads the relationship on the source bean and adds the new record's ID.

### 5.3 Action: Modify Record

**Class**: `actionModifyRecord extends actionCreateRecord`

Inherits all field-setting logic from actionCreateRecord but operates differently:

**Parameters**:
```
{
  rel_type: string,           // Relationship name (empty = modify the triggering bean itself)
  record_type: string,        // Auto-set to flow_module
  field: string[],
  value: mixed[],
  value_type: string[],
  rel: string[],
  rel_value: mixed[],
  rel_value_type: string[],
}
```

**Execution** (`run_action`):
- If `rel_type` is set and differs from the bean's module: traverses the relationship, loads all linked beans, and modifies each one.
- If `rel_type` is empty or matches: modifies the triggering bean itself.

The `set_record()` method handles saving with:
- `$bean->processed = true` (when in_save) to prevent re-triggering
- Notification check: sends assignment notification if `assigned_user_id` changed
- `$bean->process_save_dates = false` to preserve original dates
- Special handling for deleted records: if `deleted=1` is set during action, saves first then calls `mark_deleted()`

### 5.4 Action: Send Email

**Class**: `actionSendEmail extends actionBase`

**Parameters**:
```
{
  email_template: string,         // EmailTemplate record ID
  individual_email: bool,         // Send individual emails (one per recipient with per-recipient template parsing) vs one email to all
  email_target_type: string[],    // Array of recipient type configs
  email_to_type: string[],        // 'to', 'cc', or 'bcc' for each recipient
  email: mixed[],                 // Recipient value (depends on type)
}
```

**Recipient Types** (`email_target_type`):
| Type | `email` Value | Description |
|---|---|---|
| `Email Address` | string | Raw email address |
| `Specify User` | user_id | Looks up User bean, gets primary email |
| `Users` | `[source, group_id, role_id]` | All users from security group/role/all; source can be 'security_group', 'role', 'all' |
| `Related Field` | relationship_name | Gets email from linked beans via the named relationship |
| `Record Email` | (none) | Uses the triggering bean's primary email |

**Template Parsing**:
The `parse_template()` method:
1. Builds an `$object_arr` mapping module names to record IDs from the bean's relate fields and link fields
2. Adds `Users => assigned_user_id`
3. Applies `template_override` for per-recipient context (e.g., when emailing a specific user, override the Users entry)
4. Calls `aowTemplateParser::parse_template($string, $object_arr)` which extends the base `templateParser`

**Template Variable Format**:
Variables use the format `$module_field_name` in templates. The parser:
1. Retrieves each related bean by module/ID
2. Iterates through field definitions
3. Replaces `$module_fieldname` patterns with formatted values
4. Special variables: `$url` = link to the record's detail view, `$sugarurl` = site URL

**Email Sending**:
Uses `SugarPHPMailer` (wrapper around PHPMailer):
1. Gets system default email (From address)
2. Sets recipients (To, CC, BCC)
3. Handles attachments from Notes linked to the EmailTemplate
4. Sends via configured mail transport
5. Creates an Emails record in the database for audit trail
6. Copies attachments to the sent email record

### 5.5 Action: Compute Field (Calculate Fields)

**Class**: `actionComputeField extends actionBase`

**Parameters**:
```
{
  parameter: string[],               // Field names from the bean to use as {P0}, {P1}, etc.
  parameterType: string[],           // 'raw' or 'formatted' for each parameter
  relationParameter: string[],       // Relationship/relate field names for {R0}, {R1}, etc.
  relationParameterField: string[],  // Field name on the related bean
  relationParameterType: string[],   // 'raw' or 'formatted'
  formula: string[],                 // Target field names to write results to
  formulaContent: string[],          // Formula expressions to evaluate
}
```

**Parameter Resolution**:
- `raw`: Uses the field value as-is from the bean
- `formatted`: For enum/dynamicenum fields, resolves to the display label. For multienum, resolves all values and joins with ", ".

**Relation Parameter Resolution**:
- For `relate` type fields: retrieves the related bean via `BeanFactory::getBean()` using the id_name field
- For `link` type fields: loads the relationship and gets the first bean
- Then reads the specified field from the related bean

**Formula Engine** (FormulaCalculator):

The formula engine uses a custom expression language with curly-brace syntax:

```
{functionName(param1;param2;param3)}
```

Parameters are separated by semicolons (`;`). Functions can be nested:

```
{add({P0};{multiply({P1};{P2})})}
```

**Available Functions**:

*Logical Functions:*
| Function | Parameters | Returns |
|---|---|---|
| `equal(a;b)` | Two values | "1" if a == b, else "0" |
| `notEqual(a;b)` | Two values | "1" if a != b |
| `greaterThan(a;b)` | Two values | "1" if a > b |
| `greaterThanOrEqual(a;b)` | Two values | "1" if a >= b |
| `lessThan(a;b)` | Two values | "1" if a < b |
| `lessThanOrEqual(a;b)` | Two values | "1" if a <= b |
| `empty(a)` | One value | "1" if a == "" |
| `notEmpty(a)` | One value | "1" if a != "" |
| `not(a)` | One value | "1" if a == "0" |
| `and(a;b)` | Two values | "1" if both truthy |
| `or(a;b)` | Two values | "1" if either truthy |

*Control Flow:*
| Function | Parameters | Returns |
|---|---|---|
| `ifThenElse(cond;then;else)` | Three values | then if cond is truthy, else otherwise |

*String Functions:*
| Function | Parameters | Returns |
|---|---|---|
| `substring(str;start;len?)` | 2-3 params | Substring (mb_substr) |
| `length(str)` | One string | Character count (mb_strlen) |
| `replace(search;replace;subject)` | Three strings | str_replace result |
| `position(haystack;needle)` | Two strings | Position or -1 |
| `lowercase(str)` | One string | mb_strtolower |
| `uppercase(str)` | One string | mb_strtoupper |

*Math Functions:*
| Function | Parameters | Returns |
|---|---|---|
| `add(a;b)` | Two numbers | a + b |
| `subtract(a;b)` | Two numbers | a - b |
| `multiply(a;b)` | Two numbers | a * b |
| `divide(a;b)` | Two numbers | a / b (INF if b=0) |
| `power(a;b)` | Two numbers | a^b |
| `squareRoot(a)` | One number | sqrt(a) |
| `absolute(a)` | One number | abs(a) |

*Date Functions:*
| Function | Parameters | Returns |
|---|---|---|
| `now(format)` | PHP date format | Current date/time formatted |
| `yesterday(format)` | PHP date format | Yesterday formatted |
| `tomorrow(format)` | PHP date format | Tomorrow formatted |
| `date(format;datestring)` | Format + date string | Formatted date |
| `datediff(date1;date2;unit)` | Two dates + unit | Difference in years/months/days/hours/minutes/seconds |
| `addYears(format;date;n)` | Format, date, amount | Date + N years |
| `addMonths(format;date;n)` | Same pattern | Date + N months |
| `addDays(format;date;n)` | Same pattern | Date + N days |
| `addHours(format;date;n)` | Same pattern | Date + N hours |
| `addMinutes(format;date;n)` | Same pattern | Date + N minutes |
| `addSeconds(format;date;n)` | Same pattern | Date + N seconds |
| `subtractYears(format;date;n)` | Same pattern | Date - N years |
| `subtractMonths` through `subtractSeconds` | Same | Date subtraction variants |

*Global Variables / Counters:*
| Variable | Description |
|---|---|
| `{GlobalCounter(name)}` | Auto-incrementing counter, persisted in config |
| `{GlobalCounterPerUser(name)}` | Counter scoped to creator user |
| `{GlobalCounterPerModule(name)}` | Counter scoped to module |
| `{GlobalCounterPerUserPerModule(name)}` | Counter scoped to both |
| `{DailyCounter(name)}` | Resets daily |
| `{DailyCounterPerUser(name)}` | Daily + user scoped |
| `{DailyCounterPerModule(name)}` | Daily + module scoped |
| `{DailyCounterPerUserPerModule(name)}` | Daily + user + module scoped |

Counters accept an optional second parameter for zero-padding: `{GlobalCounter(invoice;6)}` produces "000001", "000002", etc.

**Formula Engine Internals**:

The `FormulaCalculator` parses formulas into a tree structure:
1. `createTree()` builds a `FormulaNode` tree by scanning for `{` and `}` delimiters
2. `evaluateTreeLevel()` recursively evaluates from leaves up
3. Leaf nodes resolve `{P0}`, `{P1}`, `{R0}`, `{R1}` variable references and global variables
4. Non-leaf nodes match function names via regex and extract semicolon-separated parameters
5. Child node values are substituted into parent expressions before evaluation

---

## 6. Relationships in Workflows

### 6.1 Conditions Across Relationships

The `module_path` field on conditions stores a base64-encoded serialized array of relationship names to traverse. For example, if the workflow targets Accounts and a condition references a Contact's field:

```
module_path = base64_encode(serialize(['contacts']))
```

The engine:
1. Decodes the path
2. For each relationship in the path:
   - Calls `build_flow_relationship_query_join()` to add a LEFT JOIN
   - Resolves the target module via `getRelatedModule()`
3. The condition field reference is then qualified with the relationship alias

This allows conditions like: "Account where any related Contact has email = 'test@example.com'"

### 6.2 Custom Fields

When a condition references a custom field (`source = 'custom_fields'`), the engine:
1. Detects the field source from vardefs
2. Adds a LEFT JOIN to the `_cstm` table (e.g., `accounts_cstm`)
3. Qualifies the field reference with the custom table alias

### 6.3 Relate Fields in Conditions

For fields of type `relate`:
- The engine substitutes the `id_name` (the actual FK column) for the display-name field
- For non-db relate fields with a `link`, it JOINs through the relationship to resolve the ID
- For non-db relate fields without a link, it JOINs directly to the related module's table

### 6.4 Modify Record Across Relationships

The `actionModifyRecord` action can modify related records:
- `rel_type` parameter specifies which relationship to traverse
- If set, the engine calls `$bean->get_linked_beans()` to load all related records
- Each related record is modified with `set_record()` and `set_relationships()`

### 6.5 Create Record with Relationship

The `actionCreateRecord` action can:
- Set relationship fields on the new record via `set_relationships()`
- Optionally link the new record back to the workflow's trigger record via `relate_to_workflow`
- The linking uses `Relationship::retrieve_by_modules()` to find the relationship definition, then `$bean->load_relationship()` and `->add()` to create the link

---

## 7. Email Templates in Workflows

### 7.1 Template Variable Substitution

The template parser (`aowTemplateParser`, extending `templateParser`) replaces variables in the format `$module_fieldname`.

**Object Resolution**:
The `parse_template()` method in `actionSendEmail` builds a map of module => record_id:
1. Starts with the triggering bean's module and ID
2. Scans all `relate` type fields on the bean -- for each, adds `module => id` to the map
3. Scans all `link` type fields -- for each, loads the first related bean and adds it
4. Adds `Users => assigned_user_id`
5. Merges any `template_override` (for per-recipient context)

**Field Type Formatting**:
The base `templateParser::parse_template_bean()` formats field values by type:
- `currency`: formatted number without symbol
- `enum/radioenum/dynamicenum`: translated display label
- `multienum`: each value translated, joined with ", "
- `int`: cast to string
- `bool`: translated via checkbox_dom
- `image`: generates `<img>` tag with file copy to public directory
- `wysiwyg`: HTML entity decoded
- `decimal/float`: locale-formatted decimal
- Default: raw value

**Special Variables**:
- `$url`: Auto-generated link to the record's detail view: `{site_url}/index.php?module={module}&action=DetailView&record={id}`
- `$sugarurl`: The configured site URL
- `$contact_user` is aliased to `$user`

### 7.2 Attachments

Email attachments come from Notes records linked to the EmailTemplate (where `parent_type = 'Emails'` and `parent_id = template.id`). After sending, attachments are copied (file and DB record) to the sent Email record for audit.

### 7.3 Individual vs Bulk Email

- `individual_email = true`: One email per recipient, with template re-parsed per recipient (allows per-recipient variable overrides like substituting the Users context for a specific user)
- `individual_email = false`: One email with all recipients in To, template parsed once

---

## 8. Utility Functions (aow_utils.php)

Key utility functions used throughout the workflow engine:

| Function | Purpose |
|---|---|
| `getModuleFields($module, $view, $value, $valid_types, $override)` | Returns HTML `<option>` elements for all fields in a module, filtered by ACL and type |
| `getRelatedModule($module, $rel_field)` | Traverses a relationship chain to find the target module name |
| `getModuleRelationships($module, $view, $value)` | Returns HTML `<option>` elements for all relationships on a module |
| `getValidFieldsTypes($module, $fieldname)` | Returns compatible field types for a given field (e.g., numeric types match numeric types) |
| `getModuleField($module, $fieldname, $aow_field, $view, $value)` | Renders the field input control using Smarty templates |
| `getRoundRobinUser($users, $id)` | Cycles through user list, tracking position in $_SESSION |
| `getLeastBusyUser($users, $field, $bean)` | Queries for user with fewest assigned records |
| `getEmailableModules()` | Returns modules that extend Person or Company (have email capability) |
| `getRelatedEmailableFields($module)` | Lists relate/link fields that point to emailable modules |
| `fixUpFormatting($module, $field, $value)` | Converts UI-formatted values to DB format |

---

## 9. Key Implementation Notes for Reimplementation

### 9.1 Serialization Format
All complex data (action parameters, condition module_path, date values) uses `base64_encode(serialize(...))`. In a TypeScript reimplementation, use JSON instead.

### 9.2 Dual Evaluation Paths
Conditions are evaluated in two different ways depending on the trigger:
- **On-Save**: In-memory comparison using bean property values and `fetched_row` (previous values)
- **Scheduler**: SQL WHERE clause construction

A reimplementation should ideally unify these into a single evaluation engine (e.g., always evaluate in-memory after loading the bean, or always use a query builder).

### 9.3 Relationship Traversal
The condition system supports arbitrary depth relationship traversal via `module_path`. Each step in the path generates a LEFT JOIN. The relationship metadata (join tables, key columns) comes from SugarCRM's relationship definitions.

### 9.4 Action Execution Order
Actions execute in `action_order` sequence. If any action fails, the processed record is marked 'Failed' but subsequent actions still execute (the `$pass` flag tracks overall success).

### 9.5 Re-entrant Save Prevention
When an action modifies or creates a bean, the save would normally re-trigger workflows. This is prevented by:
1. `AOW_WorkFlow::$doNotRunInSaveLogic` static flag (blocks during scheduler runs)
2. `$bean->processed = true` flag on beans being modified by actions (checked by the framework)
3. The `aow_processed` table preventing duplicate runs (when multiple_runs=0)

### 9.6 User Assignment Strategies
The Round Robin, Least Busy, and Random assignment strategies are only available for `relate` fields that point to the Users module. They can be filtered by:
- Security Group (with optional Role filter within the group)
- Role only
- All active users

Round Robin state is tracked per-action-id in `$_SESSION['round_robin']` with fallback to `sugar_cache`.

### 9.7 Business Hours
Date arithmetic supports a `business_hours` unit type via the `AOBH_BusinessHours` module. This is an optional SuiteCRM module that defines business hours schedules. When not installed, the engine falls back to regular hours.
