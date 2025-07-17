# STM32项目清理工具

[![版本](https://img.shields.io/badge/版本-1.0-blue.svg)](https://github.com/username/stm32_project_clean/releases/tag/v1.0)
[![许可证](https://img.shields.io/badge/许可证-GPL--3.0-green.svg)](LICENSE)

一个专为STM32项目设计的命令行工具，用于清理编译过程中产生的中间文件，保留重要的可执行文件和源代码。

## 功能特点

- 自动识别并删除常见的中间编译文件（.o, .d, .map等）
- 智能保留可执行文件（.bin, .hex, .elf等）
- 支持无扩展名可执行文件的识别和保留
- 提供预览模式，可以在实际删除前查看将要删除的文件
- 详细的统计信息，包括删除文件数量和释放空间大小
- 彩色输出，使信息更易于阅读

## 安装

1. 下载脚本文件：

```bash
wget https://raw.githubusercontent.com/username/stm32_project_clean/main/stm32_project_clean.sh
```

2. 添加执行权限：

```bash
chmod +x stm32_project_clean.sh
```

3. 可选：将脚本移动到系统路径中，以便全局访问：

```bash
sudo mv stm32_project_clean.sh /usr/local/bin/
```

## 使用方法

### 基本用法

清理当前目录下的STM32项目：

```bash
./stm32_project_clean.sh
```

清理指定目录下的STM32项目：

```bash
./stm32_project_clean.sh ~/projects/my_stm32_project
```

### 预览模式

在实际删除前预览将要删除的文件：

```bash
./stm32_project_clean.sh -d ~/projects/my_stm32_project
```

### 详细模式

显示详细的操作信息：

```bash
./stm32_project_clean.sh -V ~/projects/my_stm32_project
```

### 显示版本信息

```bash
./stm32_project_clean.sh -v
```

### 保留库文件

如果你想保留库文件（.a, .so等）：

```bash
./stm32_project_clean.sh -k ~/projects/my_stm32_project
```

## 命令行选项

| 选项 | 长选项 | 描述 |
|------|--------|------|
| `-h` | `--help` | 显示帮助信息 |
| `-v` | `--version` | 显示版本信息 |
| `-d` | `--dry-run` | 预览模式，不实际删除文件 |
| `-V` | `--verbose` | 显示详细信息 |
| `-k` | `--keep-libs` | 保留库文件（.a, .so等） |

## 支持的文件类型

### 将被删除的文件类型

- `.o` - 目标文件
- `.gch`, `.pch` - 预编译头文件
- `.d` - 依赖文件
- `.tmp` - 临时文件
- `.map` - 映射文件
- `.lst` - 列表文件
- `.su` - 堆栈使用文件
- `.cyclo` - 循环复杂度文件
- 以及更多编译中间文件

### 将被保留的文件类型

- `.bin` - 二进制可执行文件
- `.hex` - 十六进制文件
- `.elf` - ELF可执行文件
- `.out` - 输出可执行文件
- `.axf` - ARM可执行文件
- 无扩展名的可执行文件

## 许可证

本项目采用GNU通用公共许可证v3.0（GPL-3.0）进行许可。详情请参阅[LICENSE](LICENSE)文件或访问[https://www.gnu.org/licenses/gpl-3.0.html](https://www.gnu.org/licenses/gpl-3.0.html)。

## 作者

- **Dennis_Re_Yoonjiho**

## 贡献

欢迎提交问题报告和改进建议！如果你想贡献代码，请提交拉取请求。