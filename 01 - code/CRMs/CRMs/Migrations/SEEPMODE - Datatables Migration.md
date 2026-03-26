
  
## Server Info

#### SuiteCRM  
  
	ssh ubuntu@198.244.150.242
	  
	DB_USERNAME=adminDB_suite
	DB_PASSWORD=suitecrm@123
	  
  

## Pre-requirements:  Give user permissians over the database

```sh
sudo mysql -u root -p
```

```sh
GRANT ALL PRIVILEGES ON seepform_suitecrm_db.* TO 'adminDB_suite'@'localhost';
```


## Table Migration between databases:  


1. Populate seepform_suitecrm_db with the SQL file of current production (Sugar CRM)

```sh
mysql -u adminDB_suite -p -e "DROP DATABASE seepform_suitecrm_db; CREATE DATABASE seepform_suitecrm_db;"
mysql -u adminDB_suite -p seepform_suitecrm_db < seepform_sugarCRM_20240920.sql
```


2. Truncate Tables from database _seepform_suitecrm_db_ :

**Reset (NOT REMOVE!!) the heavy unnecessary tables from the Sugarcrm**

- tracker
- sugarfeed

```sh
mysql -u adminDB_suite -p -e "USE seepform_suitecrm_db; TRUNCATE TABLE tracker; TRUNCATE TABLE sugarfeed;"
```


3. Drop the old tables from the Production database _seepform_suitecrm_db_ :

```sh
mysql -u adminDB_suite -p -e "USE seepform_suitecrm_db; DROP TABLE IF EXISTS acl_actions, acl_roles, acl_roles_actions, acl_roles_users, aor_reports, aos_pdf_templates, aos_product_categories, aos_products, aos_products_cstm, aow_actions, aow_conditions, aow_workflow, config, email_templates, fields_meta_data, oauth2clients, oauth2tokens, os_reports, outbound_email, relationships, schedulers, securitygroups, securitygroups_acl_roles, securitygroups_records, securitygroups_users;"
```

4. Create a temporary database to import the newer SQL file (Seepmode DB):  

```sh
mysql -u adminDB_suite -p -e "CREATE DATABASE temp_seepmode_db;"  
mysql -u adminDB_suite -p temp_seepmode_db < seepmode_suitecrm_db_20240920.sql
```


5. Export the specified tables from the temporary database:  
  
```sh
mysqldump -u adminDB_suite -p temp_seepmode_db acl_actions acl_roles acl_roles_actions acl_roles_users aor_reports aos_pdf_templates aos_product_categories aos_products aos_products_cstm aow_actions aow_conditions aow_workflow config email_templates fields_meta_data oauth2clients oauth2tokens os_reports outbound_email relationships schedulers securitygroups securitygroups_acl_roles securitygroups_records securitygroups_users > specific_tables.sql
```

6. Import these tables into the original database (seepmode_suitecrm_db):  

```sh
mysql -u adminDB_suite -p seepform_suitecrm_db < specific_tables.sql
```

7. Export the entire updated original database to a SQL file (if needed): 

```sh
mysqldump -u suitecrm_test -p seepform_sugarcrm_db > seepform_suitecrm_db_updated.sql  
```

8. Drop the temporary database (optional, but recommended if you no longer need it):  
```sh
mysql -u adminDB_suite -p -e "DROP DATABASE temp_seepmode_db;"  
```

  

## **Note** : If you are using a different database don't forget to change:

- **config.php**
- **.env.local**


## Restart the server:  

```sh
sudo systemctl restart apache2  
sudo systemctl restart mysql  
```

  
## Datatables for Migration  
  
  
	acl_actions
	acl_roles
	acl_roles_actions
	acl_roles_users
	aor_reports
	aos_pdf_templates
	aos_product_categories
	aos_products
	aos_products_cstm
	aow_actions
	aow_conditions
	aow_workflow
	config
	email_templates
	fields_meta_data
	oauth2clients
	oauth2tokens
	os_reports
	outbound_email
	relationships
	schedulers
	securitygroups
	securitygroups_acl_roles
	securitygroups_records
	securitygroups_users



## Datatables cleaneage  for Tesletrica
  
  
	accounts
	accounts_audit
	accounts_contacts
	accounts_cstm  
	accounts_opportunities
	accounts_project_1_c
	accounts_sdmod_capability_1_c
	accounts_sdmod_contracts_manager_1_c
	accounts_sdmod_training_1_c
	accounts_sdmod_training_control_1_c
	aop_case_events
	aos_contracts
	aos_invoices
	aos_line_item_groups
	aos_pdf_templates
	aos_product_categories
	aos_products
	aos_products_audit
	aos_products_cstm
	aos_products_quotes
	aos_products_quotes_audit
	aos_quotes
	aos_quotes_aos_invoices_c
	aos_quotes_audit
	aos_quotes_sdmod_contracts_manager_1_c
	bugs
	calls
	calls_contacts
	calls_leads
	calls_users
	cases
	cases_audit
	cases_bugs
	cases_cstm
	config
	contacts
	contacts_audit
	contacts_cases
	contacts_cstm
	contacts_project_1_c
	contacts_sdmod_capability_1_c
	contacts_sdmod_iefp_accesses_1_c
	contacts_sdmod_training_control_1_c
	contacts_users
	cron_remove_documents
	document_revisions
	documents
	documents_accounts
	documents_cases
	documents_contacts
	documents_opportunities
	email_addr_bean_rel
	email_addresses
	emails
	emails_beans
	emails_email_addr_rel
	emails_text
	fields_meta_data
	leads
	meetings
	meetings_contacts
	meetings_cstm
	meetings_users
	notes
	opportunities
	opportunities_contacts
	opportunities_cstm
	os_reports
	os_reports_audit
	outbound_email
	project
	project_cstm
	project_documents_1_c
	projects_cases
	prospect_list_campaigns
	prospect_lists
	sdmod_attendances
	sdmod_attendances_cstm
	sdmod_capability
	sdmod_capability_audit
	sdmod_capability_cstm
	sdmod_capability_documents_1_c
	sdmod_contracts
	sdmod_contracts_accounts_c
	sdmod_contracts_audit
	sdmod_contracts_cstm
	sdmod_contracts_documents_c
	sdmod_contracts_manager
	sdmod_contracts_manager_audit
	sdmod_contracts_manager_cstm
	sdmod_contracts_sdmod_renewals_c
	sdmod_formation_trainers
	sdmod_formation_trainers_audit
	sdmod_formation_trainers_cstm
	sdmod_formation_trainers_sdmod_training_c
	sdmod_iefp_accesses
	sdmod_iefp_accesses_cstm
	sdmod_operations_center
	sdmod_operations_center_accounts_c
	sdmod_operations_center_audit
	sdmod_operations_center_cstm
	sdmod_renewals
	sdmod_renewals_audit
	sdmod_renewals_cstm
	sdmod_sessions
	sdmod_sessions_audit
	sdmod_sessions_cstm
	sdmod_sessions_sdmod_attendances_c
	sdmod_sessions_sdmod_formation_trainers_c
	sdmod_sessions_sdmod_training_c
	sdmod_trainers
	sdmod_trainers_cstm
	sdmod_trainers_sdmod_training_c
	sdmod_training
	sdmod_training_accounts_1_c
	sdmod_training_audit
	sdmod_training_control
	sdmod_training_control_audit
	sdmod_training_control_contacts_c
	sdmod_training_control_cstm
	sdmod_training_cstm
	sdmod_training_sdmod_attendances_c
	sdmod_training_sdmod_trainers_c
	tasks
