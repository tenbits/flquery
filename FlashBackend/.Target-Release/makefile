################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

REPOSITORY_ROOT := C:/bada/1.2.1/IDE/workspace/repository/FLVPlayer/Target-Release

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include src/subdir.mk
-include src/FlashCppProxy/subdir.mk
-include src/FlashCppProxy/Data/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: FlashTest.exe

# Tool invocations
FlashTest.exe: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: bada C++ Linker'
	@echo 'ldflags: -nostdlib -lc-newlib -lm-newlib -L"C:/bada/1.2.1/Model/Wave_LP4/Target" -L"C:/bada/1.2.1/Tools/Toolchains/ARM/arm-samsung-nucleuseabi/lib" -L"C:/bada/1.2.1/Tools/Toolchains/ARM/lib/gcc/arm-samsung-nucleuseabi/4.4.1" -L"C:/bada/1.2.1/IDE/workspace/FLVPlayer/lib" -shared -o"FlashTest.exe" ./src/FlashForm.o ./src/FlashTest.o ./src/FlashTestEntry.o ./src/MenuForm.o ./src/FlashCppProxy/FlashProxyForm.o ./src/FlashCppProxy/Utils.o ./src/FlashCppProxy/Data/Json.o ./src/FlashCppProxy/Data/ProxyServiceFactory.o ./src/FlashCppProxy/Data/StringDictionary.o '
	arm-samsung-nucleuseabi-ld @ldflags @ldobjs  $(USER_OBJS) $(LIBS) -lstdc++ -lgcc_s
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C++_DEPS)$(C_DEPS)$(CC_DEPS)$(CPP_DEPS)$(CXX_DEPS)$(C_UPPER_DEPS) FlashTest.exe $(REPOSITORY_ROOT)/*
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
