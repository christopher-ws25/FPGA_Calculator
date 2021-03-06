#ifndef __SEG7_DISPLAY_H_
#define __SEG7_DISPLAY_H_

#include "xgpio.h"		// Added for xgpio object definitions

// Definitions for 7-segment BCD codes

//definitions for integers
#define DIGIT_BLANK		0xFF
#define DIGIT_ZERO 		0xC0
#define DIGIT_ONE  		0xF9
#define DIGIT_TWO  		0xA4
#define DIGIT_THREE  	0xB0
#define DIGIT_FOUR  	0x99
#define DIGIT_FIVE  	0x92
#define DIGIT_SIX  		0x82
#define DIGIT_SEVEN  	0xF8
#define DIGIT_EIGHT  	0x80
#define DIGIT_NINE  	0x90
#define DIGIT_DASH  	0xBF

//definitions for integers with decimal point
#define DECIM_ZERO 		0x40
#define DECIM_ONE  		0x79
#define DECIM_TWO  		0x24
#define DECIM_THREE  	0x30
#define DECIM_FOUR  	0x19
#define DECIM_FIVE  	0x12
#define DECIM_SIX  		0x02
#define DECIM_SEVEN  	0x78
#define DECIM_EIGHT  	0x00
#define DECIM_NINE  	0x10

//definitions for alphabet a-f (for hexadecimals)
#define LETTER_A     	0x88
#define LETTER_B 	    0x83
#define LETTER_C    	0xC6
#define LETTER_D    	0xA1
#define LETTER_E     	0x86
#define LETTER_F    	0x8E



#define NUMBER_BLANK  	30 	// Note: since 30 cannot be a digit,
 						   	//       it is used to represent a blank digit
#define NUMBER_DASH  	31 	// Note: since 31 cannot be a digit,
 						   	//       it is used to represent "dash"

// Definitions for digit selection codes
#define EN_FIRST_SEG	0b0111
#define EN_SECOND_SEG	0b1011
#define EN_THIRD_SEG	0b1101
#define EN_FOURTH_SEG	0b1110

void print(char *str);

int setUpInterruptSystem();
void hwTimerISR(void *CallbackRef);
void displayNumber(s32 number, u16 is_decimal,u16 hexadecimal);
void calculateDigits(s32 number);
void displayDigit();

#endif
