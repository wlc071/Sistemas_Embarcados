
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;R3_P3.c,13 :: 		void interrupt()
;R3_P3.c,15 :: 		if (INTCON.TMR0IF == 1) //Interrupção gerada a cada 1 ms
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;R3_P3.c,17 :: 		if (sel_display == 4)
	MOVF       _sel_display+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;R3_P3.c,19 :: 		PORTC = 0B11110111; // Seleciona display 1 (unidade)
	MOVLW      247
	MOVWF      PORTC+0
;R3_P3.c,20 :: 		PORTB = const_7seg[cont_un];
	MOVF       _cont_un+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;R3_P3.c,21 :: 		sel_display = 3;
	MOVLW      3
	MOVWF      _sel_display+0
;R3_P3.c,22 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;R3_P3.c,25 :: 		if (sel_display == 3)
	MOVF       _sel_display+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;R3_P3.c,27 :: 		PORTC = 0B11111011;  // Selec. display 2 (dezena)
	MOVLW      251
	MOVWF      PORTC+0
;R3_P3.c,28 :: 		PORTB = const_7seg[cont_dz];
	MOVF       _cont_dz+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;R3_P3.c,29 :: 		sel_display = 2;
	MOVLW      2
	MOVWF      _sel_display+0
;R3_P3.c,30 :: 		}
	GOTO       L_interrupt4
L_interrupt3:
;R3_P3.c,33 :: 		if (sel_display == 2)
	MOVF       _sel_display+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;R3_P3.c,35 :: 		PORTC = 0B11111101;  // Selec. display 3 (Centena)
	MOVLW      253
	MOVWF      PORTC+0
;R3_P3.c,36 :: 		PORTB = const_7seg[cont_ct];
	MOVF       _cont_ct+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;R3_P3.c,37 :: 		sel_display = 1;
	MOVLW      1
	MOVWF      _sel_display+0
;R3_P3.c,38 :: 		}
	GOTO       L_interrupt6
L_interrupt5:
;R3_P3.c,41 :: 		PORTC = 0B11111110;  // Selec. display 4 (Milhar)
	MOVLW      254
	MOVWF      PORTC+0
;R3_P3.c,42 :: 		PORTB = const_7seg[cont_ml];
	MOVF       _cont_ml+0, 0
	ADDLW      _const_7seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;R3_P3.c,43 :: 		sel_display = 4;
	MOVLW      4
	MOVWF      _sel_display+0
;R3_P3.c,44 :: 		}
L_interrupt6:
;R3_P3.c,45 :: 		}
L_interrupt4:
;R3_P3.c,46 :: 		}
L_interrupt2:
;R3_P3.c,47 :: 		aux_tempo++;
	INCF       _aux_tempo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_tempo+1, 1
;R3_P3.c,48 :: 		aux_tempo2++;
	INCF       _aux_tempo2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_tempo2+1, 1
;R3_P3.c,50 :: 		if (aux_tempo == 250) //Passou 250ms??
	MOVLW      0
	XORWF      _aux_tempo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt30
	MOVLW      250
	XORWF      _aux_tempo+0, 0
L__interrupt30:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;R3_P3.c,52 :: 		aux_tempo = 0;
	CLRF       _aux_tempo+0
	CLRF       _aux_tempo+1
;R3_P3.c,53 :: 		fim_250ms = 1;
	BSF        _fim_250ms+0, BitPos(_fim_250ms+0)
;R3_P3.c,54 :: 		}
L_interrupt7:
;R3_P3.c,55 :: 		if (aux_tempo2 == 125)
	MOVLW      0
	XORWF      _aux_tempo2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt31
	MOVLW      125
	XORWF      _aux_tempo2+0, 0
L__interrupt31:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
;R3_P3.c,57 :: 		aux_tempo2 = 0;
	CLRF       _aux_tempo2+0
	CLRF       _aux_tempo2+1
;R3_P3.c,58 :: 		fim_1s = 1;
	BSF        _fim_1s+0, BitPos(_fim_1s+0)
