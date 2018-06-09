@echo off
:: Comment the '@echo off' command if you would prefer more indepth details of the program.
title ~Brady's J-Link O-Matic~
rem -- Author: Brady Lange
rem -- Junction Links *Hard Links* in Windows operating system - **Moving System Files to Another Partition**
rem -- Date: 6/8/18
rem -- This batch file has commands that J-Links *hard links* directories from the D: partition to the C: system partition 
rem -- to save space on the C: parition.
rem -- This batch file is useful upon installing Windows for the very first time and you have a solid state drive as your
rem -- system partition and want to save space on it.
rem -- Use this batch file in Windows Command Prompt *cmd.exe or Command.COM*
rem -- If successfully done the your system partition will not used as much space as most of the memory will now be stored
rem -- on the D: partition.
rem -- This batch file essentially tricks the C: partition by acting like all of its system sensitive directories are there
rem -- but in reality are actually stored on the D: partition. There is an instances of the directories on the C: partition
rem -- but they are hard links and not physical directories.

:: Choosing partition labels
:PartitionLabels
echo.
echo Welcome! & echo.
echo What partition would you like to have as your main partition?
echo HINT: Typically, people want to save memory on your system drive so chose another partition from that.

:PrimaryPartition
set /p choice="Drive Label - Only one letter from 'A-Z': "
if not "%choice:~1,1%"=="" (
    set UserError=InvPrimPartition
    GOTO UserErrorHandling
) 
if "%choice%" lss "a" (
    set UserError=InvPrimPartition
    GOTO UserErrorHandling
) 
if "%choice%" gtr "z" (
    set UserError=InvPrimPartition
    GOTO UserErrorHandling
)
set path=%choice%

:VerifyPrimaryPartition
echo Are you sure you want this partition label: %path%?
set /p retry="Enter 'Y' or 'N': "
:: /i = Not case sensitive
if /i "%retry%" == "Y" (
    echo Successfully registered your main partition! & echo.
    pause
) else if /i "%retry%" == "N" (
    GOTO PrimaryPartition
) else (
    set UserError=VerifyPrimPart
    GOTO UserErrorHandling
)

:SecondaryPartition
echo Thank you! Now, what partition would you like these folders to be linked to?
echo HINT: Typically, people chose the system drive so the system drive thinks it has its correct directories.
set /p choice="Drive Label - Only one letter from 'A-Z': "
if not "%choice:~1,1%"=="" (
    set UserError=InvSecPartition
    GOTO UserErrorHandling
) 
if "%choice%" lss "a" (
    set UserError=InvSecPartition
    GOTO UserErrorHandling
) 
if "%choice%" gtr "z" (
    set UserError=InvSecPartition
    GOTO UserErrorHandling
)
if /i "%choice%" equ "%path%" (
    set UserError=SameDrive
    GOTO UserErrorHandling
)
set linkpath=%choice%

:VerifySecondaryPartition
echo Are you sure you want this partition label: %linkpath%?
set /p retry="Enter 'Y' or 'N': "
if /i "%retry%" == "Y" (
    echo Successfully registered your secondary partition! & echo.
    pause
) else if /i "%retry%" == "N" (
    GOTO SecondaryPartition
) else (
    set UserError=VerifySecPart
    GOTO UserErrorHandling
)

:FinishProgram
echo ONLY press 'F' if you have already ran this program and want to finish the programs job!
set /p finish="Enter 'C' to continue or 'F' if you want to FINISH manipulating the 'Program Data' directory: "
if /i "%finish%" == "F" (
    GOTO CleanLinks
) else if /i "%finish%" == "C" (
    echo.
) else (
    set UserError=Finish
    GOTO UserErrorHandling
)

