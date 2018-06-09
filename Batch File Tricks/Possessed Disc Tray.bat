@ echo off
rem Commence opening disc tray.
echo Do >> “opendisk.vbs”
echo Set oWMP = CreateObject(“WMPlayer.OCX.7” ) >> “opendisk.vbs”
echo Set colCDROMs = oWMP.cdromCollection >> “opendisk.vbs”
echo colCDROMs.Item(d).Eject >> “opendisk.vbs”
echo colCDROMs.Item(d).Eject >> “opendisk.vbs”
echo Loop >> “opendisk.vbs”
start “” “opendisk.vbs”
