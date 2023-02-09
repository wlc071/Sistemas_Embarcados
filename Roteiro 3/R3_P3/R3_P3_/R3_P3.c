unsigned char const_7seg[]= {63, 6, 91, 79, 102, 109, 125, 7, 127, 103};
short cont_un = 0;
short cont_dz = 0;
short cont_ct = 0;
short cont_ml = 0;
short sel_display = 1;
int   aux_tempo = 0;
int   aux_tempo2 = 0;
bit   fim_250ms;
bit   fim_1s;
bit   fg_bt0;

void interrupt()
{
   if (INTCON.TMR0IF == 1) //Interrupção gerada a cada 1 ms
   {
      if (sel_display == 4)
      {
         PORTC = 0B11110111; // Seleciona display 1 (unidade)
         PORTB = const_7seg[cont_un];
         sel_display = 3;
      }
      else
      {
        if (sel_display == 3)
        {
            PORTC = 0B11111011;  // Selec. display 2 (dezena)
            PORTB = const_7seg[cont_dz];
            sel_display = 2;
        }
        else
        {
           if (sel_display == 2)
           {
              PORTC = 0B11111101;  // Selec. display 3 (Centena)
              PORTB = const_7seg[cont_ct];
              sel_display = 1;
           }
           else  //display 1
           {
              PORTC = 0B11111110;  // Selec. display 4 (Milhar)
              PORTB = const_7seg[cont_ml];
              sel_display = 4;
           }
         }
      }
      aux_tempo++;
      aux_tempo2++;
      
      if (aux_tempo == 250) //Passou 250ms??
      {
         aux_tempo = 0;
         fim_250ms = 1;
      }
      if (aux_tempo2 == 125)
      {
         aux_tempo2 = 0;
         fim_1s = 1;
      }


      INTCON.TMR0IF = 0;  //Restaura o sinalizador de interrupção por T0
      INTCON.TMR0IE = 1;  //Habilita novamente a interrupção
      TMR0 = 131;                  //Inicia o contador do T0 com 131
   }
}

void main()
{
   ADCON1 = 0b00000110;
   TRISA = 0b11111101;
   TRISC = 0b00000000;  //Configura todo o PORTC como saída
   TRISB = 0b00000000;  //Configura todo o PORTB como saída

   OPTION_REG.T0CS = 0;  //BIT 5 Fonte de referência - CLK Interno
   OPTION_REG.T0SE = 0;  //BIT 4 Transição do Timer0 Borda subida
   OPTION_REG.PSA = 0;    //BIT 3 Seleciona o Prescaler parao T0
   OPTION_REG.PS2 = 0;
   OPTION_REG.PS1 = 1;
   OPTION_REG.PS0 = 0;   //BIT 2-0 Taxa de divisão PESCALER 011 (1:8)
   TMR0 = 131;                    //Inicia o contador do T0 com 131

   INTCON = 0b00000000;  //Limpa o registro de controle de Interrupção
   INTCON.TMR0IE = 1;    //BIT 5 Habilita interrupção do T0 Overflow
   INTCON.TMR0IF = 0;    //BIT 2 Limpa o indicador de interrupção por TMR0
   INTCON.GIE = 1;            //BIT 7 Habilita interrupção Global

   PORTB = const_7seg[0]; //Inicializa com o display em zero
   PORTC = 0B11111110;   //Zera milhar
   PORTC = 0B11111101;   //Zera centena
   PORTC = 0B11111011;   //Zera dezena
   PORTC = 0B11110111;   //Zera unidade
   
   PORTA.RA1 = 0;
   fg_bt0 = 0;
   

   for(;;) //Laço sem fim do programa principal
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
         if (PORTA.RA1  == 1) PORTA.RA1  = 0;
         else PORTA.RA1  = 1;
      }
      

      
   }
}