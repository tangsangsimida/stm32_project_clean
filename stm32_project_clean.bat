@echo off
REM STM32项目清理工具 - Windows批处理启动脚本
REM 此脚本用于在Windows环境中方便地启动Python清理脚本

echo STM32项目清理工具 - Windows启动脚本
echo ===================================

REM 检查Python是否安装
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 错误: 未找到Python。请安装Python 3.6或更高版本。
    echo 您可以从 https://www.python.org/downloads/ 下载Python。
    pause
    exit /b 1
)

REM 检查colorama模块
python -c "import colorama" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 安装colorama模块以获得彩色输出支持...
    python -m pip install colorama
    if %ERRORLEVEL% neq 0 (
        echo 警告: 无法安装colorama模块。脚本将继续运行，但没有彩色输出。
    )
)

REM 运行Python脚本，传递所有命令行参数
REM 如果没有参数，则默认使用当前目录
if "%1"=="" (
    echo 没有指定参数，默认清理当前目录...
    python "%~dp0stm32_project_clean.py" .
) else (
    python "%~dp0stm32_project_clean.py" %*
)

REM 如果是双击运行，暂停以查看输出
echo.
pause