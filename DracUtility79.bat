@echo off
chcp 65001 >nul

title Windows Maintenance Tool by dracula0x79
color 0F
mode con: cols=90 lines=45

:: Check for Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges. Please run as Administrator.
    pause
    exit
)

:: Setup Log File
set "LOGFILE=%~dp0maintenance_log.txt"
call :log "=== Session Started ==="

cls
call :print_header

:menu
:: Clear the choice variable so hitting Enter doesn't re-trigger the last command
set "choice="
cls
call :print_header
echo.
echo  ┌─────────────────────────────────────────────────────┐
echo  │              SYSTEM MAINTENANCE                     │
echo  │  [1] Scan and repair system files (SFC)             │
echo  │  [2] Repair Windows issues (DISM)                   │
echo  │  [3] Check and fix disk errors                      │
echo  │  [4] Delete temporary files                         │
echo  │  [5] Flush DNS cache                                │
echo  │  [6] Run all maintenance tasks                      │
echo  │  [7] Update installed programs (Winget)             │
echo  ├─────────────────────────────────────────────────────┤
echo  │              SECURITY TOOLS                         │
echo  │  [8]  Show Open Ports + Processes                   │
echo  │  [9]  Scan with Windows Defender                    │
echo  │  [10] Check Startup Programs                        │
echo  │  [11] Check Scheduled Tasks (suspicious)            │
echo  │  [12] Show All Users + Admin Accounts               │
echo  ├─────────────────────────────────────────────────────┤
echo  │              NETWORK TOOLS                          │
echo  │  [13] Full Network Reset                            │
echo  │  [14] Change DNS (Cloudflare / Google)              │
echo  │  [15] Show All Saved Wi-Fi Passwords                │
echo  │  [16] Show Network Shares on this PC                │
echo  ├─────────────────────────────────────────────────────┤
echo  │              POWER TOOLS                            │
echo  │  [17] Kill a Process by Name                        │
echo  │  [18] Enable / Disable a Service                    │
echo  │  [19] View Last 24h Event Log Errors                │
echo  │  [20] Create System Restore Point                   │
echo  │  [21] Speed Up Windows (Disable Animations)         │
echo  ├─────────────────────────────────────────────────────┤
echo  │  [22] Wi-Fi Password (single network)               │
echo  │  [H]  Help        [L] View Log        [0] Exit      │
echo  └─────────────────────────────────────────────────────┘
echo.
set /p choice=  Select an option: 

if "%choice%"=="1"  goto sfc_scan
if "%choice%"=="2"  goto dism_repair
if "%choice%"=="3"  goto check_disk
if "%choice%"=="4"  goto delete_temp
if "%choice%"=="5"  goto flush_dns
if "%choice%"=="6"  goto run_all
if "%choice%"=="7"  goto winget
if "%choice%"=="8"  goto open_ports
if "%choice%"=="9"  goto defender_scan
if "%choice%"=="10" goto startup_check
if "%choice%"=="11" goto sched_tasks
if "%choice%"=="12" goto show_users
if "%choice%"=="13" goto net_reset
if "%choice%"=="14" goto change_dns
if "%choice%"=="15" goto all_wifi_pass
if "%choice%"=="16" goto net_shares
if "%choice%"=="17" goto kill_process
if "%choice%"=="18" goto toggle_service
if "%choice%"=="19" goto event_log
if "%choice%"=="20" goto restore_point
if "%choice%"=="21" goto speed_up
if "%choice%"=="22" goto ext_NetPass
if /i "%choice%"=="H" goto help
if /i "%choice%"=="L" goto view_log
if "%choice%"=="0"  goto goodbye
goto menu

:: ══════════════════════════════════════════════
::              MAINTENANCE TASKS
:: ══════════════════════════════════════════════

:sfc_scan
cls
echo  [SFC] Running system file scan...
call :log "SFC Scan started"

sfc /scannow
call :log "SFC Scan completed"
echo  Done! Logged to: %LOGFILE%
pause
goto menu

:dism_repair
cls
echo  [DISM] Repairing Windows image...
call :log "DISM Repair started"

DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM Repair completed"
echo  Done!
pause
goto menu

:check_disk
cls
echo  [CHKDSK] Checking disk errors...
call :log "CHKDSK started"

chkdsk C: /f /r
call :log "CHKDSK completed"
echo  Done!
pause
goto menu

