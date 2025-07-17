#!/bin/bash

# stm32_project_clean.sh - 清理STM32项目中的中间编译文件
# 版本：1.0
# 作者：Dennis_Re_Yoonjiho
# GitHub: https://github.com/username/stm32_project_clean
# 许可证：GNU General Public License v3.0
#
# 本程序是自由软件：您可以根据自由软件基金会发布的GNU通用公共许可证（版本3或更高版本）
# 重新分发和/或修改它。
#
# 本程序的发布是希望它能有所帮助，但没有任何保证；甚至没有对适销性或特定用途适用性的暗示保证。
# 更多详情，请参阅GNU通用公共许可证。
#
# 您应该已经收到了GNU通用公共许可证的副本。如果没有，请参阅 <https://www.gnu.org/licenses/>。

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 无颜色

# 显示版本信息
show_version() {
    echo -e "${BLUE}STM32项目清理工具${NC} - 版本 1.0"
    echo -e "作者: Dennis_Re_Yoonjiho"
    echo -e "许可证: GNU General Public License v3.0"
}

# 帮助信息
show_help() {
    echo -e "${BLUE}STM32项目清理工具${NC}"
    echo -e "${BLUE}用法:${NC} $0 [选项] [目录]"
    echo
    echo -e "${BLUE}选项:${NC}"
    echo -e "  -h, --help     显示此帮助信息"
    echo -e "  -v, --version  显示版本信息"
    echo -e "  -d, --dry-run  预览将要删除的文件，不实际删除"
    echo -e "  -V, --verbose  显示详细信息"
    echo -e "  -k, --keep-libs 保留库文件 (.a, .so)"
    echo
    echo -e "${BLUE}示例:${NC}"
    echo -e "  $0                  # 清理当前目录"
    echo -e "  $0 ~/stm32_project  # 清理指定STM32项目目录"
    echo -e "  $0 -d ~/stm32_project  # 预览将要删除的文件"
    echo
}

# 初始化变量
DRY_RUN=0
VERBOSE=0
KEEP_LIBS=0
TARGET_DIR="."

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        -d|--dry-run)
            DRY_RUN=1
            shift
            ;;
        -V|--verbose)
            VERBOSE=1
            shift
            ;;
        -k|--keep-libs)
            KEEP_LIBS=1
            shift
            ;;
        *)
            if [[ -d "$1" ]]; then
                TARGET_DIR="$1"
            else
                echo -e "${RED}错误:${NC} '$1' 不是有效的目录"
                show_help
                exit 1
            fi
            shift
            ;;
    esac
done

# 确认目标目录存在
if [[ ! -d "$TARGET_DIR" ]]; then
    echo -e "${RED}错误:${NC} 目标目录 '$TARGET_DIR' 不存在"
    exit 1
fi

# 要删除的文件类型
REMOVE_PATTERNS=(
    "*.o"       # 目标文件
    "*.gch"     # 预编译头文件
    "*.pch"     # 预编译头文件
    "*.d"       # 依赖文件
    "*.tmp"     # 临时文件
    "*.lo"      # libtool 对象文件
    "*.obj"     # 对象文件
    "*.pdb"     # 程序数据库
    "*.ilk"     # 增量链接文件
    "*.exp"     # 导出文件
    "*.map"     # 映射文件
    "*.gcda"    # GCC 代码覆盖数据
    "*.gcno"    # GCC 代码覆盖笔记
    "*.dSYM"    # 调试符号
    "*.lst"     # 列表文件
    "*.su"      # 堆栈使用文件
    "*.cyclo"   # 循环复杂度文件
)

# 如果不保留库文件，添加到删除列表
if [[ $KEEP_LIBS -eq 0 ]]; then
    REMOVE_PATTERNS+=("*.a")   # 静态库
    REMOVE_PATTERNS+=("*.so")  # 共享库
    REMOVE_PATTERNS+=("*.so.*")  # 共享库带版本号
    REMOVE_PATTERNS+=("*.dylib")  # macOS 动态库
    REMOVE_PATTERNS+=("*.dll")  # Windows 动态链接库
    REMOVE_PATTERNS+=("*.lib")  # Windows 导入库
fi

# 要保留的文件类型（可执行文件）
KEEP_PATTERNS=(
    "*.bin"     # 二进制可执行文件
    "*.hex"     # 十六进制文件
    "*.elf"     # ELF 可执行文件
    "*.out"     # 输出可执行文件
    "*.axf"     # ARM 可执行文件
)