;R3_P3.c,59 :: 		}
L_interrupt8:
;R3_P3.c,62 :: 		INTCON.TMR0IF = 0;  //Restaura o sinalizador de interrupção por T0
	BCF        INTCON+0, 2
;R3_P3.c,63 :: 		INTCON.TMR0IE = 1;  //Habilita novamente a interrupção
	BSF        INTCON+0, 5
;R3_P3.c,64 :: 		TMR0 = 131;                  //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;R3_P3.c,65 :: 		}
L_interrupt0:
;R3_P3.c,66 :: 		}
L_end_interrupt:
L__interrupt29:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;R3_P3.c,68 :: 		void main()
;R3_P3.c,70 :: 		ADCON1 = 0b00000110;
	MOVLW      6
	MOVWF      ADCON1+0
;R3_P3.c,71 :: 		TRISA = 0b11111101;
	MOVLW      253
	MOVWF      TRISA+0
;R3_P3.c,72 :: 		TRISC = 0b00000000;  //Configura todo o PORTC como saída
	CLRF       TRISC+0
;R3_P3.c,73 :: 		TRISB = 0b00000000;  //Configura todo o PORTB como saída
	CLRF       TRISB+0
;R3_P3.c,75 :: 		OPTION_REG.T0CS = 0;  //BIT 5 Fonte de referência - CLK Interno
	BCF        OPTION_REG+0, 5
;R3_P3.c,76 :: 		OPTION_REG.T0SE = 0;  //BIT 4 Transição do Timer0 Borda subida
	BCF        OPTION_REG+0, 4
;R3_P3.c,77 :: 		OPTION_REG.PSA = 0;    //BIT 3 Seleciona o Prescaler parao T0
	BCF        OPTION_REG+0, 3
;R3_P3.c,78 :: 		OPTION_REG.PS2 = 0;
	BCF        OPTION_REG+0, 2
;R3_P3.c,79 :: 		OPTION_REG.PS1 = 1;
	BSF        OPTION_REG+0, 1
;R3_P3.c,80 :: 		OPTION_REG.PS0 = 0;   //BIT 2-0 Taxa de divisão PESCALER 011 (1:8)
	BCF        OPTION_REG+0, 0
;R3_P3.c,81 :: 		TMR0 = 131;                    //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;R3_P3.c,83 :: 		INTCON = 0b00000000;  //Limpa o registro de controle de Interrupção
	CLRF       INTCON+0
;R3_P3.c,84 :: 		INTCON.TMR0IE = 1;    //BIT 5 Habilita interrupção do T0 Overflow
	BSF        INTCON+0, 5
;R3_P3.c,85 :: 		INTCON.TMR0IF = 0;    //BIT 2 Limpa o indicador de interrupção por TMR0
	BCF        INTCON+0, 2
;R3_P3.c,86 :: 		INTCON.GIE = 1;            //BIT 7 Habilita interrupção Global
	BSF        INTCON+0, 7
;R3_P3.c,88 :: 		PORTB = const_7seg[0]; //Inicializa com o display em zero
	MOVF       _const_7seg+0, 0
	MOVWF      PORTB+0
;R3_P3.c,89 :: 		PORTC = 0B11111110;   //Zera milhar
	MOVLW      254
	MOVWF      PORTC+0
;R3_P3.c,90 :: 		PORTC = 0B11111101;   //Zera centena
	MOVLW      253
	MOVWF      PORTC+0
;R3_P3.c,91 :: 		PORTC = 0B11111011;   //Zera dezena
	MOVLW      251
	MOVWF      PORTC+0
;R3_P3.c,92 :: 		PORTC = 0B11110111;   //Zera unidade
	MOVLW      247
	MOVWF      PORTC+0
;R3_P3.c,94 :: 		PORTA.RA1 = 0;
	BCF        PORTA+0, 1
;R3_P3.c,95 :: 		fg_bt0 = 0;
	BCF        _fg_bt0+0, BitPos(_fg_bt0+0)
