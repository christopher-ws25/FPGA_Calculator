#include <stdio.h>
#include "platform.h"
#include "xil_types.h"			// Added for integer type definitions
#include "seg7_display.h"		// Added for 7-segment definitions
#include "gpio_init.h"			// Added for Gpio declarations
#include "functions.h"      	// Added for function declarations
#include "arith_operations.h"   // Added for arithmetic function declarations

int main()
{
	init_platform();
	// variable declarations
	u16 input_numbers = 0, slideSwitchIn = 0,  arith_op_type = 0, is_decimal = 0, read_op_type = 0, disp_op = 0, show_results = 0;
    s32 input1 = 0, input2 = 0;
	u16  pushBtnLeftIn = 0, counter1 =0, counter2 =0, pushBtnRightIn = 0,right_pressed =0, left_pressed =0,negative=0,hexadecimal=0;
	u16 pushBtnDownIn= 0,down_pressed =0,pushBtnUpIn = 0, up_pressed = 0;
	int status;

    // Initialize the GPIOs
    status = initGpio();
	if (status != XST_SUCCESS) {
		print("GPIOs initialization failed!\n\r");
		cleanup_platform();
		return 0;
	}
	// Setup the Interrupt System
	status = setUpInterruptSystem();
	if (status != XST_SUCCESS) {
		print("Interrupt system setup failed!\n\r");
		cleanup_platform();
		return 0;
	}
		while (1)
		{
			// gpio read functions are only called here on top
			// the values from all the switches and the 4 buttons are always being read
			slideSwitchIn =  XGpio_DiscreteRead(&SLIDE_SWITCHES, 1);
			pushBtnLeftIn =  XGpio_DiscreteRead(&P_BTN_LEFT, 1);
			pushBtnRightIn = XGpio_DiscreteRead(&P_BTN_RIGHT, 1);
			pushBtnDownIn =  XGpio_DiscreteRead(&P_BTN_DOWN, 1);
			pushBtnUpIn =    XGpio_DiscreteRead(&P_BTN_UP, 1);

			// if down button is pressed, hexadecimal = 1, displaying hexadecimal value
			// if down button is pressed again, hexadecimal = 0, displaying integer
			// this will repeat again
	    	if(pushBtnDownIn == 1 )
		    	{
	    		down_pressed = 1;
		    	}
		    	else if (pushBtnDownIn == 0 && down_pressed == 1)
		    	{
		    		down_pressed = 0;
					if (hexadecimal == 0)
					{
						hexadecimal = 1;
					}
					else if (hexadecimal == 1)
					{
						hexadecimal = 0;
					}
					xil_printf("test\n");
		    	}
			// if right button is pressed, negative = 1, input will change to negative
			// if right button is pressed again, negative = 0, input will change to positive
			// this will repeat again
	    	if(pushBtnRightIn == 1 )
		    	{
	    		right_pressed = 1;
		    	}
		    	else if (pushBtnRightIn == 0 && right_pressed == 1)
		    	{
		    		right_pressed = 0;
					if (negative == 0)
					{
						negative = 1;
					}
					else if (negative == 1)
					{
						negative = 0;
					}
		    	}
	    	// taking in the first input (first 6 switches)
			if (input_numbers == 0)
			{
				input1 =  take_input1 (counter1,slideSwitchIn,negative);
				displayNumber(input1, is_decimal,hexadecimal);
				//if left button pressed, going to the next stage to read arithmetic operation type
		    	if(pushBtnLeftIn == 1 )
			    	{
			    		left_pressed = 1;
			    	}
			    	else if (pushBtnLeftIn == 0 && left_pressed == 1)
			    	{
			    		input_numbers = 1;
			    		read_op_type = 1;
						left_pressed = 0;
			    	}
			}
			// reading arithmetic operation type (last 4 switches)
			if (read_op_type == 1)
			{
				XGpio_DiscreteWrite(&LED_OUT, 1,  slideSwitchIn);
				disp_op = slideSwitchIn >> 12;
				is_decimal = 0;
				displayNumber(disp_op, is_decimal,hexadecimal);
				// if left button pressed, value read here will be assigned to arith_op_tyoe
		    	if(pushBtnLeftIn == 1 )
			    	{
			    		left_pressed = 1;
			    	}
			    	else if (pushBtnLeftIn == 0 && left_pressed == 1)
			    	{
			    		arith_op_type = disp_op;
			    		read_op_type = 0;
						left_pressed = 0;
			    	}
			}
			// shows result of the arithmetic operation
			if (show_results == 1)
			{
				displayNumber(input1, is_decimal,hexadecimal);
				// if left button pressed when result is non decimal
				// calculator will read arithmetic operation again to continue
				//else go back to stage 1, taking input 1 again
				if (is_decimal == 0)
				{
			    	if(pushBtnLeftIn == 1 )
				    	{
				    		left_pressed = 1;
				    	}
				    	else if (pushBtnLeftIn == 0 && left_pressed == 1)
				    	{
				    		show_results = 0;
				    		read_op_type = 1;
							left_pressed = 0;
				    	}
				}
				else
				{
			    	if(pushBtnLeftIn == 1 )
				    	{
				    		left_pressed = 1;
				    	}
				    	else if (pushBtnLeftIn == 0 && left_pressed == 1)
				    	{
				    		show_results = 0;
				    		input_numbers = 0;
							left_pressed = 0;
							is_decimal = 0;
				    	}
				}

			}

			//assigns the arithmetic operation type to the cases
			//all cases takes in input 2
			//when up button is pressed, result is shown
		    switch (arith_op_type)
		    {
		    // addition
		    case 1:
		    	 input2 =  take_input2 ( counter2, slideSwitchIn,negative);
		    	 displayNumber(input2, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = adder( input1, input2);
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // subtraction
		    case 2:
		    	 input2 =  take_input2 ( counter2, slideSwitchIn,negative);
		    	 displayNumber(input2, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = subtractor( input1, input2);
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // multiplication
		    case 3:
		    	 input2 =  take_input2 ( counter2, slideSwitchIn,negative);
		    	 displayNumber(input2, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = multiplicator( input1, input2);
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // division
		    case 4:
		    	 input2 =  take_input2 ( counter2, slideSwitchIn,negative);
		    	 displayNumber(input2, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = divider( input1, input2);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // square root
		    case 5:
		    	 displayNumber(0, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = square_root(input1);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // power
		    case 6:
		    	 input2 =  take_input2 ( counter2, slideSwitchIn,negative);
		    	 displayNumber(input2, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = power( input1, input2);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // exponential
		    case 7:
		    	displayNumber(0, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = exponential(input1);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // sine
		    case 8:
		    	displayNumber(0, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = sine(input1);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // cosine
		    case 9:
		    	displayNumber(0, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = cosine(input1);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    // tangent
		    case 10:
		    	displayNumber(0, is_decimal,hexadecimal);
		    	if(pushBtnUpIn == 1 )
		    	{
		    		up_pressed = 1;
		    	}
		    	else if (pushBtnUpIn == 0 && up_pressed == 1)
		    	{
		    		 up_pressed = 0;
		    		 input1 = tangent(input1);
			    	 if (input1%10 != 0)
			    	 {
			    		 is_decimal =1;
			    	 }
			    	 else if (input1%10 == 0)
			    	 {
			    		 input1 = input1/10;
			    	 }
		    		 arith_op_type = 0;
		    		 show_results = 1;
		    	}
		    	break;
		    default:

		    	break;
		    }
		}

    cleanup_platform();
    return 0;
}
