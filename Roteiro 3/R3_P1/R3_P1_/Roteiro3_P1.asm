
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Roteiro3_P1.c,5 :: 		void interrupt()
;Roteiro3_P1.c,7 :: 		if (INTCON.TMR0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Roteiro3_P1.c,9 :: 		aux_tempo++;
	INCF       _aux_tempo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_tempo+1, 1
;Roteiro3_P1.c,10 :: 		if (aux_tempo == 500)
	MOVF       _aux_tempo+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVLW      244
	XORWF      _aux_tempo+0, 0
L__interrupt8:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Roteiro3_P1.c,12 :: 		aux_tempo = 0;
	CLRF       _aux_tempo+0
	CLRF       _aux_tempo+1
;Roteiro3_P1.c,13 :: 		contagem++;
	INCF       _contagem+0, 1
	BTFSC      STATUS+0, 2
	INCF       _contagem+1, 1
;Roteiro3_P1.c,14 :: 		if (contagem > 9) contagem = 0;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _contagem+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt9
	MOVF       _contagem+0, 0
	SUBLW      9
L__interrupt9:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt2
	CLRF       _contagem+0
	CLRF       _contagem+1
L_interrupt2:
;Roteiro3_P1.c,15 :: 		PORTD = const_7seg[contagem];
	MOVF       _contagem+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Roteiro3_P1.c,16 :: 		}
L_interrupt1:
;Roteiro3_P1.c,17 :: 		INTCON.TMR0IF = 0;   //Restaura o sinalizador de interrupção por T0
	BCF        INTCON+0, 2
;Roteiro3_P1.c,18 :: 		INTCON.TMR0IE = 1;   //Habilita novamente a interrupção
	BSF        INTCON+0, 5
;Roteiro3_P1.c,19 :: 		TMR0 = 131;                   //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;Roteiro3_P1.c,20 :: 		}
L_interrupt0:
;Roteiro3_P1.c,21 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Roteiro3_P1.c,23 :: 		void main()
;Roteiro3_P1.c,25 :: 		TRISA = 0b11111111;      //Configura todo o PORTA como entrada
	MOVLW      255
	MOVWF      TRISA+0
;Roteiro3_P1.c,26 :: 		TRISD = 0b00000000;      //Configura todo o PORTD como saída
	CLRF       TRISD+0
;Roteiro3_P1.c,28 :: 		OPTION_REG.T0CS = 0;  //BIT 5 Fonte de referência - CLK Interno
	BCF        OPTION_REG+0, 5
;Roteiro3_P1.c,29 :: 		OPTION_REG.T0SE = 0;  //BIT 4 Transição do Timer0 Borda subida
	BCF        OPTION_REG+0, 4
;Roteiro3_P1.c,30 :: 		OPTION_REG.PSA = 0;   //BIT 3 Seleciona o Prescaler parao T0
	BCF        OPTION_REG+0, 3
;Roteiro3_P1.c,31 :: 		OPTION_REG.PS2 = 0;
	BCF        OPTION_REG+0, 2
;Roteiro3_P1.c,32 :: 		OPTION_REG.PS1 = 1;
	BSF        OPTION_REG+0, 1
;Roteiro3_P1.c,33 :: 		OPTION_REG.PS0 = 1;   //BIT 2-0 Taxa de divisão PESCALER 011 (1:16)
	BSF        OPTION_REG+0, 0
;Roteiro3_P1.c,34 :: 		TMR0 = 131;                    //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;Roteiro3_P1.c,36 :: 		INTCON = 0b00000000;   //Limpa o registro de controle de Interrupção
	CLRF       INTCON+0
;Roteiro3_P1.c,37 :: 		INTCON.TMR0IE = 1;     //BIT 5 Habilita interrupção do T0 Overflow
	BSF        INTCON+0, 5
;Roteiro3_P1.c,38 :: 		INTCON.TMR0IF = 0;     //BIT 2 Limpa o indicador de interrupção do T0
	BCF        INTCON+0, 2
;Roteiro3_P1.c,39 :: 		INTCON.GIE = 1;             //BIT 7 Habilita interrupção Global
	BSF        INTCON+0, 7
;Roteiro3_P1.c,41 :: 		PORTD = const_7seg[contagem];  //Inicializa com o display em zero
	MOVF       _contagem+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Roteiro3_P1.c,43 :: 		for(;;)  //Laço sem fim do programa principal
L_main3:
;Roteiro3_P1.c,45 :: 		}
	GOTO       L_main3
;Roteiro3_P1.c,46 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
