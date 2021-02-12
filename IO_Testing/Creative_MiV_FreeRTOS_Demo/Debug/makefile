################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include riscv_hal/subdir.mk
-include hal/subdir.mk
-include drivers/CoreUARTapb/subdir.mk
-include drivers/CoreTimer/subdir.mk
-include drivers/CoreGPIO/subdir.mk
-include FreeRTOS/portable/MemMang/subdir.mk
-include FreeRTOS/portable/GCC/RISCV/subdir.mk
-include FreeRTOS/subdir.mk
-include Creative/subdir.mk
-include .metadata/.plugins/org.eclipse.cdt.make.core/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
Creative_MiV_FreeRTOS_Demo.hex \

SECONDARY_LIST += \
Creative_MiV_FreeRTOS_Demo.lst \

SECONDARY_SIZE += \
Creative_MiV_FreeRTOS_Demo.siz \


# All Target
all: Creative_MiV_FreeRTOS_Demo.elf secondary-outputs

# Tool invocations
Creative_MiV_FreeRTOS_Demo.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -T "C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\Creative_MiV_FreeRTOS_Demo\riscv_hal\microsemi-riscv-igloo2.ld" -nostartfiles -Xlinker --gc-sections -Wl,-Map,"Creative_MiV_FreeRTOS_Demo.map" --specs=nano.specs -o "Creative_MiV_FreeRTOS_Demo.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

Creative_MiV_FreeRTOS_Demo.hex: Creative_MiV_FreeRTOS_Demo.elf
	@echo 'Invoking: GNU RISC-V Cross Create Flash Image'
	riscv64-unknown-elf-objcopy -O ihex "Creative_MiV_FreeRTOS_Demo.elf"  "Creative_MiV_FreeRTOS_Demo.hex"
	@echo 'Finished building: $@'
	@echo ' '

Creative_MiV_FreeRTOS_Demo.lst: Creative_MiV_FreeRTOS_Demo.elf
	@echo 'Invoking: GNU RISC-V Cross Create Listing'
	riscv64-unknown-elf-objdump --source --all-headers --demangle --line-numbers --wide "Creative_MiV_FreeRTOS_Demo.elf" > "Creative_MiV_FreeRTOS_Demo.lst"
	@echo 'Finished building: $@'
	@echo ' '

Creative_MiV_FreeRTOS_Demo.siz: Creative_MiV_FreeRTOS_Demo.elf
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	riscv64-unknown-elf-size --format=berkeley "Creative_MiV_FreeRTOS_Demo.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(SECONDARY_FLASH)$(SECONDARY_LIST)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS) Creative_MiV_FreeRTOS_Demo.elf
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_LIST) $(SECONDARY_SIZE)

.PHONY: all clean dependents

-include ../makefile.targets
