# STM32项目清理工具 (v1.1.0)

一个用于清理STM32项目中间编译文件的跨平台工具。

## 功能特点

- **跨平台支持**: 在Windows、macOS和Linux上运行
- **自动识别**: 自动识别并删除常见的中间编译文件
- **智能保留**: 保留可执行文件和其他重要文件
- **预览模式**: 在实际删除前预览将要删除的文件
- **详细统计**: 显示删除的文件数量和释放的空间
- **彩色输出**: 使用彩色输出增强可读性
- **备份功能**: 在删除前创建文件备份
- **排除目录**: 可以排除指定目录不被清理
- **递归深度**: 可以限制递归搜索的深度
- **交互式确认**: 可以在删除前确认每个文件
- **自定义模式**: 可以添加自定义的文件模式

## 安装要求

### 所有平台
- Python 3.6或更高版本

### Windows
- 支持 Windows 7/8/10/11
- 可选：将脚本目录添加到 PATH 环境变量，以便从任何位置运行

### macOS
- 支持 macOS 10.13 (High Sierra) 或更高版本
- 终端访问权限

### Linux
- 支持大多数现代 Linux 发行版
- 终端访问权限

### 可选依赖
- colorama (用于Windows彩色输出)

## 使用方法

### Windows

Windows 用户可以使用批处理文件或直接使用 Python 运行脚本：

#### 使用批处理文件
```cmd
# 双击运行批处理文件 (默认清理当前目录)
stm32_project_clean.bat

# 清理指定目录
stm32_project_clean.bat C:\path\to\stm32_project

# 预览模式
stm32_project_clean.bat -d C:\path\to\stm32_project

# 显示帮助信息
stm32_project_clean.bat -h
```

#### 使用 Python 直接运行
```cmd
# 清理当前目录
python stm32_project_clean.py

# 清理指定目录
python stm32_project_clean.py C:\path\to\stm32_project

# 预览模式
python stm32_project_clean.py -d C:\path\to\stm32_project
```

### macOS

macOS 用户可以使用 shell 脚本包装器或直接运行 Python 脚本：

#### 使用 shell 脚本包装器
```bash
# 给脚本添加执行权限
chmod +x stm32_project_clean.sh

# 清理当前目录
./stm32_project_clean.sh

# 清理指定目录
./stm32_project_clean.sh /path/to/stm32_project

# 预览模式
./stm32_project_clean.sh -d /path/to/stm32_project
```

#### 使用 Python 直接运行
```bash
# 给 Python 脚本添加执行权限
chmod +x stm32_project_clean.py

# 清理当前目录
./stm32_project_clean.py

# 清理指定目录
./stm32_project_clean.py /path/to/stm32_project

# 预览模式
./stm32_project_clean.py -d /path/to/stm32_project
```

### Linux

Linux 用户可以使用 shell 脚本包装器或直接运行 Python 脚本：

#### 使用 shell 脚本包装器
```bash
# 给脚本添加执行权限
chmod +x stm32_project_clean.sh

# 清理当前目录
./stm32_project_clean.sh

# 清理指定目录
./stm32_project_clean.sh /path/to/stm32_project

# 预览模式
./stm32_project_clean.sh -d /path/to/stm32_project
```

#### 使用 Python 直接运行
```bash
# 给 Python 脚本添加执行权限
chmod +x stm32_project_clean.py

# 清理当前目录
./stm32_project_clean.py

# 清理指定目录
./stm32_project_clean.py /path/to/stm32_project

# 预览模式
./stm32_project_clean.py -d /path/to/stm32_project
```

> **注意**: 
> - 在所有平台上，双击运行脚本或不带参数运行脚本时，将默认清理当前目录。
> - 在 macOS 和 Linux 上首次运行前，请确保已给脚本添加执行权限。
> - 如果在 macOS 上遇到"未经验证的开发者"警告，可以在"系统偏好设置 > 安全性与隐私"中允许运行。

## 平台特定说明

### Windows

1. **双击运行**：
   - 双击 `stm32_project_clean.bat` 文件可以直接运行脚本，默认清理当前目录。
   - 如果需要以管理员身份运行，可以右键点击批处理文件，选择"以管理员身份运行"。

2. **命令提示符**：
   - 打开命令提示符 (CMD) 或 PowerShell。
   - 导航到脚本所在目录：`cd path\to\script`。
   - 运行脚本：`stm32_project_clean.bat [选项] [目录]`。

