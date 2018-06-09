@echo off

:: This code disables Task Manager
rem Disable Task Manager
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_SZ /d 1 /f >nul

:: Comment out the above code and
:: Uncomment this code to re-enable the Task Manager
:: rem Enable Task Manager
:: reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_SZ /d 1 /f >nul
