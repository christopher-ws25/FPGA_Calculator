/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_types.h" //Added for integer type definitions
#include <math.h> // Added for math functions
#include "arith_operations.h"	// Added for 'pi' definition
// Explicit declarations of used functions

s32 adder (s32 num1, s32 num2);
s32 subtractor (s32 minuend, s32 subtrahend);
s32 multiplicator (s32 multiplicand, s32 multiplier);
s32 divider (s32 dividend, s32 divisor);
u32 modulator (u32 dividend, u32 divisor);
// create float variable to save value for decimals
float rad;
float degree;
void xil_print(const char*ctrl1,...);


s32 adder(s32 augend,s32 addend)
{
	s32 sum;
	sum = augend + addend;
	return sum;
}

s32 subtractor(s32 minuend, s32 subtrahend)
{
	s32 difference;
	difference = minuend - subtrahend;
	return difference;
}

s32  multiplicator(s32 multiplicand, s32 multiplier)
{
	s32 product;
	product = multiplicand * multiplier;
	return product;
}

s32 divider (s32 dividend, s32 divisor)
{
	s32 quotient;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	quotient = 10*dividend/ divisor;
	return quotient;
}

u32 modulator (u32 dividend, u32 divisor )
{
	u32 modulus;
	modulus = dividend % divisor;
	return modulus;
}
u32 square_root (u32 value)
{
	u32 square_root;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	square_root = sqrt(value)*10;
	return square_root;
}
u32 power (s32 value1, s32 value2)
{
	u32 power;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	power = pow(value1, value2)*10;
	return power;
}
u32 exponential (s32 value)
{
	u32 exponential;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	exponential = exp(value)*10;
	return exponential;
}
s32 sine (s32 degree1)
{
	s32 result;
	rad = degree1*pi;
	rad = rad/180;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	result = 10*sin(rad);
	return result;
}
s32 cosine (s32 degree2)
{
	s32 result;
	rad = degree2*pi;
	rad = rad/180;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	result = 10*cos(rad);
	return result;
}
s32 tangent (s32 degree3)
{
	s32 result;
	rad = degree3*pi;
	rad = rad/180;
	// result is multiplied by 10 before assigning to integer variable
	// to save the value of the first decimal place
	result = 10*tan(rad);
	return result;
}
