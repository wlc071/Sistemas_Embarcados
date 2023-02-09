unsigned char const_7seg[]= {63, 6, 91, 79, 102, 109, 125, 7, 127, 103};
int contagem1 = 0;
int contagem2 = 0;
int aux_tempo = 0;

void interrupt()
{
   if (INTCON.TMR0IF == 1)
   {
      aux_tempo++;
      if (aux_tempo == 500)
      {
         aux_tempo = 0;
         contagem1++;
         if (contagem1 > 9) contagem1 = 0;
         PORTD = const_7seg[contagem1];
      }
      INTCON.TMR0IF = 0;   //Restaura o sinalizador de interrupção por T0
      INTCON.TMR0IE = 1;   //Habilita novamente a interrupção
      TMR0 = 131;                   //Inicia o contador do T0 com 131
   }
}

void main()
{
   TRISA = 0b11111111;      //Configura todo o PORTA como entrada
   TRISD = 0b00000000;      //Configura todo o PORTD como saída
   TRISC = 0b00000000;

   OPTION_REG.T0CS = 0;  //BIT 5 Fonte de referência - CLK Interno
   OPTION_REG.T0SE = 0;  //BIT 4 Transição do Timer0 Borda subida
   OPTION_REG.PSA = 0;   //BIT 3 Seleciona o Prescaler parao T0
   OPTION_REG.PS2 = 0;
   OPTION_REG.PS1 = 1;
   OPTION_REG.PS0 = 1;   //BIT 2-0 Taxa de divisão PESCALER 011 (1:16)
   TMR0 = 131;                    //Inicia o contador do T0 com 131

   INTCON = 0b00000000;   //Limpa o registro de controle de Interrupção
   INTCON.TMR0IE = 1;     //BIT 5 Habilita interrupção do T0 Overflow
   INTCON.TMR0IF = 0;     //BIT 2 Limpa o indicador de interrupção do T0
   INTCON.GIE = 1;             //BIT 7 Habilita interrupção Global

   PORTD = const_7seg[contagem1];  //Inicializa com o display em zero
   PORTC = const_7seg[contagem2];

   for(;;)  //Laço sem fim do programa principal
   {
   }
}