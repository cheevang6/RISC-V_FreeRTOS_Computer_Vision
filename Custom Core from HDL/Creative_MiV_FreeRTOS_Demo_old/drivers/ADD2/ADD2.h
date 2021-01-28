/*
 * ADD2.h
 *
 *  Created on: Jan 20, 2021
 *      Author: cheec
 */

#ifndef DRIVERS_ADD2_ADD2_H_
#define DRIVERS_ADD2_ADD2_H_

#include <stdint.h>
#include "cpu_types.h"

#define ADD2_BASE_ADDR		0x70002000UL

typedef struct add2_instance add2_instance_t;

struct add2_instance
{
    addr_t base_addr;
};

void ADD2_init
(
	add2_instance_t * this_add2,
	addr_t base_addr
);
void set_A
(
	add2_instance_t * this_add2,
	uint8_t aValue
);
void set_B
(
	add2_instance_t * this_add2,
	uint8_t bValue
);
uint8_t get_ABX
(
	add2_instance_t * this_add2,
	uint8_t value
);

#endif /* DRIVERS_ADD2_ADD2_H_ */
