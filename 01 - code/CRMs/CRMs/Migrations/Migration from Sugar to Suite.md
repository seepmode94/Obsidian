
  
## **Perform an upgrade on the sugarcrm to SuiteCRM via packages**  
  
### 1. Backup Your Data and Files  
  
### 2. Check Compability between sugar and suitecrm  
  
### 3. Download the Upgrade Package to the remote server  
  
  
	Download the appropriate SuiteCRM from the official website.

```sh
https://sourceforge.net/projects/suitecrm/files/upgrades/
```

	  
	  
	Your path will be  
	Sugarcrm to SuiteCRM 7.6  
	Suitecrm 7.6 to 7.8.31  
	Suitecrm 7.8 to 7.11.12  
	  
	Suitecrm 7.11 to 7.12.8  
  
### 4.1. Before uploading make sure you modify the upload_max_filesize value in your php.ini located at: /etc/php/5.6/apache2/php.ini  
  
  
	sudo vim /etc/php/5.6/apache2/php.ini  
	  
	  
	max_execution_time=6000  
	post_max_size=80M  
	upload_max_filesize=80M  
	max_input_time=6000  
	memory_limit=256M  
	  
  
### 4.2. Restart the server  
  
	sudo systemctl restart apache2  
  
### 5. Upload the Upgrade Package  
  
	[https://docs.bitnami.com/google/how-to/upgrade-sugarcrm-suitecrm/](https://docs.bitnami.com/google/how-to/upgrade-sugarcrm-suitecrm/)  
	  
	- Navigate to the Admin section of your SugarCRM application.  
	- Locate the Upgrade Wizard in the system section. This tool facilitates the upgrade process.  
	- Follow the wizard's instructions to upload and install the SuiteCRM upgrade package. You will need to:  
	- Choose the package: Select the downloaded SuiteCRM upgrade package.  
	- Pre-flight check: The wizard will perform a check to ensure your system meets the requirements.  
	- Commit the upgrade: After the checks, you can proceed with the upgrade. Follow the on-screen instructions to complete the process.  
	  
	  
	Case necessary install these dependencies:  
	  
	sudo apt-get install php5.6-mbstring
	sudo apt-get install php5.6-zip
	sudo apt-get install php5.6-imap
	  
	sudo service apache2 restart  
  
  
  
##################################################################### 
  
## Migrate the database to local host  
  
scp root@164.90.179.162:/root/databases/seepform_suitecrm_db_20240221.sql /home/guilherme/Documents/Work/CRM/Bases\ de\ dados/seepform/  
  
Migrate from localhost to suitecrm server  
  
scp seepform_suitecrm_db_20240221.sql ubuntu@198.244.150.242:/home/ubuntu/databases/seepform/  
  
  
  
##################################################################### 
  
## 12/02/2024  
Abuzar:  
- grap my sugarcrm code, pass it to the remote server but you can skip the contents of the upload folder  
- install php7.3 on the remote server (I think this is the version with the largest coverage of compatibility)  
- perform the upgrade  
- copy the database from this server to the existing [crm.seepmode.com](http://crm.seepmode.com/) (ovh) server into a new database (let's call it seepmode_feb_24)  
- in the .env.local and config.php update the name of database  
- login into [crm.seepmode.com](http://crm.seepmode.com/)  
- do a repair and rebuild and execute the queries (if any) at the bottom  
- copy the table data from the fields_meta_data and workflow tables (aow_*)  
- again do a repair and rebuild