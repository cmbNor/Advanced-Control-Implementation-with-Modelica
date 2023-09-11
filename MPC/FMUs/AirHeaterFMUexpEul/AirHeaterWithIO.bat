@echo off
SET PATH=;C:/Program Files/OpenModelica1.21.0-dev-64bit/bin/;%PATH%;
SET ERRORLEVEL=
CALL "%CD%/AirHeaterWithIO.exe" %*
SET RESULT=%ERRORLEVEL%

EXIT /b %RESULT%
