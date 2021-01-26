################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../main.c 

OBJS += \
./main.o 

C_DEPS += \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS\include" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\MemMang" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC\RISCV" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\hal" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\riscv_hal" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\Creative" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\drivers\CoreGPIO" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\drivers\CoreUARTapb" -I"D:\Work\SoftConsole6\Creative_MiV_FreeRTOS_Demo\drivers\CoreTimer" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


