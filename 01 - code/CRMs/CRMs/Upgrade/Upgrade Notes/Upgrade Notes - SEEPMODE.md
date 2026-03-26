1. Create a tmp directory inside the suitecrm code

```sh
sudo mkdir -p /var/www/html/seepmode/tmp/package/upgrade
```

2. Pass the suitecrm zip folder into it

```sh
sudo cp SuiteCRM-8.8.0.zip /var/www/html/seepmode/tmp/package/upgrade/
```

3. Set the permissions

```sh
sudo find /var/www/html/seepmode -type d -not -perm 2755 -exec chmod 2755 {} \;  
sudo find /var/www/html/seepmode -type f -not -perm 0644 -exec chmod 0644 {} \;
sudo find /var/www/html/seepmode ! -user www-data -exec sudo chown www-data:www-data {} \;
sudo chmod +x /var/www/html/seepmode/bin/console
```

4. Run the installation command

```sh
sudo ./bin/console suitecrm:app:upgrade -t SuiteCRM-8.8.0
```

5. Reset the permissions

6. Finalize the upgrade

_See metadata merge modes for this step https://docs.suitecrm.com/8.x/admin/upgrading/additional-materials/metadata-merge/_

```sh
sudo ./bin/console suitecrm:app:upgrade-finalize -t SuiteCRM-8.8.0 -m merge
```

7. Reset the permissions

8. Read the before start url to know which variables you need to declare

### Useful links

https://docs.suitecrm.com/8.x/admin/compatibility-matrix/#_suitecrm_8_4_x
https://docs.suitecrm.com/8.x/admin/upgrading/upgrading-82x-versions/
https://docs.suitecrm.com/8.x/admin/upgrading/before-start/