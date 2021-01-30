/*******************************************************************************
 * Project     : ...
 * File        : BasicIO.h
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

#ifndef BASIC_IO_H_
#define BASIC_IO_H_

#include "cpu_types.h"

#ifndef NULL
#define NULL  (void*) 0
#endif

// -- Definitions ------------------------------------------------------------

// --- Public Functions --------------------------------------------------------

/*-------------------------------------------------------------------------*//**
  The BasicIO_Init() initialized the different hardware drivers related to the 
  basic Avalanche board I/O: LEDs and a UART used for Terminal communication.

  @param interface_addr
    The base address of the interface based on the FPGA memory map. This value
    is usually a 32 bits HEX value (ie 0x6000 2000) with the 12 bits LSB 
    being reserved for the interface.

  @return
    none.

  */
void BasicIO_Init(addr_t interface_addr);

/*-------------------------------------------------------------------------*//**
  The getPBstatuses() function is used to poll the pushbuttons status.

  @param 
    none.

  @return uint32_t
    The value read from the internal GPIO module. 
      Pushbutton 1 (SW1): bit 0  
      Pushbutton 2 (SW2): bit 1  

  */
uint32_t getPBstatuses();

/*-------------------------------------------------------------------------*//**
  The clearPB1_IRQ() function is used to clear the generated pushbutton IRQ  
  from the internal GPIO module.

  @param 
    none.

  @return 
    none.  

  */
void clearPB1_IRQ();

/*-------------------------------------------------------------------------*//**
  The clearPB2_IRQ() function is used to clear the generated pushbutton IRQ  
  from the internal GPIO module.

  @param 
    none.

  @return 
    none.  

  */
void clearPB2_IRQ();

/*-------------------------------------------------------------------------*//**
  The getLEDsPattern() function is used to poll the LEDs status.

  @param 
    none.

  @return uint32_t
    The value read from the internal GPIO module. 
      LED 1 Green (LED4): bit 2  
      LED 1 Red   (LED4): bit 3
      LED 2 Green (LED5): bit 4
      LED 2 Red   (LED5): bit 5  

  */
uint32_t getLEDsPattern();

/*-------------------------------------------------------------------------*//**
  The setLED1_GREEN() function is used to turn on LED1 green color.

  @param 
    none.

  @return 
    none.  

  */
void setLED1_GREEN();

/*-------------------------------------------------------------------------*//**
  The clearLED1_GREEN() function is used to turn off LED1 green color.

  @param 
    none.

  @return 
    none.  

  */
void clearLED1_GREEN();

/*-------------------------------------------------------------------------*//**
  The setLED1_RED() function is used to turn on LED1 red color.

  @param 
    none.

  @return 
    none.  

  */
void setLED1_RED();

/*-------------------------------------------------------------------------*//**
  The clearLED1_RED() function is used to turn off LED1 red color.

  @param 
    none.

  @return 
    none.  

  */
void clearLED1_RED();

/*-------------------------------------------------------------------------*//**
  The setLED2_GREEN() function is used to turn on LED2 green color.

  @param 
    none.

  @return 
    none.  

  */
void setLED2_GREEN();

/*-------------------------------------------------------------------------*//**
  The clearLED2_GREEN() function is used to turn off LED2 green color.

  @param 
    none.

  @return 
    none.  

  */
void clearLED2_GREEN();

/*-------------------------------------------------------------------------*//**
  The setLED2_RED() function is used to turn on LED2 red color.

  @param 
    none.

  @return 
    none.  

  */
void setLED2_RED();

/*-------------------------------------------------------------------------*//**
  The clearLED2_RED() function is used to turn off LED2 red color.

  @param 
    none.

  @return 
    none.  

  */
void clearLED2_RED();

/*-------------------------------------------------------------------------*//**
  The UART_Rx_Msg() function is used to read data received on the UART.

  @param msg
    A pointer to a buffer where the received data will be copied.

  @return size_t 
    The number of bytes copied into the receive buffer.  

  */
size_t UART_Rx_Msg(char* msg);

/*-------------------------------------------------------------------------*//**
  The UART_Tx_Msg() function is used to send data to the UART for 
  transmission.

  @param type
    The type of data that need to be transmitted: 
      1: a NULL ('\0') terminated string
      2: a generic data content
    
  @param msg
    A pointer to a buffer containing the data to be transmitted.

  @return  
    none.  

  */
void UART_Tx_Msg(char* msg, uint8_t type);


#endif /* BASIC_IO_H_ */
