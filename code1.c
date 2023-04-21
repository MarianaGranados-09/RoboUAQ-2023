#Include <18F4550.h>
#device adc=10
#Fuses INTRC,NOPROTECT, NOWDT, CPUDIV1, PLL1
#Use Delay(Clock=8M)
#Use RS232(RCV=PIN_C7, XMIT=PIN_C6, Baud=9600, Bits=8, Stream = TTL)


void main()
{
   int16 valor0, valor1;
   //float conv0, conv1;
   
   setup_adc_ports(AN0_TO_AN1 );  //activar canales analogicos
   setup_adc(ADC_CLOCK_INTERNAL); //fuente de reloj rc
   printf(TTL, "Puertos analogicos configurados\n");
   delay_ms(500);
   

   
   while(true)
   {
      
      set_adc_channel(0);
      delay_us(20); //espera necesaria al cambiar de canal
      valor0 = read_adc(); //leer canal 0
      //conv0 = 5.0 * valor0 / 1024.0;
      
      set_adc_channel(1);
      delay_us(20); //espera necesaria al cambiar de canal
      valor1 = read_adc(); //leer canal 1
      //conv1 = 5.0 * valor1 / 1024.0;
      
      printf(TTL, "A0: %41d \n", valor0);
      printf(TTL, "A1: %41d", valor1);
      delay_ms(500);

   
   }


}


