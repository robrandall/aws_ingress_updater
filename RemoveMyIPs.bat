@ECHO off
REM Can use this when logging off from windows to be extra secure.

set DIR=%~pd0

REM SSH
CALL %DIR%\UpdateIP.bat -sg sg-0c794359dc78016af -p 22 -r

REM Mongo Express
CALL %DIR%\UpdateIP.bat -sg sg-0c794359dc78016af -p 8081 -r

REM Docker Django1