sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB2_bit;
sbit LCD_D6 at RB1_bit;
sbit LCD_D7 at RB0_bit;
// Conexões do LCD - Definição de Pinos
sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB4_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB2_bit;
sbit LCD_D6_Direction at TRISB1_bit;
sbit LCD_D7_Direction at TRISB0_bit;
//----------------------------------------------------
//Declaração variaveis globais do codigo
char *text, mytext[4];
unsigned char  a = 0, b = 0, i = 0, t1 = 0,
               t2 = 0, rh1 = 0, rh2 = 0, sum = 0;
//----------------------------------------------------
void inicia_sinal()
{
   TRISD.F2 = 0;  //Configura RD2 como  saída
   PORTD.F2 = 0;  //RD2 envia 0 para o sensor
   Delay_ms(18);
   PORTD.F2 = 1;  //RD2 envia 1 para o sensor
   Delay_us(30);
   TRISD.F2 = 1;  //Configura RD2 como entrada
}
//----------------------------------------------------
void verifica_resposta()
{
   a = 0;
   Delay_us(40);
   if (PORTD.F2 == 0)
   {
      Delay_us(80);
      if (PORTD.F2 == 1)   a = 1;
      Delay_us(40);
   }
}
//----------------------------------------------------
void le_dados()
{
   for(b=0;b<8;b++)
   {
      while(!PORTD.F2); //Espera até PORTD.F2 ficar HIGH
      Delay_us(30);
      if(PORTD.F2 == 0)    i&=~(1<<(7-b));  //Clear bit (7-b)
      else
      {
         i|= (1<<(7-b));  //Set bit (7-b)
         while(PORTD.F2); //Espera até PORTD.F2 ficar LOW
      }
   }
}
//----------------------------------------------------
void main()
{
   TRISB = 0;        //Configura PORTB com saída
   PORTB = 0;        //Inicializa  valor 0 PORTB
   Lcd_Init();
   Lcd_Cmd(_LCD_CURSOR_OFF); //Desliga cursorLCD
   Lcd_Cmd(_LCD_CLEAR);      //Limpa  todo  LCD
   while(1)
   {
      inicia_sinal();
      verifica_resposta();
      if (a == 1)
      {
         le_dados();
         rh1 =i;
         le_dados();
         rh2 =i;
         le_dados();
         t1 =i;
         le_dados();
         t2 =i;
         le_dados();
         sum = i;
         if(sum == rh1+rh2+t1+t2)
         {
            text = "Temperatura:   C";
            Lcd_Out(1,1,text);
            text = "    Umidade:   %";
            Lcd_Out(2,1,text);
            ByteToStr(t1,mytext);
            Lcd_Out(1,14,Ltrim(mytext));
            ByteToStr(rh1,mytext);
            Lcd_Out(2,14,Ltrim(mytext));
         }
         else
         {
            Lcd_Cmd(_LCD_CURSOR_OFF);
            Lcd_Cmd(_LCD_CLEAR);
            text = "Erro de CheckSum";
            Lcd_Out(1,1,text);
         }
      }
      else
      {
         text="  Sem resposta  ";
         Lcd_Out(1,3,text);
         text = "    do sensor   ";
         Lcd_Out(2,1,text);
      }
      Delay_ms(1000);
   }
}
