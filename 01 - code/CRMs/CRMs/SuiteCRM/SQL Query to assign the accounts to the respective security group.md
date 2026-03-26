
```sh

-- Active: 1715344458811@@51.255.64.165@3306@seepmode_suitecrm_db

-- Loop through each security group and process in batches of 300 records

  

-- Security Group: M02 - Vendedores Norte Seepmed -> 430871cc-f7ad-563e-4baf-656758f9b73b

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'430871cc-f7ad-563e-4baf-656758f9b73b' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '430871cc-f7ad-563e-4baf-656758f9b73b'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: M03 - Vendedores Centro Seepmed -> 2c7b5c8f-383f-564c-8c06-656761929497

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'2c7b5c8f-383f-564c-8c06-656761929497' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '2c7b5c8f-383f-564c-8c06-656761929497'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: M04 - Vendedores Sul Seepmed -> 272b43bb-100a-37d4-a602-65675eef14b0

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'272b43bb-100a-37d4-a602-65675eef14b0' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '272b43bb-100a-37d4-a602-65675eef14b0'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: S02 - Vendedores Norte Seepmode -> 1661dd46-7b35-bebc-586c-65677565b259

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'1661dd46-7b35-bebc-586c-65677565b259' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '1661dd46-7b35-bebc-586c-65677565b259'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: S03 - Vendedores Centro Seepmode -> 757e4ec4-1a09-e145-a215-65677cc982f1

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'757e4ec4-1a09-e145-a215-65677cc982f1' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '757e4ec4-1a09-e145-a215-65677cc982f1'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: S04 - Vendedores Sul Seepmode -> 85e0830a-c701-6ca6-4ab4-656780613a8f

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'85e0830a-c701-6ca6-4ab4-656780613a8f' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '85e0830a-c701-6ca6-4ab4-656780613a8f'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: S05 - Vendedores Outros Seepmode -> 51cccefc-733d-cce9-ab31-6568b9b72b8d

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'51cccefc-733d-cce9-ab31-6568b9b72b8d' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '51cccefc-733d-cce9-ab31-6568b9b72b8d'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

  

-- Security Group: S06 - Vendedores España Seepmode -> 74549575-9ea6-1675-8c2e-651938910575

INSERT INTO securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted)

SELECT

UUID() AS id,

'74549575-9ea6-1675-8c2e-651938910575' AS securitygroup_id,

a.id AS record_id,

'Accounts' AS module,

NOW() AS date_modified,

'1' AS modified_user_id,

'1' AS created_by,

0 AS deleted

FROM

accounts a

JOIN

securitygroups_users sgu ON a.assigned_user_id = sgu.user_id

JOIN

users u ON sgu.user_id = u.id

WHERE

sgu.securitygroup_id = '74549575-9ea6-1675-8c2e-651938910575'

AND a.deleted = 0

AND sgu.deleted = 0

AND u.deleted = 0

```
