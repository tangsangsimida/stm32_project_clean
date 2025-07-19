#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
STM32项目清理工具 - 环境检测模块
此模块用于检测系统环境是否满足运行条件
"""

import os
import sys
import platform
import tempfile
import shutil
import subprocess
from pathlib import Path

def check_python_version():
    """检查Python版本是否满足要求"""
    required_version = (3, 6)
    current_version = sys.version_info
    
    if current_version >= required_version:
        return True, f"Python版本检查通过 (当前版本: {sys.version.split()[0]})"
    else:
        return False, f"Python版本过低 (当前版本: {sys.version.split()[0]}, 需要: 3.6+)"

def check_colorama():
    """检查是否安装了colorama模块"""
    try:
        import colorama
        return True, f"colorama模块已安装 (版本: {colorama.__version__})"
    except ImportError:
        return False, "未安装colorama模块 (可选，用于彩色输出)"

def check_write_permissions(directory=None):
    """检查是否有写入权限"""
    if directory is None:
        directory = os.getcwd()
    
    try:
        test_file = tempfile.NamedTemporaryFile(dir=directory, delete=True)
        test_file.close()
        return True, f"目录写入权限检查通过: {directory}"
    except (IOError, PermissionError):
        return False, f"无写入权限: {directory}"

def check_temp_directory():
    """检查临时目录是否可用"""
    try:
        with tempfile.NamedTemporaryFile() as tmp:
            return True, f"临时目录可用: {tempfile.gettempdir()}"
    except:
        return False, f"临时目录不可用: {tempfile.gettempdir()}"

def is_admin():
    """检查是否具有管理员权限"""
    if platform.system() == 'Windows':
        try:
            # 尝试创建一个临时文件在一个通常需要管理员权限的位置
            admin_path = os.path.join(os.environ.get('SystemRoot', 'C:\\Windows'), 'temp')
            if not os.path.exists(admin_path):
                return False, "无管理员权限"
            
            test_file = os.path.join(admin_path, 'admin_check.tmp')
            with open(test_file, 'w') as f:
                f.write('admin check')
            os.remove(test_file)
            return True, "具有管理员权限"
        except:
            return False, "无管理员权限"
    else:
        # Unix-like系统
        return os.geteuid() == 0, "具有管理员权限" if os.geteuid() == 0 else "无管理员权限"

def check_disk_space(directory=None, min_space_mb=100):
    """检查磁盘空间是否足够"""
    if directory is None:
        directory = os.getcwd()
    
    try:
        if platform.system() == 'Windows':
            free_bytes = shutil.disk_usage(directory).free
        else:
            stat = os.statvfs(directory)
            free_bytes = stat.f_bavail * stat.f_frsize
        
        free_mb = free_bytes / (1024 * 1024)
        
        if free_mb >= min_space_mb:
            return True, f"磁盘空间充足: {free_mb:.2f} MB可用"
        else:
            return False, f"磁盘空间不足: {free_mb:.2f} MB可用，需要至少 {min_space_mb} MB"
    except:
        return False, "无法检查磁盘空间"

def check_environment(directory=None, verbose=True):
    """执行所有环境检查并返回结果"""
    if directory is None:
        directory = os.getcwd()
    
    checks = [
        ("Python版本", check_python_version()),
        ("colorama模块", check_colorama()),
        ("目录写入权限", check_write_permissions(directory)),
        ("临时目录", check_temp_directory()),
        ("管理员权限", is_admin()),
        ("磁盘空间", check_disk_space(directory))
    ]
    
    all_passed = all(result[0] for _, result in checks)
    
    if verbose:
        print("\n环境检查结果:")
        print("=" * 50)
        for name, (passed, message) in checks:
            status = "✓" if passed else "✗"
            print(f"{status} {name}: {message}")
        print("=" * 50)
        print(f"总体结果: {'通过' if all_passed else '未通过'}")
        print()
    
    return all_passed, checks

if __name__ == "__main__":
    # 如果直接运行此脚本，执行环境检查
    passed, results = check_environment()
    sys.exit(0 if passed else 1)