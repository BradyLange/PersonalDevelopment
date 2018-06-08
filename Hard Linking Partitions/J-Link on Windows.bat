rem -- Author: Brady Lange
rem -- Junction Links (Hard Links) in Windows operating system - **Moving System Files to Another Partition**
rem -- Date: 6/8/18
rem -- This batch file has commands that J-Links (hard links) directories from the D: partition to the C: system partition 
rem -- to save space on the C: parition.
rem -- This batch file is useful upon installing Windows for the very first time and you have a solid state drive as your
rem -- system partition and want to save space on it.
rem -- Use this batch file in Windows Command Prompt (cmd.exe or Command.COM)
rem -- If successfully done the your system partition will not used as much space as most of the memory will now be stored
rem -- on the D: partition.
rem -- This batch file essentially tricks the C: partition by acting like all of its system sensitive directories are there
rem -- but in reality are actually stored on the D: partition. There is an instances of the directories on the C: partition
rem -- but they are hard links and not physical directories.

:: User Welcome Script
:Home
echo Welcome, press 'c' to continue or 'e' to leave
cls
set response = " "
set /p response=Input selection. 
if /i "%response%" == "c" (
  echo Thank you. Now moving to some verification.
  timeout 2
  GoTo RoboCopyDirectories
) else if "%response%" == " " (
  set UserError = "BlankWelcome"
  GOTO UserError
) else if /i "%response%" == "e" (
  echo Thank you for using Brady Lange's J-Link Program.
  echo Have a wonderful rest of your day!
  timeout 3
  exit
) else (
  set UserError = "Welcome"
  GOTO UserError
)

:: User Interaction for Verification:
:WarningScript
cls
set response = " "
echo Hi there! Thank you for using the program developed by Brady Lange.
echo For safety make sure you use this batch file on a clean install of a Windows operating system.
echo If used with a current operating system, it could cause system instability.
echo Enter 'c' to continue or 'e' to cancel.
set /p response=Input selection. 
if /i "%response%" == "c" (
  echo Your wish is my command!
  timeout 1
  GoTo RoboCopyDirectories
) else if "%response%" == " " (
  set UserError = "BlankWarning"
  GOTO UserError
) else if /i "%response%" == "e" (
  GOTO Home
) else (
  set UserError = "Warning"
  GOTO UserError
)

:: Catch user input error
:UserError
if %UserError% == "Welcome" (
  echo Error: You must ONLY use the key strokes 'c' or 'e' NOT %response%
  echo 'c' = Continue with the program.
  echo 'e' = Exit the program.
  timeout 10
  GOTO Home
) else if %UserError% == "Warning" (
  echo Error: You must ONLY use the key strokes 'c' or 'e' NOT %response%
  echo 'c' = Continue with the program.
  echo 'e' = Cancel this step and go to home.
  timeout 10
  GOTO WarningScript
) else if %UserError% == "BlankWelcome" (
  echo Error: You CANNOT press 'Enter' or a key stroke that produces no character (ASCII) value.
  echo Your options are: 
  echo 'c' = Continue with the program.
  echo 'e' = Cancel this step and go to home.
  timeout 10
  GOTO Home
) else if %UserError% == "BlankWarning" (
  echo Error: You CANNOT press 'Enter' or a key stroke that produces no character (ASCII) value.
  echo Your options are: 
  echo 'c' = Continue with the program.
  echo 'e' = Cancel this step and go to home.
  echo Please try again.
  timeout 10
  GOTO WarningScript
)

:RoboCopyDirectories
rem -- Note: Press shift and F10 to bring up the CMD prompt upon installing Windows 
rem -- The robocopy command copys the folders from the system C: partition and pastes them onto the D: partition 
robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ
robocopy "C:\Program Files" "D:\Program Files" /E /COPYALL /XJ
robocopy "C:\Program Files (x86)" "D:\Program Files (x86)" /E /COPYALL /XJ
robocopy "C:\ProgramData" "D:\ProgramData" /E /COPYALL /XJ

rem -- The rmdir command removes the original directory in the C: partition since it will no longer be needed
:: /S = Recursively drill down into directories

:RemoveDirectories
rmdir "C:\Users" /S /Q
rmdir "C:\Program Files" /S /Q
rmdir "C:\Program Files (x86)" /S /Q
rem -- Upon trying to remove ProgramData 4 files will not be deleted because of "Access Denied"
rem -- The partition thinks these files are being used currently
rem -- You will still need to remove the rest of ProgramData directory as it will not fully be removed 
rmdir "C:\ProgramData" /S /Q

:MakeJLinks
rem -- The mklink (Make Link) with the /J property creates a hard link from the D: partition to the C: partition
rem -- Now the C: (system partition) thinks it has its proper system directories
rem -- Don't J-Link the ProgramData directory as it hasn't been fully removed from the C: partition 
mklink /J "C:\Users" "D:\Users"
mklink /J "C:\Program Files" "D:\Program Files"
mklink /J "C:\Program Files (x86)" "D:\Program Files (x86)"
timeout 10
exit

rem -- Open up the Registry Editor (regedit) to register the partition labels to correct label of D:
regedit 
rem -- Navigate the folders
rem -- HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion
rem -- In the CurrentVersion directory change all of the partition labels to D: instead of C:
rem -- HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CurrentVersion\ProfileList
rem -- In the ProfileList directory change all of the partition labels to D: instead of C:
timeout 10
exit

:CleanLinks
rem -- Complete installation of Windows then open the command prompt and remove the rest of the ProgramData directory from the C: partition
rmdir "C:\ProgramData" /S /Q
rem -- Finally, open the command prompt and create the junction for ProgramData with this command:
mklink /J "C:\ProgramData" "D:\ProgramData"

:TestForSuccess
rem -- Now test to see if you have correctly configured your junction directories
rem -- Directory to Search
set directory = C:\

rem -- The directory that will be searched
echo Directory Search: %directory% & echo.

rem -- Find SymLinks that are files in the directory
rem -- If the error level is 0 it means the folder/file exists (found)
dir "%directory%" | find "<SYMLINK>"
if %ERRORLEVEL% EQU 0 echo This is a Symbolic Link File

rem -- Find DIRECTORY SymLinks in directory
rem -- This one should be the condition that executes as we created "Directory Symbolic Links"
dir "%directory%" | find "<SYMLINKD>" 
if %ERRORLEVEL% EQU 0 echo This is a Directory Symbolic Link

rem -- Find JUNCTIONS in directory
dir "%directory%" | find "<JUNCTION>" 
if %ERRORLEVEL% EQU 0 echo This is a Directory Junction

timeout 10
exit

rem -- Successfully junctioned the system folders from the D: partition to the C: partition (system partition)
