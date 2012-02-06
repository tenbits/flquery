################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/FlashCppProxy/Data/Json.cpp \
../src/FlashCppProxy/Data/ProxyServiceFactory.cpp \
../src/FlashCppProxy/Data/StringDictionary.cpp 

OBJS += \
./src/FlashCppProxy/Data/Json.o \
./src/FlashCppProxy/Data/ProxyServiceFactory.o \
./src/FlashCppProxy/Data/StringDictionary.o 

CPP_DEPS += \
./src/FlashCppProxy/Data/Json.d \
./src/FlashCppProxy/Data/ProxyServiceFactory.d \
./src/FlashCppProxy/Data/StringDictionary.d 


# Each subdirectory must supply rules for building sources it contributes
src/FlashCppProxy/Data/%.o: ../src/FlashCppProxy/Data/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: bada C++ Compiler'
	arm-samsung-nucleuseabi-g++ -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/FLVPlayer/inc" -Os -Wall -c -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	arm-samsung-nucleuseabi-g++ -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/FLVPlayer/inc" -Os -Wall -E -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -o"C:/bada/1.2.1/IDE/workspace/repository/FLVPlayer/Target-Release/$(notdir $(basename $@).i)" "$<"
	@echo 'Finished building: $<'
	@echo ' '


