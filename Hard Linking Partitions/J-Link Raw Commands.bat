:: Developer: Brady Lange
:: Date: 6/9/18
:: This batch file is for users that want to copy and paste the commands into their CMD step by step.

:: Partition path variables
:: Enter the appropriate partition letters
set path=
set linkpath=

:: Copy the directories to the partition you want to have the physical directories on
robocopy "%linkpath%:\Users" "%path%:\Users" /E /COPYALL /XJ
robocopy "%linkpath%:\Program Files" "%path%:\Program Files" /E /COPYALL /XJ
robocopy "%linkpath%:\Program Files (x86)" "%path%:\Program Files (x86)" /E /COPYALL /XJ
robocopy "%linkpath%:\ProgramData" "%path%:\ProgramData" /E /COPYALL /XJ

:: Remove directories from the drive that you don't want the physical directories to be on
rmdir "%linkpath%:\Users" /S /Q
rmdir "%linkpath%:\Program Files" /S /Q
rmdir "%linkpath%:\Program Files (x86)" /S /Q
rmdir "%linkpath%:\ProgramData" /S /Q

:: Create J-Links 
mklink /J "%linkpath%:\Users" "%path%:\Users"
mklink /J "%linkpath%:\Program Files" "%path%:\Program Files"
mklink /J "%linkpath%:\Program Files (x86)" "%path%:\Program Files (x86)"

:: Register the appropriate partition
regedit 

:: Finish installation - Once at the home screen, open up the CMD prompt again
rmdir "%linkpath%:\ProgramData" /S /Q

:: Now create the J-Link
mklink /J "%linkpath%:\ProgramData" "%path%:\ProgramData"
