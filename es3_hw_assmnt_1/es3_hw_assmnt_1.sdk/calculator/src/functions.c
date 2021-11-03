#include <stdio.h>
#include "platform.h"
#include "xil_types.h" //Added for integer type definitions
#include <math.h>
#include "seg7_display.h"	// Added for 7-segment definitions
#include "gpio_init.h"		// Added for Gpio declarations
#include "arith_operations.h"      // Added for arithmetic function declarations

// signed variable declarations for returning negative values
s32 scounter1,scounter2;

//takes in first input from first 6 switches
s32 take_input1 ( u16 counter1, u16 slideSwitchIn, u16 negative)
{
	XGpio_DiscreteWrite(&LED_OUT, 1,  slideSwitchIn);

	// isolates first 6 switches
	counter1 =  slideSwitchIn << 10;
	counter1 =  counter1 >> 10;

	//checks if negative button is pressed
	if (negative == 0)
	{
		return counter1;
	}
	else if (negative == 1)
	{
		scounter1 = counter1;
		return -scounter1;
	}
	return 0;
}

//takes in input 2 from next 6 switches
s32 take_input2 ( u16 counter2, u16 slideSwitchIn, u16 negative)
{
	 XGpio_DiscreteWrite(&LED_OUT, 1,  slideSwitchIn);

	 //isolates next 6 switches
	 counter2 =  slideSwitchIn << 4;
	 counter2 =  counter2 >> 10;

	 //checks if negative button is presed.
	if (negative == 0)
	{
		return counter2;
	}
	else if (negative == 1)
	{
		scounter2 = counter2;
		return -scounter2;
	}
	return 0;
}


