  
  
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
sudo tail -f /var/log/mysql/error.log
```

```sh
tail -f /var/www/html/seepmode/log/prod/prod.log
```


```sh
Put 

in the index.php file  
```  

### Web server side:  
  
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
```sh
sudo a2enmod rewrite  
```

6. Set permissions  

```sh
sudo find /var/www/html/seepmode -type d -not -perm 2755 -exec chmod 2755 {} \;  
sudo find /var/www/html/seepmode -type f -not -perm 0644 -exec chmod 0644 {} \;  
sudo find /var/www/html/seepmode ! -user www-data -exec sudo chown www-data:www-data {} \;
sudo chmod +x /var/www/html/seepmode/bin/console  
```


***Only if necessary*** * 
```sh
sudo find seepmode -type d -exec chmod 755 {} \;
```
  
  
8. Enable extensions and modules in /etc/php/8.3/apache2/php.ini  
  
***To see the php loaded models do: php -m****
  
  
***To run all the prerequired models:***
```sh
sudo apt-get install php7.4-cli  
sudo apt-get install php7.4-curl  
sudo apt-get install php7.4-intl  
sudo apt-get install php7.4-gd  
sudo apt-get install php7.4-mbstring  
sudo apt-get install php7.4-mysqli  
sudo apt-get install php7.4-pdo-mysql  
sudo apt-get install php7.4-xml  
sudo apt-get install php7.4-zip  
sudo apt-get install php7.4-imap # Optional  
sudo apt-get install php7.4-ldap # Optional  
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
* * * * * cd /var/www/html/seepmode/public/legacy; php -f cron.php > /dev/null 2>&1
```


Manually trigger the cron jobs

```sh
curl '[http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1'](http://crm.seepmode.com/index.php?module=jtjw_Maps&entryPoint=jtjw_Maps&cron=1%27)  
```  


### Install a certbot for crm.seepmode.com

#### 1) Install Certbot (Apache plugin)

```sh
sudo apt update
sudo apt install -y certbot python3-certbot-apache
```


#### 2) Issue & install the cert (Apache plugin)

```sh
sudo certbot --apache \
  -d crm.seepmode.com \
  -m guilhermeferreira@tacovia.eu --agree-tos -n
```

This will:

- Validate via HTTP-01    
- Install the cert into your SSL vhost
- Set up auto-renew + Apache reload on renew

### 3) (Recommended) Remove the unused `www` alias from your vhost

Since `www.crm.seepmode.com` is NXDOMAIN, drop the alias to avoid confusion:

```sh
sudo sed -i '/ServerAlias www\.crm\.seepmode\.com/d' /etc/apache2/sites-available/seepmode.conf
sudo systemctl reload apache2
```

If Certbot didn’t rewrite your SSL paths automatically, set them to Let’s Encrypt and remove the chain file:

```sh
SSLEngine on
SSLCertificateFile /etc/letsencrypt/live/crm.seepmode.com/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/crm.seepmode.com/privkey.pem
# (Delete/omit SSLCertificateChainFile — fullchain.pem already includes it)
```

```sh
sudo systemctl reload apache2
```

### 4) Verify it’s live

```sh
openssl s_client -connect crm.seepmode.com:443 -servername crm.seepmode.com -showcerts \
| openssl x509 -noout -subject -issuer -dates
```

You should see a fresh **notAfter ≈ 90 days** and SAN including `crm.seepmode.com`.

### 5) Auto-renew (already enabled)

```sh
systemctl status certbot.timer
sudo certbot renew --dry-run
```


