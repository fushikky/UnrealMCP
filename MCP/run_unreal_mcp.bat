@echo off
REM When run with no args (e.g. double-click), use a window that stays open
if not defined UNREAL_MCP_KEEPOPEN if "%~1"=="" (
    cmd /k "set UNREAL_MCP_KEEPOPEN=1 & cd /d "%~dp0" & "%~f0" %*"
    exit /b
)

setlocal

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

set "ENV_DIR=%SCRIPT_DIR%\python_env"
set "PYTHON_PATH=%ENV_DIR%\Scripts\python.exe"

if not exist "%PYTHON_PATH%" (
    echo ERROR: Python environment not found. Please run setup_unreal_mcp.bat first. >&2
    echo.
    pause
    goto :end
)

echo Starting Unreal MCP bridge... >&2
"%PYTHON_PATH%" "%SCRIPT_DIR%\unreal_mcp_bridge.py" %*

if errorlevel 1 (
    echo.
    echo Bridge exited with error. Check messages above. >&2
    echo Press any key to close...
    pause >nul
)

:end
