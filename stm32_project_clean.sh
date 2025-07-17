#!/bin/bash
# STM32项目清理工具 - Shell脚本启动器
# 此脚本用于在Linux/macOS环境中方便地启动Python清理脚本

echo "STM32项目清理工具 - Shell脚本启动器"
echo "=================================="

# 检查Python是否安装
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到Python3。请安装Python 3.6或更高版本。"
    echo "您可以从 https://www.python.org/downloads/ 下载Python，"
    echo "或者使用您的包管理器安装，例如:"
    echo "  Ubuntu/Debian: sudo apt install python3"
    echo "  Fedora: sudo dnf install python3"
    echo "  macOS: brew install python3"
    exit 1
fi

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