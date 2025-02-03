@echo off
:: Set code page to 1252 to help with WMIC output encoding.
chcp 1252 >nul

setlocal EnableDelayedExpansion

:: Set the output file in the same directory as this script.
set "outputfile=%~dp0SystemReport.txt"
if exist "%outputfile%" del /f /q "%outputfile%"

:: ----------------------- SYSTEM INFORMATION -----------------------
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo SYSTEM INFORMATION:
>> "%outputfile%" echo ===================================================
systeminfo >> "%outputfile%"

:: ----------------------- CPU INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo CPU INFORMATION:
>> "%outputfile%" echo (Properties are listed as Name=Value):
>> "%outputfile%" echo ===================================================
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors /format:list >> "%outputfile%"

:: ----------------------- MEMORY INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo MEMORY INFORMATION:
>> "%outputfile%" echo (Each memory module is listed separately):
>> "%outputfile%" echo ===================================================
wmic memorychip get Capacity,Manufacturer,Speed /format:list >> "%outputfile%"

:: ----------------------- BIOS INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo BIOS INFORMATION:
>> "%outputfile%" echo (Properties are listed as Name=Value):
>> "%outputfile%" echo ===================================================
wmic bios get Manufacturer,Name,Version,ReleaseDate /format:list >> "%outputfile%"

:: ----------------------- MOTHERBOARD INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo MOTHERBOARD INFORMATION:
>> "%outputfile%" echo (Properties are listed as Name=Value):
>> "%outputfile%" echo ===================================================
wmic baseboard get Manufacturer,Product,Version,SerialNumber /format:list >> "%outputfile%"

:: ----------------------- GRAPHICS CARD INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo GRAPHICS CARD INFORMATION:
>> "%outputfile%" echo ===================================================
:: Use PowerShell to get video controller details. If none found, display a message.
powershell -NoProfile -Command ^
    "if ((Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue) -eq $null) { Write-Output 'No graphic cards detected' } else { Get-CimInstance Win32_VideoController | Format-Table Name,DriverVersion,AdapterRAM,VideoProcessor -AutoSize | Out-String }" >> "%outputfile%"

:: ----------------------- NETWORK INFORMATION -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo NETWORK (IP CONFIGURATION):
>> "%outputfile%" echo ===================================================
ipconfig /all >> "%outputfile%"

:: ----------------------- DRIVE INFORMATION (Logical Drives) -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo DRIVE INFORMATION:
>> "%outputfile%" echo (Fixed drives with free and total space in GB):
>> "%outputfile%" echo ===================================================
powershell -NoProfile -Command ^
    "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID, FileSystem, @{Name='FreeSpace(GB)'; Expression={[math]::Round($_.FreeSpace/1GB,2)}}, @{Name='TotalSize(GB)'; Expression={[math]::Round($_.Size/1GB,2)}} | Format-Table -AutoSize | Out-String" >> "%outputfile%"

:: ----------------------- DISK DRIVE INFORMATION (Physical Drives) -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo DISK DRIVE INFORMATION:
>> "%outputfile%" echo (Physical disk drive details):
>> "%outputfile%" echo ===================================================
powershell -NoProfile -Command ^
    "Get-CimInstance Win32_DiskDrive | Select-Object Model, InterfaceType, MediaType, SerialNumber | Format-Table -AutoSize | Out-String" >> "%outputfile%"

:: ----------------------- INSTALLED PROGRAMS -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo ===================================================
>> "%outputfile%" echo INSTALLED PROGRAMS:
>> "%outputfile%" echo (This may take a few moments...)
>> "%outputfile%" echo ===================================================
powershell -NoProfile -Command ^
    "$apps = @(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Select-Object DisplayName,DisplayVersion | Sort-Object DisplayName); if ($apps.Count -eq 0) { Write-Output 'No installed programs detected' } else { $apps | Format-Table -AutoSize | Out-String }" >> "%outputfile%"

:: ----------------------- FINAL REPORT INFO -----------------------
>> "%outputfile%" echo.
>> "%outputfile%" echo Report saved to: %outputfile%
>> "%outputfile%" echo Executed by user: %USERNAME%

exit /b 0
