//Roteiro 6 - C?digo 3 - Sequenciador

 short  sel_saida = 1, i = 0;
 bit fim_1s;
 int aux_tempo = 0;
 char texto_LCD[4];

 //Conex?es do LCD com as Portas do PIC
 sbit LCD_RS at RC2_bit; //LCD reset
 sbit LCD_EN at RC3_bit; //LCD enable
 sbit LCD_D4 at RC4_bit; //LCD data
 sbit LCD_D5 at RC5_bit; //LCD data
 sbit LCD_D6 at RC6_bit; //LCD data
 sbit LCD_D7 at RC7_bit; //LCD data

 //Dire??o dos pinos do LCD
 sbit LCD_RS_Direction at TRISC2_bit;
 sbit LCD_EN_Direction at TRISC3_bit;
 sbit LCD_D4_Direction at TRISC4_bit;
 sbit LCD_D5_Direction at TRISC5_bit;
 sbit LCD_D6_Direction at TRISC6_bit;
 sbit LCD_D7_Direction at TRISC7_bit;

void interrupt()
{
   if (INTCON.TMR0IF == 1)
   {
      aux_tempo++;
      if (aux_tempo == 125)
      {
         aux_tempo = 0;
         fim_1s = 1;
      }
      INTCON.TMR0IF = 0; //Restaura o sinalizador de interrup??o por T0
      INTCON.TMR0IE = 1; //Habilita novamente a interrup??o
      TMR0 = 131;                 //Inicia o contador do T0 com 131
   }
}

void main()
{
  TRISB = 0x00;                 //Configura a porta B como sa?da digital
  TRISC = 0x00;                 //Configura a porta C como sa?da digital
  PORTB = 0;                     //Ao energizar, incializa com 0 no PORTB

  Lcd_Init();                       //Iniciliza o LCD
  Lcd_Cmd(_LCD_CLEAR);                  //Limpa todos os caracteres do LCD
  Lcd_Cmd(_LCD_CURSOR_OFF);     //Desabilita cursor piscando no LCD

  //Mensagens iniciais no display LCD
  Lcd_Out(1,1,"   Pratica 8   ");
  Lcd_Out(2,1,"Eng. Computacao");
  Delay_ms(1000);
  for (i=0; i<15; i++)
  {
     Lcd_Cmd(_LCD_SHIFT_LEFT);
     Delay_ms(200);
  }
  for (i=0; i<15; i++)
  {
     Lcd_Cmd(_LCD_SHIFT_RIGHT);
     Delay_ms(200);
  }
  Delay_ms(1000);
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1,1,"  Sequenciador  ");

  OPTION_REG.T0CS = 0;    //BIT 5 Fonte de refer?ncia - CLK Interno
  OPTION_REG.T0SE = 0;    //BIT 4 Transi??o do Timer0 Borda subida
  OPTION_REG.PSA = 0;     //BIT 3 Seleciona o Prescaler parao T0
  OPTION_REG.PS2 = 1;
  OPTION_REG.PS1 = 0;
  OPTION_REG.PS0 = 1;      //BIT 2-0 Taxa de divis?o PESCALER 011 (1:64)
  TMR0 = 131;                       //Inicia o contador do T0 com 131

  INTCON = 0b00000000;     //Limpa o registro de controle de Interrup??o
  INTCON.TMR0IE = 1;        //BIT 5 Habilita interrup??o do T0 Overflow
  INTCON.TMR0IF = 0;        //BIT 2 Limpa indicador de interrup??o por T0
  INTCON.GIE = 1;               //BIT 7 Habilita interrup??o Global

  for (;;)
  {
    if (fim_1s)  //Passou 1s ?
    {
       fim_1s = 0;
       switch (sel_saida)
       {
          case 1: Lcd_Out(2,5,"00000001");
                  PORTB = 1;
                  PORTC.RC1 = 1;
                  sel_saida++;
          break;
          //------------------------
          case 2: Lcd_Out(2,5,"00000010");
                  PORTB = 2;
                  PORTC.RC1 = 0;
                  sel_saida++;
          break;
          //------------------------
          case 3: Lcd_Out(2,5,"00000100");
                  PORTB = 4;
                  PORTC.RC1 = 1;
                  sel_saida++;
          break;
          //------------------------
          case 4: Lcd_Out(2,5,"00001000");
                  PORTB = 8;
                  RC1_bit = 0;
                  sel_saida++;
          break;
          //------------------------
          case 5: Lcd_Out(2,5,"00010000");
                  PORTB = 16;
                  RC1_bit = 1;
                  sel_saida++;
          break;
          //------------------------
          case 6: Lcd_Out(2,5,"00100000");
                  PORTB = 32;
                  RC1_bit = 0;
                  sel_saida++;
          break;
          //------------------------
          case 7: Lcd_Out(2,5,"01000000");
                  PORTB = 64;
                  RC1_bit = 1;
                  sel_saida++;
          break;
          //------------------------
          case 8: Lcd_Out(2,5,"10000000");
                  PORTB = 128;
                  RC1_bit = 0;
                  sel_saida = 1;
          break;
       }
    }
  }
}