rem Rob Randall
rem 2021-02-18

rem Get the IP address using PowerShell
rem for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a

rem Get the IP address using Amazon's server
for /f %%a in ('curl --silent https://checkip.amazonaws.com') do set PublicIP=%%a
rem Linux equivalent below.
rem MY_IP=$(curl --silent https://checkip.amazonaws.com)

REM set defaults

set IngressDescription=Robs Home IP
set port=22

:loop
IF NOT "%1%"=="" (
    if "%1%"=="--description" (
        SET IngressDescription=~%2
        SHIFT
    )
    if "%1%"=="-d" (
        SET IngressDescription=%~2
        SHIFT
    )
    if "%1%"=="--newdescription" (
        SET NewIngressDescription=~%2
        SHIFT
    )
    if "%1%"=="-n" (
        SET NewIngressDescription=%~2
        SHIFT
    )
    if "%1%"=="--port" (
        SET port=%2
        SHIFT
    )
    if "%1%"=="-p" (
        SET port=%2
        SHIFT
    )
    SHIFT
    GOTO :loop
)

if "%NewIngressDescription%"=="" (
    SET NewIngressDescription=%IngressDescription%
)

rem if "%NewIngressDescription%"=="" GOTO set_new
rem GOTO done
rem :set_new
rem SET NewIngressDescription=%IngressDescription%
rem :done

rem Find the IP address previously used from the security group
for /f %%a in ('aws ec2 describe-security-groups --profile nta --output text --group-id sg-0c794359dc78016af --query "SecurityGroups[].IpPermissions[?ToPort==`%port%`].IpRanges[][?Description=='%IngressDescription%'][CidrIp]"') do set Old_AWS_IP=%%a
 
rem Remove the previous IP Address
aws ec2 revoke-security-group-ingress --profile nta --group-id sg-0c794359dc78016af --protocol tcp --port %PORT% --cidr=%Old_AWS_IP%

rem Add the  new IP Address
aws ec2 authorize-security-group-ingress --profile nta --group-id sg-0c794359dc78016af --ip-permissions IpProtocol=tcp,FromPort=%PORT%,ToPort=%PORT%,IpRanges=[{CidrIp=%PublicIP%/32,Description="%NewIngressDescription%"}]

