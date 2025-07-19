#!/bin/bash
# STM32项目清理工具 - Linux/macOS安装脚本
# 此脚本用于配置环境、添加环境变量等初始操作

# 定义颜色常量
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取脚本所在的完整路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

clear
echo -e "${BLUE}STM32项目清理工具 - Linux/macOS安装程序${NC}"
echo -e "${BLUE}=======================================${NC}"
echo -e "安装目录: ${SCRIPT_DIR}"
echo ""

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${YELLOW}[警告]${NC} 此脚本未以root权限运行。"
    echo -e "某些操作（如添加到系统PATH）可能需要管理员权限。"
    echo -e "建议使用 sudo 重新运行此脚本。"
    echo ""
    read -p "是否继续安装? [y/N]: " CONTINUE
    if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
        echo -e "${RED}安装已取消${NC}"
        exit 1
    fi
    echo ""
    IS_ROOT=0
else
    IS_ROOT=1
    echo -e "${GREEN}[成功]${NC} 已获得管理员权限。"
    echo ""
fi

# 检查Python是否安装
echo -e "检查Python环境..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}[错误]${NC} 未找到Python3。请安装Python 3.6或更高版本。"
    echo "您可以从 https://www.python.org/downloads/ 下载Python，"
    echo "或者使用您的包管理器安装，例如:"
    echo "  Ubuntu/Debian: sudo apt install python3"
    echo "  Fedora: sudo dnf install python3"
    echo "  macOS: brew install python3"
    
    # 检测操作系统并提供具体命令
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo -e "\n在macOS上，您可以使用以下命令安装Python:"
        echo "  1. 安装Homebrew (如果尚未安装): /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo "  2. 安装Python: brew install python3"
        read -p "是否打开Python下载页面? [y/N]: " OPEN_PYTHON
        if [[ "$OPEN_PYTHON" =~ ^[Yy]$ ]]; then
            if command -v open &> /dev/null; then
                open "https://www.python.org/downloads/"
            elif command -v xdg-open &> /dev/null; then
                xdg-open "https://www.python.org/downloads/"
            fi
        fi
    elif command -v apt &> /dev/null; then
        # Debian/Ubuntu
        echo -e "\n检测到Debian/Ubuntu系统，您可以使用以下命令安装Python:"
        echo "  sudo apt update && sudo apt install python3 python3-pip"
        read -p "是否现在安装Python? [y/N]: " INSTALL_PYTHON
        if [[ "$INSTALL_PYTHON" =~ ^[Yy]$ ]]; then
            if [ "$IS_ROOT" -eq 1 ]; then
                apt update && apt install -y python3 python3-pip
            else
                echo "请手动运行: sudo apt update && sudo apt install python3 python3-pip"
            fi
        fi
    elif command -v dnf &> /dev/null; then
        # Fedora
        echo -e "\n检测到Fedora系统，您可以使用以下命令安装Python:"
        echo "  sudo dnf install python3 python3-pip"
        read -p "是否现在安装Python? [y/N]: " INSTALL_PYTHON
        if [[ "$INSTALL_PYTHON" =~ ^[Yy]$ ]]; then
            if [ "$IS_ROOT" -eq 1 ]; then
                dnf install -y python3 python3-pip
            else
                echo "请手动运行: sudo dnf install python3 python3-pip"
            fi
        fi
    elif command -v yum &> /dev/null; then
        # CentOS/RHEL
        echo -e "\n检测到CentOS/RHEL系统，您可以使用以下命令安装Python:"
        echo "  sudo yum install python3 python3-pip"
        read -p "是否现在安装Python? [y/N]: " INSTALL_PYTHON
        if [[ "$INSTALL_PYTHON" =~ ^[Yy]$ ]]; then
            if [ "$IS_ROOT" -eq 1 ]; then
                yum install -y python3 python3-pip
            else
                echo "请手动运行: sudo yum install python3 python3-pip"
            fi
        fi
    fi
    
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
    echo "或者使用您的包管理器更新。"
    exit 1
fi
echo -e "${GREEN}[成功]${NC} Python版本检查通过。"
echo ""

# 安装必要的Python模块
echo -e "安装必要的Python模块..."
python3 -c 'import colorama' &> /dev/null
if [ $? -ne 0 ]; then
    echo -e "安装colorama模块..."
    if [ "$IS_ROOT" -eq 1 ]; then
        python3 -m pip install colorama
        if [ $? -ne 0 ]; then
            echo -e "${YELLOW}[警告]${NC} 无法安装colorama模块。"
            echo "您可以稍后手动运行: pip3 install colorama"
        else
            echo -e "${GREEN}[成功]${NC} colorama模块已安装。"
        fi
    else
        echo -e "${YELLOW}[警告]${NC} 需要管理员权限来安装colorama模块。"
        read -p "是否尝试使用sudo安装? [y/N]: " SUDO_INSTALL
        if [[ "$SUDO_INSTALL" =~ ^[Yy]$ ]]; then
            sudo python3 -m pip install colorama
            if [ $? -ne 0 ]; then
                echo -e "${YELLOW}[警告]${NC} 无法安装colorama模块。"
                echo "您可以稍后手动运行: sudo pip3 install colorama"
            else
                echo -e "${GREEN}[成功]${NC} colorama模块已安装。"
            fi
        else
            echo "您可以稍后手动运行: sudo pip3 install colorama"
        fi
    fi
else
    echo -e "${GREEN}[成功]${NC} colorama模块已安装。"
