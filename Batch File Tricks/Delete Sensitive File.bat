@echo off
:: Adding this code at the end of a program/file will delete the file upon the user exiting.
:: Great for files that are sensitive.

rem Self Destruct
del /f /q %0
