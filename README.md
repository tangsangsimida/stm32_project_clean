# STM32项目清理工具

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

一个用于清理STM32项目中间编译文件的跨平台工具，支持Windows、Linux和macOS。

## 功能特点

- 自动识别并清理STM32项目中的中间编译文件和目录
- 支持多种IDE和编译系统生成的文件（Keil MDK、IAR EWARM、STM32CubeIDE等）
- 跨平台支持（Windows、Linux、macOS）
- 彩色输出，清晰展示清理过程
- 支持递归清理子目录
- 支持备份模式，在删除前创建备份
- 支持模拟模式，显示将要删除的文件但不实际删除
- 支持自定义排除规则，避免删除重要文件
- 详细的日志记录，便于追踪清理过程

## 安装指南

### Windows

1. 下载项目文件
2. 运行 `install_windows.bat` 安装脚本（右键点击，选择"以管理员身份运行"）
3. 按照安装向导的提示完成安装

安装脚本将：
- 检查Python环境
- 安装必要的Python模块
- 将脚本目录添加到系统PATH环境变量（可选）
- 创建桌面快捷方式（可选）

### Linux/macOS

1. 下载项目文件
2. 打开终端，进入项目目录
3. 运行安装脚本：
   ```bash
   chmod +x install_unix.sh
   sudo ./install_unix.sh
   ```
4. 按照安装向导的提示完成安装

安装脚本将：
- 检查Python环境
- 安装必要的Python模块
- 将脚本目录添加到系统PATH环境变量（可选）
- 创建桌面快捷方式或应用程序启动器（可选）

## 使用方法

### Windows

有多种方式使用此工具：

1. **直接运行批处理文件**：双击 `stm32_project_clean.bat` 清理当前目录
2. **拖放目录**：将要清理的文件夹拖放到 `stm32_project_clean.bat` 上
3. **命令行使用**：
   ```cmd
   stm32_project_clean.bat [选项] [目录]
   ```

### Linux/macOS

1. **直接运行脚本**：
   ```bash
   ./stm32_project_clean.sh [选项] [目录]
   ```
2. **如果已添加到PATH**：
   ```bash
   stm32_project_clean.sh [选项] [目录]
   ```

### 命令行参数

```
用法: stm32_project_clean.py [选项] [目录]

选项:
  -h, --help            显示帮助信息
  -v, --version         显示版本信息
  --skip-env-check      跳过环境检测
  -r, --recursive       递归清理子目录
  -d, --dry-run         模拟模式，不实际删除文件
  -b, --backup          在删除前创建备份
  -f, --force           强制模式，不提示确认
  -e PATTERN, --exclude PATTERN
                        排除匹配的文件或目录 (可多次使用)
  -l FILE, --log FILE   将日志写入指定文件
  -q, --quiet           安静模式，减少输出
  --no-color            禁用彩色输出
```

### 示例

1. 清理当前目录：
   ```
   stm32_project_clean.py
   ```

2. 递归清理指定目录，并创建备份：
   ```
   stm32_project_clean.py -r -b /path/to/project
   ```

3. 模拟清理，查看将要删除的文件：
   ```
   stm32_project_clean.py -d -r /path/to/project
   ```

4. 排除特定文件或目录：
   ```
   stm32_project_clean.py -r -e "*.bak" -e "backup/*" /path/to/project
   ```

## 清理的文件类型

此工具会清理以下类型的文件和目录：

1. **编译输出文件**：
   - `.o`, `.obj`, `.d`, `.crf`, `.lst`, `.out`, `.hex`, `.bin`, `.map`, `.axf`, `.elf`

2. **临时文件**：
   - `.bak`, `.tmp`, `.temp`

3. **IDE生成的目录**：
   - `Debug/`, `Release/`, `Objects/`, `Listings/`, `MDK-ARM/DebugConfig/`

4. **其他中间文件**：
   - `.dep`, `.i`, `.pbi`, `.xcl`, `.pbd`, `.browse`, `.linf`

## 贡献指南

欢迎贡献代码、报告问题或提出改进建议！请遵循以下步骤：

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 打开一个 Pull Request

## 许可证

本项目采用 GNU General Public License v3.0 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

## 作者

- **Dennis_Re_Yoonjiho** - *初始工作* - [GitHub](https://github.com/username)

## 致谢

- 感谢所有为此项目做出贡献的开发者
- 感谢STM32社区的支持和反馈