fi
echo ""

# 添加到PATH环境变量
echo -e "配置环境变量..."
PATH_TO_ADD="$SCRIPT_DIR"

# 检查PATH中是否已经包含该目录
if [[ ":$PATH:" != *":$PATH_TO_ADD:"* ]]; then
    read -p "是否将脚本目录添加到系统PATH环境变量? [y/N]: " ADD_TO_PATH
    if [[ "$ADD_TO_PATH" =~ ^[Yy]$ ]]; then
        # 检测shell类型并添加到相应的配置文件
        SHELL_TYPE=$(basename "$SHELL")
        
        if [[ "$SHELL_TYPE" == "bash" ]]; then
            CONFIG_FILE="$HOME/.bashrc"
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS上的bash可能使用.bash_profile
                if [ -f "$HOME/.bash_profile" ]; then
                    CONFIG_FILE="$HOME/.bash_profile"
                fi
            fi
        elif [[ "$SHELL_TYPE" == "zsh" ]]; then
            CONFIG_FILE="$HOME/.zshrc"
        else
            # 默认使用.profile
            CONFIG_FILE="$HOME/.profile"
        fi
        
        # 添加到配置文件
        echo "" >> "$CONFIG_FILE"
        echo "# STM32项目清理工具路径" >> "$CONFIG_FILE"
        echo "export PATH=\"\$PATH:$PATH_TO_ADD\"" >> "$CONFIG_FILE"
        
        echo -e "${GREEN}[成功]${NC} 已将脚本目录添加到PATH环境变量。"
        echo -e "您需要重新启动终端或运行 'source $CONFIG_FILE' 使更改生效。"
        echo -e "之后，您可以从任何位置运行 'stm32_project_clean.sh' 命令。"
    else
        echo "已跳过添加到PATH环境变量。"
    fi
else
    echo -e "${GREEN}[信息]${NC} 脚本目录已在PATH环境变量中。"
fi
echo ""

# 创建可执行权限
echo -e "设置可执行权限..."
chmod +x "$SCRIPT_DIR/stm32_project_clean.sh"
chmod +x "$SCRIPT_DIR/stm32_project_clean.py"
echo -e "${GREEN}[成功]${NC} 已设置可执行权限。"
echo ""

# 创建桌面快捷方式或应用程序启动器
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    read -p "是否创建应用程序启动器? [y/N]: " CREATE_LAUNCHER
    if [[ "$CREATE_LAUNCHER" =~ ^[Yy]$ ]]; then
        echo "创建应用程序启动器..."
        
        # 创建AppleScript
        APPLESCRIPT_FILE="/tmp/stm32_cleaner.applescript"
        cat > "$APPLESCRIPT_FILE" << EOL
tell application "Terminal"
    do script "cd; cd \"$SCRIPT_DIR\"; ./stm32_project_clean.sh"
end tell
EOL
        
        # 编译AppleScript为应用程序
        LAUNCHER_PATH="$HOME/Applications/STM32项目清理工具.app"
        mkdir -p "$HOME/Applications"
        osacompile -o "$LAUNCHER_PATH" "$APPLESCRIPT_FILE"
        
        # 清理临时文件
        rm "$APPLESCRIPT_FILE"
        
        if [ -d "$LAUNCHER_PATH" ]; then
            echo -e "${GREEN}[成功]${NC} 应用程序启动器已创建: $LAUNCHER_PATH"
        else
            echo -e "${RED}[错误]${NC} 无法创建应用程序启动器。"
        fi
    else
        echo "已跳过创建应用程序启动器。"
    fi
else
    # Linux
    read -p "是否创建桌面快捷方式? [y/N]: " CREATE_SHORTCUT
    if [[ "$CREATE_SHORTCUT" =~ ^[Yy]$ ]]; then
        echo "创建桌面快捷方式..."
        
        # 创建.desktop文件
        DESKTOP_FILE="$HOME/Desktop/stm32-project-cleaner.desktop"
        cat > "$DESKTOP_FILE" << EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=STM32项目清理工具
Comment=清理STM32项目中的中间编译文件
Exec=bash -c "cd \"$SCRIPT_DIR\" && ./stm32_project_clean.sh"
Icon=utilities-terminal
Terminal=true
Categories=Development;Utility;
EOL
        
        # 设置可执行权限
        chmod +x "$DESKTOP_FILE"
        
        if [ -f "$DESKTOP_FILE" ]; then
            echo -e "${GREEN}[成功]${NC} 桌面快捷方式已创建: $DESKTOP_FILE"
        else
            echo -e "${RED}[错误]${NC} 无法创建桌面快捷方式。"
        fi
    else
        echo "已跳过创建桌面快捷方式。"
    fi
fi
echo ""

# 安装完成
echo -e "${BLUE}=======================================${NC}"
echo -e "${GREEN}STM32项目清理工具安装完成!${NC}"
echo ""
echo "您可以通过以下方式使用该工具:"
echo "1. 直接运行 ./stm32_project_clean.sh (清理当前目录)"
echo "2. 指定目录: ./stm32_project_clean.sh /path/to/directory"
echo "3. 如果已添加到PATH: stm32_project_clean.sh [选项] [目录]"
echo ""
echo -e "感谢您使用STM32项目清理工具!"
echo -e "${BLUE}=======================================${NC}"
echo ""

# 设置可执行权限
chmod +x "$SCRIPT_DIR/install_unix.sh"