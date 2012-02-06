################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/FlashForm.cpp \
../src/FlashTest.cpp \
../src/FlashTestEntry.cpp \
../src/MenuForm.cpp 

OBJS += \
./src/FlashForm.o \
./src/FlashTest.o \
./src/FlashTestEntry.o \
./src/MenuForm.o 

CPP_DEPS += \
./src/FlashForm.d \
./src/FlashTest.d \
./src/FlashTestEntry.d \
./src/MenuForm.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: bada C++ Compiler'
	arm-samsung-nucleuseabi-g++ -D_DEBUG -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/Denkreactor/inc" -O0 -g -Wall -c -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	arm-samsung-nucleuseabi-g++ -D_DEBUG -DSHP -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/Denkreactor/inc" -O0 -g -Wall -E -fpic -fshort-wchar -mcpu=cortex-a8 -mfpu=vfpv3 -mfloat-abi=hard -mlittle-endian -mthumb-interwork -o"C:/bada/1.2.1/IDE/workspace/repository/Denkreactor/Target-Debug/$(notdir $(basename $@).i)" "$<"
	@echo 'Finished building: $<'
	@echo ' '


