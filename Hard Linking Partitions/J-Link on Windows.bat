rem -- Author: Brady Lange
rem -- Junction Links (Hard Links) in Windows operating system - **Moving System Files to Another Partition**
rem -- Date: 6/6/18
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

rem -- These commands copy the folders from the system C: partition
robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ
robocopy "C:\Program Files" "E:\Program Files" /E /COPYALL /XJ
robocopy "C:\Program Files (x86)" "E:\Program Files (x86)" /E /COPYALL /XJ
robocopy "C:\ProgramData" "E:\ProgramData" /E /COPYALL /XJ

rem -- These commands remove the original directory in the C: partition since it will no longer be needed
rmdir "C:\Users" /S /Q
rmdir "C:\Program Files" /S /Q
rmdir "C:\Program Files (x86)" /S /Q
rem -- You will still need to remove the rest of ProgramData directory as it will not fully be removed 
rmdir "C:\ProgramData" /S /Q

rem -- The mklink (Make Link) with the /J property creates a hard link from the D: partition to the C: partition
rem -- Now the C: (system partition) thinks it has its proper system directories
rem -- Don't J-Link the ProgramData directory as it hasn't been fully removed from the C: partition 
mklink /J "C:\Users" "D:\Users"
mklink /J "C:\Program Files" "E:\Program Files"
mklink /J "C:\Program Files (x86)" "E:\Program Files (x86)"
rem -- Complete installation of Windows then open the command prompt and remove the rest of the ProgramData directory from the C: partition
rmdir "C:\ProgramData" /S /Q
rem -- Finally, open the command prompt and create the junction for ProgramData with this command:
mklink /J "C:\ProgramData" "E:\ProgramData"

rem -- Successfully junctioned the system folders from the D: partition to the C: partition (system partition)
