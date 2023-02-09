#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 7/7_1/Roteiro7_1.c"
bit flagSerial;
unsigned int aux_timer0, adc_AN0, luminosidade;
char text_serial[5];
bit fg_bt ;
short cont = 0;


void interrupt()
{
 if (INTCON.TMR0IF == 1)
 {
 aux_timer0++;
 if(aux_timer0 == 500)
 {
 flagSerial = 1;
 aux_timer0 = 0;
 RC2_bit = ~ RC2_bit;
 }
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0 = 6;
 }
}


void main()
{
 TRISA = 0xFF;
 TRISC = 0X00;


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


 OPTION_REG.T0CS = 0;
 OPTION_REG.T0SE = 0;
 OPTION_REG.PSA = 0;
 OPTION_REG.PS2 = 1;
 OPTION_REG.PS1 = 0;
 OPTION_REG.PS0 = 1;
 TMR0 = 6;


 INTCON = 0;
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;

 UART1_Init(9600);
 Delay_ms(100);

 TRISB= 0b1111111;
 RB0_bit = 0;


 while(1)
 {
 if(flagSerial == 1)
 {
 flagSerial = 0;

 if((RB0_bit == 0) && (fg_bt == 0)){
 cont = cont + 1;
 fg_bt=1;
 }
 if((RB0_bit == 1) && (fg_bt == 1)){
 fg_bt=0;
 }
 adc_AN0 = ADC_Read(0);

 IntToStr(adc_AN0, cont);


 UART1_Write_Text(cont);


 UART1_Write(13); UART1_Write(13);
 }
 }
}
