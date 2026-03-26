  
  
_Make sure mod_rewrite is enabled and 3-4 of the required modules aren't missing:_
  
[https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite](https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite)  
  
### Requirements

[[Application Requirements]]

### Restart the Apache server
```sh
sudo systemctl restart apache2
sudo systemctl restart mariadb
```
  

### Error Logs:  

```sh
sudo tail -f /var/log/apache2/error.log  
```

```sh
sudo tail -f /var/log/php_errors.log
```

```sh
tail -f public/legacy/suitecrm.log  
```

```sh
sudo tail -n 100 /var/log/mysql/error.log
```

```sh
Put 

in the index.php file  
```  

### Web server side:  
  
1. Create a new file in etc/apache2/sites-available  
```sh
sudo vim tacovia.conf
```
  

2. Insert the following Apache configuration:

```sh
# HTTP -> HTTPS
<VirtualHost *:80>
    ServerName crm.tacovia.eu
    ServerAlias www.crm.tacovia.eu
    Redirect permanent / https://crm.tacovia.eu/
</VirtualHost>

# HTTPS
<VirtualHost *:443>
    ServerName crm.tacovia.eu
    DocumentRoot /var/www/html/tacovia/public

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/crm.tacovia.eu/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/crm.tacovia.eu/privkey.pem

    # Recommended SSL settings from Certbot (file created by certbot packages)
    Include /etc/letsencrypt/options-ssl-apache.conf

    <Directory /var/www/html/tacovia/public>
        AllowOverride All
        Require all granted
    </Directory>

    # Security headers (requires: a2enmod headers)
    Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

    ErrorLog ${APACHE_LOG_DIR}/crm_error.log
    CustomLog ${APACHE_LOG_DIR}/crm_access.log combined
</VirtualHost>
````
  

3. Create the symbolic link inside the _sites-enabled_ directory

```sh
sudo ln -s /etc/apache2/sites-available/tacovia.conf .
```

4. Enable the site:
```sh
sudo a2ensite tacovia.conf  
```

5. Activate Mod_Rewrites:  
```sh
sudo a2enmod rewrite  
```

6. Set permissions  

```sh
sudo find /var/www/html/tacovia -type d -not -perm 2755 -exec chmod 2755 {} \;  
sudo find /var/www/html/tacovia -type f -not -perm 0644 -exec chmod 0644 {} \;  
sudo find /var/www/html/tacovia ! -user www-data -exec sudo chown www-data:www-data {} \;
sudo chmod +x /var/www/html/tacovia/bin/console  
```

  
***Only if necessary*** * 
```sh
sudo find tacovia -type d -exec chmod 755 {} \;
```
  
  
7. Installing using cli (optional)  
  
./bin/console suitecrm:app:install \  
-U "adminDB" \ # The existing database username (from your config).  
-P "GuiTachovia2022" \ # The existing database password (from your config).  
-H "localhost" \ # The hostname for your database server.  
-N "suitecrm_db" \ # The name of your database for SuiteCRM.  
-S "http://51.75.163.147/SuiteCRM/public/" \ # Your SuiteCRM URL.  
-d "yes" # Drop and recreate tables if necessary.  
  
  
7. Enable extensions and modules in /etc/php/8.3/apache2/php.ini  
  
***To see the php loaded models do: php -m****
  
  
***To run all the prerequired models:***
```sh
sudo apt-get install php8.3-cli
sudo apt-get install php8.3-curl
sudo apt-get install php8.3-intl
sudo apt-get install php8.3-gd
sudo apt-get install php8.3-mbstring
sudo apt-get install php8.3-mysql
sudo apt-get install php8.3-xml
sudo apt-get install -y php8.3-soap
sudo apt-get install php8.3-zip
sudo apt-get install php8.3-imap # Optional
sudo apt-get install php8.3-ldap # Optional
```

9. Restart the apache server  
```sh 
sudo systemctl restart apache2  
sudo systemctl restart mariadb  
```


## Application side  
  
1. Change if necessary:  

	public/legacy/config - Edit the db fields (db_host_name) and the sites_url  
	public/legacy/.htaccess  
	.env.local  
  
  
2. Set up cron jobs for google API sync  
[https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler](https://docs.suitecrm.com/admin/administration-panel/system/#_scheduler)  
[https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup](https://docs.suitecrm.com/admin/administration-panel/google-maps/#_google_map_setup)  
  
  
  
  
**To Setup Crontab**

	In order to run SuiteCRM Schedulers, edit your web server user's crontab file with this command:

```sh
sudo crontab -e -u www-data
```

And add the following line to the crontab file:  

```sh
* * * * * cd /var/www/html/tacovia/public/legacy; php -f cron.php > /dev/null 2>&1
```


Manually trigger the cron jobs

```sh
curl '[http://crm.tacovia.eu/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1'](http://crm.tacovia.eu/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1%27)  
```  
  

### Install a certbot for crm.tacovia.eu

#### 1) Install Certbot (Apache plugin)

```sh
sudo apt update
sudo apt install -y certbot python3-certbot-apache
```


#### 2) Issue & install the cert (Apache plugin)

```sh
sudo certbot --apache \
  -d crm.tacovia.eu \
  -m guilhermeferreira@tacovia.eu --agree-tos -n
```

This will:

- Validate via HTTP-01    
- Install the cert into your SSL vhost
- Set up auto-renew + Apache reload on renew

### 3) (Recommended) Remove the unused `www` alias from your vhost

Since `www.crm.tacovia.eu` is NXDOMAIN, drop the alias to avoid confusion:

```sh
sudo sed -i '/ServerAlias www\.crm\.tacovia\.eu/d' /etc/apache2/sites-available/tacovia.conf
sudo systemctl reload apache2
```

If Certbot didn’t rewrite your SSL paths automatically, set them to Let’s Encrypt and remove the chain file:

```sh
SSLEngine on
SSLCertificateFile /etc/letsencrypt/live/crm.tacovia.eu/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/crm.tacovia.eu/privkey.pem
# (Delete/omit SSLCertificateChainFile — fullchain.pem already includes it)
```

```sh
sudo systemctl reload apache2
```

### 4) Verify it’s live

```sh
openssl s_client -connect crm.tacovia.eu:443 -servername crm.tacovia.eu -showcerts \
| openssl x509 -noout -subject -issuer -dates
```

You should see a fresh **notAfter ≈ 90 days** and SAN including `crm.tacovia.eu`.

### 5) Auto-renew (already enabled)

```sh
systemctl status certbot.timer
sudo certbot renew --dry-run
```


