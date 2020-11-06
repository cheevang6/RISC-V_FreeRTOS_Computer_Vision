################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/CoreI2C/core_i2c.c \
../drivers/CoreI2C/i2c_interrupt.c 

OBJS += \
./drivers/CoreI2C/core_i2c.o \
./drivers/CoreI2C/i2c_interrupt.o 

C_DEPS += \
./drivers/CoreI2C/core_i2c.d \
./drivers/CoreI2C/i2c_interrupt.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/CoreI2C/%.o: ../drivers/CoreI2C/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\include" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\MemMang" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC\RISCV" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\riscv_hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\Creative" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreGPIO" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreUARTapb" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreTimer" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreI2C" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


