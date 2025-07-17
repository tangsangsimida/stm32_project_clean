#include "user_main.hpp"

#include "main.h"
#include "stdio.h"

int user_main()
{
    HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13); 
    printf("Hello World!\n");
    HAL_Delay(1000);
    return 0;
}