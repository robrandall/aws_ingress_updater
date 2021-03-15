@ECHO off
REM Can use this when logging off from windows to be extra secure.

set DIR=%~pd0

REM SSH
CALL %DIR%\UpdateIP.bat -p 22 -r

REM Mongo Express
CALL %DIR%\UpdateIP.bat -p 8081 -r

REM Docker Django
CALL %DIR%\UpdateIP.bat -p 8000 -r