3. **添加到 PATH**：
   - 将脚本目录添加到系统 PATH 环境变量，可以从任何位置运行脚本。
   - 右键点击"此电脑" > 属性 > 高级系统设置 > 环境变量 > 系统变量 > Path > 编辑 > 新建 > 添加脚本目录路径。

### macOS

1. **首次运行**：
   - 打开终端应用程序。
   - 导航到脚本所在目录：`cd path/to/script`。
   - 添加执行权限：`chmod +x stm32_project_clean.py stm32_project_clean.sh`。
   - 运行脚本：`./stm32_project_clean.sh [选项] [目录]`。

2. **安全性警告**：
   - 如果遇到"无法打开'stm32_project_clean.py'，因为它来自身份不明的开发者"的警告：
     1. 打开系统偏好设置 > 安全性与隐私 > 通用。
     2. 点击"仍要打开"或"允许"。
     3. 或者在终端中运行：`xattr -d com.apple.quarantine stm32_project_clean.py stm32_project_clean.sh`。

3. **创建别名**：
   - 为了方便使用，可以在 `~/.zshrc` 或 `~/.bash_profile` 中创建别名：
   - `echo 'alias stm32clean="path/to/stm32_project_clean.sh"' >> ~/.zshrc`
   - 然后重新加载配置：`source ~/.zshrc`

### Linux

1. **首次运行**：
   - 打开终端。
   - 导航到脚本所在目录：`cd path/to/script`。
   - 添加执行权限：`chmod +x stm32_project_clean.py stm32_project_clean.sh`。
   - 运行脚本：`./stm32_project_clean.sh [选项] [目录]`。

2. **创建符号链接**：
   - 为了从任何位置运行脚本，可以创建符号链接到 `/usr/local/bin`：
   - `sudo ln -s "$(pwd)/stm32_project_clean.sh" /usr/local/bin/stm32clean`
   - 然后可以直接使用 `stm32clean` 命令。

3. **桌面快捷方式**：
   - 创建 `.desktop` 文件以添加桌面快捷方式：
   ```
   [Desktop Entry]
   Name=STM32 Project Cleaner
   Comment=Clean STM32 project intermediate files
   Exec=/path/to/stm32_project_clean.sh
   Terminal=true
   Type=Application
   Icon=utilities-terminal
   ```

## 命令行选项

```
选项:
  -h, --help         显示帮助信息
  -v, --version      显示版本信息
  -d, --dry-run      预览将要删除的文件，不实际删除
  -V, --verbose      显示详细信息
  -k, --keep-libs    保留库文件 (.a, .so)
  -b, --backup       在删除前创建备份
  -B, --backup-dir DIR 指定备份目录 (默认: ./backup_YYYYMMDD_HHMMSS)
  -e, --exclude DIRS 排除指定目录，用逗号分隔
  -m, --max-depth N  限制递归深度为N级
  -i, --interactive  交互式确认删除
  -c, --custom PAT   添加自定义文件模式，用逗号分隔
  -s, --suffix SUF   添加额外的文件后缀，用逗号分隔
```

## 示例

```bash
# 清理当前目录
stm32_project_clean.py

# 清理指定STM32项目目录
stm32_project_clean.py ~/stm32_project

# 预览将要删除的文件
stm32_project_clean.py -d ~/stm32_project

# 创建备份并显示详细信息
stm32_project_clean.py -b -V ~/stm32_project

# 排除指定目录
stm32_project_clean.py -e "build,Debug,Release"

# 添加自定义文件模式
stm32_project_clean.py -c "*.tmp,*.bak"

# 额外清理.hex和.bin文件
stm32_project_clean.py -s "hex,bin"
```

## 从Bash脚本迁移

如果你之前使用的是`stm32_project_clean.sh` Bash脚本，这个Python版本提供了完全相同的功能，但增加了跨平台支持。命令行参数保持不变，所以你可以直接替换使用。

## 许可证

GNU General Public License v3.0

## 贡献

我们欢迎并感谢任何形式的贡献！如果您想为这个项目做出贡献，请查看 [贡献指南](CONTRIBUTING.md) 了解详细规则和流程。

## 版本历史

详细的更新日志请查看 [CHANGELOG.md](CHANGELOG.md)

- 1.1.0: 跨平台支持，添加Windows批处理和Linux/macOS shell脚本包装器，默认清理当前目录
- 1.0.1: 修复bug，优化性能
- 1.0.0: 初始版本

## 作者

Dennis_Re_Yoonjiho