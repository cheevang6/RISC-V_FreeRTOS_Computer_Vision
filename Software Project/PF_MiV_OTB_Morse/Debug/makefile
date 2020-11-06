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
-include drivers/CoreI2C/subdir.mk
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
PF_MiV_OTB_Morse.hex \

SECONDARY_LIST += \
PF_MiV_OTB_Morse.lst \

SECONDARY_SIZE += \
PF_MiV_OTB_Morse.siz \


# All Target
all: PF_MiV_OTB_Morse.elf secondary-outputs

# Tool invocations
PF_MiV_OTB_Morse.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -T "C:\Users\cheec\Desktop\Master\Software Project\PF_MiV_OTB_Morse\riscv_hal\microsemi-riscv-igloo2.ld" -nostartfiles -Xlinker --gc-sections -Wl,-Map,"PF_MiV_OTB_Morse.map" --specs=nano.specs -o "PF_MiV_OTB_Morse.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

PF_MiV_OTB_Morse.hex: PF_MiV_OTB_Morse.elf
	@echo 'Invoking: GNU RISC-V Cross Create Flash Image'
	riscv64-unknown-elf-objcopy -O ihex "PF_MiV_OTB_Morse.elf"  "PF_MiV_OTB_Morse.hex"
	@echo 'Finished building: $@'
	@echo ' '

PF_MiV_OTB_Morse.lst: PF_MiV_OTB_Morse.elf
	@echo 'Invoking: GNU RISC-V Cross Create Listing'
	riscv64-unknown-elf-objdump --source --all-headers --demangle --line-numbers --wide "PF_MiV_OTB_Morse.elf" > "PF_MiV_OTB_Morse.lst"
	@echo 'Finished building: $@'
	@echo ' '

PF_MiV_OTB_Morse.siz: PF_MiV_OTB_Morse.elf
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	riscv64-unknown-elf-size --format=berkeley "PF_MiV_OTB_Morse.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(SECONDARY_FLASH)$(SECONDARY_LIST)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS) PF_MiV_OTB_Morse.elf
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_LIST) $(SECONDARY_SIZE)

.PHONY: all clean dependents

-include ../makefile.targets
