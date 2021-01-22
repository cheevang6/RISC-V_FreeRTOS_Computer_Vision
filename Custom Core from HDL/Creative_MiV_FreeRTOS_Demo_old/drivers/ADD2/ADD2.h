/*
 * AND2_GATE.h
 *
 *  Created on: Jan 20, 2021
 *      Author: cheec
 */

#ifndef DRIVERS_ADD2_ADD2_H_
#define DRIVERS_ADD2_ADD2_H_

#include <stdint.h>
#include "cpu_types.h"

#define AND2_GATE_BASE_ADDR		0x70002000UL

typedef struct and2_gate_instance and2_gate_instance_t;

struct and2_gate_instance
{
    addr_t              base_addr;
};

void AND2_GATE_init
(
    and2_gate_instance_t *   this_and2_gate,
	addr_t base_addr
);
void set_A
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t aValue
);
void set_B
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t bValue
);
uint8_t get_ABX
(
	and2_gate_instance_t *   this_and2_gate,
	uint8_t value
);

#endif /* DRIVERS_ADD2_ADD2_H_ */
