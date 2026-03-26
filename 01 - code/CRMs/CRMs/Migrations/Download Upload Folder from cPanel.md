
## Step 1

_Compress the folder into an FTP location inside the Seepform cPanel_

## Step 2

_Start a session_

```sh
screen -S ftp_session
```

## Step 3

_Inside the remote server log in as the respective FTP User to extract the Upload.zip file_

```sh
lftp -u crm.seepmode@crm.seepform.pt ftp.seepform.pt -e "set ssl:verify-certificate no; ls"
```



## Step 4

```sh
get upload.zip
```


### Notes

To leave session:

```sh
Ctrl + A, then D
```

To reattach  session:

```sh
session -r ftp_session
```
