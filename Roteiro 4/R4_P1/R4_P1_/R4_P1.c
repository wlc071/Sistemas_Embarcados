//Roteiro 6 - Código 1 - Contador de 0 a 1000

 int  contador = 0;
 char texto_LCD[4];
 int i =0;

 //Conexões do LCD com as Portas do PIC
 sbit LCD_RS at RC2_bit; //LCD reset
 sbit LCD_EN at RC3_bit; //LCD enable
 sbit LCD_D4 at RC4_bit; //LCD data
 sbit LCD_D5 at RC5_bit; //LCD data
 sbit LCD_D6 at RC6_bit; //LCD data
 sbit LCD_D7 at RC7_bit; //LCD data

 //Direção dos pinos do LCD
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
  TRISC = 0x00;                          //Configura a porta C como saída digital
  OPTION_REG.INTEDG = 0;   //Configura borda inter. externa Descida
  INTCON = 0;                            //Escreve 0 em todos os bits de INTCON
  INTCON.INTE = 1;                  //Habilita as interrupções externas
  INTCON.PEIE = 1;                  //Habilita todas interrup. periféricas
  INTCON.GIE = 1;                    //Habilita as interrupções globais
  INTCON.INTF = 0;                 //Limpa Flag de Interrupção Externa

  Lcd_Init();                                 //Iniciliza o LCD
  Lcd_cmd(_LCD_CLEAR);              //Limpa todos os caracteres do LCD
  Lcd_Cmd(_LCD_CURSOR_OFF); //Desabilita cursor piscando no LCD

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
  // lcd_Chr(2,col,0xff);
}