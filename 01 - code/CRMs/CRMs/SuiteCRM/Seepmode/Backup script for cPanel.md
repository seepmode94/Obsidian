
## Step 1: Created script for backup automatically the source code and the database file

```sh
#!/bin/bash

# FTP credentials
FTP_USERNAME='guilhermeferreira@seepmode.com'
FTP_PASSWORD='Ferreira3278'  # Replace 'xxxx' with your actual FTP password.
FTP_SERVER='ftp.seepmode.com'
FTP_PORT='21'
REMOTE_PATH_CODE='/crm.seepmode.com/code_backup'
REMOTE_PATH_DB='/crm.seepmode.com/db_backup'
LOCAL_PATH='/var/www/html/seepmode'

# MySQL credentials
DB_USER='adminDB_suite'
DB_NAME='seepmode_suitecrm_db'

# Current date
DATE=$(date +%Y%m%d)

# Archive and SQL filenames
FILENAME="backup-$DATE.tar.gz"
SQLFILE="seepmode_suitecrm_db_$DATE.sql"

echo "Starting backup process..."
echo "Running as user: $(whoami)"

# Ensure /home/ubuntu/backup directory exists and is writable
BACKUP_DIR="/home/ubuntu/backup"
if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR
  echo "Created directory $BACKUP_DIR"
fi

# Dump the database
echo "Dumping database..."
mysqldump -u $DB_USER -p'suitecrm@2024' --no-tablespaces $DB_NAME > $BACKUP_DIR/$SQLFILE
if [ $? -eq 0 ]; then
    echo "Database dumped successfully."
else
    echo "Failed to dump database."
    exit 1
fi

# Create a compressed archive of the directory
echo "Creating tar file in $BACKUP_DIR..."
tar -czvf $BACKUP_DIR/$FILENAME $LOCAL_PATH
if [ $? -eq 0 ]; then
    echo "Archive created successfully."
else
    echo "Failed to create archive."
    exit 1
fi

# Upload code backup to FTP
echo "Starting FTP process for code backup..."
lftp -e "
set ssl:verify-certificate no
open $FTP_SERVER
user $FTP_USERNAME $FTP_PASSWORD
lcd $BACKUP_DIR
cd $REMOTE_PATH_CODE
put $FILENAME
bye
"
if [ $? -eq 0 ]; then
    echo "Code file uploaded successfully."
else
    echo "FTP upload for code file failed."
fi

# Upload database backup to FTP
echo "Starting FTP process for database backup..."
lftp -e "
set ssl:verify-certificate no
open $FTP_SERVER
user $FTP_USERNAME $FTP_PASSWORD
lcd $BACKUP_DIR
cd $REMOTE_PATH_DB
put $SQLFILE
bye
"
if [ $? -eq 0 ]; then
    echo "Database file uploaded successfully."
else
    echo "FTP upload for database file failed."
fi

# Clean up local files by removing the archive and SQL dump from /home/ubuntu/backup
rm $BACKUP_DIR/$FILENAME $BACKUP_DIR/$SQLFILE
if [ $? -eq 0 ]; then
    echo "Local files removed successfully."
else
    echo "Failed to remove local files."
fi
```


## Step 2: Give file permissions


```sh
sudo chmod +x backup_to_cpanel.sh
```

## Step 3: Create the folder where the backups will be placed on cPanel and on the remote server

***For example***

```sh
sudo mkdir /home/ubuntu/backup
```

## Step 4: Schedule the script to run at 2 A.M.

1. **To edit the crontab for the current user** (if you're logged in as the user who should run the script):

```bash
sudo crontab -e
```

2. Add the cron Job

```bash
0 2 * * * /bin/bash /var/www/html/backup_to_cpanel.sh >> /var/log/backup_to_cpanel.log 2>&1
```

3. Verify the cronjob

```sh
sudo crontab -l
```
