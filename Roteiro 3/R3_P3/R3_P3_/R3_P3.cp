#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 3/R3_P3/R3_P3_/R3_P3.c"
unsigned char const_7seg[]= {63, 6, 91, 79, 102, 109, 125, 7, 127, 103};
short cont_un = 0;
short cont_dz = 0;
short cont_ct = 0;
short cont_ml = 0;
short sel_display = 1;
int aux_tempo = 0;
int aux_tempo2 = 0;
bit fim_250ms;
bit fim_1s;
bit fg_bt0;

void interrupt()
{
 if (INTCON.TMR0IF == 1)
 {
 if (sel_display == 4)
 {
 PORTC = 0B11110111;
 PORTB = const_7seg[cont_un];
 sel_display = 3;
 }
 else
 {
 if (sel_display == 3)
 {
 PORTC = 0B11111011;
 PORTB = const_7seg[cont_dz];
 sel_display = 2;
 }
 else
 {
 if (sel_display == 2)
 {
 PORTC = 0B11111101;
 PORTB = const_7seg[cont_ct];
 sel_display = 1;
 }
 else
 {
 PORTC = 0B11111110;
 PORTB = const_7seg[cont_ml];
 sel_display = 4;
 }
 }
 }
 aux_tempo++;
 aux_tempo2++;

 if (aux_tempo == 250)
 {
 aux_tempo = 0;
 fim_250ms = 1;
 }
 if (aux_tempo2 == 125)
 {
 aux_tempo2 = 0;
 fim_1s = 1;
 }


 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0 = 131;
 }
}

void main()
{
 ADCON1 = 0b00000110;
 TRISA = 0b11111101;
 TRISC = 0b00000000;
 TRISB = 0b00000000;

 OPTION_REG.T0CS = 0;
 OPTION_REG.T0SE = 0;
 OPTION_REG.PSA = 0;
 OPTION_REG.PS2 = 0;
 OPTION_REG.PS1 = 1;
 OPTION_REG.PS0 = 0;
 TMR0 = 131;

 INTCON = 0b00000000;
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;

 PORTB = const_7seg[0];
 PORTC = 0B11111110;
 PORTC = 0B11111101;
 PORTC = 0B11111011;
 PORTC = 0B11110111;

 PORTA.RA1 = 0;
 fg_bt0 = 0;


 for(;;)
 {
 if (fim_250ms)
 {
 fim_250ms = 0;
 cont_un++;
 if (cont_un > 9)
 {
 cont_un = 0;
 cont_dz++;
 if (cont_dz > 9)
 {
 cont_dz = 0;
 cont_ct++;
 if (cont_ct > 9)
 {
 cont_ct = 0;
 cont_ml++;
 if (cont_ml > 9) cont_ml = 0;
 }
 }
 }
 }
 if((RA0_bit == 0) && (fg_bt0 == 0)){
 cont_un = 0;
 cont_dz = 0;
 cont_ct = 0;
 cont_ml = 0;
 fg_bt0 = 1;
 }
 if((RA0_bit == 1) && (fg_bt0 == 1))fg_bt0 = 0;

 if (fim_1s){
 fim_1s = 0;
 if (PORTA.RA1 == 1) PORTA.RA1 = 0;
 else PORTA.RA1 = 1;
 }



 }
}
