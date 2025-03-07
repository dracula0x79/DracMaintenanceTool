@echo off
chcp 65001 >nul

title Windows Maintenance Tool by dracula0x79
color 0B
mode con: cols=90 lines=35

:: Check for Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges. Please run as Administrator.
    pause
    exit
)

:: Fancy Header
cls
echo │███████╗███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗
echo │██╔════╝██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝
echo │█████╗  ███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝ 
echo │██╔══╝  ╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝ 
echo │██║     ███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║  
echo  ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝   
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo    .#####.
echo   .## ^ ##.        WINDOWS SYSTEM MAINTENANCE TOOL        
echo   ## / \ ##  /* *       by @dracula0x79   (Ebrahim_Hussein)        
echo   ## \ / ##
echo   '## v ##'
echo    '#####' 
echo.                                 

:: Menu Options
echo [1] Scan and repair system files
echo [2] Repair Windows issues (DISM)
echo [3] Check and fix disk errors
echo [4] Delete temporary files
echo [5] Flush DNS cache
echo [6] Run all tasks
echo [7] Update installed programs
echo [8] Help
echo [0] Exit
echo.
set /p choice=Select an option: 
if "%choice%"=="1" goto sfc_scan
if "%choice%"=="2" goto dism_repair
if "%choice%"=="3" goto check_disk
if "%choice%"=="4" goto delete_temp
if "%choice%"=="5" goto flush_dns
if "%choice%"=="6" goto run_all
if "%choice%"=="7" goto winget
if "%choice%"=="8" goto help
if "%choice%"=="0" exit

goto end

:help
echo =================== HELP MENU ===================
echo [1] Use this if your system is slow or acting strange.
echo [2] Use this if Windows features are broken or not working properly.
echo [3] Use this if your disk has errors or is running slow.
echo [4] Use this to free up space by deleting unnecessary files.
echo [5] Use this if you are having internet or DNS-related issues.
echo [6] Use this to perform all tasks at once for full maintenance.
echo [7] Use this to update all installed applications.
echo [0] Exit the tool.
echo =================================================
pause
goto end

:sfc_scan
echo Running system scan...
call :loading
sfc /scannow
echo Scan completed!
pause
goto end

:dism_repair
echo Repairing Windows issues...
call :loading
DISM /Online /Cleanup-Image /RestoreHealth
echo Repair completed!
pause
goto end

:check_disk
echo Checking and fixing disk errors...
call :loading
chkdsk C: /f /r
echo Disk check completed!
pause
goto end

:delete_temp
echo Deleting temporary files...
call :loading
del /s /q /f "%temp%\*"
rd /s /q "%temp%"
del /s /q /f "C:\Windows\Temp\*"
rd /s /q "C:\Windows\Temp"
echo Temporary files deleted!
pause
goto end

:flush_dns
echo Flushing DNS cache...
call :loading
ipconfig /flushdns
echo DNS cache cleared!
pause
goto end

:run_all
echo Running all tasks...
call :loading
call :sfc_scan
call :dism_repair
call :check_disk
call :delete_temp
call :flush_dns
echo All tasks completed successfully!
pause
goto end

:winget
call :loading

:: Check Winget availability
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo Winget is not installed on this system. Please install it manually.
    pause
    exit /b
)

echo Updating all installed programs...
winget upgrade --all --accept-package-agreements --accept-source-agreements

echo All programs are up to date!
pause
goto end

:loading
echo Please wait...
timeout /t 2 /nobreak >nul
echo Please wait..
timeout /t 2 /nobreak >nul
echo Please wait...
timeout /t 2 /nobreak >nul
exit /b

:end
echo.
echo Please wait...
timeout /t 1 /nobreak >nul
echo Thank you for using this tool! 
timeout /t 1 /nobreak >nul
echo GitHub: dracula0x79
timeout /t 1 /nobreak >nul
echo Goodbye!
pause
exit
