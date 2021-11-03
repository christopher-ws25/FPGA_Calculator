#include "gpio_init.h"

XStatus initGpio(void)
{
	XStatus status;

	/* Note that the Xgpio objects SEG7_HEX_OUT and SEG7_SEL_OUT
	 * have been declared in the gpio_init.h header file,
	 * but make sure you confirm that the IDs used to initialize
	 * the GPIOs here are correct
	 */
	status = XGpio_Initialize(&SEG7_HEX_OUT, 0);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	status = XGpio_Initialize(&SEG7_SEL_OUT, 1);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	status = XGpio_Initialize(&LED_OUT, 2);
	if (status != XST_SUCCESS){
		return XST_FAILURE;
	}
	status = XGpio_Initialize(&P_BTN_DOWN, 3);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	status = XGpio_Initialize(&P_BTN_LEFT, 4);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	status = XGpio_Initialize(&P_BTN_RIGHT, 5);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	status = XGpio_Initialize(&P_BTN_UP, 6);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	status = XGpio_Initialize(&SLIDE_SWITCHES, 7);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}
