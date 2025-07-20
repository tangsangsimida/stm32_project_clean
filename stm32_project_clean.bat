@echo off
REM STM32��Ŀ������ - Windows�����������ű�
REM �˽ű�������Windows�����з��������Python����ű�

REM ������ɫ����
set "RED=31"
set "GREEN=32"
set "YELLOW=33"
set "BLUE=34"
set "MAGENTA=35"
set "CYAN=36"
set "WHITE=37"

REM ��ɫ�������
call :DefineColorEcho

echo [%BLUE%]STM32��Ŀ������ - Windows�����ű�[0m]
echo [%BLUE%]===================================[0m]
echo.

REM ������ԱȨ��
net session >nul 2>&1
set IS_ADMIN=0
if %ERRORLEVEL% EQU 0 (
    set IS_ADMIN=1
)

REM ���Python�Ƿ�װ
call :ColorEcho %WHITE% "���Python����..."
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %RED% "[����]" & echo  δ�ҵ�Python���밲װPython 3.6����߰汾��
    echo �����Դ� https://www.python.org/downloads/ ����Python��
    pause
    exit /b 1
)

REM ���Python�汾
for /f "tokens=2" %%I in ('python --version 2^>^&1') do set PYTHON_VERSION=%%I
call :ColorEcho %WHITE% "��⵽Python�汾: %PYTHON_VERSION%"
echo.

REM ���Python�汾�Ƿ�����Ҫ�� (3.6+)
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 6) else 1)" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %RED% "[����]" & echo  Python�汾���͡���ҪPython 3.6����߰汾��
    echo ��ǰ�汾: %PYTHON_VERSION%
    echo ��� https://www.python.org/downloads/ ���ظ��µ�Python�汾��
    pause
    exit /b 1
)
call :ColorEcho %GREEN% "[�ɹ�]" & echo  Python�汾���ͨ����
echo.

REM ����Ҫ��Pythonģ��
call :ColorEcho %WHITE% "����Ҫ��Pythonģ��..."
echo.

REM ���coloramaģ��
python -c "import colorama" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :ColorEcho %YELLOW% "[��Ϣ]" & echo  δ�ҵ�coloramaģ�飬���԰�װ...
    if %IS_ADMIN% EQU 1 (
        python -m pip install colorama
        if %ERRORLEVEL% neq 0 (
            call :ColorEcho %YELLOW% "[����]" & echo  �޷���װcoloramaģ�顣�ű����������У���û�в�ɫ�����
        ) else (
            call :ColorEcho %GREEN% "[�ɹ�]" & echo  coloramaģ���Ѱ�װ��
        )
    ) else (
        call :ColorEcho %YELLOW% "[����]" & echo  ��Ҫ����ԱȨ������װcoloramaģ�顣
        echo �ű����������У���û�в�ɫ�����
        echo �������ֶ�����: pip install colorama
    )
) else (
    call :ColorEcho %GREEN% "[�ɹ�]" & echo  coloramaģ���Ѱ�װ��
)
echo.

REM ���ϵͳ��ʱĿ¼Ȩ��
call :ColorEcho %WHITE% "���ϵͳȨ��..."
echo.
set TEMP_TEST_FILE=%TEMP%\stm32_clean_test_%RANDOM%.tmp
echo test > "%TEMP_TEST_FILE%" 2>nul
if not exist "%TEMP_TEST_FILE%" (
    call :ColorEcho %YELLOW% "[����]" & echo  �޷�д����ʱĿ¼��ĳЩ���ܿ������ޡ�
) else (
    del "%TEMP_TEST_FILE%" >nul 2>&1
    call :ColorEcho %GREEN% "[�ɹ�]" & echo  ϵͳȨ�޼��ͨ����
)
echo.

call :ColorEcho %WHITE% "���������ɡ�"
echo.

REM ����Python�ű����������������в���
REM ���û�в�������Ĭ��ʹ�õ�ǰĿ¼
if "%1"=="" (
    call :ColorEcho %CYAN% "û��ָ��������Ĭ������ǰĿ¼..."
    echo.
    python "%~dp0stm32_project_clean.py" .
) else (
    python "%~dp0stm32_project_clean.py" %*
)

REM �����˫�����У���ͣ�Բ鿴���
echo.
pause

REM ===== �������� =====

:DefineColorEcho
REM ������ɫ�������
set "ESC="
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)
exit /b

:ColorEcho
REM ʹ����ɫ����ı�
REM ����1: ��ɫ����
REM ����2: �ı�
setlocal EnableDelayedExpansion
echo !ESC![%~1m%~2!ESC![0m
endlocal
exit /b