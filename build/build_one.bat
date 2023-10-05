@echo off

echo - Liberation_RX PBO build script -

set NAME=Liberation_RX.Stratis
REM set NAME=Liberation_RX.Altis
REM set NAME=Liberation_RX.Malden
REM set NAME=Liberation_RX.Enoch
REM set NAME=Liberation_RX.Tanoa
REM set NAME=Liberation_RX.OPTRE_iberius
REM set NAME=Liberation_RX.Chernarus
REM set NAME=Liberation_RX.Chernarus_Winter
REM set NAME=Liberation_RX.Takistan
REM set NAME=Liberation_RX.Sara
REM set NAME=Liberation_RX.Saralite
REM set NAME=Liberation_RX.Kapaulio
REM set NAME=Liberation_RX.Isladuala3
REM set NAME=Liberation_RX.vt7
REM set NAME=Liberation_RX.Eusa
REM set NAME=Liberation_RX.SefrouRamal
REM set NAME=Liberation_RX.Cam_Lao_Nam
REM set NAME=Liberation_RX.gm_weferlingen_winter
REM set NAME=Liberation_RX.Utes
REM set NAME=Liberation_RX.jnd_dakpek_terrain

REM -------------------------------------------------------------------------
if "%NAME%" == "" exit

rem taskkill /im arma3server_x64.exe
rem ping -n4 127.0.0.1 > nul 2>&1

del /f "S:\Steam\SteamApps\common\Arma 3 Server\mpmissions\%NAME%.pbo"
del /f %NAME%.pbo  > nul 2>&1

set GRLIB_file="..\core.liberation\build_info.sqf"
echo //Liberation_RX was build on : > %GRLIB_file%
echo GRLIB_build_date = "%DATE%"; >> %GRLIB_file%
echo GRLIB_build_time = "%TIME:~0,8%"; >> %GRLIB_file%
echo GRLIB_build_version = "internal-dev"; >> %GRLIB_file%
echo diag_log format ["version %%1 - build date: %%2",GRLIB_build_version, GRLIB_build_date]; >> %GRLIB_file%

for /f %%i in ("%NAME%") do (
	echo.
	echo Building PBO for map %%i 
	xcopy /Q /E /Y ..\core.liberation .\%%i\
	xcopy /Q /E /Y ..\maps\%%i .\%%i\
	xcopy /Q /E /Y .\custom\* .\%%i\
	bin\PBOConsole.exe -pack %%i .\%%i.pbo  > nul 2>&1
	rmdir /S /Q %%i
	echo Done.
)

echo.
echo.
echo Copy PBO to server folders (MP/SP)
copy /Y %NAME%.pbo "S:\Steam\SteamApps\common\Arma 3 Server\mpmissions\"
copy /Y %NAME%.pbo "S:\Steam\SteamApps\common\Arma 3\MPMissions"

rem start "S:\Steam\SteamApps\common\Arma 3 Server\start.cmd"
ping -n 5 127.0.0.1 > nul 2>&1