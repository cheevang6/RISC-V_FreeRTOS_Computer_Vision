/*******************************************************************************
 * Project     : Creative_MiV_FreeRTOS_Demo
 * File        : main.c
 *
 * Description : The Creative FreeRTOS demo features a port of FreeRTOS 8.2.3
 * 				 on the Mi-V softcore. The program is very simple.
 *
 * 				 Upon power-up of the board, introduction messages will be sent
 * 				 to the Terminal. Then three tasks will be created and the
 * 				 scheduler will be started. LED1 red, LED2 green and LED2 red
 * 				 will start blinking at different rates. The blinking will be
 * 				 influence also by the task scheduler.
 *
 * 				 There is some commented code related to the pushbuttons and
 * 				 the timer implemented in the FPGA. This is provided to help
 * 				 you exploring the different FreeRTOS possibilities.
 *
 * 				 Terminal setup: Serial Terminal, 115200/8/1, no parity,
 * 				 no flow control.
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
#include "ADD2.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"

#include "hw_platform.h"
#include "BasicIO.h"
#include "core_timer.h"
#include <stdio.h>


// -- Definitions ------------------------------------------------------------

/* A block time of zero simply means "don't block". */
#define mainDONT_BLOCK						( 0UL )

// -- Constants --------------------------------------------------------------
char *g_MSG_INTRO =
		"\n\r(C) Copyright 2019 Future Electronics - Creative Board\n\r";

char *g_MSG_DEMO =
		"\n\rFreeRTOS Simple Demo"
		"\n\r  This demo creates 3 blinking LED tasks and activate the FreeRTOS"
		"\n\r  scheduler. LED1 Red, LED2 Green and Red should start blinking.\n\r";

char *Checking = "Checking...";

// -- Timer instance data ----------------------------------------------------
timer_instance_t g_timer_0;

// -- Global variables -------------------------------------------------------

// -- Function Declarations --------------------------------------------------
static void vLEDTestTask1(void *pvParameters);
//static void vLEDTestTask2(void *pvParameters);
//static void vLEDTestTask3(void *pvParameters);

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

/*-----------------------------------------------------------*/
#define ADD2_BASE_ADDR 0x70002000UL
#define ADD2 &add2_inst
static add2_instance_t add2_inst;

int main(void) {

	PLIC_init();

	// -- Hardware setup -------------------------------------------------------

	BasicIO_Init(BASIC_IO_INTR_ADDR);
	ADD2_init(ADD2, ADD2_BASE_ADDR);

	// -- Main program ---------------------------------------------------------

	UART_Tx_Msg(Checking, 1);
	//UART_Tx_Msg(g_MSG_INTRO, 1);
	//UART_Tx_Msg(g_MSG_DEMO, 1);

	/* Create the three test tasks. */
	xTaskCreate(vLEDTestTask1, "LED1", 1000, NULL, 1, NULL);
	//xTaskCreate(vLEDTestTask2, "LED2", 1000, NULL, 3, NULL);
	//xTaskCreate(vLEDTestTask3, "LED3", 1000, NULL, 2, NULL);

	uint8_t outA = 0;
	uint8_t outB = 0;
	uint8_t outX = 0;
	uint8_t a = 2;
	uint8_t b = 5;

	set_A(ADD2,a);
	set_B(ADD2,b);

	outA = get_ABX(ADD2,0);
	outB = get_ABX(ADD2,1);
	outX = get_ABX(ADD2,2);

	char message[50];

	sprintf(message,"%d %d %d",outA,outB,outX);
	UART_Tx_Msg(message, 1);

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

static void vLEDTestTask1(void *pvParameters) {

	(void) pvParameters;

	for(;;)	{
	  setLED2_GREEN();
	  vTaskDelay(13);
	  clearLED2_GREEN();
	  vTaskDelay(13);
	}

}
/*
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
}
*/
