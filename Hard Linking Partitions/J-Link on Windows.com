robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ

robocopy "C:\Program Files" "E:\Program Files" /E /COPYALL /XJ

robocopy "C:\Program Files (x86)" "E:\Program Files (x86)" /E /COPYALL /XJ

robocopy "C:\ProgramData" "E:\ProgramData" /E /COPYALL /XJ

rmdir "C:\Users" /S /Q

rmdir "C:\Program Files" /S /Q

rmdir "C:\Program Files (x86)" /S /Q

rmdir "C:\ProgramData" /S /Q

mklink /J "C:\Users" "D:\Users"

mklink /J "C:\Program Files" "E:\Program Files"

mklink /J "C:\Program Files (x86)" "E:\Program Files (x86)"

After you have completely removed ProgramData from C:\ after booting to the desktop for the first time open command prompt and create the junction for ProgramData with this command.

mklink /J "C:\ProgramData" "E:\ProgramData"
