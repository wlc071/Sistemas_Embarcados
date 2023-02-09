#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 5/R5_P2/R5_P2.c"
unsigned int adc_AN0 = 0;
float temperatura;
char txt_lcd[5];
bit fg_bt ;
int x =0;

 sbit LCD_RS at RC2_bit;
 sbit LCD_EN at RC3_bit;
 sbit LCD_D4 at RC4_bit;
 sbit LCD_D5 at RC5_bit;
 sbit LCD_D6 at RC6_bit;
 sbit LCD_D7 at RC7_bit;

 sbit LCD_RS_Direction at TRISC2_bit;
 sbit LCD_EN_Direction at TRISC3_bit;
 sbit LCD_D4_Direction at TRISC4_bit;
 sbit LCD_D5_Direction at TRISC5_bit;
 sbit LCD_D6_Direction at TRISC6_bit;
 sbit LCD_D7_Direction at TRISC7_bit;

void main()
{
 TRISA = 0xFF;
 TRISB = 0x00;
 TRISC = 0b00000001;
 TRISD = 0b00000000;
 RB0_bit = 0;
 RD0_bit = 0;

 ADCON0 = 0b00000001;
 ADCON1 = 0b00001110;
 ADC_Init();
 CMCON = 0b00000111;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);




 Delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Temperatura:");

 while(1)
 {
 adc_AN0 = ADC_Read(0);
 temperatura = (adc_AN0 / 1024.0) * 500.0;
 FloatToStr(temperatura, txt_lcd);
 Lcd_Out(1,13,txt_lcd);

 if (x == 1) {
 if (temperatura >= 50){
 RB0_bit = 1;

 }
 else if (temperatura <= 45) {
 RB0_bit = 0;

 }
 }
 if((RC0_bit == 0) && (fg_bt == 0)){
 x = ~ x;
 RD0_bit = ~ RD0_bit;
 fg_bt=1;
 }
 if((RC0_bit == 1)&&(fg_bt == 1)){
 fg_bt=0;
 }

 }
}
