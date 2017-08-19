@echo off 
::set /a _ID=(%RANDOM%*2000/30466)+2000 
set ID=%DATE:~-4%%DATE:~4,2%%DATE:~7,2%%time:~-11,2%%time:~-8,2%%time:~-5,2% 
set PREFIX=backup_%ID% 
 
cls 
echo. 
echo ------------------------------------
echo      !! DO NOT USE THIS TOOL !!
echo   FOR ADMINS ONLY.
echo   CREATE RESTORE-POINT BEFORE USE.
echo ------------------------------------ 
echo AHCIIDE-Starter v31.11 
echo. 
echo force Windows to always load 
echo ALL of the storage-drivers. 
echo. 
echo                 Elad Karako Aug.2017 
echo ------------------------------------ 
 
for %%x in (ACPI adpahci aliide amdide amdsata atapi cmdide CompositeBus iaStor iaStorAV iaStorV intelide isapnp iScsiPrt LSI_FC LSI_SAS LSI_SAS2 LSI_SCSI mpio msahci msdsm msisadrv nvraid pci pciide viaide) do ( 
  reg export "HKLM\SYSTEM\CurrentControlSet\services\%%x" "%PREFIX%__%%x.reg" 
  sc config "%%x" start= boot
) 

echo.
echo ------------------------------------------------------------
echo Done.
echo Reboot your system.
echo.
echo Any issues? Try to Revert the Changes:
echo 1. If you can switch the IDE-mode back
echo    and reboot into Windows, run each of
echo    the backup files to restore the start-state
echo    of each driver.
echo 2. If you can not boot into Windows,
echo    try restoring from last known-good state,
echo    or an earlier restore-point.
echo.
echo 3. If #1 and #2 do not work for you
echo    .....you're pretty much fucked..
echo.
echo Have Fun!
echo.

pause