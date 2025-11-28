@echo off
setlocal

echo Setting up environment...
set "PYTHONPATH=%~dp0..\code\gdconverter\src"
set "PYTHON_EXE=%~dp0..\python\python.exe"
set "EXPORT_SCRIPT=%~dp0..\code\gdconverter\src\gdconverter\export_tscn.py"
set "PROJECT_ROOT=%~dp0.."

echo Exporting night_eastwood.tscn...
"%PYTHON_EXE%" "%EXPORT_SCRIPT%" "%PROJECT_ROOT%\GodotProject\mods\EastwoodMidnightOps\night_eastwood.tscn" "%PROJECT_ROOT%\FbExportData" "%PROJECT_ROOT%\mods\EastwoodMidnightOps"
if %ERRORLEVEL% NEQ 0 (
    echo Error exporting night_eastwood.tscn
    pause
    exit /b %ERRORLEVEL%
)

echo Exporting night_eastwood_flat.tscn...
"%PYTHON_EXE%" "%EXPORT_SCRIPT%" "%PROJECT_ROOT%\GodotProject\mods\EastwoodMidnightOps\night_eastwood_flat.tscn" "%PROJECT_ROOT%\FbExportData" "%PROJECT_ROOT%\mods\EastwoodMidnightOps"
if %ERRORLEVEL% NEQ 0 (
    echo Error exporting night_eastwood_flat.tscn
    pause
    exit /b %ERRORLEVEL%
)

echo Export complete! Check mods\EastwoodMidnightOps for .spatial.json files.
pause
