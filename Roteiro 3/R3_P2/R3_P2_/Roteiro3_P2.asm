
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Roteiro3_P2.c,6 :: 		void interrupt()
;Roteiro3_P2.c,8 :: 		if (INTCON.TMR0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Roteiro3_P2.c,10 :: 		aux_tempo++;
	INCF       _aux_tempo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_tempo+1, 1
;Roteiro3_P2.c,11 :: 		if (aux_tempo == 125)
	MOVLW      0
	XORWF      _aux_tempo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt9
	MOVLW      125
	XORWF      _aux_tempo+0, 0
L__interrupt9:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Roteiro3_P2.c,13 :: 		aux_tempo = 0;
	CLRF       _aux_tempo+0
	CLRF       _aux_tempo+1
;Roteiro3_P2.c,14 :: 		contagem1++;
	INCF       _contagem1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _contagem1+1, 1
;Roteiro3_P2.c,15 :: 		if (contagem1 > 9) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _contagem1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt10
	MOVF       _contagem1+0, 0
	SUBLW      9
L__interrupt10:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt2
;Roteiro3_P2.c,16 :: 		contagem1 = 0;
	CLRF       _contagem1+0
	CLRF       _contagem1+1
;Roteiro3_P2.c,17 :: 		contagem2++;
	INCF       _contagem2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _contagem2+1, 1
;Roteiro3_P2.c,18 :: 		if (contagem2 > 9) contagem2 = 0;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _contagem2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt11
	MOVF       _contagem2+0, 0
	SUBLW      9
L__interrupt11:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
	CLRF       _contagem2+0
	CLRF       _contagem2+1
L_interrupt3:
;Roteiro3_P2.c,19 :: 		};
L_interrupt2:
;Roteiro3_P2.c,20 :: 		PORTD = const_7seg[contagem1];
	MOVF       _contagem1+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Roteiro3_P2.c,21 :: 		PORTC = const_7seg[contagem2];
	MOVF       _contagem2+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Roteiro3_P2.c,22 :: 		}
L_interrupt1:
;Roteiro3_P2.c,23 :: 		INTCON.TMR0IF = 0;   //Restaura o sinalizador de interrupção por T0
	BCF        INTCON+0, 2
;Roteiro3_P2.c,24 :: 		INTCON.TMR0IE = 1;   //Habilita novamente a interrupção
	BSF        INTCON+0, 5
;Roteiro3_P2.c,25 :: 		TMR0 = 131;                   //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;Roteiro3_P2.c,26 :: 		}
L_interrupt0:
;Roteiro3_P2.c,27 :: 		}
L_end_interrupt:
L__interrupt8:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Roteiro3_P2.c,29 :: 		void main()
;Roteiro3_P2.c,31 :: 		TRISA = 0b11111111;      //Configura todo o PORTA como entrada
	MOVLW      255
	MOVWF      TRISA+0
;Roteiro3_P2.c,32 :: 		TRISD = 0b00000000;      //Configura todo o PORTD como saída
	CLRF       TRISD+0
;Roteiro3_P2.c,33 :: 		TRISC = 0b00000000;
	CLRF       TRISC+0
;Roteiro3_P2.c,35 :: 		OPTION_REG.T0CS = 0;  //BIT 5 Fonte de referência - CLK Interno
	BCF        OPTION_REG+0, 5
;Roteiro3_P2.c,36 :: 		OPTION_REG.T0SE = 0;  //BIT 4 Transição do Timer0 Borda subida
	BCF        OPTION_REG+0, 4
;Roteiro3_P2.c,37 :: 		OPTION_REG.PSA = 0;   //BIT 3 Seleciona o Prescaler parao T0
	BCF        OPTION_REG+0, 3
;Roteiro3_P2.c,38 :: 		OPTION_REG.PS2 = 0;
	BCF        OPTION_REG+0, 2
;Roteiro3_P2.c,39 :: 		OPTION_REG.PS1 = 1;
	BSF        OPTION_REG+0, 1
;Roteiro3_P2.c,40 :: 		OPTION_REG.PS0 = 1;   //BIT 2-0 Taxa de divisão PESCALER 011 (1:16)
	BSF        OPTION_REG+0, 0
;Roteiro3_P2.c,41 :: 		TMR0 = 131;                    //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;Roteiro3_P2.c,43 :: 		INTCON = 0b00000000;   //Limpa o registro de controle de Interrupção
	CLRF       INTCON+0
;Roteiro3_P2.c,44 :: 		INTCON.TMR0IE = 1;     //BIT 5 Habilita interrupção do T0 Overflow
	BSF        INTCON+0, 5
;Roteiro3_P2.c,45 :: 		INTCON.TMR0IF = 0;     //BIT 2 Limpa o indicador de interrupção do T0
	BCF        INTCON+0, 2
;Roteiro3_P2.c,46 :: 		INTCON.GIE = 1;             //BIT 7 Habilita interrupção Global
	BSF        INTCON+0, 7
;Roteiro3_P2.c,48 :: 		PORTD = const_7seg[contagem1];  //Inicializa com o display em zero
	MOVF       _contagem1+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Roteiro3_P2.c,49 :: 		PORTC = const_7seg[contagem2];
	MOVF       _contagem2+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Roteiro3_P2.c,51 :: 		for(;;)  //Laço sem fim do programa principal
L_main4:
;Roteiro3_P2.c,53 :: 		}
	GOTO       L_main4
;Roteiro3_P2.c,54 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
