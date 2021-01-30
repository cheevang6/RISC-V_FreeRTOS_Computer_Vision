/*
 * ADD2.c
 *
 *  Created on: Jan 20, 2021
 *      Author: cheec
 */
#include "ADD2.h"
#include "ADD2_regs.h"
#include "../../hal/hal.h"
#include "../../hal/hal_assert.h"

void ADD2_init
(
	add2_instance_t * this_add2,
	addr_t base_addr
)
{
	this_add2->base_addr = base_addr;

	// clear all
	HAL_set_8bit_reg(this_add2->base_addr, A, 0x00);
	HAL_set_8bit_reg(this_add2->base_addr, B, 0x00);

}

void set_A
(
	add2_instance_t * this_add2,
	uint8_t aValue
)
{
	HAL_set_8bit_reg(this_add2->base_addr, A, aValue);
	HAL_ASSERT( set_AB( this_add2 ) == aValue );

}

void set_B
(
	add2_instance_t * this_add2,
	uint8_t bValue
)
{
	HAL_set_8bit_reg(this_add2->base_addr, B, bValue);
	HAL_ASSERT( set_AB( this_add2 ) == bValue );

}

uint8_t get_ABX
(
	add2_instance_t * this_add2,
	uint8_t value
)
{
	uint8_t output = 0;
	if(value == 0)
		output = HAL_get_8bit_reg(this_add2->base_addr, A);
	else if(value == 1)
		output = HAL_get_8bit_reg(this_add2->base_addr, B);
	else if(value == 2)
		output = HAL_get_8bit_reg(this_add2->base_addr, X);
	else
		HAL_ASSERT(0);

	return output;
}
