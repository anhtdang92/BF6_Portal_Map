@echo off
setlocal

echo Setting up environment...
set "PYTHONPATH=%~dp0..\..\code\gdconverter\src"
set "PYTHON_EXE=%~dp0..\..\python\python.exe"
set "EXPORT_SCRIPT=%~dp0..\..\code\gdconverter\src\gdconverter\export_tscn.py"
set "PROJECT_ROOT=%~dp0..\.."

echo Exporting siege_night.tscn...
"%PYTHON_EXE%" "%EXPORT_SCRIPT%" "%PROJECT_ROOT%\mods\SiegeNightOps\siege_night.tscn" "%PROJECT_ROOT%\FbExportData" "%PROJECT_ROOT%\mods\SiegeNightOps"
if %ERRORLEVEL% NEQ 0 (
    echo Error exporting siege_night.tscn
    pause
    exit /b %ERRORLEVEL%
)

echo Export complete! Check mods\SiegeNightOps for .spatial.json files.
pause
