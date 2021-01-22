################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/CoreUARTapb/core_uart_apb.c 

OBJS += \
./drivers/CoreUARTapb/core_uart_apb.o 

C_DEPS += \
./drivers/CoreUARTapb/core_uart_apb.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/CoreUARTapb/%.o: ../drivers/CoreUARTapb/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\include" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\MemMang" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC\RISCV" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\riscv_hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\Creative" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreGPIO" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreUARTapb" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreTimer" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreI2C" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


