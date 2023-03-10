unsigned short i = 0;
int flg = 0;
int j = 1;
void main()
{
   //Conf.todos pinos do PORTC c/ sa?da
   TRISC = 0x00;

   //Configura o modo de opera??o do CCP (11XX Modo PWM)
   CCP1CON.CCP1M0 = 1;
   CCP1CON.CCP1M1 = 1;
   CCP1CON.CCP1M2 = 1;
   CCP1CON.CCP1M3 = 1;

   //Configura Prescaler (1:16)
   T2CON.T2CKPS0 = 0;
   T2CON.T2CKPS1 = 0;
   T2CON.TMR2ON  = 0;

   //Habilita Timer2
   T2CON.TOUTPS0 = 0;

   //Configura o Postcaler (1:1)
   T2CON.TOUTPS1 = 0;
   T2CON.TOUTPS2 = 0;
   T2CON.TOUTPS3 = 0;

   //Configura o per?odo do PWM
   PR2 = 255;

   //Configura o Duty Cycle do PWM
   CCP1CON.CCP1Y = 0;  //Bit0
   CCP1CON.CCP1X = 0;  //Bit1
   CCPR1L = 0;          //Bit 2 ao 9

   while(1)
   {
     CCPR1L = i;
     i = i + j;

     if (i == 255){
        j = j * -1;
     }
     if (i == 0) {
        j = j * -1;
     }
     Delay_ms(40);
   }
}