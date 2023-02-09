#line 1 "C:/Users/walla/OneDrive/Documentos/Sistemas embarcados/Roteiros/Roteiro 3/R3_P1/R3_P1_/Roteiro3_P1.c"
unsigned char const_7seg[]= {63, 6, 91, 79, 102, 109, 125, 7, 127, 103};
int contagem = 0;
int aux_tempo = 0;

void interrupt()
{
 if (INTCON.TMR0IF == 1)
 {
 aux_tempo++;
 if (aux_tempo == 500)
 {
 aux_tempo = 0;
 contagem++;
 if (contagem > 9) contagem = 0;
 PORTD = const_7seg[contagem];
 }
 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;
 TMR0 = 131;
 }
}

void main()
{
 TRISA = 0b11111111;
 TRISD = 0b00000000;

 OPTION_REG.T0CS = 0;
 OPTION_REG.T0SE = 0;
 OPTION_REG.PSA = 0;
 OPTION_REG.PS2 = 0;
 OPTION_REG.PS1 = 1;
 OPTION_REG.PS0 = 1;
 TMR0 = 131;

 INTCON = 0b00000000;
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;

 PORTD = const_7seg[contagem];

 for(;;)
 {
 }
}
