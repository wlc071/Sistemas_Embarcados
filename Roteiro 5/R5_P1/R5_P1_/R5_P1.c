unsigned int adc_AN0 = 0;

void main()
{
   TRISA = 0xFF;    //Conf.todos os pinos do PORTA c/ entrada
   TRISB = 0x00;    //Conf.todos os pinos do PORTB c/ saída
   TRISC = 0x00;    //Conf.todos os pinos do PORTC c/ saída

   //Configurando o Clock do Conversor A/D (Fosc / 2)
   ADCON0.ADCS0 = 0;
   ADCON0.ADCS1 = 0;
   ADCON1.ADCS2 = 0;

   //Selecionando o canal a ser convertido (AN0)
   ADCON0.CHS0 = 0;
   ADCON0.CHS1 = 0;
   ADCON0.CHS2 = 0;

   //Habilita o módulo A/D
   ADCON0.ADON = 1;

   //Seleciona o formato do resultado - Justificado a Esquerda
   ADCON1.ADFM = 0;

   //Controle de configuração das portas - Analógicas ou Digitais
   ADCON1.PCFG0 = 0;
   ADCON1.PCFG1 = 1;
   ADCON1.PCFG2 = 1;
   ADCON1.PCFG3 = 1;

  //Modo de operação do comparador - Desligados (111)
   CMCON.CM0 = 1;
   CMCON.CM1 = 1;
   CMCON.CM2 = 1;

  //Inicializa o módulo conversor A/D
   ADC_Init();

   //Inicializando
   PORTB = 0X00;
   PORTC = 0X00;

  while(1)
  {
    adc_AN0 = ADC_Get_Sample(0); //Lê o valor da porta AN0
    PORTB = adc_AN0;
    PORTC = adc_AN0 >> 8;
  }
}