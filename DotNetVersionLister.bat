@echo off

set noinst=1

rem ===========================================================================
rem TODO detect .Net 5 ?

rem ===========================================================================
rem Detect .Net 4.5 and later

set RQ=reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v "Release"
set value=-1
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==-1 ( goto :_t1_no45 )

rem Exact values
if %value%==378389 ( goto :_45 )
if %value%==378675 ( goto :_451 )
if %value%==378758 ( goto :_451 )
if %value%==379893 ( goto :_452 )
if %value%==393295 ( goto :_46 )
if %value%==393297 ( goto :_46 )
if %value%==394254 ( goto :_461 )
if %value%==394271 ( goto :_461 )
if %value%==394802 ( goto :_462 )
if %value%==394806 ( goto :_462 )
if %value%==460798 ( goto :_47 )
if %value%==460805 ( goto :_47 )
if %value%==461308 ( goto :_471 )
if %value%==461310 ( goto :_471 )
if %value%==461808 ( goto :_472 )
if %value%==461814 ( goto :_472 )
if %value%==528040 ( goto :_48 )
if %value%==528372 ( goto :_48 )
if %value%==528049 ( goto :_48 )

rem Minimum version
if %value% geq 528040 ( goto :_48 )
if %value% geq 461808 ( goto :_472 )
if %value% geq 461308 ( goto :_471 )
if %value% geq 460798 ( goto :_47 )
if %value% geq 394802 ( goto :_462 )
if %value% geq 394254 ( goto :_461 )
if %value% geq 393295 ( goto :_46 )
if %value% geq 379893 ( goto :_452 )
if %value% geq 378675 ( goto :_451 )
if %value% geq 378389 ( goto :_45 )

rem Version number cannot be determined
goto :_t1_unknown

:_45
echo .NET Framework 4.5
set noinst=0
goto :_t2

:_451
echo .NET Framework 4.5.1
set noinst=0
goto :_t2

:_452
echo .NET Framework 4.5.2
set noinst=0
goto :_t2

:_46
echo .NET Framework 4.6
set noinst=0
goto :_t2

:_461
echo .NET Framework 4.6.1
set noinst=0
goto :_t2

:_462
echo .NET Framework 4.6.2
set noinst=0
goto :_t2

:_47
echo .NET Framework 4.7
set noinst=0
goto :_t2

:_471
echo .NET Framework 4.7.1
set noinst=0
goto :_t2

:_472
echo .NET Framework 4.7.2
set noinst=0
goto :_t2

:_48
echo .NET Framework 4.8
set noinst=0
goto :_t2

:_t1_no45
@REM echo No .Net Framework 4.5 or later detected
goto :_t2

:_t1_unknown
echo .Net Framework ??? (Unknown 'Release' number: %value%)
goto :_t2

rem ===========================================================================
rem Detect .Net 1.0 to 4.0

:_t2

rem === .Net 4.0 Full

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4\Full" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 4.0 Full Profile
)

rem === .Net 4.0 Client

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4\Client" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 4.0 Client Profile
)

rem === .Net 3.5

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v3.5" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 3.5
)

rem === .Net 3.0

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v3.0\Setup" /v "InstallSuccess"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 3.0
)

rem === .Net 2.0

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 2.0
)

rem === .Net 1.1

set RQ=reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v1.1.4322" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 1.1
)

rem === .Net 1.0

set RQ=reg query "HKLM\Software\Microsoft\.NETFramework\Policy\v1.0\3705" /v "Install"
set value=0
%RQ% >nul 2>nul
if %errorlevel%==0 ( for /f "tokens=3" %%a in ( '%RQ%' ) do set /a value=%%a )

if %value%==1 (
    set noinst=0
    echo .Net Framework 1.0
)

rem ===========================================================================
rem If not detected from reg query

if %noinst%==1 (
    echo .Net Framework not detected in registry
)

echo.
pause