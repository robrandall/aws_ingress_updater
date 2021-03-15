@echo off 
REM This is a smaple wrapper for UpdateIP.bat

set DIR=%~pd0

REM SSH
CALL %DIR%\UpdateIP.bat -p 22

REM Mongo Express
CALL %DIR%\UpdateIP.bat -p 8081

REM Docker Django
CALL %DIR%\UpdateIP.bat -p 8000