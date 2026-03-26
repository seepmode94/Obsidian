
### **1. Core Architecture**

SuiteCRM is structured around a **modular architecture** with a mix of object-oriented PHP and procedural PHP. The core components include:

- **Entry Points**: `index.php`, `api/index.php`, `service/v4_1/rest.php` (for REST API)
- **MVC Pattern**: Though loosely following MVC, the implementation is custom.
- **Legacy Code**: Many parts of the codebase still resemble SugarCRM CE 6.5.

---

### **2. Directory Structure**

Here’s a high-level overview of the key directories:

- **`/modules/`** – Contains individual modules (e.g., Accounts, Contacts, AOS_Quotes).
- **`/custom/`** – Stores customizations to avoid modifying core files.
- **`/include/`** – Contains core framework files (e.g., database abstraction, UI components).
- **`/data/`** – Manages database schemas, ORM-like functionality.
- **`/service/`** – Implements SOAP and REST APIs.
- **`/metadata/`** – Defines relationships, views, layouts.

---

### **3. Database & ORM**

SuiteCRM uses a **custom ORM** instead of Laravel's Eloquent or Symfony's Doctrine:

- Database operations are abstracted through `DBManager.php` (`include/database/DBManager.php`).
- Queries are written via `SugarQuery`, a wrapper around raw SQL.
- Relationship definitions are stored in `vardefs.php` inside each module.

---

### **4. Controllers & Views (Legacy MVC)**

SuiteCRM follows an **old-school MVC approach**:

- **Controllers**: Found in `modules/<Module>/controller.php` or `modules/<Module>/views/`
- **Models**: Typically in `modules/<Module>/<Module>.php`
- **Views**: Located in `modules/<Module>/views/`

However, the routing and logic are not centralized like in Laravel or Symfony.

---

### **5. Logic Hooks & Extension Framework**

Instead of Laravel Middleware or Symfony Event Listeners, SuiteCRM uses:

- **Logic Hooks** (`custom/modules/<Module>/logic_hooks.php`): Triggered before/after saving records.
- **Extensions** (`custom/Extension/`): Allows modifications without touching core files.

---

### **6. API System**

SuiteCRM provides a **SOAP and REST API**, but it is not built on modern API standards like Laravel's API Resources:

- REST API is defined in `service/v4_1/rest.php`.
- Custom API endpoints require modifying `custom/service/v4_1/CustomApi.php`.

---

### **7. UI & Template System**

Instead of Blade (Laravel) or Twig (Symfony), SuiteCRM uses **Smarty** for templating:

- Templates are found in `include/Sugar_Smarty/`.
- Many UI elements are rendered using `tpl` files.

---

### **8. Workflow Engine**

SuiteCRM has a built-in workflow engine (`AOW_`) that operates on database triggers rather than an event-driven system like Laravel Queues.