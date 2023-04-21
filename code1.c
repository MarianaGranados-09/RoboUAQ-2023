#include <18F4550.h>
#device adc=10
#Fuses INTRC,NOPROTECT, NOWDT, CPUDIV1, PLL1
#Use Delay(Clock=8M)
#use RS232(RCV=PIN_C7, XMIT=PIN_C6, Baud=9600, Bits=8)

int main(void)
{
   int value0;
   float conv0;
   
   setup_adc_ports(AN0);
   setup_adc(ADC_CLOCK_INTERNAL);
   printf("Analog ports configured\n");
   delay_ms(500);
   
   for(;;)
   {   
      set_adc_channel(0);
      delay_ms(20);
      value0 = read_adc();
      conv0 = 5.0 * value0 / 1024.0;
      
      printf("A0: %d\n", value0);
      printf("Voltage: %01.2f V\n", conv0);
      delay_ms(2000);
   }

   return 0;
}
