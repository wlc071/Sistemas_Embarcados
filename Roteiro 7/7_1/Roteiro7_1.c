bit flagSerial;
unsigned int aux_timer0, adc_AN0, luminosidade;
char text_serial[5];
bit fg_bt ;
short cont = 0;

//--------------------------------------------------------------
void interrupt() //Interrupção chamada a cada 25us
{
   if (INTCON.TMR0IF == 1)  //Verifica se foi inter. por TMR0
   {
      aux_timer0++;     //Incrementa 1 unidade a cada 10ms
      if(aux_timer0 == 500) //Passou 500ms?
      {
         flagSerial = 1;
         aux_timer0 = 0;
         RC2_bit = ~ RC2_bit;
      }
      INTCON.TMR0IF = 0;   // Limpa o sinalizador
      INTCON.TMR0IE = 1;  // Habilita novamente a Interrupção
      TMR0 = 6;          // Inicia o contador Timer0 no valor 6
   }
}
//---------------------------------------------------------------

void main()
{
   TRISA = 0xFF;    //Config.todos os pinos do PORTA c/ entrada
   TRISC = 0X00;   //Configura todos   pinos do PORTC c/ saídas

   //Configurando o Clock do Conversor A/D (Freq.oscilador / 2)
   ADCON0.ADCS0 = 0;
   ADCON0.ADCS1 = 0;
   ADCON1.ADCS2 = 0;

   //Selecionando o  canal a ser  convertido (AN0) - PORTA RA0
   ADCON0.CHS0 = 0;
   ADCON0.CHS1 = 0;
   ADCON0.CHS2 = 0;

   //Habilita o  módulo Analogico/Digital do  Microcontrolador
   ADCON0.ADON = 1;

   //Seleciona o formato do resultado - Justificado a Esquerda
   ADCON1.ADFM = 0;

   //Controle configuração das portas - Analógicas ou Digitais
   ADCON1.PCFG0 = 0;
   ADCON1.PCFG1 = 1;
   ADCON1.PCFG2 = 1;
   ADCON1.PCFG3 = 1;

  //Modo de operação do comparador - Desligados (111)
   CMCON.CM0 = 1;
   CMCON.CM1 = 1;
   CMCON.CM2 = 1;

   // Interrupcao  do Timer0:  Configuração do  Registro Option_ Reg
   OPTION_REG.T0CS = 0; // bit 5 Fonte de referência - Clock Interno
   OPTION_REG.T0SE = 0; // bit 4 Transição do Timer0 biaxa-para-alta
   OPTION_REG.PSA = 0;  // bit 3 Seleciona o Prescaler para o Timer0
   OPTION_REG.PS2 = 1;  // -----------------------------------------
   OPTION_REG.PS1 = 0;  // bits 2-0 PS2:PS0: TaxaPrescaler 101 (1:64)
   OPTION_REG.PS0 = 1;  // -----------------------------------------
   TMR0 = 6;                       // Inicia o contador Timer0 no valor 6

   // Registros de configuração de Interrupções INTCON
   INTCON = 0;         // Limpa o registro de controle de Interrupção
   INTCON.TMR0IE = 1;  // bit5 Habilita Interrupção d Timer0 Overflow
   INTCON.TMR0IF = 0;  // bit2 Limpa sinalizador d Interrupção timer0
   INTCON.GIE = 1;     // bit7 Habilita Interrupção Global

   UART1_Init(9600);     // Inicializa módulo Serial UART em 9600 bps
   Delay_ms(100);          // Aguarda a estabilização do módulo UART

   TRISB= 0b1111111;  //Configura todo o PORTB como saída
   RB0_bit = 0;


   while(1)
   {
      if(flagSerial == 1)
      {
         flagSerial = 0;

         if((RB0_bit == 0) && (fg_bt == 0)){
            cont = cont + 1;
            fg_bt=1;
         }
         if((RB0_bit == 1) && (fg_bt == 1)){
            fg_bt=0;
         }
         adc_AN0 = ADC_Read(0); //Lê o valor da porta AN0
         //IntToStr(adc_AN0, text_serial);
         IntToStr(adc_AN0, cont);
         //UART1_Write_Text("Valor lido AN0:");
         //UART1_Write_Text(text_serial);  // Envia os dados via UART
         UART1_Write_Text(cont);  // Envia os dados via UART
         //Using Carriage return in short "ENTER" key of keyboard whose ASCII value is 13
         //Moves cursor down to the next line without returning to the beginning of the line
         UART1_Write(13);  UART1_Write(13);
      }
   }
}