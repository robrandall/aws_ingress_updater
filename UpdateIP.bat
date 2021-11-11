@ECHO off

REM Rob Randall
REM 2021-02-18

REM Get the IP address using PowerShell
REM for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a

REM Get the IP address using Amazon's server
for /f %%a in ('curl --silent https://checkip.amazonaws.com') do SET PublicIP=%%a
REM Linux equivalent below.
REM MY_IP=$(curl --silent https://checkip.amazonaws.com)

REM set defaults

SET IngressDescription=%USERNAME%@%COMPUTERNAME%
SET Port=22
SET RemoveOnly=0


:loop
IF NOT "%1%"=="" (
    IF "%1%"=="--description" (
        SET IngressDescription=~%2
        SHIFT
    )
    IF "%1%"=="-d" (
        SET IngressDescription=%~2
        SHIFT
    )
    IF "%1%"=="--securitygroup" (
        SET SG=~%2
        SHIFT
    )
    IF "%1%"=="-sg" (
        SET SG=%~2
        SHIFT
    )
    IF "%1%"=="--newdescription" (
        SET NewIngressDescription=~%2
        SHIFT
    )
    IF "%1%"=="-n" (
        SET NewIngressDescription=%~2
        SHIFT
    )
    IF "%1%"=="--port" (
        SET Port=%2
        SHIFT
    )
    IF "%1%"=="-p" (
        SET Port=%2
        SHIFT
    )
    IF "%1%"=="--removeonly" (
        SET RemoveOnly=1
    )
    IF "%1%"=="-r" (
        SET RemoveOnly=1
    )
    SHIFT
    GOTO :loop
)

if "%NewIngressDescription%"=="" (
    SET NewIngressDescription=%IngressDescription%
)

IF "%SG%"=="" (
    ECHO "You must define a Security Group"
    GOTO :end
)

REM if "%NewIngressDescription%"=="" GOTO set_new
REM GOTO done
REM :set_new
REM SET NewIngressDescription=%IngressDescription%
REM :done

REM Clear any previous value
set Old_AWS_IP=

REM Find the IP address previously used from the security group
for /f %%a in ('aws ec2 describe-security-groups --profile nta --output text --group-id %SG% --query "SecurityGroups[].IpPermissions[?ToPort==`%Port%`].IpRanges[][?Description=='%IngressDescription%'][CidrIp]"') do set Old_AWS_IP=%%a
 
if NOT "%Old_AWS_IP%"=="" (
    REM Remove the previous IP Address
    aws ec2 revoke-security-group-ingress --profile nta --group-id %SG% --protocol tcp --port %Port% --cidr=%Old_AWS_IP%
)

if "%RemoveOnly%" EQU "0" (
    REM Add the  new IP Address
    aws ec2 authorize-security-group-ingress --profile nta --group-id %SG% --ip-permissions IpProtocol=tcp,FromPort=%Port%,ToPort=%Port%,IpRanges=[{CidrIp=%PublicIP%/32,Description="%NewIngressDescription%"}]
)

:end
