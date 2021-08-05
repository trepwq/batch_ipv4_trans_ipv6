chcp 936&cls
@echo off&PUSHD %~DP0 &TITLE IPv4地址转IPv6
mode con cols=90 lines=30&COLOR f0

:input_ipv4_address
cls
echo;请输入IPv4地址：
setlocal enabledelayedexpansion
set /p ipv4=
set "s=[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"
echo %ipv4%|findstr /be "%s%" >nul||set flag=a
set n=%ipv4:.= %
for %%a in (%n%) do (
   set /a var=1%%a 2>nul
   if !var! gtr 1255 set flag=a
)
if defined flag echo;IPv4地址格式错误，按任意键重新输入&pause>nul&endlocal&goto :input_ipv4_address
for /f "tokens=1 delims=." %%a in ("%ipv4%")  do ( set ipv4_a=%%a)
if not defined ipv4_a echo;IPv4地址格式错误，按任意键重新输入&pause>nul&goto :input_ipv4_address
for /f "tokens=2 delims=." %%a in ("%ipv4%")  do ( set ipv4_b=%%a)
if not defined ipv4_b echo;IPv4地址格式错误，按任意键重新输入&pause>nul&goto :input_ipv4_address
for /f "tokens=3 delims=." %%a in ("%ipv4%")  do ( set ipv4_c=%%a)
if not defined ipv4_c echo;IPv4地址格式错误，按任意键重新输入&pause>nul&goto :input_ipv4_address
for /f "tokens=4 delims=." %%a in ("%ipv4%")  do ( set ipv4_d=%%a)
if not defined ipv4_d echo;IPv4地址格式错误，按任意键重新输入&pause>nul&goto :input_ipv4_address
call :dec2hex %ipv4_a% ipv4_a_hex
call :dec2hex %ipv4_b% ipv4_b_hex
call :dec2hex %ipv4_c% ipv4_c_hex
call :dec2hex %ipv4_d% ipv4_d_hex
cls
echo;IPv4地址：%ipv4%
echo;IPv6地址：%ipv4_a_hex%%ipv4_b_hex%:%ipv4_c_hex%%ipv4_d_hex%
echo;按任意键重新输入，或按右上角X退出
pause>nul
set ipv4=
set ipv4_a=
set ipv4_b=
set ipv4_c=
set ipv4_d=
cls
goto :input_ipv4_address

:dec2hex
setlocal EnableDelayedExpansion
set n=%1
for /l %%i in (1,1,2) do set/a"H%%i=n&15,n>>=4"&set o=!H%%i!:!o!
for %%e in ("10:=A" "11:=B" "12:=C" "13:=D" "14:=E" "15:=F" ":=") do set o=!o:%%~e!
endlocal & set %2=%o%