;R3_P3.c,98 :: 		for(;;) //Laço sem fim do programa principal
L_main9:
;R3_P3.c,100 :: 		if (fim_250ms)
	BTFSS      _fim_250ms+0, BitPos(_fim_250ms+0)
	GOTO       L_main12
;R3_P3.c,102 :: 		fim_250ms = 0;
	BCF        _fim_250ms+0, BitPos(_fim_250ms+0)
;R3_P3.c,103 :: 		cont_un++;
	INCF       _cont_un+0, 1
;R3_P3.c,104 :: 		if (cont_un > 9)
	MOVLW      128
	XORLW      9
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont_un+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;R3_P3.c,106 :: 		cont_un = 0;
	CLRF       _cont_un+0
;R3_P3.c,107 :: 		cont_dz++;
	INCF       _cont_dz+0, 1
;R3_P3.c,108 :: 		if (cont_dz > 9)
	MOVLW      128
	XORLW      9
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont_dz+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;R3_P3.c,110 :: 		cont_dz = 0;
	CLRF       _cont_dz+0
;R3_P3.c,111 :: 		cont_ct++;
	INCF       _cont_ct+0, 1
;R3_P3.c,112 :: 		if (cont_ct > 9)
	MOVLW      128
	XORLW      9
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont_ct+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;R3_P3.c,114 :: 		cont_ct = 0;
	CLRF       _cont_ct+0
;R3_P3.c,115 :: 		cont_ml++;
	INCF       _cont_ml+0, 1
;R3_P3.c,116 :: 		if (cont_ml > 9) cont_ml = 0;
	MOVLW      128
	XORLW      9
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont_ml+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main16
	CLRF       _cont_ml+0
L_main16:
;R3_P3.c,117 :: 		}
L_main15:
;R3_P3.c,118 :: 		}
L_main14:
;R3_P3.c,119 :: 		}
L_main13:
;R3_P3.c,120 :: 		}
L_main12:
;R3_P3.c,121 :: 		if((RA0_bit == 0) && (fg_bt0 == 0)){
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main19
	BTFSC      _fg_bt0+0, BitPos(_fg_bt0+0)
	GOTO       L_main19
L__main27:
;R3_P3.c,122 :: 		cont_un = 0;
	CLRF       _cont_un+0
;R3_P3.c,123 :: 		cont_dz = 0;
	CLRF       _cont_dz+0
;R3_P3.c,124 :: 		cont_ct = 0;
	CLRF       _cont_ct+0
;R3_P3.c,125 :: 		cont_ml = 0;
	CLRF       _cont_ml+0
;R3_P3.c,126 :: 		fg_bt0 = 1;
	BSF        _fg_bt0+0, BitPos(_fg_bt0+0)
;R3_P3.c,127 :: 		}
L_main19:
;R3_P3.c,128 :: 		if((RA0_bit == 1) && (fg_bt0 == 1))fg_bt0 = 0;
	BTFSS      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main22
	BTFSS      _fg_bt0+0, BitPos(_fg_bt0+0)
	GOTO       L_main22
L__main26:
	BCF        _fg_bt0+0, BitPos(_fg_bt0+0)
L_main22:
;R3_P3.c,130 :: 		if (fim_1s){
	BTFSS      _fim_1s+0, BitPos(_fim_1s+0)
	GOTO       L_main23
;R3_P3.c,131 :: 		fim_1s = 0;
	BCF        _fim_1s+0, BitPos(_fim_1s+0)
;R3_P3.c,132 :: 		if (PORTA.RA1  == 1) PORTA.RA1  = 0;
	BTFSS      PORTA+0, 1
	GOTO       L_main24
	BCF        PORTA+0, 1
	GOTO       L_main25
L_main24:
;R3_P3.c,133 :: 		else PORTA.RA1  = 1;
	BSF        PORTA+0, 1
L_main25:
;R3_P3.c,134 :: 		}
L_main23:
;R3_P3.c,138 :: 		}
	GOTO       L_main9
;R3_P3.c,139 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
