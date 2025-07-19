#!/bin/bash
# STM32项目清理工具 - Shell脚本启动器
# 此脚本用于在Linux/macOS环境中方便地启动Python清理脚本

# 定义颜色常量
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}STM32项目清理工具 - Shell脚本启动器${NC}"
echo -e "${BLUE}==================================${NC}"
echo ""

# 检查Python是否安装
echo -e "检查Python环境..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}[错误]${NC} 未找到Python3。请安装Python 3.6或更高版本。"
    echo "您可以从 https://www.python.org/downloads/ 下载Python，"
    echo "或者使用您的包管理器安装，例如:"
    echo "  Ubuntu/Debian: sudo apt install python3"
    echo "  Fedora: sudo dnf install python3"
    echo "  macOS: brew install python3"
    exit 1
fi

# 检查Python版本
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
echo -e "检测到Python版本: ${PYTHON_VERSION}"

# 检查Python版本是否满足要求 (3.6+)
python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3, 6) else 1)' &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}[错误]${NC} Python版本过低。需要Python 3.6或更高版本。"
    echo -e "当前版本: ${PYTHON_VERSION}"
    echo "请从 https://www.python.org/downloads/ 下载更新的Python版本，"
    echo "或者使用您的包管理器更新，例如:"
    echo "  Ubuntu/Debian: sudo apt install python3"
    echo "  Fedora: sudo dnf install python3"
    echo "  macOS: brew install python3"
    exit 1
fi
echo -e "${GREEN}[成功]${NC} Python版本检查通过。"

# 检查colorama模块
echo -e "\n检查必要的Python模块..."
python3 -c 'import colorama' &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}[信息]${NC} 未找到colorama模块，尝试安装..."
    if [ "$(id -u)" -eq 0 ]; then
        python3 -m pip install colorama
        if [ $? -ne 0 ]; then
            echo -e "${YELLOW}[警告]${NC} 无法安装colorama模块。脚本将继续运行，但没有彩色输出。"
        else
            echo -e "${GREEN}[成功]${NC} colorama模块已安装。"
        fi
    else
        echo -e "${YELLOW}[警告]${NC} 需要管理员权限来安装colorama模块。"
        echo "脚本将继续运行，但没有彩色输出。"
        echo "您可以手动运行: pip3 install colorama"
    fi
else
    echo -e "${GREEN}[成功]${NC} colorama模块已安装。"
fi

# 检查系统权限
echo -e "\n检查系统权限..."
TEMP_TEST_FILE="/tmp/stm32_clean_test_$RANDOM.tmp"
echo "test" > "$TEMP_TEST_FILE" 2> /dev/null
if [ ! -f "$TEMP_TEST_FILE" ]; then
    echo -e "${YELLOW}[警告]${NC} 无法写入临时目录。某些功能可能受限。"
else
    rm "$TEMP_TEST_FILE" &> /dev/null
    echo -e "${GREEN}[成功]${NC} 系统权限检查通过。"
fi

echo -e "\n环境检查完成。"

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 运行Python脚本，传递所有命令行参数
# 如果没有参数，则默认使用当前目录
if [ $# -eq 0 ]; then
    echo "没有指定参数，默认清理当前目录..."
    python3 "$SCRIPT_DIR/stm32_project_clean.py" .
else
    python3 "$SCRIPT_DIR/stm32_project_clean.py" "$@"
fi