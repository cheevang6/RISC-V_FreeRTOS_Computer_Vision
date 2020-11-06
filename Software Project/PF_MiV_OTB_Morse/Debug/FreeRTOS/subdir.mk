################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../FreeRTOS/croutine.c \
../FreeRTOS/event_groups.c \
../FreeRTOS/list.c \
../FreeRTOS/queue.c \
../FreeRTOS/string.c \
../FreeRTOS/tasks.c \
../FreeRTOS/timers.c 

OBJS += \
./FreeRTOS/croutine.o \
./FreeRTOS/event_groups.o \
./FreeRTOS/list.o \
./FreeRTOS/queue.o \
./FreeRTOS/string.o \
./FreeRTOS/tasks.o \
./FreeRTOS/timers.o 

C_DEPS += \
./FreeRTOS/croutine.d \
./FreeRTOS/event_groups.d \
./FreeRTOS/list.d \
./FreeRTOS/queue.d \
./FreeRTOS/string.d \
./FreeRTOS/tasks.d \
./FreeRTOS/timers.d 


# Each subdirectory must supply rules for building sources it contributes
FreeRTOS/%.o: ../FreeRTOS/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\include" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\MemMang" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\FreeRTOS\portable\GCC\RISCV" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\riscv_hal" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\Creative" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreGPIO" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreUARTapb" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreTimer" -I"C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\drivers\CoreI2C" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