:: User Welcome Script
:Home
echo Welcome! 
set /p response=Enter 'C' to continue, 'E' to leave, or 'P' to alter your partition labels:
if /i "%response%" == "C" (
    echo Thank you. Now moving to some verification. & echo.
    pause
    cls
    GoTo WarningScript
) else if "%response%" == "" (
    set UserError=BlankWelcome
    GOTO UserErrorHandling
) else if /i "%response%" == "E" (
    :ExitProgram
    cls
    echo Thank you for using Brady Lange's J-Link Program.
    echo Have a wonderful rest of your day!
    timeout 3
    exit
) else if /i "%response%" == "P" (
    GOTO PartitionLabels
) else (
    set UserError=Welcome
    GOTO UserErrorHandling
)

:: User Interaction for Verification:
:WarningScript
echo Hi there! Thank you for using the program developed by Brady Lange.
echo For safety make sure you use this batch file on a clean install of a Windows operating system.
echo If used with a current operating system, it could cause system instability. & echo.
set /p response=Enter 'C' to continue or 'E' to cancel:  
if /i "%response%" == "C" (
    echo Your wish is my command!
    GoTo RoboCopyDirectories
) else if "%response%" == "" (
    set UserError=BlankWarning
    GOTO UserErrorHandling
) else if /i "%response%" == "E" (
    GOTO Home
) else (
    set UserError=Warning
    GOTO UserErrorHandling
)
cls

:: Catch user input error
:UserErrorHandling
cls
if "%UserError%" == "Welcome" (
    echo Error: You must ONLY use the key strokes 'C' or 'E' NOT %response%
    echo 'C' = Continue with the program.
    echo 'E' = Exit the program.
    pause
  GOTO Home
) else if "%UserError%" == "Warning" (
    echo Error: You must ONLY use the key strokes 'C' or 'E' NOT %response%
    echo 'C' = Continue with the program.
    echo 'E' = Cancel this step and go to home.
    pause
    GOTO WarningScript
) else if "%UserError%" == "BlankWelcome" (
    echo Error: You CANNOT press 'Enter' or a key stroke that produces no character ASCII value.
    echo Your options are: 
    echo 'C' = Continue with the program.
    echo 'E' = Cancel this step and go to home.
    pause
    GOTO Home
) else if "%UserError%" == "BlankWarning" (
    echo Error: You CANNOT press 'Enter' or a key stroke that produces no character ASCII value.
    echo Your options are: 
    echo 'C' = Continue with the program.
    echo 'E' = Cancel this step and go to home.
    echo Please try again.
    pause
    GOTO WarningScript
) else if "%UserError%" == "VerifyPrimPart" (
    echo Error: You CANNOT press 'Enter' or a key stroke that produces no character ASCII value.
    echo Your options are: 
    echo 'Y' = Yes.
    echo 'N' = No.
    pause
    GOTO VerifyPrimaryPartition
) else if "%UserError%" == "VerifySecPart" (
    echo Error: You CANNOT press 'Enter' or a key stroke that produces no character ASCII value.
    echo Your options are: 
    echo 'Y' = Yes.
    echo 'N' = No.
    pause
    GOTO VerifySecondaryPartition
) else if "%UserError%" == "Finish" (
    echo Error: You CANNOT press 'Enter' or a key stroke that produces no character ASCII value.
    echo Your options are: 
    echo 'C' = Continue *first time running program*
    echo 'F' = Finish program *already have completed program steps*
    pause
    GOTO FinishProgram
) else if "%UserError%" == "InvPrimPartition" (
    echo Error: You must enter ONLY one letter from A to Z.
    echo Your options are:
    echo Letters *A-Z* = A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    pause
    GOTO PrimaryPartition
) else if "%UserError%" == "InvSecPartition" (
    echo Error: You must enter ONLY one letter from A to Z.
    echo Your options are:
    echo Letters *A-Z* = A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    pause
    GOTO SecondaryPartition
) else if "%UserError%" == "SameDrive" (
    echo Error: You cannot have the same Drive Label as your main partition.
    echo Please chose another Drive Label other than %path%:.
    pause
    GOTO SecondaryPartition
)

