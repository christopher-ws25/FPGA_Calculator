################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/arith_operations.c \
../src/functions.c \
../src/gpio_init.c \
../src/main.c \
../src/platform.c \
../src/seg7_display.c \
../src/timer_interrupt_func.c \
../src/xinterruptES3.c 

OBJS += \
./src/arith_operations.o \
./src/functions.o \
./src/gpio_init.o \
./src/main.o \
./src/platform.o \
./src/seg7_display.o \
./src/timer_interrupt_func.o \
./src/xinterruptES3.o 

C_DEPS += \
./src/arith_operations.d \
./src/functions.d \
./src/gpio_init.d \
./src/main.d \
./src/platform.d \
./src/seg7_display.d \
./src/timer_interrupt_func.d \
./src/xinterruptES3.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../calculator_bsp/microblaze_0/include -mlittle-endian -mcpu=v9.5 -mxl-soft-mul -Wl,--no-relax -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


