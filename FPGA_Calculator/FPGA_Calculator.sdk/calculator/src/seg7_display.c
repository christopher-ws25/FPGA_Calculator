#include <stdio.h>
#include "xil_types.h"		// Added for integer type definitions
#include "seg7_display.h"	// Added for 7-segment definitions
#include "gpio_init.h"
u8 digitDisplayed = FALSE;
u8 digits[4];
u8 numOfDigits;
u8 digitToDisplay;
u8 digitNumber;

void displayNumber(s32 number, u16 is_decimal, u16 hexadecimal)
{
	u8 count;
	/* Note that 9999 is the maximum number that can be displayed
	 * Therefore, check if the number is less than or equal to 9999
	 * and display the number otherwise, display dashes in all the four segments
	 */

	//displays non decimal number
	if (is_decimal == 0 && hexadecimal == 0)
	{
		if (number <= 9999 && number >=0)
			{
				// Call the calculateDigits method to determine the digits of the number
				calculateDigits(number);
				/* Do not display leading zeros in a number,
				 * but if the entire number is a zero, it should be displayed.
				 * By displaying the number from the last digit, it is easier
				 * to avoid displaying leading zeros by using the numOfDigits variable
				 */
				count = 4;
				while (count > 4 - numOfDigits)
				{
					digitToDisplay = digits[count-1];
					digitNumber = count;
					count--;
					/* Wait for timer interrupt to occur and ISR to finish
					 * executing digit display instructions
					 */
					while (digitDisplayed == FALSE);
					digitDisplayed = FALSE;
				}
			}

		// displays the negative number
		/* Note that -999 is the maximum number that can be displayed
		 * Therefore, check if the number is greater than or equal to -999
		 * and display the number otherwise, display dashes in all the four segments
		 */
		// wait for last digit to be displayed and displays - afterwards
		else if(number <0 && number >= -999)
			{
				// make number to positive
				number = - number;
				// Call the calculateDigits method to determine the digits of the number
				calculateDigits(number);
				count = 4;
				while (count >= 4 - numOfDigits)
				{
					if (count == 4 - numOfDigits)
					{
						digitToDisplay = NUMBER_DASH;
						digitNumber = count;
						count--;
					}
					else
					{
						digitToDisplay = digits[count-1];
						digitNumber = count;
						count--;
						/* Wait for timer interrupt to occur and ISR to finish
						 * executing digit display instructions
						 */
					}
					while (digitDisplayed == FALSE);
					digitDisplayed = FALSE;

				}
			}
			else
			{

				// << Write the code to display dashes for out-of-range numbers >>
				// Display "----" to indicate that the number is out of range
				count = 1;
				while (count < 5)
				{
					digitToDisplay = NUMBER_DASH;
					digitNumber = count;
					count++;
					/* Wait for timer interrupt to occur and ISR to finish
					 * executing digit display instructions
					 */
					while (digitDisplayed == FALSE) ;
					digitDisplayed = FALSE;
				}
			}
	}
	if (is_decimal == 1)
	{
		if (number <= 9999 && number >=0)
			{
				// Call the calculateDigits method to determine the digits of the number
				calculateDigits(number);
				/* if number of digit is 1, displays the first digit
				 * then display 0 with decimal, ie. 5 then 0. , becomes 0.5
				 */
				count = 4;
				if (numOfDigits == 1)
				{
					while (count >= 4 - numOfDigits)
					{
						if (count == 4 - numOfDigits)
						{
							digitToDisplay = 10;
							digitNumber = count;
							count--;
						}
						else
						{
							digitToDisplay = digits[count-1];
							digitNumber = count;
							count--;
							/* Wait for timer interrupt to occur and ISR to finish
							 * executing digit display instructions
							 */
						}
						while (digitDisplayed == FALSE);
						digitDisplayed = FALSE;

					}
				}

				/*displays the first digit, then the second digit to be displayed has a decimal point
				 * digits after the decimal digit are all normal
				 */
				else if (numOfDigits > 1)
				{
					while (count > 4 - numOfDigits)
					{

						if (count == 3)
						{
							digitToDisplay = digits[count-1] + 10;
							digitNumber = count;
							count--;
						}
						else
						{
							digitToDisplay = digits[count-1];
							digitNumber = count;
							count--;
						}
						/* Wait for timer interrupt to occur and ISR to finish
						 * executing digit display instructions
						 */
						while (digitDisplayed == FALSE);
						digitDisplayed = FALSE;
					}
				}

			}
		//displays negative decimal numbers
		else if(number <0 && number >= -999)
		{
			number = - number;
			calculateDigits(number);
			count = 4;
			/*if number is only 1 digit, first display the first digit
			 * then display the 0 decimal
			 * then display the dash
			 */
			if (numOfDigits == 1)
			{
				while (count >= 3 - numOfDigits)
				{
					if (count == 3 - numOfDigits)
					{
						digitToDisplay = NUMBER_DASH;
						digitNumber = count;
						count--;
					}
					else if (count == 4 - numOfDigits)
					{
						digitToDisplay = 10;
						digitNumber = count;
						count--;
					}
					else
					{
						digitToDisplay = digits[count-1];
						digitNumber = count;
						count--;
						/* Wait for timer interrupt to occur and ISR to finish
						 * executing digit display instructions
						 */
					}
					while (digitDisplayed == FALSE);
					digitDisplayed = FALSE;

				}
			}
			/*if number more than 1 digit, first display the first digit
			 * then the second digit will be decimal
			 * if there are more digits, they will be integers
			 * then display the dash
			 */
			else if (numOfDigits > 1)
			{
				while (count >= 4 - numOfDigits)
				{

					if (count == 3)
					{
						digitToDisplay = digits[count-1] + 10;
						digitNumber = count;
						count--;
					}
					else if (count == 4 - numOfDigits)
					{
						digitToDisplay = NUMBER_DASH;
						digitNumber = count;
						count--;
					}
					else
					{
						digitToDisplay = digits[count-1];
						digitNumber = count;
						count--;
					}
					/* Wait for timer interrupt to occur and ISR to finish
					 * executing digit display instructions
					 */
					while (digitDisplayed == FALSE);
					digitDisplayed = FALSE;
				}
			}
			else
			{

				// << Write the code to display dashes for out-of-range numbers >>
				// Display "----" to indicate that the number is out of range
				count = 1;
				while (count < 5)
				{
					digitToDisplay = NUMBER_DASH;
					digitNumber = count;
					count++;
					/* Wait for timer interrupt to occur and ISR to finish
					 * executing digit display instructions
					 */
					while (digitDisplayed == FALSE) ;
					digitDisplayed = FALSE;
				}
			}
		}
	}

	//displays hexadecimal, only can work from integers
	if (is_decimal == 0 && hexadecimal == 1)
	{
		/*
		 * Step 1 is to divide the decimal number by 16. Treat the division as an integer division.
		 * Step 2, The remainder here will be first value to be displayed in the 7-seg display.
		 * This remainder should be a hexadecimal.
		 * Step 3,do an integer division again to the result in step 1.
		 * Step 4, repeat steps 2 and 3 until the result is 0.
		 */
		if (number <= 9999 && number >0)
			{
				count = 4;
				u16 temp , remainder;
				temp = number;
				while (temp > 0)
				{
					remainder = temp % 16;
					temp = temp/16;
					if (remainder >= 10)
					{
						digitToDisplay = remainder + 10;
						digitNumber = count;
						count--;
					}
					else if (remainder < 10)
					{
						digitToDisplay =remainder;
						digitNumber = count;
						count--;
					}
					while (digitDisplayed == FALSE);
					digitDisplayed = FALSE;
				}
			}
		else if(number <0 && number >= -999)
			{
			count = 4;
			u16 temp , remainder;
			temp = -number;
			while (temp > 0)
			{
				remainder = temp % 16;
				temp = temp/16;
				if (remainder >= 10)
				{
					digitToDisplay = remainder + 10;
					digitNumber = count;
					count--;
				}
				else if (remainder < 10)
				{
					digitToDisplay =remainder;
					digitNumber = count;
					count--;
				}
				while (digitDisplayed == FALSE);
				digitDisplayed = FALSE;
			}
			digitToDisplay =NUMBER_DASH;
			digitNumber = count;
			count--;
			while (digitDisplayed == FALSE);
			digitDisplayed = FALSE;
			}
		else if (number == 0)
		{
			digitToDisplay =0;
			digitNumber = 4;
			while (digitDisplayed == FALSE);
			digitDisplayed = FALSE;
		}
		else
		{

			// << Write the code to display dashes for out-of-range numbers >>
			// Display "----" to indicate that the number is out of range
			count = 1;
			while (count < 5)
			{
				digitToDisplay = NUMBER_DASH;
				digitNumber = count;
				count++;
				/* Wait for timer interrupt to occur and ISR to finish
				 * executing digit display instructions
				 */
				while (digitDisplayed == FALSE) ;
				digitDisplayed = FALSE;
			}
		}
	}
}

