### Requirements

https://docs.suitecrm.com/8.x/admin/compatibility-matrix/

**SuiteCRM current code version -- 8.3.1**

| Platform   |     Technology1     |     Technology2      |        Technology3        |
| ---------- | :-----------------: | :------------------: | :-----------------------: |
| Database*  | **MariaDB** (10.4+) | **Mysql** (5.7, 8.0) |            ---            |
| Backend    |     **php** 7.4     |         ---          |            ---            |
| Frontend   | **node** (18.20.4)  |  **yarn** (1.22.22)  | **Angular CLI** (12.2.17) |
| Web Server |     **Apache2**     |         ---          |            ---            |

**SuiteCRM current code version -- 8.3.1**

| Platform   |     Technology1     |     Technology2      |        Technology3        |
| ---------- | :-----------------: | :------------------: | :-----------------------: |
| Database*  | **MariaDB** (10.4+) | **Mysql** (5.7, 8.0) |            ---            |
| Backend    |     **php** 8.3     |         ---          |            ---            |
| Frontend   | **node** (20.11.1)  |   **yarn** (4.5.0)   | **Angular CLI** (18.20.4) |
| Web Server |     **Apache2**     |         ---          |            ---            |




* **Choose only one database client* (Preferable MariaDB)**

## Restart the Apache server
```sh
sudo systemctl restart apache2
sudo systemctl restart mysql
```

### Clean Cache

```
sudo bin/console cache:clear
```
### Install dependencies

1. Enable extensions and modules in /etc/php/8.3/apache2/php.ini  
  
***To see the php loaded models do: ****

```sh
php -m
```
  
***To run all the prerequired models:***
```sh
sudo apt-get install php8.3-cli  
sudo apt-get install php8.3-curl  
sudo apt-get install php8.3-intl  
sudo apt-get install php8.3-gd  
sudo apt-get install php8.3-mbstring  
sudo apt-get install php8.3-mysql
sudo apt-get install php8.3-xml  
sudo apt-get install php8.3-zip  
sudo apt-get install php8.3-imap   # Optional  
sudo apt-get install php8.3-ldap   # Optional  
sudo apt-get install php8.3-imagick
```


### Web server side:  

#### SuiteCRM Official Documentation

https://docs.suitecrm.com/8.x/admin/installation-guide/downloading-installing/


1. Create a new file in etc/apache2/sites-available  
```sh
sudo vim seepmode.conf
```
  

2. Insert the following Apache configuration:

```sh
# Redirect HTTP to HTTPS
<VirtualHost *:80>
    ServerName crm.seepmode.com
    Redirect permanent / https://crm.seepmode.com/
</VirtualHost>

# HTTPS configuration
<VirtualHost *:443>
    ServerName crm.seepmode.com
    DocumentRoot /var/www/html/seepmode/public
 
    # Enable SSL
    SSLEngine on
    SSLCertificateFile /etc/ssl/seepmode.com/certificate.crt
    SSLCertificateKeyFile /etc/ssl/seepmode.com/private.key
    SSLCertificateChainFile /etc/ssl/seepmode.com/ca_bundle.crt
    
    # If you have a chain file (intermediate certificate), include it as well
    # SSLCertificateChainFile /etc/ssl/seepmode/seepmode_com_chain.pem


    <Directory /var/www/html/seepmode/public>
        AllowOverride All
        # Apache 2.4 requires 'Require all granted' instead of 'Order' and 'Allow'
        Require all granted
    </Directory>

    # Other SSL configurations like SSLProtocol, SSLCipherSuite, etc.

</VirtualHost>
````
  

3. Create the symbolic link inside the _sites-enabled_ directory

```sh
sudo ln -s /etc/apache2/sites-available/seepmode.conf .
```

4. Enable the site:
```sh
sudo a2ensite seepmode.conf  
```

5. Activate Mod_Rewrites:  

- _Make sure mod_rewrite is enabled and 3-4 of the required modules aren't missing:_
  
- [https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite](https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite)  
  

```sh
sudo a2enmod rewrite  
```


6. Set permissions  

```sh
sudo find /var/www/html/abuzar_tacovia -type d -not -perm 2755 -exec chmod 2755 {} \;  
sudo find /var/www/html/abuzar_tacovia -type f -not -perm 0644 -exec chmod 0644 {} \;  
sudo find /var/www/html/abuzar_tacovia ! -user www-data -exec sudo chown www-data:www-data {} \;
sudo chmod +x /var/www/html/abuzar_tacovia/bin/console  
```



***Only if necessary*** * 
```sh
sudo find seepmode -type d -exec chmod 755 {} \;
```
  
  

7. Restart the apache server 

```sh 
sudo systemctl restart apache2  
sudo systemctl restart mysql  
```


## Application side
  
1. Change case the database user or name has changed:  

	public/legacy/config - Edit the db fields (db_host_name) and the sites_url  
	public/legacy/.htaccess  
	.env.local  
  
  
2. Set up cron jobs for google API sync  
[https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler](https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler)  
[https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup](https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup)  
  
  
  
### **To Setup Crontab**

	In order to run SuiteCRM Schedulers, edit your web server user's crontab file with this command:

```sh
sudo crontab -e -u www-data
```

And add the following line to the crontab file:  

```sh
* * * * * cd /var/www/html/seepmode/public/legacy; php -f cron.php > /dev/null 2>&1
```


Manually trigger the cron jobs

```sh
curl '[http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1'](http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1%27)  
```  
  
  