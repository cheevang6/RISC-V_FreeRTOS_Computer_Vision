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
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DMSCC_STDIO_THRU_CORE_UART_APB -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\include" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\MemMang" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\FreeRTOS\portable\GCC\RISCV" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\hal" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\riscv_hal" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\Creative" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreGPIO" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreUARTapb" -I"C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\drivers\CoreTimer" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

