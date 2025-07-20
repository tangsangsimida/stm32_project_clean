@echo off
REM STM32项目清理工具 - Windows批处理启动脚本
REM 此脚本用于在Windows环境中方便地启动Python清理脚本

REM 定义颜色常量
set "RED=31"
set "GREEN=32"
set "YELLOW=33"
set "BLUE=34"
set "MAGENTA=35"
set "CYAN=36"
set "WHITE=37"

REM 颜色输出函数
call :DefineColorEcho

echo [%BLUE%]STM32项目清理工具 - Windows启动脚本[0m]
echo [%BLUE%]===================================[0m]
echo.

REM 检查管理员权限
net session >nul 2>&1
set IS_ADMIN=0
if %ERRORLEVEL% EQU 0 (
    set IS_ADMIN=1
)

REM 检查Python是否安装
call :ColorEcho %WHITE% "检查Python环境..."
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %RED% "[错误]" & echo  未找到Python。请安装Python 3.6或更高版本。
    echo 您可以从 https://www.python.org/downloads/ 下载Python。
    pause
    exit /b 1
)

REM 检查Python版本
for /f "tokens=2" %%I in ('python --version 2^>^&1') do set PYTHON_VERSION=%%I
call :ColorEcho %WHITE% "检测到Python版本: %PYTHON_VERSION%"
echo.

REM 检查Python版本是否满足要求 (3.6+)
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 6) else 1)" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %RED% "[错误]" & echo  Python版本过低。需要Python 3.6或更高版本。
    echo 当前版本: %PYTHON_VERSION%
    echo 请从 https://www.python.org/downloads/ 下载更新的Python版本。
    pause
    exit /b 1
)
call :ColorEcho %GREEN% "[成功]" & echo  Python版本检查通过。
echo.

REM 检查必要的Python模块
call :ColorEcho %WHITE% "检查必要的Python模块..."
echo.

REM 检查colorama模块
python -c "import colorama" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %YELLOW% "[信息]" & echo  未找到colorama模块，尝试安装...
    if %IS_ADMIN% EQU 1 (
        python -m pip install colorama
        if %ERRORLEVEL% neq 0 (
            call :ColorEcho %YELLOW% "[警告]" & echo  无法安装colorama模块。脚本将继续运行，但没有彩色输出。
        ) else (
            call :ColorEcho %GREEN% "[成功]" & echo  colorama模块已安装。
        )
    ) else (
        call :ColorEcho %YELLOW% "[警告]" & echo  需要管理员权限来安装colorama模块。
        echo 脚本将继续运行，但没有彩色输出。
        echo 您可以手动运行: pip install colorama
    )
) else (
    call :ColorEcho %GREEN% "[成功]" & echo  colorama模块已安装。
)
echo.

REM 检查系统临时目录权限
call :ColorEcho %WHITE% "检查系统权限..."
echo.
set TEMP_TEST_FILE=%TEMP%\stm32_clean_test_%RANDOM%.tmp
echo test > "%TEMP_TEST_FILE%" 2>nul
if not exist "%TEMP_TEST_FILE%" (
    call :ColorEcho %YELLOW% "[警告]" & echo  无法写入临时目录。某些功能可能受限。
) else (
    del "%TEMP_TEST_FILE%" >nul 2>&1
    call :ColorEcho %GREEN% "[成功]" & echo  系统权限检查通过。
)
echo.

call :ColorEcho %WHITE% "环境检查完成。"
echo.

REM 运行Python脚本，传递所有命令行参数
REM 如果没有参数，则默认使用当前目录
if "%1"=="" (
    call :ColorEcho %CYAN% "没有指定参数，默认清理当前目录..."
    echo.
    python "%~dp0stm32_project_clean.py" .
) else (
    python "%~dp0stm32_project_clean.py" %*
)

REM 如果是双击运行，暂停以查看输出
echo.
pause

REM ===== 函数定义 =====

:DefineColorEcho
REM 定义颜色输出函数
set "ESC="
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)
exit /b

:ColorEcho
REM 使用颜色输出文本
REM 参数1: 颜色代码
REM 参数2: 文本
setlocal EnableDelayedExpansion
echo !ESC![%~1m%~2!ESC![0m
endlocal
exit /b