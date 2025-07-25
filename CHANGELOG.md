# 更新日志

本项目的所有显著更改都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [1.2.0] - 2023-12-10

### 新增
- 环境检测模块 (environment_check.py)，用于检查系统环境是否满足运行条件
- Linux/macOS 安装脚本 (install_unix.sh)，提供完整的安装流程
- 命令行参数 `--skip-env-check` 用于跳过环境检测
- 详细的项目文档 (README.md)

### 改进
- 增强 Windows 批处理文件，添加更详细的环境检测
- 增强 Linux/macOS shell 脚本，添加彩色输出和错误处理
- 改进错误提示和用户引导
- 优化彩色输出，添加更多颜色区分不同类型的信息
- 添加 Python 版本检查，确保兼容性

### 修复
- 修复在某些环境下颜色显示不正确的问题
- 修复权限检查逻辑

## [1.1.0] - 2023-11-15

### 新增
- 跨平台支持：重写为 Python 脚本，支持 Windows、macOS 和 Linux
- Windows 批处理文件 (stm32_project_clean.bat)，方便 Windows 用户使用
- Linux/macOS shell 脚本包装器 (stm32_project_clean.sh)
- 双击运行脚本时默认清理当前目录
- 详细的贡献指南 (CONTRIBUTING.md)

### 改进
- 更新 README.md，添加跨平台使用说明
- 改进错误处理和用户提示
- 优化彩色输出支持，使用 colorama 库在 Windows 上实现彩色输出

### 修复
- 修复在某些系统上路径处理的问题
- 修复文件大小计算的精度问题

## [1.0.1] - 2023-10-20

### 改进
- 优化文件搜索性能
- 改进统计信息显示

### 修复
- 修复在某些情况下无法正确识别可执行文件的问题
- 修复备份功能的小错误

## [1.0.0] - 2023-10-01

### 新增
- 初始版本发布
- 支持清理 STM32 项目中的中间编译文件
- 预览模式
- 详细统计信息
- 彩色输出
- 备份功能
- 排除目录选项
- 递归深度限制
- 交互式确认
- 自定义文件模式