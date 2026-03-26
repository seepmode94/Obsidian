Enable extensions and modules in /etc/php/8.3/apache2/php.ini  
  
You can change here various attributes, such as:  
memory_limit



https://docs.suitecrm.com/8.x/admin/installation-guide/performance/

https://symfony.com/doc/current/components/cache/adapters/apcu_adapter.html

https://symfony.com/doc/current/performance.html#performance-install-apcu-polyfill



## PHP (mod_php under Apache)

_/etc/php/8.3/apache2/php.ini_

```SH
memory_limit = 512M
max_execution_time = 300
```

Enable OPcache

```sh
opcache.enable=1
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=20000
opcache.validate_timestamps=0
```


```sh
sudo systemctl reload apache2
```

## APACHE

_/etc/apache2/mods-available/mpm_prefork.conf_

```sh
<IfModule mpm_prefork_module>
    StartServers             5
    MinSpareServers          5
    MaxSpareServers         10

    # With ~145MB per Apache worker on this server, keep this sane.
    MaxRequestWorkers       100

    # Recycle processes to prevent long-term memory growth
    MaxConnectionsPerChild  2000
</IfModule>

```

## MYSQL - MARIADB

Create `/etc/mysql/mariadb.conf.d/60-suitecrm.cnf`. This file will overwrite 50-server.cnf

```sh
[mariadbd]
# SuiteCRM performance overrides (32GB shared server)

# Connections
max_connections = 250
thread_cache_size = 100

# InnoDB
innodb_buffer_pool_size = 16G
innodb_buffer_pool_instances = 8
innodb_flush_method = O_DIRECT
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1

# Caches
table_open_cache = 4096
table_definition_cache = 2048

# Temp tables
tmp_table_size = 256M
max_heap_table_size = 256M

# IO hints
innodb_io_capacity = 1000
innodb_io_capacity_max = 2000

```

```sh
sudo systemctl restart mariadb
```


### Optional - Use **APCu (User Cache):**

```sh
sudo apt install php-apcu
```

*Ensure SuiteCRM uses APCu by adding in your `config_override.php`:*


```sh
$sugar_config['external_cache_disabled'] = false;
```
