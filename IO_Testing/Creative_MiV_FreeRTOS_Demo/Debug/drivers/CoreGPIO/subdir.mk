################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/CoreGPIO/core_gpio.c 

OBJS += \
./drivers/CoreGPIO/core_gpio.o 

C_DEPS += \
./drivers/CoreGPIO/core_gpio.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/CoreGPIO/%.o: ../drivers/CoreGPIO/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\include" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\MemMang" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC\RISCV" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\hal" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\riscv_hal" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\Creative" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreGPIO" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreUARTapb" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreTimer" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