:delete_temp
cls
echo  [TEMP] Deleting temporary files...
call :log "Temp cleanup started"

del /s /q /f "%temp%\*" >nul 2>&1
del /s /q /f "C:\Windows\Temp\*" >nul 2>&1
call :log "Temp cleanup completed"
echo  Temporary files deleted!
pause
goto menu

:flush_dns
cls
echo  [DNS] Flushing DNS cache...
call :log "DNS Flush started"

ipconfig /flushdns
call :log "DNS Flush completed"
pause
goto menu

:run_all
cls
echo  [ALL] Running all maintenance tasks...
call :log "Run All started"

call :sfc_scan
call :dism_repair
call :check_disk
call :delete_temp
call :flush_dns
call :log "Run All completed"
echo  All tasks completed!
pause
goto menu

:winget
cls

where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo  Winget is not installed. Please install it manually.
    pause
    goto menu
)
echo  [WINGET] Updating all installed programs...
call :log "Winget upgrade started"
winget upgrade --all --accept-package-agreements --accept-source-agreements
call :log "Winget upgrade completed"
echo  All programs updated!
pause
goto menu

:: ══════════════════════════════════════════════
::              SECURITY TOOLS
:: ══════════════════════════════════════════════

:open_ports
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        OPEN PORTS + PROCESSES                   ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Open Ports scan started"

echo  [*] Active connections and listening ports:
echo  ─────────────────────────────────────────────────
netstat -ano | findstr "LISTENING"
echo.
echo  ─────────────────────────────────────────────────
echo  [*] All active connections:
netstat -ano | findstr "ESTABLISHED"
echo.
echo  [TIP] Use Task Manager to match PID to process name
call :log "Open Ports scan completed"
pause
goto menu

:defender_scan
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        WINDOWS DEFENDER FULL SCAN               ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [!] This may take several minutes...
call :log "Defender scan started"

"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
call :log "Defender scan completed"
echo  Scan finished! Check Windows Security for results.
pause
goto menu

:startup_check
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        STARTUP PROGRAMS                         ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Startup check started"

echo  [*] Startup entries from Registry (Current User):
echo  ─────────────────────────────────────────────────
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
echo.
echo  [*] Startup entries from Registry (All Users):
echo  ─────────────────────────────────────────────────
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
echo.
echo  [*] Startup folder items:
echo  ─────────────────────────────────────────────────
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /b
call :log "Startup check completed"
pause
goto menu

:sched_tasks
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        SCHEDULED TASKS (non-Microsoft)          ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Scheduled tasks check started"

echo  [*] Tasks NOT made by Microsoft (check these!):
echo  ─────────────────────────────────────────────────
schtasks /query /fo LIST /v | findstr /i /v "microsoft\|\\Microsoft"| findstr "TaskName Status"
echo.
echo  [TIP] Suspicious = random names or unknown publishers
call :log "Scheduled tasks check completed"
pause
goto menu

:show_users
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        USERS + ADMIN ACCOUNTS                   ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "User check started"

echo  [*] All user accounts on this PC:
echo  ─────────────────────────────────────────────────
net user
echo.
echo  [*] Members of Administrators group:
echo  ─────────────────────────────────────────────────
net localgroup Administrators
echo.
echo  [TIP] Any unknown admin account = RED FLAG
call :log "User check completed"
pause
goto menu

:: ══════════════════════════════════════════════
::              NETWORK TOOLS
:: ══════════════════════════════════════════════

:net_reset
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        FULL NETWORK RESET                       ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [!] This will reset all network settings.
set /p confirm=  Are you sure? (Y/N): 
if /i not "%confirm%"=="Y" goto menu
call :log "Full network reset started"

echo  Resetting Winsock...
netsh winsock reset
echo  Resetting IP stack...
netsh int ip reset
echo  Flushing DNS...
ipconfig /flushdns
echo  Releasing IP...
ipconfig /release
echo  Renewing IP...
ipconfig /renew
call :log "Full network reset completed"
echo.
echo  [!] Please RESTART your PC for changes to take effect.
pause
goto menu

:change_dns
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        CHANGE DNS SERVER                        ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [1] Cloudflare  (1.1.1.1 / 1.0.0.1)  - Fastest + Private
echo  [2] Google      (8.8.8.8 / 8.8.4.4)  - Reliable
echo  [3] Restore Default (DHCP automatic)
echo.
set /p dns_choice=  Select DNS: 

