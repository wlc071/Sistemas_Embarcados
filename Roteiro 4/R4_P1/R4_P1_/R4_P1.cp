#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 4/R4_P1/R4_P1_/R4_P1.c"


 int contador = 0;
 char texto_LCD[4];
 int i =0;


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

void interrupt()
{
 if (INTCON.INTF==1)
 {
 INTCON.INTF = 0;
 contador++;
 if (contador > 1000) contador = 0;
 }
}

void main()
{
 TRISB = 0xFF;
 TRISC = 0x00;
 OPTION_REG.INTEDG = 0;
 INTCON = 0;
 INTCON.INTE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 INTCON.INTF = 0;

 Lcd_Init();
 Lcd_cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"  Seja bem-vindo   ");
 Lcd_Out(2,2,"Inicializando...");
 Delay_ms(2000);
 Lcd_Out(1,1,"  Roteiro Prático   ");
 Lcd_Out(2,2,"Sist. Embarcados");
 Delay_ms(2000);
 contador = 1;
 for(i = 1; i<=16; i++){
 Delay_ms(100);
 lcd_Chr(2,i,0xff);
 }
 do
 {
 Lcd_Out(1,1,"  Uniube 2022  ");
 Lcd_Out(2,2,"Contador:");
 IntToStr(contador, texto_LCD);
 Lcd_Out(2,11, texto_LCD);

 }while(1);

}