:RoboCopyDirectories
rem -- Note: Press shift and F10 to bring up the CMD prompt upon installing Windows if copying and pasting this script
rem -- The robocopy command copys the folders from the system %linkpath%: partition and pastes them onto the %path%: partition 
cls
echo Copying your directories from %linkpath% to %path%...
pause
robocopy "%linkpath%:\Users" "%path%:\Users" /E /COPYALL /XJ
robocopy "%linkpath%:\Program Files" "%path%:\Program Files" /E /COPYALL /XJ
robocopy "%linkpath%:\Program Files (x86)" "%path%:\Program Files (x86)" /E /COPYALL /XJ
robocopy "%linkpath%:\ProgramData" "%path%:\ProgramData" /E /COPYALL /XJ

rem -- The rmdir command removes the original directory in the %linkpath%: partition since it will no longer be needed
:: /S = Recursively drill down into directories
:RemoveDirectories
cls
echo CLEANING up old directories off of the %linkpath%: drive...
pause
rmdir "%linkpath%:\Users" /S /Q
rmdir "%linkpath%:\Program Files" /S /Q
rmdir "%linkpath%:\Program Files (x86)" /S /Q
rem -- Upon trying to remove ProgramData 4 files will not be deleted because of "Access Denied"
rem -- The partition thinks these files are being used currently
rem -- You will still need to remove the rest of ProgramData directory as it will not fully be removed 
rmdir "%linkpath%:\ProgramData" /S /Q
echo An ERROR will occur on some of the '%linkpath%:\ProgramData' files
echo No worries! This is being taken care of right away
pause

:MakeJLinks
cls
rem -- The mklink (Make Link) with the /J property creates a hard link from the %path%: partition to the %linkpath%: partition
rem -- Now the C: (system partition) thinks it has its proper system directories
rem -- Don't J-Link the ProgramData directory as it hasn't been fully removed from the %linkpath%: partition 
echo CREATING J Link Directories!
pause
mklink /J "%linkpath%:\Users" "%path%:\Users"
mklink /J "%linkpath%:\Program Files" "%path%:\Program Files"
mklink /J "%linkpath%:\Program Files (x86)" "%path%:\Program Files (x86)"

rem -- Open up the Registry Editor *regedit* to register the partition labels to correct label of %path%:
echo Now opening Registry Editor *REGEDIT*...
pause
regedit 
echo -- Navigate the folders:
echo -- HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CurrentVersion
echo -- In the CurrentVersion directory change all of the partition labels to %path%: instead of %linkpath%:
echo -- HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CurrentVersion\ProfileList
echo -- In the ProfileList directory change all of the partition labels to %path%: instead of %linkpath%: & echo.
echo -- After, done complete installing of the operating system.
pause
exit

:CleanLinks
echo CLEANING the 'ProgramData' directory and junction linking it... & echo.
pause
rem -- Complete installation of Windows then open the command prompt and remove the rest of the ProgramData directory from the %linkpath%: partition
rmdir "%linkpath%:\ProgramData" /S /Q
rem -- Finally, open the command prompt and create the junction for ProgramData with this command:
mklink /J "%linkpath%:\ProgramData" "%path%:\ProgramData"

:TestForSuccess
rem -- Now test to see if you have correctly configured your junction directories
rem -- Directory to Search
echo Finding junction directories that you have created... & echo.
set directory=%linkpath%:\

rem -- The directory that will be searched
echo Directory Search: %directory% & echo.

rem -- Find SymLinks that are files in the directory
rem -- If the error level is 0 it means the folder/file exists *found*
dir "%directory%" | find "<SYMLINK>"
if %ERRORLEVEL% EQU 0 echo This is a Symbolic Link File

rem -- Find DIRECTORY SymLinks in directory
rem -- This one should be the condition that executes as we created "Directory Symbolic Links"
dir "%directory%" | find "<SYMLINKD>" 
if %ERRORLEVEL% EQU 0 echo This is a Directory Symbolic Link

rem -- Find JUNCTIONS in directory
dir "%directory%" | find "<JUNCTION>" 
if %ERRORLEVEL% EQU 0 echo This is a Directory Junction

echo You have SUCCESSFULLY junctioned the system folders 
echo from the %path%: partition to the %linkpath%: partition *system partition*
pause
GOTO ExitProgram
exit
