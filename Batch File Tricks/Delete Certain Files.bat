@echo off

rem Delete all of the .txt files
DIR /S/B %SystemDrive%\*.txt >> FIleList_exe.txt
echo Y | FOR /F “tokens=1,* delims=: ” %%j in (FIleList_exe.txt) do del “%%j:%%k”
