
```sh
-- Active: 1727773300408@@149.202.68.45@3306@seepform_suitecrm_db

  

-- Query to Insert [sdmod_contracts] with Security Group ID of the Account

  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

c.id AS record_id, -- Contract ID

'sdmod_contracts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

sdmod_contracts c

JOIN

sdmod_contracts_accounts_c cac ON c.id = cac.sdmod_contracts_accountssdmod_contracts_idb

JOIN

securitygroups_records sgr ON cac.sdmod_contracts_accountsaccounts_ida = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

c.deleted = 0

AND cac.deleted = 0

AND sgr.deleted = 0;

  
  

-- Query to Insert [Opportunities] with Security Group ID of the Account

  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

o.id AS record_id, -- Opportunity ID

'Opportunities' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

opportunities o

JOIN

accounts_opportunities ao ON o.id = ao.opportunity_id

JOIN

securitygroups_records sgr ON ao.account_id = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

o.deleted = 0

AND ao.deleted = 0

AND sgr.deleted = 0;

  
  
  

-- Query to Insert [Cases] with Security Group ID of the Account

  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

c.id AS record_id, -- Case ID

'Cases' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

cases c

JOIN

securitygroups_records sgr ON c.account_id = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

c.deleted = 0

AND sgr.deleted = 0;

  
  

-- Query to Insert [Contacts] with Security Group ID of the Account

  
  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

c.id AS record_id, -- Contact ID

'Contacts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

contacts c

JOIN

accounts_contacts ac ON c.id = ac.contact_id

JOIN

securitygroups_records sgr ON ac.account_id = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

c.deleted = 0

AND ac.deleted = 0

AND sgr.deleted = 0;

  
  
  

-- Query to Insert [AOS_Quotes] with Security Group ID of the Account

  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

q.id AS record_id, -- Quote ID

'AOS_Quotes' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

aos_quotes q

JOIN

securitygroups_records sgr ON q.billing_account_id = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

q.deleted = 0

AND sgr.deleted = 0;

  
  
  
  
  

-- Query to Insert [sdmod_training] with Security Group ID of the Account

  

INSERT INTO securitygroups_records (

id,

securitygroup_id,

record_id,

module,

date_modified,

modified_user_id,

created_by,

deleted

)

SELECT

UUID() AS id,

sgr.securitygroup_id, -- Security group ID associated with the Account

st.id AS record_id, -- Training ID

'sdmod_training' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

sdmod_training st

JOIN

accounts_sdmod_training_1_c ast ON st.id = ast.accounts_sdmod_training_1sdmod_training_idb

JOIN

securitygroups_records sgr ON ast.accounts_sdmod_training_1accounts_ida = sgr.record_id

AND sgr.module = 'Accounts'

WHERE

st.deleted = 0

AND ast.deleted = 0

AND sgr.deleted = 0;
```
