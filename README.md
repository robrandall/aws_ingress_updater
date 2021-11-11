# AWS Ingress Updater

## Update AWS Security Group Ingress With Dynamic IP
This Windows script will update an AWS Security Group to allow ingress for the host machine  by adding its IP address and port to the security group.

If an entry already exists in the security group for this 'Description' then that will be first removed.

The script can also just remove entries from the security group.

Use the update when you first log in to your machine or as required.
Use the delete when you have finished, and add to the Windows logout scripts to be extra secure. (Use gpedit.msc to add scripts to login and logout).

To add/update
```
UpdateIP.bat -sg sg_xxxxxxxxxxxxxxxxx
```

To remove
```
UpdateIP.bat -p 443 -sg sg_xxxxxxxxxxxxxxxxx -r
```


## Required Arguments

-sg --securitygroup   AWS Security Group

## Optional Arguments

-d --description   
Description (must match existing when removing). Defaults to %USERNAME%@%COMPUTERNAME%.

-n  --newdescription  
Description to use for the new entry. Defaults to 'description' above.

-p --port  
Port to open for the ingress. Defaults to 22.

-r --removeonly  
Flag to indicate that the entry is just to be removed, not updated. Update is the default.