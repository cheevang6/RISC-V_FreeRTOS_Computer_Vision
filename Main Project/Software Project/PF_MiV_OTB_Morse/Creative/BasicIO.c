/*******************************************************************************
 * Project     : ...
 * File        : BasicIO.c
 *
 * Description : This file contains a definition for a basic I/O module
 *               interface for the Creative and Avalanche dev boards. 
 *
 *               The module takes care of the two (2) user pushbuttons by
 *               including a debouncer unit and generate interrupts if required
 *               by the design. Both pushbuttons can be polled for their status.
 *
 *               The module also provides basic LED control (On/Off) and a 
 *               polling function to get the current LED pattern.
 *
 * Created on  : June 14, 2018
 * Updated on  : April 24, 2019
 * Author      : Frederic.Vachon  
 *
 * (c) Copyright 2018 Future Electronics - Advanced Engineering Group 
 *     All rights reserved
 *
 * DISCLAIMER OF WARRANTY
 * All materials, information and services are provided “as-is” and “as-available”
 * for your use. Future Electronics disclaims all warranties of any kind, either
 * express or implied, including but not limited to, the implied warranties of
 * merchantability and fitness for a particular purpose, title, or non-infringement.
 * You acknowledge and agree that the reference designs and other such design
 * materials included herein are provided as an example only and that you will
 * exercise your own independent analysis and judgment in your use of these
 * materials. Future Electronics assumes no liability for your use of these
 * materials for your product designs.
 *
 * INDEMNIFICATION
 * You agree to indemnify, defend and hold Future Electronics and all of its
 * agents, directors, employees, information providers, licensors and licensees,
 * and affiliated companies (collectively, “Indemnified Parties”), harmless from
 * and against any and all liability and costs (including, without limitation,
 * attorneys’ fees and costs), incurred by the Indemnified Parties in connection
 * with any claim arising out of any breach by You of these Terms and Conditions 
 * of Use or any representations or warranties made by You herein. You will
 * cooperate as fully as reasonably required in Future Electronics’ defense of
 * any claim. Future Electronics reserves the right, at its own expense, to
 * assume the exclusive defense and control of any matter otherwise subject to
 * indemnification by You and You shall not in any event settle any matter
 * without the written consent of Future Electronics.
 *
 * LIMITATION OF LIABILITY
 * Under no circumstances shall Future Electronics, nor its agents, directors,
 * employees, information providers, licensors and licensee, and affiliated
 * companies be liable for any damages, including without limitation, direct,
 * indirect, incidental, special, punitive, consequential, or other damages
 * (including without limitation lost profits, lost revenues, or similar economic
 * loss), whether in contract, tort, or otherwise, arising out of the use or
 * inability to use the materials provided as a reference design, even if we
 * are advised of the possibility thereof, nor for any claim by a third party.
 ******************************************************************************/

#include "BasicIO.h"
#include "hw_platform.h"
#include "core_gpio.h"
#include "core_uart_apb.h"

// -- Dev Board Config ---------------------------------------------------------
#define CREATIVE              1
#define AVALANCHE             0

// -- Definitions --------------------------------------------------------------
#define BASIC_IO_UART_ADDR		0x00000000UL
#define BASIC_IO_GPIO_ADDR 		0x00000100UL

#define PB1							      GPIO_0
#define PB2							      GPIO_1

#define LED1_GREEN			      GPIO_2
#define LED1_RED				      GPIO_3
#define LED2_GREEN			      GPIO_4
#define LED2_RED				      GPIO_5

#if CREATIVE
#define LED_ON				 	      1
#define LED_OFF					      0
#endif

#if AVALANCHE
#define LED_ON				 	      0
#define LED_OFF					      1
#endif

#define BASIC_GPIO_LEDS       &g_gpio_out_LEDs
#define BASIC_GPIO_PBS        &g_gpio_in_PBs
#define BASIC_UART            &g_uart_term

static gpio_instance_t g_gpio_in_PBs;
static gpio_instance_t g_gpio_out_LEDs;
static UART_instance_t g_uart_term;

// --- Private functions -------------------------------------------------------

// --- Public Functions --------------------------------------------------------

void BasicIO_Init(addr_t interface_addr) {

 	GPIO_init(BASIC_GPIO_PBS,
 						interface_addr | BASIC_IO_GPIO_ADDR,
						GPIO_APB_32_BITS_BUS);
 	GPIO_init(BASIC_GPIO_LEDS,
 						interface_addr | BASIC_IO_GPIO_ADDR,
						GPIO_APB_32_BITS_BUS);
  
  GPIO_enable_irq(BASIC_GPIO_PBS, PB1);
  GPIO_enable_irq(BASIC_GPIO_PBS, PB2);  

  GPIO_set_output(BASIC_GPIO_LEDS, LED1_GREEN, LED_OFF);
  GPIO_set_output(BASIC_GPIO_LEDS, LED1_RED, LED_OFF);
  GPIO_set_output(BASIC_GPIO_LEDS, LED2_GREEN, LED_OFF);
  GPIO_set_output(BASIC_GPIO_LEDS, LED2_RED, LED_OFF);
    
  UART_init(BASIC_UART,
  					interface_addr | BASIC_IO_UART_ADDR,
						BAUD_VALUE_115200,
            (DATA_8_BITS | NO_PARITY));
   
}

// --- Pushbuttons Functions ---------------------------------------------------

uint32_t getPBstatuses() {
	return GPIO_get_inputs(BASIC_GPIO_PBS);
}

void clearPB1_IRQ() {
	GPIO_clear_irq(BASIC_GPIO_PBS, PB1);
}

void clearPB2_IRQ() {
	GPIO_clear_irq(BASIC_GPIO_PBS, PB2);
}

// --- LEDs Functions ----------------------------------------------------------

uint32_t getLEDsPattern() {
	return(GPIO_get_outputs(BASIC_GPIO_LEDS));
}

void setLED1_GREEN() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED1_GREEN, LED_ON);
}

void clearLED1_GREEN() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED1_GREEN, LED_OFF);
}

void setLED1_RED() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED1_RED, LED_ON);
}

void clearLED1_RED() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED1_RED, LED_OFF);
}

void setLED2_GREEN() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED2_GREEN, LED_ON);
}

void clearLED2_GREEN() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED2_GREEN, LED_OFF);
}

void setLED2_RED() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED2_RED, LED_ON);
}

void clearLED2_RED() {
	GPIO_set_output(BASIC_GPIO_LEDS, LED2_RED, LED_OFF);
}

// --- Terminal Functions ------------------------------------------------------

void UART_Tx_Msg(char* msg, uint8_t type) {
	if (type == 1) {
		UART_polled_tx_string(BASIC_UART, (const uint8_t *) msg);
	} else {
		UART_send(BASIC_UART, (const uint8_t *) msg, sizeof(*msg));
	}
}

size_t UART_Rx_Msg(char* msg) {
	return(UART_get_rx(BASIC_UART, msg, sizeof(*msg)));
}





