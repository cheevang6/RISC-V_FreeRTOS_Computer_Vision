/*
 * AND2_GATE.c
 *
 *  Created on: Jan 20, 2021
 *      Author: cheec
 */
#include "ADD2.h"
#include "ADD2_regs.h"
#include "../../hal/hal.h"
#include "../../hal/hal_assert.h"

void AND2_GATE_init
(
    and2_gate_instance_t *   this_and2_gate,
	addr_t base_addr
)
{
	this_and2_gate->base_addr = base_addr;

	// clear all
	HAL_set_8bit_reg(this_and2_gate->base_addr, A, 0x00);
	HAL_set_8bit_reg(this_and2_gate->base_addr, B, 0x00);

}

void set_A
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t aValue
)
{
	HAL_set_8bit_reg(this_and2_gate->base_addr, A, aValue);
	HAL_ASSERT( set_AB( this_and2_gate ) == aValue );

}

void set_B
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t bValue
)
{
	HAL_set_8bit_reg(this_and2_gate->base_addr, B, bValue);
	HAL_ASSERT( set_AB( this_and2_gate ) == bValue );

}

uint8_t get_ABX
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t value
)
{
	uint8_t output_x = 0;
	if(value == 0)
		output_x = HAL_get_8bit_reg(this_and2_gate->base_addr, A);
	else if(value == 1)
		output_x = HAL_get_8bit_reg(this_and2_gate->base_addr, B);
	else if(value == 2)
		output_x = HAL_get_8bit_reg(this_and2_gate->base_addr, X);
	else
		HAL_ASSERT(0);

	return output_x;
}
