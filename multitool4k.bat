@echo off
title AC Holdings Multitool v1.1.4 - MILITARY GRADE
color 0A
chcp 65001 >nul

:menu
cls
echo ==========================================
echo      AC HOLDINGS MULTITOOL v1.1.4
echo          TACTICAL OPERATIONS
echo ==========================================
echo.
echo 1. System Reconnaissance
echo 2. Network Configuration
echo 3. Simple Port Scanner
echo 4. Advanced Nmap Scan
echo 5. HTTP Request Probe
echo 6. IP Grabify Logger
echo 7. Exit
echo ==========================================
set /p choice=Select Option (1-7): 

if "%choice%"=="1" goto sysinfo
if "%choice%"=="2" goto netconfig
if "%choice%"=="3" goto portscan
if "%choice%"=="4" goto nmapscan
if "%choice%"=="5" goto httpreq
if "%choice%"=="6" goto grabify
if "%choice%"=="7" goto exit

echo Invalid selection. Operation aborted.
pause
goto menu

:sysinfo
cls
echo ===== SYSTEM RECONNAISSANCE =====
systeminfo | more
pause
goto menu

:netconfig
cls
echo ===== NETWORK CONFIGURATION =====
ipconfig /all | more
pause
goto menu

:portscan
cls
set /p target=Target IP: 
if "%target%"=="" goto menu
echo Initiating port scan on %target% (ports 1-100)...
for /L %%p in (1,1,100) do (
    <nul (set /p "=%%p ") >nul
    powershell -noprofile -command "(New-Object System.Net.Sockets.TcpClient).Connect('%target%',%%p)" 2>nul && echo [OPEN PORT %%p]
)
pause
goto menu

:nmapscan
cls
set /p target=Target: 
if "%target%"=="" goto menu
where nmap >nul 2>&1 || echo Nmap not detected. Install for full capability.
if %errorlevel%==0 nmap -T4 -F %target%
pause
goto menu

:httpreq
cls
set /p url=Enter Target URL: 
if "%url%"=="" goto menu
powershell -noprofile -command "Invoke-WebRequest -Uri '%url%' -UseBasicParsing | Select-Object StatusCode,Content" 
pause
goto menu

:grabify
cls
echo ===== IP GRABIFY LOGGER - TACTICAL =====
set /p link=Enter Grabify Tracking Link: 
if "%link%"=="" goto menu
echo.
echo Opening tracking dashboard...
echo %link% | clip
start "" "%link%"
echo Link copied to clipboard.
echo Deploy link to target. Monitor incoming connections on Grabify dashboard.
pause
goto menu

:exit
echo.
echo Operation terminated. AC Holdings secure.
timeout /t 2 >nul
exit
