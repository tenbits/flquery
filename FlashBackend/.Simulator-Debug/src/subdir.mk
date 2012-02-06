################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/FlashForm.b.cpp \
../src/FlashForm.cpp \
../src/FlashTest.cpp \
../src/FlashTestEntry.cpp \
../src/MenuForm.cpp 

OBJS += \
./src/FlashForm.b.o \
./src/FlashForm.o \
./src/FlashTest.o \
./src/FlashTestEntry.o \
./src/MenuForm.o 

CPP_DEPS += \
./src/FlashForm.b.d \
./src/FlashForm.d \
./src/FlashTest.d \
./src/FlashTestEntry.d \
./src/MenuForm.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: bada C++ Compiler'
	i686-mingw32-g++ -D_DEBUG -DSHP -DBUILD_DLL -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/FlashTest/inc" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	i686-mingw32-g++ -D_DEBUG -DSHP -DBUILD_DLL -I"C:/bada/1.2.1/include" -I"C:/bada/1.2.1/IDE/workspace/FlashTest/inc" -O0 -g3 -Wall -E -fmessage-length=0 -o"C:/bada/1.2.1/IDE/workspace/repository/FlashTest/Simulator-Debug/$(notdir $(basename $@).i)" "$<"
	@echo 'Finished building: $<'
	@echo ' '


