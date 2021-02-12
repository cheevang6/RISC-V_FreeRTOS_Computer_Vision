/*******************************************************************************
 * Project     : Creative_MiV_FreeRTOS_Demo
 * File        : main.c
 *
 * Description : The Creative FreeRTOS demo features a port of FreeRTOS 8.2.3
 * 							 on the Mi-V softcore. The program is very simple.
 *
 * 							 Upon power-up of the board, introduction messages will be sent
 * 							 to the Terminal. Then three tasks will be created and the
 * 							 scheduler will be started. LED1 red, LED2 green and LED2 red
 * 							 will start blinking at different rates. The blinking will be
 * 							 influence also by the task scheduler.
 *
 * 							 There is some commented code related to the pushbuttons and
 * 							 the timer implemented in the FPGA. This is provided to help
 * 							 you exploring the different FreeRTOS possibilities.
 *
 * 							 Terminal setup: Serial Terminal, 115200/8/1, no parity,
 * 							 no flow control.
 *
 * Created on  : Apr 23, 2019
 * Author      : Frederic.Vachon  
 *
 * (c) Copyright 2019 Future Electronics - Advanced Engineering Group
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
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"

#include "hw_platform.h"
#include "BasicIO.h"
#include "core_timer.h"
#include "core_gpio.h"
#include <stdio.h>

// -- Definitions ------------------------------------------------------------

/* A block time of zero simply means "don't block". */
#define mainDONT_BLOCK						( 0UL )

// -- Timer instance data ----------------------------------------------------
timer_instance_t g_timer_0;

// -- Global variables -------------------------------------------------------

// -- Function Declarations --------------------------------------------------
static void blinkingLED(void *pvParameters);

// FreeRTOS hook for when malloc fails, enable in FreeRTOSConfig.
void vApplicationMallocFailedHook( void );

// FreeRTOS hook for when FreeRtos is idling, enable in FreeRTOSConfig.
void vApplicationIdleHook( void );

// FreeRTOS hook for when a stack overflow occurs, enable in FreeRTOSConfig.
void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName );


/*----------------------------------------------------------------------------
 * User Pushbutton #1 Interrupt Handler
 */
void External_31_IRQHandler() {
/*
	GPIO_clear_irq(&g_gpio_in_pbs, PB1);
	PLIC_CompleteIRQ(PLIC_ClaimIRQ());
*/
}

/*----------------------------------------------------------------------------
 * User Pushbutton #2 Interrupt Handler
 */
void External_30_IRQHandler() {
/*
	GPIO_clear_irq(&g_gpio_in_pbs, PB2);
	PLIC_CompleteIRQ(PLIC_ClaimIRQ());
*/
}

/*----------------------------------------------------------------------------
 * User Timer Interrupt Handler
 */
void External_29_IRQHandler() {
/*
	PLIC_CompleteIRQ(PLIC_ClaimIRQ());
*/
}

/*-----------------------------------------------------------
 * CoreGPIO declarations
 */
#define GPIO_BASE_ADDR	0x70002000UL
#define gpio &g_gpio
static gpio_instance_t g_gpio;

int main(void) {

	PLIC_init();

	// -- Hardware setup -------------------------------------------------------

	BasicIO_Init(BASIC_IO_INTR_ADDR);
	GPIO_init(gpio, GPIO_BASE_ADDR, GPIO_APB_32_BITS_BUS);

	// -- Main program ---------------------------------------------------------

	UART_Tx_Msg("\rHello World! Flip the switch to run on/off LED.\n\r",1);

	/* Create the test tasks. */
	xTaskCreate(blinkingLED, "blink", 1000, NULL, 1, NULL);

	/* Start the kernel.  From here on, only tasks and interrupts will run. */
	vTaskStartScheduler();

	/* Exit FreeRTOS */
	return 0;
}

/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook(void) {

	/* vApplicationMallocFailedHook() will only be called if
	configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
	function that will get called if a call to pvPortMalloc() fails.
	pvPortMalloc() is called internally by the kernel whenever a task, queue,
	timer or semaphore is created.  It is also called by various parts of the
	demo application.  If heap_1.c or heap_2.c are used, then the size of the
	heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
	FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
	to query the size of free heap space that remains (although it does not
	provide information on how the remaining heap might be fragmented). */
	taskDISABLE_INTERRUPTS();
	for(;;);
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook(void) {

	/* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
	to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
	task.  It is essential that code added to this hook function never attempts
	to block in any way (for example, call xQueueReceive() with a block time
	specified, or call vTaskDelay()).  If the application makes use of the
	vTaskDelete() API function (as this demo application does) then it is also
	important that vApplicationIdleHook() is permitted to return to its calling
	function, because it is the responsibility of the idle task to clean up
	memory allocated by the kernel to any task that has since been deleted. */
}

/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName) {

	(void) pcTaskName;
	(void) pxTask;

	/* Run time stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
	function is called if a stack overflow is detected. */
	taskDISABLE_INTERRUPTS();
	for(;;);
}


/*-----------------------------------------------------------*/

static void blinkingLED(void *pvParameters) {
	(void) pvParameters;
	uint32_t value;
	char message[50];
	for(;;) {
		value = GPIO_get_inputs(gpio);
		sprintf(message,"switch = %d\n\r",value);
		UART_Tx_Msg(message,1);
		if(value == 1) {
			GPIO_set_output(gpio,GPIO_1,1);
			vTaskDelay(13);
			GPIO_set_output(gpio,GPIO_1,0);
			vTaskDelay(13);
		} else {
			GPIO_set_output(gpio,GPIO_1,0);
			vTaskDelay(13);
		}
	}
}
/*static void vLEDTestTask1(void *pvParameters) {

	(void) pvParameters;

	for(;;)	{
		setLED2_GREEN();
	  vTaskDelay(13);
	  clearLED2_GREEN();
	  vTaskDelay(13);
	}
}

static void vLEDTestTask2(void *pvParameters) {

	(void) pvParameters;

	for(;;)	{
		setLED1_RED();
	  vTaskDelay(4);
	  clearLED1_RED();
	  vTaskDelay(4);
	}
}


static void vLEDTestTask3(void *pvParameters) {

	(void) pvParameters;

	for(;;)	{
		setLED1_GREEN();
	  vTaskDelay(10);
	  clearLED1_GREEN();
	  vTaskDelay(10);
	}
}*/