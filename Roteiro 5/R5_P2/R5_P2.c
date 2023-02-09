unsigned int adc_AN0 = 0;
float temperatura;
char txt_lcd[5];
bit fg_bt ;
int x =0;
 //Conex�es do LCD com as Portas do PIC
 sbit LCD_RS at RC2_bit; //LCD reset
 sbit LCD_EN at RC3_bit; //LCD enable
 sbit LCD_D4 at RC4_bit; //LCD data
 sbit LCD_D5 at RC5_bit; //LCD data
 sbit LCD_D6 at RC6_bit; //LCD data
 sbit LCD_D7 at RC7_bit; //LCD data
 //Dire��o dos pinos do LCD
 sbit LCD_RS_Direction at TRISC2_bit;
 sbit LCD_EN_Direction at TRISC3_bit;
 sbit LCD_D4_Direction at TRISC4_bit;
 sbit LCD_D5_Direction at TRISC5_bit;
 sbit LCD_D6_Direction at TRISC6_bit;
 sbit LCD_D7_Direction at TRISC7_bit;

void main()
{
   TRISA = 0xFF;          //Conf.todos os pinos do PORTA c/ entrada
   TRISB = 0x00;          //Conf.todos os pinos do PORTB c/ sa�da
   TRISC = 0b00000001;    //Conf.todos os pinos do PORTC c/ sa�da
   TRISD = 0b00000000;
   RB0_bit = 0;              //Inicializa a sa�da do ventilador em 0
   RD0_bit = 0;

   ADCON0 = 0b00000001;   //Habilita A/D e seleciona a entrada AN0
   ADCON1 = 0b00001110;   //Seleciona apenas o pino AN0 como A/D
   ADC_Init();                        //Inicializa o m�dulo conversor A/D
   CMCON = 0b00000111;    //Desabilita os comparadores internos

   Lcd_Init();                //Iniciliza o LCD
   Lcd_Cmd(_LCD_CLEAR);              //Limpa todos os caracteres do LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);  //Desabilita cursor piscando no LCD

   //Mensagens iniciais no display LCD
   //Lcd_Out(1,1,"  Indicador de  ");
   //Lcd_Out(2,1,"  Temperatura  ");
   Delay_ms(2000);
   Lcd_Cmd(_LCD_CLEAR);
   Lcd_Out(1,1,"Temperatura:");

   while(1)
   {
    adc_AN0 = ADC_Read(0); //L� o valor da porta AN0
    temperatura = (adc_AN0 / 1024.0) * 500.0;
    FloatToStr(temperatura, txt_lcd);
    Lcd_Out(1,13,txt_lcd);

    if (x == 1) {
       if (temperatura >= 50){
        RB0_bit = 1;
        //Lcd_Out(2,1,"Motor ON");
        }
        else if (temperatura <= 45) {
        RB0_bit = 0;
        //Lcd_Out(2,1,"Motor OFF");
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
    //if (x==0)RB0_bit = 0;
    }
}