if "%dns_choice%"=="1" (
    call :log "DNS changed to Cloudflare"
    netsh interface ip set dns name="Wi-Fi" static 1.1.1.1
    netsh interface ip add dns name="Wi-Fi" 1.0.0.1 index=2
    netsh interface ip set dns name="Ethernet" static 1.1.1.1
    netsh interface ip add dns name="Ethernet" 1.0.0.1 index=2
    echo  DNS set to Cloudflare!
)
if "%dns_choice%"=="2" (
    call :log "DNS changed to Google"
    netsh interface ip set dns name="Wi-Fi" static 8.8.8.8
    netsh interface ip add dns name="Wi-Fi" 8.8.4.4 index=2
    netsh interface ip set dns name="Ethernet" static 8.8.8.8
    netsh interface ip add dns name="Ethernet" 8.8.4.4 index=2
    echo  DNS set to Google!
)
if "%dns_choice%"=="3" (
    call :log "DNS restored to DHCP"
    netsh interface ip set dns name="Wi-Fi" dhcp
    netsh interface ip set dns name="Ethernet" dhcp
    echo  DNS restored to automatic!
)
ipconfig /flushdns
pause
goto menu

:all_wifi_pass
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        ALL SAVED WI-FI PASSWORDS                ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Wi-Fi password dump started"

echo  [*] Extracting all saved networks and passwords...
echo  ─────────────────────────────────────────────────
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set "profile=%%a"
    setlocal enabledelayedexpansion
    set "profile=!profile:~1!"
    echo.
    echo  Network: !profile!
    netsh wlan show profile name="!profile!" key=clear | findstr "Key Content"
    endlocal
)
call :log "Wi-Fi password dump completed"
echo.
pause
goto menu

:net_shares
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        SHARED FOLDERS ON THIS PC                ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Net shares check started"

echo  [*] All shared folders (including hidden $):
echo  ─────────────────────────────────────────────────
net share
echo.
echo  [TIP] C$ D$ ADMIN$ = default Windows shares (normal)
echo  [TIP] Any other share you don't recognize = investigate!
call :log "Net shares check completed"
pause
goto menu

:: ══════════════════════════════════════════════
::              POWER TOOLS
:: ══════════════════════════════════════════════

:kill_process
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        KILL PROCESS BY NAME                     ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [*] Running processes:
tasklist /fo table /nh | more
echo.
set /p procname=  Enter process name to kill (e.g. notepad.exe): 
if "%procname%"=="" goto menu
call :log "Kill process: %procname%"
taskkill /f /im "%procname%"
echo  Done!
pause
goto menu

