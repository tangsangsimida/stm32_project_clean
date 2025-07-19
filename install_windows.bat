@echo off
REM STM32项目清理工具 - Windows安装脚本
REM 此脚本用于配置环境、添加环境变量等初始操作

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

REM 获取管理员权限
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    call :ColorEcho %YELLOW% "[警告]" & echo  此脚本未以管理员权限运行。
    echo 某些操作（如添加到系统PATH）可能需要管理员权限。
    echo 建议右键点击脚本，选择"以管理员身份运行"。
    echo.
    set /p CONTINUE="是否继续安装? [y/N]: "
    if /i not "%CONTINUE%"=="y" (
        call :ColorEcho %RED% "安装已取消"
        echo.
        pause
        exit /b 1
    )
    echo.
    set IS_ADMIN=0
) else (
    call :ColorEcho %GREEN% "[成功]" & echo  已获得管理员权限。
    echo.
    set IS_ADMIN=1
)

REM 获取脚本所在的目录
set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

cls
call :ColorEcho %BLUE% "STM32项目清理工具 - Windows安装程序"
echo.
call :ColorEcho %BLUE% "======================================="
echo.
echo 安装目录: %SCRIPT_DIR%
echo.

REM 检查Python是否安装
call :ColorEcho %WHITE% "检查Python环境..."
echo.
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %RED% "[错误]" & echo  未找到Python。请安装Python 3.6或更高版本。
    echo 您可以从 https://www.python.org/downloads/ 下载Python。
    echo.
    set /p OPEN_PYTHON="是否打开Python下载页面? [y/N]: "
    if /i "%OPEN_PYTHON%"=="y" (
        start https://www.python.org/downloads/
    )
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

REM 安装必要的Python模块
call :ColorEcho %WHITE% "安装必要的Python模块..."
echo.

REM 检查colorama模块
python -c "import colorama" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %YELLOW% "[信息]" & echo  未找到colorama模块，尝试安装...
    if %IS_ADMIN% EQU 1 (
        python -m pip install colorama
        if %ERRORLEVEL% neq 0 (
            call :ColorEcho %YELLOW% "[警告]" & echo  无法安装colorama模块。
            echo 您可以稍后手动运行: pip install colorama
        ) else (
            call :ColorEcho %GREEN% "[成功]" & echo  colorama模块已安装。
        )
    ) else (
        call :ColorEcho %YELLOW% "[警告]" & echo  需要管理员权限来安装colorama模块。
        set /p SUDO_INSTALL="是否尝试以管理员权限安装? [y/N]: "
        if /i "%SUDO_INSTALL%"=="y" (
            REM 创建临时批处理文件以管理员权限运行
            echo @echo off > "%TEMP%\install_colorama.bat"
            echo python -m pip install colorama >> "%TEMP%\install_colorama.bat"
            echo pause >> "%TEMP%\install_colorama.bat"
            
            REM 以管理员权限运行临时批处理文件
            powershell -Command "Start-Process cmd -ArgumentList '/c %TEMP%\install_colorama.bat' -Verb RunAs"
        ) else (
            echo 您可以稍后手动运行: pip install colorama
        )
    )
) else (
    call :ColorEcho %GREEN% "[成功]" & echo  colorama模块已安装。
)
echo.

REM 添加到PATH环境变量
call :ColorEcho %WHITE% "配置环境变量..."
echo.

REM 检查PATH中是否已经包含该目录
set "PATH_TO_ADD=%SCRIPT_DIR%"
echo %PATH% | findstr /C:"%PATH_TO_ADD%" >nul
if %ERRORLEVEL% neq 0 (
    set /p ADD_TO_PATH="是否将脚本目录添加到系统PATH环境变量? [y/N]: "
    if /i "%ADD_TO_PATH%"=="y" (
        if %IS_ADMIN% EQU 1 (
            REM 添加到系统PATH
            setx PATH "%PATH%;%PATH_TO_ADD%" /M
            if %ERRORLEVEL% neq 0 (
                call :ColorEcho %RED% "[错误]" & echo  无法添加到系统PATH环境变量。
            ) else (
                call :ColorEcho %GREEN% "[成功]" & echo  已将脚本目录添加到系统PATH环境变量。
                echo 您需要重新启动命令提示符使更改生效。
                echo 之后，您可以从任何位置运行 'stm32_project_clean.bat' 命令。
            )
        ) else (
            call :ColorEcho %YELLOW% "[警告]" & echo  需要管理员权限来修改系统PATH环境变量。
            echo 请以管理员身份重新运行此脚本。
        )
    ) else (
        echo 已跳过添加到PATH环境变量。
    )
) else (
    call :ColorEcho %GREEN% "[信息]" & echo  脚本目录已在PATH环境变量中。
)
echo.

REM 创建桌面快捷方式
call :ColorEcho %WHITE% "创建桌面快捷方式..."
echo.
set /p CREATE_SHORTCUT="是否创建桌面快捷方式? [y/N]: "
if /i "%CREATE_SHORTCUT%"=="y" (
    REM 创建VBS脚本来创建快捷方式
    echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut.vbs"
    echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\STM32项目清理工具.lnk" >> "%TEMP%\CreateShortcut.vbs"
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\CreateShortcut.vbs"
    echo oLink.TargetPath = "%SCRIPT_DIR%\stm32_project_clean.bat" >> "%TEMP%\CreateShortcut.vbs"
    echo oLink.WorkingDirectory = "%SCRIPT_DIR%" >> "%TEMP%\CreateShortcut.vbs"
    echo oLink.Description = "STM32项目清理工具" >> "%TEMP%\CreateShortcut.vbs"
    echo oLink.IconLocation = "cmd.exe,0" >> "%TEMP%\CreateShortcut.vbs"
    echo oLink.Save >> "%TEMP%\CreateShortcut.vbs"
    
    REM 运行VBS脚本
    cscript //nologo "%TEMP%\CreateShortcut.vbs"
    del "%TEMP%\CreateShortcut.vbs"
    
    call :ColorEcho %GREEN% "[成功]" & echo  桌面快捷方式已创建。
) else (
    echo 已跳过创建桌面快捷方式。
)
echo.

REM 安装完成
call :ColorEcho %BLUE% "======================================="
echo.
call :ColorEcho %GREEN% "STM32项目清理工具安装完成!"
echo.
echo.
echo 您可以通过以下方式使用该工具:
echo 1. 直接运行 stm32_project_clean.bat (清理当前目录)
echo 2. 将要清理的文件夹拖放到 stm32_project_clean.bat 上
echo 3. 如果已添加到PATH: stm32_project_clean.bat [选项] [目录]
echo.
echo 感谢您使用STM32项目清理工具!
call :ColorEcho %BLUE% "======================================="
echo.
echo.
pause
exit /b 0

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