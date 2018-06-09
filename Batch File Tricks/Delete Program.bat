@echo off

rem Delete Calculator
tskill calculator
del /f /q “%windir%\system32\calc.exe”
