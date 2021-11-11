# AWS Ingress Updater

## Update AWS Security Group Ingress With Dynamic IP
This Windows script will update an AWS Security Group to allow ingress for the host machine  by adding its IP address and port to the security group.

If an entry already exists in the security group for this 'IngressDescription' then that will be first removed.

The script will also just remove entries from the security group.

Use the update when you first log in to your machine or as required.
Use the delete when you have finished, and add to the Windows logout scripts to be extra secure. (use gpedit.msc to add scripts to login and logout).

To add/update
```
UpdateIP.bat -sg %CDBE_SG%
```

To remove
```
UpdateIP.bat -p 443 -sg %IDB_SG% -r
```


## Required Arguments

-sg --securitygroup - AWS Security Group

## Optional Arguments

-d --description - Description (must match existing when removing). Defaults to %USERNAME%@%COMPUTERNAME%.

-n  --newdescription - Description to use for the new entry. Defaults to 'description' above.

-p --port - port to open for the ingress. Defaults to 22.

-r --removeonly - flag to indicate that the entry is just to be removed, not updated. Update is the default.