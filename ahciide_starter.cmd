::@echo off 
::set /a _ID=(%RANDOM%*2000/30466)+2000 
set ID=%DATE:~-4%%DATE:~4,2%%DATE:~7,2%%time:~-11,2%%time:~-8,2%%time:~-5,2% 
set PREFIX=backup_%ID% 
 
cls 
echo. 
echo ------------------------------------ 
echo AHCIIDE-Starter v31.11 
echo. 
echo force Windows to always load 
echo ALL of the storage-drivers. 
echo. 
echo backups will look like this: 
echo ^"%PREFIX%__atapi.reg^" 
echo. 
echo                 Elad Karako Aug.2017 
echo ------------------------------------ 
 
::more common
for %%x in (atapi iaStor iaStorAV iaStorV msahci pciide) do ( 
  reg export "HKLM\SYSTEM\CurrentControlSet\services\%%x" "%PREFIX%__%%x.reg" 
  sc config "%%x" start= boot
) 
::less common
for %%x in (ACPI aliide amdide cmdide CompositeBus intelide isapnp iScsiPrt LSI_FC LSI_SAS LSI_SAS2 LSI_SCSI mpio msdsm msisadrv nvraid pci viaide) do ( 
  reg export "HKLM\SYSTEM\CurrentControlSet\services\%%x" "%PREFIX%__%%x.reg" 
  sc config "%%x" start= boot
) 

echo.
echo Done. backup the reg-files, Reboot your system.
echo if you have any issues try importing them back,
echo or go back to an earlier restore-point
echo or last-known good-state.

pause 
