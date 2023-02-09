
_main:

;R5_P1.c,3 :: 		void main()
;R5_P1.c,5 :: 		TRISA = 0xFF;    //Conf.todos os pinos do PORTA c/ entrada
	MOVLW      255
	MOVWF      TRISA+0
;R5_P1.c,6 :: 		TRISB = 0x00;    //Conf.todos os pinos do PORTB c/ saída
	CLRF       TRISB+0
;R5_P1.c,7 :: 		TRISC = 0x00;    //Conf.todos os pinos do PORTC c/ saída
	CLRF       TRISC+0
;R5_P1.c,10 :: 		ADCON0.ADCS0 = 0;
	BCF        ADCON0+0, 6
;R5_P1.c,11 :: 		ADCON0.ADCS1 = 0;
	BCF        ADCON0+0, 7
;R5_P1.c,12 :: 		ADCON1.ADCS2 = 0;
	BCF        ADCON1+0, 6
;R5_P1.c,15 :: 		ADCON0.CHS0 = 0;
	BCF        ADCON0+0, 3
;R5_P1.c,16 :: 		ADCON0.CHS1 = 0;
	BCF        ADCON0+0, 4
;R5_P1.c,17 :: 		ADCON0.CHS2 = 0;
	BCF        ADCON0+0, 5
;R5_P1.c,20 :: 		ADCON0.ADON = 1;
	BSF        ADCON0+0, 0
;R5_P1.c,23 :: 		ADCON1.ADFM = 0;
	BCF        ADCON1+0, 7
;R5_P1.c,26 :: 		ADCON1.PCFG0 = 0;
	BCF        ADCON1+0, 0
;R5_P1.c,27 :: 		ADCON1.PCFG1 = 1;
	BSF        ADCON1+0, 1
;R5_P1.c,28 :: 		ADCON1.PCFG2 = 1;
	BSF        ADCON1+0, 2
;R5_P1.c,29 :: 		ADCON1.PCFG3 = 1;
	BSF        ADCON1+0, 3
;R5_P1.c,32 :: 		CMCON.CM0 = 1;
	BSF        CMCON+0, 0
;R5_P1.c,33 :: 		CMCON.CM1 = 1;
	BSF        CMCON+0, 1
;R5_P1.c,34 :: 		CMCON.CM2 = 1;
	BSF        CMCON+0, 2
;R5_P1.c,37 :: 		ADC_Init();
	CALL       _ADC_Init+0
;R5_P1.c,40 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;R5_P1.c,41 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;R5_P1.c,43 :: 		while(1)
L_main0:
;R5_P1.c,45 :: 		adc_AN0 = ADC_Get_Sample(0); //Lê o valor da porta AN0
	CLRF       FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       R0+0, 0
	MOVWF      _adc_AN0+0
	MOVF       R0+1, 0
	MOVWF      _adc_AN0+1
;R5_P1.c,46 :: 		PORTB = adc_AN0;
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;R5_P1.c,47 :: 		PORTC = adc_AN0 >> 8;
	MOVF       R0+1, 0
	MOVWF      R2+0
	CLRF       R2+1
	MOVF       R2+0, 0
	MOVWF      PORTC+0
;R5_P1.c,48 :: 		}
	GOTO       L_main0
;R5_P1.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
