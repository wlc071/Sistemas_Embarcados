unsigned int adc_AN0, out_PWM, duty_cycle;
char txt_lcd[4];

 //Conex?es do LCD com as Portas do PIC
 sbit LCD_RS at RB2_bit; //LCD reset
 sbit LCD_EN at RB3_bit; //LCD enable
 sbit LCD_D4 at RB4_bit; //LCD data
 sbit LCD_D5 at RB5_bit; //LCD data
 sbit LCD_D6 at RB6_bit; //LCD data
 sbit LCD_D7 at RB7_bit; //LCD data
 //Dire??o dos pinos do LCD
 sbit LCD_RS_Direction at TRISB2_bit;
 sbit LCD_EN_Direction at TRISB3_bit;
 sbit LCD_D4_Direction at TRISB4_bit;
 sbit LCD_D5_Direction at TRISB5_bit;
 sbit LCD_D6_Direction at TRISB6_bit;
 sbit LCD_D7_Direction at TRISB7_bit;

void main()
{
   TRISA = 0xFF;    //Conf.todos os pinos do PORTA c/ entrada
   TRISB = 0x00;    //Conf.todos os pinos do PORTB c/ sa?da
   TRISC = 0x00;    //Conf.todos os pinos do PORTC c/ sa?da

   //Configurando o Clock do Conversor A/D (Fosc / 2)
   ADCON0.ADCS0 = 0;
   ADCON0.ADCS1 = 0;
   ADCON1.ADCS2 = 0;
   //Selecionando o canal a ser convertido (AN0)
   ADCON0.CHS0 = 0;
   ADCON0.CHS1 = 0;
   ADCON0.CHS2 = 0;
   //Habilita o m?dulo A/D
   ADCON0.ADON = 1;
   //Seleciona o formato do resultado - Justificado a Esquerda
   ADCON1.ADFM = 0;

   //Controle de configura??o das portas - Anal?gicas ou Digitais
   ADCON1.PCFG0 = 0;
   ADCON1.PCFG1 = 1;
   ADCON1.PCFG2 = 1;
   ADCON1.PCFG3 = 1;

  //Modo de opera??o do comparador - Desligados (111)
   CMCON.CM0 = 1;
   CMCON.CM1 = 1;
   CMCON.CM2 = 1;

   PIE1 = 0b00000100; //Habilita o m?dulo CCP
   PWM1_Init(10000);

   Lcd_Init();                //Iniciliza o LCD
   Lcd_Cmd(_LCD_CLEAR);       //Limpa todos os caracteres do LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);  //Desabilita cursor piscando no LCD

   //Mensagens iniciais no display LCD
   Lcd_Out(1,1," Gerando sinal ");
   Lcd_Out(2,1,"PWM de 0 a 100%");
   Delay_ms(2000);
   Lcd_Cmd(_LCD_CLEAR);
   Lcd_Out(1,1,"AN0:");
   Lcd_Out(2,1,"PWM:      DC:");

   while(1)
   {
      adc_AN0 = ADC_Read(0); //L? o valor da porta AN0
      out_PWM = (float)((adc_AN0 / 1023.0) * 255.0);
      duty_cycle = (float)((adc_AN0 / 1023.0) * 100.0);
      //-----------------------------------------------
      IntToStr(adc_AN0, txt_lcd);
      Ltrim(txt_lcd);
      Lcd_Out(1,5,txt_lcd);
      if ((adc_AN0 < 1000) && (adc_AN0 > 99)) Lcd_Out(1,8," ");
      if ((adc_AN0 < 100) && (adc_AN0 > 9)) Lcd_Out(1,7," ");
      if (adc_AN0 < 10) Lcd_Out(1,6," ");
      //------------------------------------------------
      IntToStr(out_PWM, txt_lcd);
      Ltrim(txt_lcd);
      Lcd_Out(2,5,txt_lcd);
      if ((out_PWM < 100) && (out_PWM > 9)) Lcd_Out(2,7," ");
      if (out_PWM < 10) Lcd_Out(2,6,"  ");
      //------------------------------------------------
      IntToStr(duty_cycle, txt_lcd);
      Ltrim(txt_lcd);
      Lcd_Out(2,14,txt_lcd);
      if ((duty_cycle < 100) && (duty_cycle > 9)) Lcd_Out(2,16," ");
      if (duty_cycle < 10) Lcd_Out(2,15,"  ");
      //-------------------------------------------------
      PWM1_Start();
      PWM1_Set_Duty(out_PWM);
   }
}