# 检查无扩展名的可执行文件
check_executable() {
    if [[ -f "$1" && -x "$1" ]]; then
        local file_name=$(basename "$1")
        # 检查文件名是否包含点号（表示有扩展名）
        if [[ "$file_name" != *.* ]]; then
            return 0  # 是可执行文件
        fi
    fi
    return 1  # 不是可执行文件
}

# 统计变量
TOTAL_FILES=0
DELETED_FILES=0
KEPT_FILES=0
TOTAL_SIZE=0

# 显示脚本开始信息
echo -e "${BLUE}=== STM32项目清理工具 ===${NC}"
echo -e "${BLUE}目标目录:${NC} $(realpath "$TARGET_DIR")"
if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "${YELLOW}模式: 预览 (不会实际删除文件)${NC}"
else
    echo -e "${YELLOW}模式: 实际删除${NC}"
fi
echo

# 查找并处理文件
process_files() {
    local pattern="$1"
    local action="$2"  # "delete" 或 "keep"
    
    # 使用 find 查找匹配的文件
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            local file_size=$(stat -c %s "$file" 2>/dev/null || stat -f %z "$file" 2>/dev/null)
            
            if [[ $action == "delete" ]]; then
                ((TOTAL_FILES++))
                ((TOTAL_SIZE+=file_size))
                
                if [[ $DRY_RUN -eq 1 ]]; then
                    if [[ $VERBOSE -eq 1 ]]; then
                        echo -e "${RED}将删除:${NC} $file ($(numfmt --to=iec-i --suffix=B $file_size))"
                    fi
                else
                    if [[ $VERBOSE -eq 1 ]]; then
                        echo -e "${RED}删除:${NC} $file ($(numfmt --to=iec-i --suffix=B $file_size))"
                    fi
                    rm -f "$file"
                    if [[ $? -eq 0 ]]; then
                        ((DELETED_FILES++))
                    fi
                fi
            elif [[ $action == "keep" && $VERBOSE -eq 1 ]]; then
                echo -e "${GREEN}保留:${NC} $file"
                ((KEPT_FILES++))
            fi
        fi
    done < <(find "$TARGET_DIR" -type f -name "$pattern" 2>/dev/null)
}

# 处理无扩展名的可执行文件
process_executables() {
    while IFS= read -r file; do
        if check_executable "$file"; then
            if [[ $VERBOSE -eq 1 ]]; then
                echo -e "${GREEN}保留可执行文件:${NC} $file"
            fi
            ((KEPT_FILES++))
        fi
    done < <(find "$TARGET_DIR" -type f -executable 2>/dev/null)
}

# 处理要删除的文件
for pattern in "${REMOVE_PATTERNS[@]}"; do
    process_files "$pattern" "delete"
done

# 处理要保留的文件（仅在详细模式下显示）
if [[ $VERBOSE -eq 1 ]]; then
    for pattern in "${KEEP_PATTERNS[@]}"; do
        process_files "$pattern" "keep"
    done
fi

# 处理无扩展名的可执行文件
process_executables

# 显示统计信息
echo
echo -e "${BLUE}=== 清理统计 ===${NC}"
if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "${YELLOW}将删除文件数:${NC} $TOTAL_FILES"
    echo -e "${YELLOW}总计大小:${NC} $(numfmt --to=iec-i --suffix=B $TOTAL_SIZE)"
    if [[ $TOTAL_FILES -eq 0 ]]; then
        echo -e "${GREEN}项目已经是干净的，没有需要删除的文件。${NC}"
    fi
else
    echo -e "${GREEN}已删除文件数:${NC} $DELETED_FILES / $TOTAL_FILES"
    echo -e "${GREEN}释放空间:${NC} $(numfmt --to=iec-i --suffix=B $TOTAL_SIZE)"
    if [[ $DELETED_FILES -eq 0 ]]; then
        echo -e "${GREEN}项目已经是干净的，没有需要删除的文件。${NC}"
    fi
fi

if [[ $VERBOSE -eq 1 ]]; then
    echo -e "${GREEN}保留的可执行文件数:${NC} $KEPT_FILES"
fi

echo
if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "${YELLOW}提示:${NC} 这是预览模式，没有文件被实际删除。使用不带 -d 选项的命令来实际删除文件。"
fi

exit 0