
```sh
mysql -u suitecrm_test -p -e " DROP DATABASE seepform_sugarcrm_db; CREATE DATABASE seepform_sugarcrm_db;"
```


```sh
mysql -u suitecrm_test -p seepform_sugarcrm_db < tacoviapt_CRM.sql
```


Save the Database to then send to the production server

```sh
sudo mysqldump -u suitecrm_test -p seepform_sugarcrm_db > tacovia_sugarcrm_db_20241102.sql
```

User:

```sh
suitecrm_test
```

Pass:

```sh
suitecrm@123
```
