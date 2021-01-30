/*
 * core_sccb.h
 *
 *  Created on: Jan 27, 2021
 *      Author: cheec
 */

#ifndef DRIVERS_CORESCCB_CORE_SCCB_H_
#define DRIVERS_CORESCCB_CORE_SCCB_H_

#include <stdint.h>
#include "cpu_types.h"

typedef struct sccb_instance sccb_instance_t;

struct sccb_instance {
	addr_t base_addr;
};

void set_ip_addr (
	sccb_instance_t * this_sccb,
	addr_t base_addr
);

void set_sub_addr (
	sccb_instance_t * this_sccb,
	uint8_t
);

void set_reg (
	sccb_instance_t * this_sccb,
);

#endif /* DRIVERS_CORESCCB_CORE_SCCB_H_ */
