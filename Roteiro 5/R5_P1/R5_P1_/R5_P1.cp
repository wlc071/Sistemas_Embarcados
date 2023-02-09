#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 5/R5_P1/R5_P1_/R5_P1.c"
unsigned int adc_AN0 = 0;

void main()
{
 TRISA = 0xFF;
 TRISB = 0x00;
 TRISC = 0x00;


 ADCON0.ADCS0 = 0;
 ADCON0.ADCS1 = 0;
 ADCON1.ADCS2 = 0;


 ADCON0.CHS0 = 0;
 ADCON0.CHS1 = 0;
 ADCON0.CHS2 = 0;


 ADCON0.ADON = 1;


 ADCON1.ADFM = 0;


 ADCON1.PCFG0 = 0;
 ADCON1.PCFG1 = 1;
 ADCON1.PCFG2 = 1;
 ADCON1.PCFG3 = 1;


 CMCON.CM0 = 1;
 CMCON.CM1 = 1;
 CMCON.CM2 = 1;


 ADC_Init();


 PORTB = 0X00;
 PORTC = 0X00;

 while(1)
 {
 adc_AN0 = ADC_Get_Sample(0);
 PORTB = adc_AN0;
 PORTC = adc_AN0 >> 8;
 }
}
