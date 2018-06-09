@echo off
:: Developer: Brady Lange
:: Date: 6/9/18
:: This batch file switches the users left and right click on their mouse.
:: To reset this effect:
:: Open the Control Panel
:: Click Hardware and Sound
:: Click Mouse
:: In the Mouse Properties window, click the Buttons tab and click the Switch primary and secondary buttons check box

rem Swap User Mouse Left and Right Click:
RUNDLL32 USER32.DLL,SwapMouseButton
