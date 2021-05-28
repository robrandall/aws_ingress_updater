@echo off 
REM This is a smaple wrapper for UpdateIP.bat

set DIR=%~pd0

REM SSH
CALL %DIR%\UpdateIP.bat -sg sg-0c794359dc78016af 

REM Mongo Express
CALL %DIR%\UpdateIP.bat -p 8081 -sg sg-0c794359dc78016af 

REM Docker Django
REM CALL %DIR%\UpdateIP.bat -p 8888 -sg sg-0c794359dc78016af 

REM Docker Redis
CALL %DIR%\UpdateIP.bat -p 6379 -sg sg-0c794359dc78016af 

REM Django protected pages
CALL %DIR%\UpdateIP.bat -p 8443 -sg sg-0c794359dc78016af 

REM Access to IDB
CALL %DIR%\UpdateIP.bat -p 443 -sg sg-0dca9eb1846b7a219