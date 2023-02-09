
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Roteiro7_1.c,8 :: 		void interrupt() //Interrupção chamada a cada 25us
;Roteiro7_1.c,10 :: 		if (INTCON.TMR0IF == 1)  //Verifica se foi inter. por TMR0
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Roteiro7_1.c,12 :: 		aux_timer0++;     //Incrementa 1 unidade a cada 10ms
	INCF       _aux_timer0+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_timer0+1, 1
;Roteiro7_1.c,13 :: 		if(aux_timer0 == 500) //Passou 500ms?
	MOVF       _aux_timer0+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt16
	MOVLW      244
	XORWF      _aux_timer0+0, 0
L__interrupt16:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Roteiro7_1.c,15 :: 		flagSerial = 1;
	BSF        _flagSerial+0, BitPos(_flagSerial+0)
;Roteiro7_1.c,16 :: 		aux_timer0 = 0;
	CLRF       _aux_timer0+0
	CLRF       _aux_timer0+1
;Roteiro7_1.c,17 :: 		RC2_bit = ~ RC2_bit;
	MOVLW
	XORWF      RC2_bit+0, 1
;Roteiro7_1.c,18 :: 		}
L_interrupt1:
;Roteiro7_1.c,19 :: 		INTCON.TMR0IF = 0;   // Limpa o sinalizador
	BCF        INTCON+0, 2
;Roteiro7_1.c,20 :: 		INTCON.TMR0IE = 1;  // Habilita novamente a Interrupção
	BSF        INTCON+0, 5
;Roteiro7_1.c,21 :: 		TMR0 = 6;          // Inicia o contador Timer0 no valor 6
	MOVLW      6
	MOVWF      TMR0+0
;Roteiro7_1.c,22 :: 		}
L_interrupt0:
;Roteiro7_1.c,23 :: 		}
L_end_interrupt:
L__interrupt15:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Roteiro7_1.c,26 :: 		void main()
;Roteiro7_1.c,28 :: 		TRISA = 0xFF;    //Config.todos os pinos do PORTA c/ entrada
	MOVLW      255
	MOVWF      TRISA+0
;Roteiro7_1.c,29 :: 		TRISC = 0X00;   //Configura todos   pinos do PORTC c/ saídas
	CLRF       TRISC+0
;Roteiro7_1.c,32 :: 		ADCON0.ADCS0 = 0;
	BCF        ADCON0+0, 6
;Roteiro7_1.c,33 :: 		ADCON0.ADCS1 = 0;
	BCF        ADCON0+0, 7
;Roteiro7_1.c,34 :: 		ADCON1.ADCS2 = 0;
	BCF        ADCON1+0, 6
;Roteiro7_1.c,37 :: 		ADCON0.CHS0 = 0;
	BCF        ADCON0+0, 3
;Roteiro7_1.c,38 :: 		ADCON0.CHS1 = 0;
	BCF        ADCON0+0, 4
;Roteiro7_1.c,39 :: 		ADCON0.CHS2 = 0;
	BCF        ADCON0+0, 5
;Roteiro7_1.c,42 :: 		ADCON0.ADON = 1;
	BSF        ADCON0+0, 0
;Roteiro7_1.c,45 :: 		ADCON1.ADFM = 0;
	BCF        ADCON1+0, 7
;Roteiro7_1.c,48 :: 		ADCON1.PCFG0 = 0;
	BCF        ADCON1+0, 0
;Roteiro7_1.c,49 :: 		ADCON1.PCFG1 = 1;
	BSF        ADCON1+0, 1
;Roteiro7_1.c,50 :: 		ADCON1.PCFG2 = 1;
	BSF        ADCON1+0, 2
;Roteiro7_1.c,51 :: 		ADCON1.PCFG3 = 1;
	BSF        ADCON1+0, 3
;Roteiro7_1.c,54 :: 		CMCON.CM0 = 1;
	BSF        CMCON+0, 0
;Roteiro7_1.c,55 :: 		CMCON.CM1 = 1;
	BSF        CMCON+0, 1
;Roteiro7_1.c,56 :: 		CMCON.CM2 = 1;
	BSF        CMCON+0, 2
;Roteiro7_1.c,59 :: 		OPTION_REG.T0CS = 0; // bit 5 Fonte de referência - Clock Interno
	BCF        OPTION_REG+0, 5
