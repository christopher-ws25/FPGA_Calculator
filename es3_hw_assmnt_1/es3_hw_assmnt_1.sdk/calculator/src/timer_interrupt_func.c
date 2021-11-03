#include "seg7_display.h"

void hwTimerISR(void *CallbackRef)
{
	displayDigit();
}
