# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build

# Include any dependencies generated for this target.
include CMakeFiles/test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/test.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/test.dir/flags.make

CMakeFiles/test.dir/Core/Src/main.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/main.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/main.c
CMakeFiles/test.dir/Core/Src/main.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/test.dir/Core/Src/main.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/main.c.obj -MF CMakeFiles/test.dir/Core/Src/main.c.obj.d -o CMakeFiles/test.dir/Core/Src/main.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/main.c

CMakeFiles/test.dir/Core/Src/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/main.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/main.c > CMakeFiles/test.dir/Core/Src/main.c.i

CMakeFiles/test.dir/Core/Src/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/main.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/main.c -o CMakeFiles/test.dir/Core/Src/main.c.s

CMakeFiles/test.dir/Core/Src/gpio.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/gpio.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/gpio.c
CMakeFiles/test.dir/Core/Src/gpio.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/test.dir/Core/Src/gpio.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/gpio.c.obj -MF CMakeFiles/test.dir/Core/Src/gpio.c.obj.d -o CMakeFiles/test.dir/Core/Src/gpio.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/gpio.c

CMakeFiles/test.dir/Core/Src/gpio.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/gpio.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/gpio.c > CMakeFiles/test.dir/Core/Src/gpio.c.i

CMakeFiles/test.dir/Core/Src/gpio.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/gpio.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/gpio.c -o CMakeFiles/test.dir/Core/Src/gpio.c.s

CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_it.c
CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj -MF CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj.d -o CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_it.c

CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_it.c > CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.i

CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_it.c -o CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.s

CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_hal_msp.c
CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj -MF CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj.d -o CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_hal_msp.c

CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_hal_msp.c > CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.i

CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/stm32f4xx_hal_msp.c -o CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.s

CMakeFiles/test.dir/Core/Src/sysmem.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/sysmem.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/sysmem.c
CMakeFiles/test.dir/Core/Src/sysmem.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/test.dir/Core/Src/sysmem.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/sysmem.c.obj -MF CMakeFiles/test.dir/Core/Src/sysmem.c.obj.d -o CMakeFiles/test.dir/Core/Src/sysmem.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/sysmem.c

CMakeFiles/test.dir/Core/Src/sysmem.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/sysmem.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/sysmem.c > CMakeFiles/test.dir/Core/Src/sysmem.c.i

CMakeFiles/test.dir/Core/Src/sysmem.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/sysmem.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/sysmem.c -o CMakeFiles/test.dir/Core/Src/sysmem.c.s

CMakeFiles/test.dir/Core/Src/syscalls.c.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/Core/Src/syscalls.c.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/syscalls.c
CMakeFiles/test.dir/Core/Src/syscalls.c.obj: CMakeFiles/test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/test.dir/Core/Src/syscalls.c.obj"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test.dir/Core/Src/syscalls.c.obj -MF CMakeFiles/test.dir/Core/Src/syscalls.c.obj.d -o CMakeFiles/test.dir/Core/Src/syscalls.c.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/syscalls.c

CMakeFiles/test.dir/Core/Src/syscalls.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test.dir/Core/Src/syscalls.c.i"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/syscalls.c > CMakeFiles/test.dir/Core/Src/syscalls.c.i

CMakeFiles/test.dir/Core/Src/syscalls.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test.dir/Core/Src/syscalls.c.s"
	/usr/bin/arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/Core/Src/syscalls.c -o CMakeFiles/test.dir/Core/Src/syscalls.c.s

CMakeFiles/test.dir/startup_stm32f407xx.s.obj: CMakeFiles/test.dir/flags.make
CMakeFiles/test.dir/startup_stm32f407xx.s.obj: /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/startup_stm32f407xx.s
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building ASM object CMakeFiles/test.dir/startup_stm32f407xx.s.obj"
	/usr/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/test.dir/startup_stm32f407xx.s.obj -c /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/startup_stm32f407xx.s

CMakeFiles/test.dir/startup_stm32f407xx.s.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing ASM source to CMakeFiles/test.dir/startup_stm32f407xx.s.i"
	/usr/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -E /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/startup_stm32f407xx.s > CMakeFiles/test.dir/startup_stm32f407xx.s.i

CMakeFiles/test.dir/startup_stm32f407xx.s.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling ASM source to assembly CMakeFiles/test.dir/startup_stm32f407xx.s.s"
	/usr/bin/arm-none-eabi-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -S /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/startup_stm32f407xx.s -o CMakeFiles/test.dir/startup_stm32f407xx.s.s

# Object files for target test
test_OBJECTS = \
"CMakeFiles/test.dir/Core/Src/main.c.obj" \
"CMakeFiles/test.dir/Core/Src/gpio.c.obj" \
"CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj" \
"CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj" \
"CMakeFiles/test.dir/Core/Src/sysmem.c.obj" \
"CMakeFiles/test.dir/Core/Src/syscalls.c.obj" \
"CMakeFiles/test.dir/startup_stm32f407xx.s.obj"

# External object files for target test
test_EXTERNAL_OBJECTS = \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Core/Src/system_stm32f4xx.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c.obj" \
"/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/user/CMakeFiles/user_objects.dir/Application/src/user_main.cpp.obj"

test.elf: CMakeFiles/test.dir/Core/Src/main.c.obj
test.elf: CMakeFiles/test.dir/Core/Src/gpio.c.obj
test.elf: CMakeFiles/test.dir/Core/Src/stm32f4xx_it.c.obj
test.elf: CMakeFiles/test.dir/Core/Src/stm32f4xx_hal_msp.c.obj
test.elf: CMakeFiles/test.dir/Core/Src/sysmem.c.obj
test.elf: CMakeFiles/test.dir/Core/Src/syscalls.c.obj
test.elf: CMakeFiles/test.dir/startup_stm32f407xx.s.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Core/Src/system_stm32f4xx.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c.obj
test.elf: cmake/stm32cubemx/CMakeFiles/STM32_Drivers.dir/__/__/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c.obj
test.elf: user/CMakeFiles/user_objects.dir/Application/src/user_main.cpp.obj
test.elf: CMakeFiles/test.dir/build.make
test.elf: CMakeFiles/test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking CXX executable test.elf"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test.dir/link.txt --verbose=$(VERBOSE)
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold "Generating test.hex"
	arm-none-eabi-objcopy -O ihex /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/test.elf test.hex
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold "Generating test.bin"
	arm-none-eabi-objcopy -O binary /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/test.elf test.bin

# Rule to build all files generated by this target.
CMakeFiles/test.dir/build: test.elf
.PHONY : CMakeFiles/test.dir/build

CMakeFiles/test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/test.dir/clean

CMakeFiles/test.dir/depend:
	cd /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build /home/dennis/Desktop/workspace/github_projects/stm32_project_clean/test/build/CMakeFiles/test.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/test.dir/depend

