
## Credentials

1. ***User***

```sh
adminDB_suite_staging
```

1. ***Password***

```sh
suitecrm@staging
```
  

## Log into MySQL as root:

```sh
sudo mysql -u root -p
```

```sh
sudo mysql  
```


## Log in as user  

```sql
mysql -u adminDB_suite_staging  
```


## Creating and Managing Databases:

_Inside mysql shell_

```sql
CREATE DATABASE seepmode_suitecrm_db;
```

```sql
CREATE USER 'adminDB_suite_staging'@'localhost' IDENTIFIED BY 'suitecrm@staging';
```

```sql
GRANT ALL PRIVILEGES ON seepmode_suitecrm_db.* TO 'adminDB_suite_staging'@'localhost';
```

```sql
exit  
```

### List All Databases:  

```sql
SHOW DATABASES;  
```


### Create Empty database  


```sh
mysql -u adminDB_suite -p -e " DROP DATABASE backup_temp_db; CREATE DATABASE backup_temp_db;"
```

**_Inside the mysql shell_**

```sql  
CREATE DATABASE seepform_suitecrm_db;
```
  
### Populate Database

```sh
mysql -u adminDB_suite_staging -p seepmode_suitecrm_db < seepmode_suitecrm_db_20250219.sql
```

### Check Database tables:

**_Inside the mysql shell_**
```sh
mysql -u adminDB_suite_staging -p seepform_suitecrm_db  
  
SHOW TABLES;  
```
  
### Do a dump of the database:

```sh
sudo mysqldump -u adminDB_suite_staging -p seepform_suitecrm_db > seepmode_suitecrm_db_20241001.sql
```