;Roteiro7_1.c,60 :: 		OPTION_REG.T0SE = 0; // bit 4 Transição do Timer0 biaxa-para-alta
	BCF        OPTION_REG+0, 4
;Roteiro7_1.c,61 :: 		OPTION_REG.PSA = 0;  // bit 3 Seleciona o Prescaler para o Timer0
	BCF        OPTION_REG+0, 3
;Roteiro7_1.c,62 :: 		OPTION_REG.PS2 = 1;  // -----------------------------------------
	BSF        OPTION_REG+0, 2
;Roteiro7_1.c,63 :: 		OPTION_REG.PS1 = 0;  // bits 2-0 PS2:PS0: TaxaPrescaler 101 (1:64)
	BCF        OPTION_REG+0, 1
;Roteiro7_1.c,64 :: 		OPTION_REG.PS0 = 1;  // -----------------------------------------
	BSF        OPTION_REG+0, 0
;Roteiro7_1.c,65 :: 		TMR0 = 6;                       // Inicia o contador Timer0 no valor 6
	MOVLW      6
	MOVWF      TMR0+0
;Roteiro7_1.c,68 :: 		INTCON = 0;         // Limpa o registro de controle de Interrupção
	CLRF       INTCON+0
;Roteiro7_1.c,69 :: 		INTCON.TMR0IE = 1;  // bit5 Habilita Interrupção d Timer0 Overflow
	BSF        INTCON+0, 5
;Roteiro7_1.c,70 :: 		INTCON.TMR0IF = 0;  // bit2 Limpa sinalizador d Interrupção timer0
	BCF        INTCON+0, 2
;Roteiro7_1.c,71 :: 		INTCON.GIE = 1;     // bit7 Habilita Interrupção Global
	BSF        INTCON+0, 7
;Roteiro7_1.c,73 :: 		UART1_Init(9600);     // Inicializa módulo Serial UART em 9600 bps
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Roteiro7_1.c,74 :: 		Delay_ms(100);          // Aguarda a estabilização do módulo UART
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;Roteiro7_1.c,76 :: 		TRISB= 0b1111111;  //Configura todo o PORTB como saída
	MOVLW      127
	MOVWF      TRISB+0
;Roteiro7_1.c,77 :: 		RB0_bit = 0;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;Roteiro7_1.c,80 :: 		while(1)
L_main3:
;Roteiro7_1.c,82 :: 		if(flagSerial == 1)
	BTFSS      _flagSerial+0, BitPos(_flagSerial+0)
	GOTO       L_main5
;Roteiro7_1.c,84 :: 		flagSerial = 0;
	BCF        _flagSerial+0, BitPos(_flagSerial+0)
;Roteiro7_1.c,86 :: 		if((RB0_bit == 0) && (fg_bt == 0)){
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main8
	BTFSC      _fg_bt+0, BitPos(_fg_bt+0)
	GOTO       L_main8
L__main13:
;Roteiro7_1.c,87 :: 		cont = cont + 1;
	INCF       _cont+0, 1
;Roteiro7_1.c,88 :: 		fg_bt=1;
	BSF        _fg_bt+0, BitPos(_fg_bt+0)
;Roteiro7_1.c,89 :: 		}
L_main8:
;Roteiro7_1.c,90 :: 		if((RB0_bit == 1) && (fg_bt == 1)){
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main11
	BTFSS      _fg_bt+0, BitPos(_fg_bt+0)
	GOTO       L_main11
L__main12:
;Roteiro7_1.c,91 :: 		fg_bt=0;
	BCF        _fg_bt+0, BitPos(_fg_bt+0)
;Roteiro7_1.c,92 :: 		}
L_main11:
;Roteiro7_1.c,93 :: 		adc_AN0 = ADC_Read(0); //Lê o valor da porta AN0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_AN0+0
	MOVF       R0+1, 0
	MOVWF      _adc_AN0+1
;Roteiro7_1.c,95 :: 		IntToStr(adc_AN0, cont);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVF       _cont+0, 0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Roteiro7_1.c,98 :: 		UART1_Write_Text(cont);  // Envia os dados via UART
	MOVF       _cont+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Roteiro7_1.c,101 :: 		UART1_Write(13);  UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Roteiro7_1.c,102 :: 		}
L_main5:
;Roteiro7_1.c,103 :: 		}
	GOTO       L_main3
;Roteiro7_1.c,104 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