void calculateDigits(s32 number)
{
	u8 fourthDigit;
	u8 thirdDigit;
	u8 secondDigit;
	u8 firstDigit;

	// Check if number is up to four digits
	if (number > 999)
	{
		numOfDigits = 4;

		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = (number / 100) % 10;
		firstDigit = number / 1000;
	}
	// Check if number is three-digits long
	else if (number > 99 && number < 1000)
	{
		numOfDigits = 3;

		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = (number / 100) % 10;
		firstDigit = 0;
	}
	// Check if number is two-digits long
	else if (number > 9 && number < 100)
	{
		numOfDigits = 2;

		// << Write code to assign digits here >>
		fourthDigit  = number % 10;
		thirdDigit = (number / 10) % 10;
		secondDigit  = 0;
		firstDigit = 0;

	}
	// Check if number is one-digit long
	else if (number >= 0 && number < 10)
	{
		numOfDigits = 1;

		// << Write code to assign digits here >>
		fourthDigit  = number % 10;
		thirdDigit = 0;
		secondDigit  = 0;
		firstDigit = 0;


	}

	digits[0] = firstDigit;
	digits[1] = secondDigit;
	digits[2] = thirdDigit;
	digits[3] = fourthDigit;

	return;
}

void displayDigit()
{
	/*
	 * The timer ISR is used to call this function to display the digits
	 */

	// Write the appropriate value to the SEG7_HEX_OUT object
	switch (digitToDisplay)
	{
		case NUMBER_BLANK :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_BLANK);
			break;
		case 0 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ZERO);
			break;
		case 1 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_ONE);
			break;
		case 2 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_TWO);
			break;
		case 3 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_THREE);
			break;
		case 4 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FOUR);
			break;
		case 5 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_FIVE);
			break;
		case 6 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SIX);
			break;
		case 7 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_SEVEN);
			break;
		case 8 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_EIGHT);
			break;
		case 9 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_NINE);
			break;
		case 10 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_ZERO);
			break;
		case 11 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_ONE);
			break;
		case 12 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_TWO);
			break;
		case 13 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_THREE);
			break;
		case 14 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_FOUR);
			break;
		case 15 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_FIVE);
			break;
		case 16 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_SIX);
			break;
		case 17 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_SEVEN);
			break;
		case 18 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_EIGHT);
			break;
		case 19 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DECIM_NINE);
			break;
		case 20 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_A);
			break;
		case 21 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_B);
			break;
		case 22 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_C);
			break;
		case 23 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_D);
			break;
		case 24 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_E);
			break;
		case 25 :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, LETTER_F);
			break;

		case NUMBER_DASH :
			XGpio_DiscreteWrite(&SEG7_HEX_OUT, 1, DIGIT_DASH);
			break;
		// << Complete the case statement for other digit values >>
			
	}

	// Select the appropriate digit
	if (digitNumber == 1) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_FIRST_SEG);
	}
	else if (digitNumber == 2) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_SECOND_SEG);
	}
	else if (digitNumber == 3) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_THIRD_SEG);
	}
	else if (digitNumber == 4) {
		XGpio_DiscreteWrite(&SEG7_SEL_OUT, 1, EN_FOURTH_SEG);
	}

	digitDisplayed = TRUE;
	return;
}
