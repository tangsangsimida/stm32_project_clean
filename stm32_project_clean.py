#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
stm32_project_clean.py - 清理STM32项目中的中间编译文件
版本：1.0.1
作者：Dennis_Re_Yoonjiho
GitHub: https://github.com/username/stm32_project_clean
许可证：GNU General Public License v3.0

本程序是自由软件：您可以根据自由软件基金会发布的GNU通用公共许可证（版本3或更高版本）
重新分发和/或修改它。

本程序的发布是希望它能有所帮助，但没有任何保证；甚至没有对适销性或特定用途适用性的暗示保证。
更多详情，请参阅GNU通用公共许可证。

您应该已经收到了GNU通用公共许可证的副本。如果没有，请参阅 <https://www.gnu.org/licenses/>。
"""

import os
import sys
import shutil
import argparse
import datetime
import glob
import fnmatch
import stat
from typing import List, Dict, Any, Tuple, Optional

# 颜色定义（支持Windows和Unix/Linux）
try:
    import colorama
    colorama.init()
    RED = colorama.Fore.RED
    GREEN = colorama.Fore.GREEN
    YELLOW = colorama.Fore.YELLOW
    BLUE = colorama.Fore.BLUE
    NC = colorama.Fore.RESET
except ImportError:
    # 如果colorama不可用，使用ANSI转义序列（在Windows命令提示符中可能不起作用）
    RED = '\033[0;31m' if os.name != 'nt' else ''
    GREEN = '\033[0;32m' if os.name != 'nt' else ''
    YELLOW = '\033[0;33m' if os.name != 'nt' else ''
    BLUE = '\033[0;34m' if os.name != 'nt' else ''
    NC = '\033[0m' if os.name != 'nt' else ''

# 版本信息
VERSION = "1.1.0"
AUTHOR = "Dennis_Re_Yoonjiho"
LICENSE = "GNU General Public License v3.0"

def show_version() -> None:
    """显示版本信息"""
    print(f"{BLUE}STM32项目清理工具{NC} - 版本 {VERSION}")
    print(f"作者: {AUTHOR}")
    print(f"许可证: {LICENSE}")

def show_help() -> None:
    """显示帮助信息"""
    print(f"{BLUE}STM32项目清理工具{NC}")
    print(f"{BLUE}用法:{NC} {sys.argv[0]} [选项] [目录]")
    print()
    print(f"{BLUE}选项:{NC}")
    print("  -h, --help         显示此帮助信息")
    print("  -v, --version      显示版本信息")
    print("  -d, --dry-run      预览将要删除的文件，不实际删除")
    print("  -V, --verbose      显示详细信息")
    print("  -k, --keep-libs    保留库文件 (.a, .so)")
    print("  -b, --backup       在删除前创建备份")
    print("  -B, --backup-dir DIR 指定备份目录 (默认: ./backup_YYYYMMDD_HHMMSS)")
    print("  -e, --exclude DIRS 排除指定目录，用逗号分隔")
    print("  -m, --max-depth N  限制递归深度为N级")
    print("  -i, --interactive  交互式确认删除")
    print("  -c, --custom PAT   添加自定义文件模式，用逗号分隔")
    print("  -s, --suffix SUF   添加额外的文件后缀，用逗号分隔")
    print()
    print(f"{BLUE}示例:{NC}")
    print(f"  {sys.argv[0]}                           # 清理当前目录")
    print(f"  {sys.argv[0]} ~/stm32_project           # 清理指定STM32项目目录")
    print(f"  {sys.argv[0]} -d ~/stm32_project        # 预览将要删除的文件")
    print(f"  {sys.argv[0]} -b -V ~/stm32_project     # 创建备份并显示详细信息")
    print(f"  {sys.argv[0]} -e \"build,Debug,Release\" # 排除指定目录")
    print(f"  {sys.argv[0]} -c \"*.tmp,*.bak\"          # 添加自定义文件模式")
    print(f"  {sys.argv[0]} -s \"hex,bin\"              # 额外清理.hex和.bin文件")
    print()

def format_size(size_bytes: int) -> str:
    """格式化文件大小为人类可读的格式"""
    for unit in ['B', 'KiB', 'MiB', 'GiB', 'TiB']:
        if size_bytes < 1024.0 or unit == 'TiB':
            break
        size_bytes /= 1024.0
    return f"{size_bytes:.2f} {unit}"

def is_executable(file_path: str) -> bool:
    """检查文件是否是无扩展名的可执行文件"""
    if not os.path.isfile(file_path):
        return False
    
    # 检查文件是否有扩展名
    file_name = os.path.basename(file_path)
    if '.' in file_name:
        return False
    
    # 检查文件是否可执行
    if os.name == 'posix':  # Unix/Linux/macOS
        return os.access(file_path, os.X_OK)
    elif os.name == 'nt':  # Windows
        # Windows没有明确的可执行权限，检查常见的可执行扩展名
        return file_path.lower().endswith(('.exe', '.bat', '.cmd', '.com'))
    
    return False

def is_excluded(file_path: str, exclude_dirs: List[str]) -> bool:
    """检查文件是否在排除目录中"""
    if not exclude_dirs:
        return False
    
    # 获取相对路径
    norm_path = os.path.normpath(file_path)
    
    for exclude_dir in exclude_dirs:
        exclude_pattern = os.path.normpath(exclude_dir)
        # 检查文件路径是否包含排除目录
        if exclude_pattern in norm_path.split(os.sep):
            return True
    
    return False

def find_files(directory: str, patterns: List[str], max_depth: Optional[int] = None) -> List[str]:
    """查找匹配指定模式的文件"""
    matches = []
    
    # 计算起始目录的深度
    base_depth = directory.count(os.sep)
    
    for root, dirnames, filenames in os.walk(directory):
        # 检查深度限制
        if max_depth is not None:
            current_depth = root.count(os.sep) - base_depth
            if current_depth > max_depth:
                continue
        
        # 查找匹配的文件
        for pattern in patterns:
            for filename in fnmatch.filter(filenames, pattern):
                matches.append(os.path.join(root, filename))
    
    return matches

def backup_file(file_path: str, target_dir: str, backup_dir: str) -> bool:
    """备份文件"""
    try:
        # 创建相对路径的目录结构
        rel_path = os.path.relpath(file_path, target_dir)
        backup_file_dir = os.path.join(backup_dir, os.path.dirname(rel_path))
        
        # 创建备份目录
        os.makedirs(backup_file_dir, exist_ok=True)
        
        # 复制文件
        shutil.copy2(file_path, os.path.join(backup_file_dir, os.path.basename(file_path)))
        return True
    except Exception as e:
        print(f"{RED}备份错误:{NC} {e}")
        return False

def main() -> None:
    """主函数"""
    # 解析命令行参数
    parser = argparse.ArgumentParser(description='STM32项目清理工具', add_help=False)
    parser.add_argument('-h', '--help', action='store_true', help='显示帮助信息')
    parser.add_argument('-v', '--version', action='store_true', help='显示版本信息')
    parser.add_argument('-d', '--dry-run', action='store_true', help='预览将要删除的文件，不实际删除')
    parser.add_argument('-V', '--verbose', action='store_true', help='显示详细信息')
    parser.add_argument('-k', '--keep-libs', action='store_true', help='保留库文件 (.a, .so)')
    parser.add_argument('-b', '--backup', action='store_true', help='在删除前创建备份')
    parser.add_argument('-B', '--backup-dir', help='指定备份目录')
    parser.add_argument('-e', '--exclude', help='排除指定目录，用逗号分隔')
    parser.add_argument('-m', '--max-depth', type=int, help='限制递归深度为N级')
    parser.add_argument('-i', '--interactive', action='store_true', help='交互式确认删除')
    parser.add_argument('-c', '--custom', help='添加自定义文件模式，用逗号分隔')
    parser.add_argument('-s', '--suffix', help='添加额外的文件后缀，用逗号分隔')
    parser.add_argument('target_dir', nargs='?', default='.', help='目标目录')
    
    args = parser.parse_args()
    
    # 显示帮助或版本信息
    if args.help:
        show_help()
        return
    
    if args.version:
        show_version()
        return
    
    # 验证目标目录
    target_dir = os.path.abspath(args.target_dir)
    if not os.path.isdir(target_dir):
        print(f"{RED}错误:{NC} 目标目录 '{target_dir}' 不存在")
        return
    
    # 处理备份
    backup_dir = None
    if args.backup or args.backup_dir:
        if args.backup_dir:
            backup_dir = args.backup_dir
        else:
            backup_dir = f"./backup_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        backup_dir = os.path.abspath(backup_dir)
        print(f"{BLUE}创建备份目录:{NC} {backup_dir}")
        os.makedirs(backup_dir, exist_ok=True)
    
    # 处理排除目录
    exclude_dirs = []
    if args.exclude:
        exclude_dirs = [d.strip() for d in args.exclude.split(',')]
    
    # 要删除的文件类型
    remove_patterns = [
        "*.o",       # 目标文件
        "*.gch",     # 预编译头文件
        "*.pch",     # 预编译头文件
        "*.d",       # 依赖文件
        "*.tmp",     # 临时文件
        "*.lo",      # libtool 对象文件
        "*.obj",     # 对象文件
        "*.pdb",     # 程序数据库
        "*.ilk",     # 增量链接文件
        "*.exp",     # 导出文件
        "*.map",     # 映射文件
        "*.gcda",    # GCC 代码覆盖数据
        "*.gcno",    # GCC 代码覆盖笔记
        "*.dSYM",    # 调试符号
        "*.lst",     # 列表文件
        "*.su",      # 堆栈使用文件
        "*.cyclo",   # 循环复杂度文件
    ]
    
    # 如果不保留库文件，添加到删除列表
    if not args.keep_libs:
        remove_patterns.extend([
            "*.a",      # 静态库
            "*.so",     # 共享库
            "*.so.*",   # 共享库带版本号
            "*.dylib",  # macOS 动态库
            "*.dll",    # Windows 动态链接库
            "*.lib",    # Windows 导入库
        ])
    
    # 要保留的文件类型（可执行文件）
    keep_patterns = [
        "*.bin",     # 二进制可执行文件
        "*.hex",     # 十六进制文件
        "*.elf",     # ELF 可执行文件
        "*.out",     # 输出可执行文件
        "*.axf",     # ARM 可执行文件
    ]
    
    # 处理自定义文件模式
    if args.custom:
        custom_patterns = [p.strip() for p in args.custom.split(',')]
        remove_patterns.extend(custom_patterns)
        if args.verbose:
            for pattern in custom_patterns:
                print(f"{YELLOW}添加自定义模式:{NC} {pattern}")
    
    # 处理额外的文件后缀
    if args.suffix:
        suffix_patterns = [f"*.{s.strip()}" for s in args.suffix.split(',')]
        remove_patterns.extend(suffix_patterns)
        if args.verbose:
            for pattern in suffix_patterns:
                print(f"{YELLOW}添加额外后缀:{NC} {pattern}")
    
    # 显示脚本开始信息
    print(f"{BLUE}=== STM32项目清理工具 ==={NC}")
    print(f"{BLUE}目标目录:{NC} {target_dir}")
    
    # 显示模式信息
    if args.dry_run:
        print(f"{YELLOW}模式: 预览 (不会实际删除文件){NC}")
    else:
        print(f"{YELLOW}模式: 实际删除{NC}")
    
    # 显示其他选项状态
    if backup_dir:
        print(f"{BLUE}备份:{NC} 启用 (目录: {backup_dir})")
    
    if exclude_dirs:
        print(f"{BLUE}排除目录:{NC} {', '.join(exclude_dirs)}")
    
    if args.max_depth is not None:
        print(f"{BLUE}最大递归深度:{NC} {args.max_depth}")
    
    if args.interactive:
        print(f"{BLUE}交互模式:{NC} 启用")
    
    if args.custom:
        print(f"{BLUE}自定义模式:{NC} {args.custom}")
    
    if args.suffix:
        print(f"{BLUE}额外后缀:{NC} {args.suffix}")
    
    print()
    
    # 统计变量
    total_files = 0
    deleted_files = 0
    kept_files = 0
    total_size = 0
    backup_files = 0
    
    # 查找要删除的文件
    files_to_delete = []
    for pattern in remove_patterns:
        found_files = find_files(target_dir, [pattern], args.max_depth)
        for file_path in found_files:
            if not is_excluded(file_path, exclude_dirs):
                files_to_delete.append(file_path)
    
    # 去重
    files_to_delete = list(set(files_to_delete))
    
    # 处理要删除的文件
    for file_path in files_to_delete:
        if os.path.isfile(file_path):
            file_size = os.path.getsize(file_path)
            total_files += 1
            total_size += file_size
            
            # 交互式确认
            do_delete = True
            if args.interactive and not args.dry_run:
                response = input(f"{YELLOW}删除文件?{NC} {file_path} ({format_size(file_size)}) [y/N]: ")
                if not response.lower().startswith('y'):
                    do_delete = False
                    print(f"{GREEN}跳过:{NC} {file_path}")
            
            if args.dry_run:
                if args.verbose:
                    print(f"{RED}将删除:{NC} {file_path} ({format_size(file_size)})")
            elif do_delete:
                # 备份文件
                if backup_dir:
                    if backup_file(file_path, target_dir, backup_dir):
                        backup_files += 1
                        if args.verbose:
                            print(f"{BLUE}备份:{NC} {file_path} -> {os.path.join(backup_dir, os.path.relpath(file_path, target_dir))}")
                
                if args.verbose:
                    print(f"{RED}删除:{NC} {file_path} ({format_size(file_size)})")
                
                try:
                    os.remove(file_path)
                    deleted_files += 1
                except Exception as e:
                    print(f"{RED}删除错误:{NC} {file_path} - {e}")
    
    # 处理要保留的文件（仅在详细模式下显示）
    if args.verbose:
        # 查找匹配保留模式的文件
        for pattern in keep_patterns:
            found_files = find_files(target_dir, [pattern], args.max_depth)
            for file_path in found_files:
                if not is_excluded(file_path, exclude_dirs):
                    print(f"{GREEN}保留:{NC} {file_path}")
                    kept_files += 1
        
        # 查找无扩展名的可执行文件
        for root, _, filenames in os.walk(target_dir):
            # 检查深度限制
            if args.max_depth is not None:
                current_depth = root.count(os.sep) - target_dir.count(os.sep)
                if current_depth > args.max_depth:
                    continue
            
            for filename in filenames:
                file_path = os.path.join(root, filename)
                if not is_excluded(file_path, exclude_dirs) and is_executable(file_path):
                    print(f"{GREEN}保留可执行文件:{NC} {file_path}")
                    kept_files += 1
    
    # 显示统计信息
    print()
    print(f"{BLUE}=== 清理统计 ==={NC}")
    if args.dry_run:
        print(f"{YELLOW}将删除文件数:{NC} {total_files}")
        print(f"{YELLOW}总计大小:{NC} {format_size(total_size)}")
        if total_files == 0:
            print(f"{GREEN}项目已经是干净的，没有需要删除的文件。{NC}")
    else:
        print(f"{GREEN}已删除文件数:{NC} {deleted_files} / {total_files}")
        print(f"{GREEN}释放空间:{NC} {format_size(total_size)}")
        if deleted_files == 0:
            print(f"{GREEN}项目已经是干净的，没有需要删除的文件。{NC}")
        
        # 显示备份信息
        if backup_dir and deleted_files > 0:
            print(f"{GREEN}已备份文件数:{NC} {backup_files}")
            print(f"{GREEN}备份目录:{NC} {backup_dir}")
            print(f"{YELLOW}提示:{NC} 如需恢复文件，请从备份目录复制回原位置")
    
    if args.verbose:
        print(f"{GREEN}保留的可执行文件数:{NC} {kept_files}")
    
    print()
    if args.dry_run:
        print(f"{YELLOW}提示:{NC} 这是预览模式，没有文件被实际删除。使用不带 -d 选项的命令来实际删除文件。")
    
    # 添加恢复提示
    if backup_dir and not args.dry_run and deleted_files > 0:
        if os.name == 'posix':  # Unix/Linux/macOS
            print(f"{YELLOW}恢复提示:{NC} 要恢复所有文件，请运行: cp -r {backup_dir}/* {target_dir}/")
        else:  # Windows
            print(f"{YELLOW}恢复提示:{NC} 要恢复所有文件，请运行: xcopy {backup_dir}\\* {target_dir}\\ /E /H /Y")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{YELLOW}操作已取消{NC}")
        sys.exit(1)