:toggle_service
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        ENABLE / DISABLE SERVICE                 ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  Common services:
echo    wuauserv      = Windows Update
echo    Spooler       = Print Spooler
echo    wSearch       = Windows Search
echo    SysMain       = Superfetch (can slow old PCs)
echo    DiagTrack     = Telemetry (sends data to Microsoft)
echo.
set /p svcname=  Enter service name: 
if "%svcname%"=="" goto menu
echo.
echo  [1] Start service
echo  [2] Stop service
echo  [3] Disable service (won't start on boot)
echo  [4] Enable service (set to auto)
set /p svc_action=  Select action: 

if "%svc_action%"=="1" (
    net start "%svcname%"
    call :log "Service started: %svcname%"
)
if "%svc_action%"=="2" (
    net stop "%svcname%"
    call :log "Service stopped: %svcname%"
)
if "%svc_action%"=="3" (
    sc config "%svcname%" start= disabled
    call :log "Service disabled: %svcname%"
)
if "%svc_action%"=="4" (
    sc config "%svcname%" start= auto
    call :log "Service enabled: %svcname%"
)
pause
goto menu

:event_log
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        LAST 24H SYSTEM ERRORS                   ║
echo  ╚══════════════════════════════════════════════════╝
echo.
call :log "Event log check started"

echo  [*] Critical and Error events in last 24 hours:
echo  ─────────────────────────────────────────────────
wevtutil qe System /q:"*[System[(Level=1 or Level=2) and TimeCreated[timediff(@SystemTime) <= 86400000]]]" /f:text /rd:true /c:20
call :log "Event log check completed"
pause
goto menu

:restore_point
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        CREATE SYSTEM RESTORE POINT              ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [*] Creating restore point...
call :log "Restore point creation started"

powershell -Command "Checkpoint-Computer -Description 'WinTool_Backup' -RestorePointType 'MODIFY_SETTINGS'"
call :log "Restore point created"
echo  Restore point created successfully!
echo  You can restore from: Control Panel > Recovery > System Restore
pause
goto menu

:speed_up
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        SPEED UP WINDOWS                         ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  This will:
echo   - Disable visual animations
echo   - Set performance mode
echo   - Disable transparency effects
echo.
set /p confirm=  Continue? (Y/N): 
if /i not "%confirm%"=="Y" goto menu
call :log "Speed up / disable animations started"

:: Disable animations via registry
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
:: Disable transparency
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
call :log "Speed up completed"
echo  Done! Changes take effect after restart or sign out.
pause
goto menu

:: ══════════════════════════════════════════════
::              SINGLE WI-FI PASSWORD
:: ══════════════════════════════════════════════

:ext_NetPass
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║        WI-FI PASSWORD LOOKUP                    ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  [*] Saved networks on this PC:
netsh wlan show profiles | findstr "All User Profile"
echo.
set /p wifiname=  Enter Wi-Fi name: 
if "%wifiname%"=="" goto menu
call :log "Wi-Fi lookup: %wifiname%"

netsh wlan show profile name="%wifiname%" key=clear
pause
goto menu

:: ══════════════════════════════════════════════
::              HELP + LOG
:: ══════════════════════════════════════════════

:help
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║                  HELP MENU                      ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  MAINTENANCE:
echo   [1]  SFC   - Fixes corrupted Windows system files
echo   [2]  DISM  - Repairs the Windows image itself
echo   [3]  CHKDSK- Finds and fixes disk errors
echo   [4]  TEMP  - Frees space by removing junk files
echo   [5]  DNS   - Fixes DNS / internet issues
echo   [6]  ALL   - Runs options 1-5 together
echo   [7]  WINGET- Updates all apps automatically
echo.
echo  SECURITY:
echo   [8]  Open ports - Detect suspicious connections
echo   [9]  Defender  - Full antivirus scan
echo   [10] Startup   - Check what runs at boot
echo   [11] Sched.Tasks- Detect malware persistence
echo   [12] Users     - Find unknown admin accounts
echo.
echo  NETWORK:
echo   [13] Net Reset  - Fix all network issues at once
echo   [14] DNS Change - Switch to faster/safer DNS
echo   [15] Wi-Fi Pass - Dump ALL saved passwords
echo   [16] Net Shares - See what folders are shared
echo.
echo  POWER TOOLS:
echo   [17] Kill Process - Force-close any app by name
echo   [18] Services    - Start/stop/disable services
echo   [19] Event Log   - See last 24h system errors
echo   [20] Restore Pt  - Backup before big changes
echo   [21] Speed Up    - Disable animations for performance
echo.
pause
goto menu

:view_log
cls
echo  ╔══════════════════════════════════════════════════╗
echo  ║                MAINTENANCE LOG                  ║
echo  ╚══════════════════════════════════════════════════╝
echo.
if exist "%LOGFILE%" (
    type "%LOGFILE%"
) else (
    echo  No log file found yet.
)
echo.
pause
goto menu

:: ══════════════════════════════════════════════
::              UTILITIES
:: ══════════════════════════════════════════════

:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
exit /b


:print_header
echo.

echo  ┌──────────────────────────────────────────────────────────────────────────────┐
echo  │ ███████╗███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗              │
echo  │ ██╔════╝██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝             │
echo  │ █████╗  ███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝              │
echo  │ ██╔══╝  ╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝              │
echo  │ ██║     ███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║               │
echo  │ ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝               │
echo  ├──────────────────────────────────────────────────────────────────────────────┤
echo  │   WINDOWS SYSTEM MAINTENANCE TOOL  v2.0     by @dracula0x79                 │
echo  │   Log: maintenance_log.txt                                                  │
echo  └──────────────────────────────────────────────────────────────────────────────┘
exit /b

:: ══════════════════════════════════════════════
::              EXIT
:: ══════════════════════════════════════════════

:goodbye
call :log "=== Session Ended ==="
cls
echo.
echo  Thank you for using Windows Maintenance Tool v2.0
echo  GitHub: dracula0x79
echo  Log saved to: %LOGFILE%
echo.
timeout /t 2 /nobreak >nul
echo  Goodbye!
timeout /t 1 /nobreak >nul
exit
