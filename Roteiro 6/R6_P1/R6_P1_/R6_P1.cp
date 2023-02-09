#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 6/R6_P1/R6_P1_/R6_P1.c"
unsigned short i = 0;
int flg = 0;
int j = 1;
void main()
{

 TRISC = 0x00;


 CCP1CON.CCP1M0 = 1;
 CCP1CON.CCP1M1 = 1;
 CCP1CON.CCP1M2 = 1;
 CCP1CON.CCP1M3 = 1;


 T2CON.T2CKPS0 = 0;
 T2CON.T2CKPS1 = 0;
 T2CON.TMR2ON = 0;


 T2CON.TOUTPS0 = 0;


 T2CON.TOUTPS1 = 0;
 T2CON.TOUTPS2 = 0;
 T2CON.TOUTPS3 = 0;


 PR2 = 255;


 CCP1CON.CCP1Y = 0;
 CCP1CON.CCP1X = 0;
 CCPR1L = 0;

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
