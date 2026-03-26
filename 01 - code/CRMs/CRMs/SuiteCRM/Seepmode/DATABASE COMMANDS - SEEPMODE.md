
## Credentials

1. ***User***

```sh
adminDB_suite
```

2. ***Password***

```sh
suitecrm@2024
```
  

## Log into MySQL as root:

```sh
sudo mariadb
```


## Creating and Managing Databases:

```sql
CREATE DATABASE seepform_suitecrm_db;
  
CREATE USER 'adminDB_suite'@'localhost' IDENTIFIED BY 'suitecrm@2024';
  
GRANT ALL PRIVILEGES ON seepform_suitecrm_db.* TO 'adminDB_suite'@'localhost';
  
exit
```
  
### List All Databases:  

```sql
SHOW DATABASES;
```

### List All Users:  

```sql
sudo mysql -u root -p -e "SELECT User, Host FROM mysql.user;"
```
  

### Create Empty database  
  
```sh
mariadb -u adminDB_suite -p -e "DROP DATABASE seepform_suitecrm_db; CREATE DATABASE seepform_suitecrm_db"
```

```sql  
CREATE DATABASE seepmode_suitecrm_db;  
exit  
```
  
### Populate Database

```sh
mariadb -u adminDB_suite -p seepform_suitecrm_db < seepmode_suitecrm_db_20260117.sql
```

### Check Database tables:
  
```sh
mysql -u adminDB_suite_tesletrica -p seepmode_suitecrm_db  
  
SHOW TABLES;  
```
  
### Do a dump of the database:

```sh
sudo mysqldump -u adminDB_suite -p seepform_suitecrm_db > seepform_suitecrm_db_20250327_v8.8.sql
```
  


```sh
sudo mysqldump -u adminDB_suite -p tacovia_suitecrm_db > tacovia_suitecrm_db_20250311.sql
```
  
