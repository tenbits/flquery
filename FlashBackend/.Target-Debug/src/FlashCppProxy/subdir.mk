################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/FlashCppProxy/FlashProxyForm.cpp \
../src/FlashCppProxy/Utils.cpp 

OBJS += \
./src/FlashCppProxy/FlashProxyForm.o \
./src/FlashCppProxy/Utils.o 

CPP_DEPS += \
./src/FlashCppProxy/FlashProxyForm.d \
./src/FlashCppProxy/Utils.d 


# Each subdirectory must supply rules for building sources it contributes
src/FlashCppProxy/%.o: ../src/FlashCppProxy/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: bada C++ Compiler'
	arm-samsung-nucleuseabi-g++ -D_DEBUG -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/Denkreactor/inc" -O0 -g -Wall -c -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	arm-samsung-nucleuseabi-g++ -D_DEBUG -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/Denkreactor/inc" -O0 -g -Wall -E -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -o"C:/bada/1.2.1/IDE/workspace/repository/Denkreactor/Target-Debug/$(notdir $(basename $@).i)" "$<"
	@echo 'Finished building: $<'
	@echo ' '


