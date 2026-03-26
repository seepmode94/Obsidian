
**Small Note:** To manage different PHP versions for various applications, we used Docker to create an isolated environment for SuiteCRM with PHP 7.3, while the server's global environment runs PHP 8.1 for other apps. This approach ensures compatibility and stability across applications without affecting the global server settings, showcasing Docker's utility in handling multiple software versions seamlessly on the same system.  

## Server

Digital Ocean - SugarCRM
  
```sh
ssh root@164.90.179.162  
fc5a2db03cec0d990eef17fce5  
```

################################################################################################  

## Requirements

**Make sure mod_rewrite is enabled and 3-4 of the required modules arent missing:**
  
[https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite](https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite)  
  
	ssh ubuntu@198.244.150.242  
	Database: MySql - 5.7  
	Back-end: php - 5.6  
	Web server: apache2  

[https://docs.suitecrm.com/8.x/admin/compatibility-matrix/](https://docs.suitecrm.com/8.x/admin/compatibility-matrix/)  
  
  
  
  
  
################################################################################################  
  
## Method 1 (CURRENTLY ACTIVE)  

### Web server side:  
  
1. Create a new file in etc/apache2/sites-available  
```sh
sudo vim sugar_seepform.conf:  
```

```sh
# Redirect HTTP to HTTPS  
<VirtualHost *:80>  
ServerName [sugar.seepform.pt](http://sugar.seepform.pt/)  
Redirect permanent / [https://sugar.seepform.pt/](https://sugar.seepform.pt/)  
</VirtualHost>  
  
<VirtualHost *:443>  
ServerName [sugar.seepform.pt](http://sugar.seepform.pt/)  
DocumentRoot /var/www/html/sugar_seepform  
  
# Enable SSL  
SSLEngine on  
SSLCertificateFile /etc/ssl/sugar.seepform.pt/certificate.crt  
SSLCertificateKeyFile /etc/ssl/sugar.seepform.pt/private.key  
SSLCertificateChainFile /etc/ssl/sugar.seepform.pt/ca_bundle.crt  
  
<Directory /var/www/html/sugar_seepform>  
AllowOverride All  
# Apache 2.4 requires 'Require all granted' instead of 'Order' and 'Allow'  
Require all granted  
</Directory>  
  
# Other SSL configurations like SSLProtocol, SSLCipherSuite, etc.  
</VirtualHost>  
```
  
**Check apache2 syntax:**

```sh
sudo apache2ctl configtest  
```
  
2. Enable the site:  
```sh
sudo a2ensite seepmode.conf  
```

3. Activate Mod_Rewrites:  
```sh
sudo a2enmod rewrite  
```
4. Set permissions  

```sh
sudo find /var/www/html/sugar_seepform -type d -not -perm 2755 -exec chmod 2755 {} \;
sudo find /var/www/html/sugar_seepform -type f -not -perm 0644 -exec chmod 0644 {} \;
sudo find /var/www/html/sugar_seepform ! -user www-data -exec sudo chown www-data:www-data {} \;
```
  
  
**Only if necessary**
```sh
sudo find sugar_seepform -type d -exec chmod 755 {} \;  
```  
  
  
5. Enable extensions and modules in /etc/php/5.6/apache2/php.ini  
  
	To see the php loaded models do: php5.6 -m  
  
  
  
5.  
***To run all the prerequired models:***
```sh  
sudo apt-get install php5.6-cli  
sudo apt-get install php5.6-curl  
sudo apt-get install php5.6-intl  
sudo apt-get install php5.6-gd  
sudo apt-get install php5.6-mbstring  
sudo apt-get install php5.6-mysqli  
sudo apt-get install php5.6-pdo-mysql  
sudo apt-get install php5.6-xml  
sudo apt-get install php5.6-zip  
sudo apt-get install php5.6-imap # Optional  
sudo apt-get install php5.6-ldap # Optional  
```

6. Restart the apache server  
```sh
sudo systemctl restart apache2  
sudo systemctl restart mysql  
```
  
### Application side  
  
1. Change if necessary (There isnt a public folder for old versions (before SuiteCRM 8)):  
config - Edit the db fields (db_host_name) and the sites_url  
.htaccess  
  
  
  
  
2. Set up cron jobs for google API sync  

[https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler](https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler)  
[https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup](https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup)  
  
  
  
  
### To Setup Crontab  

	In order to run SuiteCRM Schedulers, edit your web server user's crontab file with this command:
	sudo crontab -e -u www-data
	... and add the following line to the crontab file:  
	* * * * * cd /var/www/html/seepmode/public/legacy; php -f cron.php > /dev/null 2>&1  
	  
	  
	Manually trigger the cron jobs  
	  
	curl '[http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1'](http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1%27)  
  
  
### Performance configurations:  
  
[https://docs.suitecrm.com/8.x/admin/installation-guide/performance/](https://docs.suitecrm.com/8.x/admin/installation-guide/performance/)  
  
  
  
### How to troubleshoot:  
  
Go to this specific url  
  
  
Check DNS:  
  
curl -I [http://crm.seepmode.com](http://crm.seepmode.com/)  
curl -I [https://crm.seepmode.com](https://crm.seepmode.com/)  
  
  
  
### logs:
```sh
sudo tail -f /var/log/apache2/error.log  
```
```sh
tail -f sugarcrm.log  
```
  

  
  
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$  
  
***Database Mysql commands***  
  
user: root  
password: suitecrm@123  
  
Log into MySQL as root:  
mysql -u root -p  
  
  
Create Empty database  
  
mysql -u suitecrm_test -p -e "DROP DATABASE seepform_sugarcrm_db; CREATE DATABASE seepform_sugarcrm_db;"  
  
CREATE DATABASE seepform_sugarcrm_db;  
exit  
  
  
Populate Database  
  
mysql -u suitecrm_test -p seepform_sugarcrm_db < seepform_CRM_19_03_2024.sql  
  
Check Database tables:  
  
mysql -u suitecrm_test -p seepform_sugarcrm_db  
  
SHOW TABLES;  
  
  
Do a dump of the database:  
  
mysqldump -u suitecrm_test -p seepform_sugarcrm_db > seepform_suitecrm_db_20240221.sql