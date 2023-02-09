
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;R4_P2.c,24 :: 		void interrupt()
;R4_P2.c,26 :: 		if (INTCON.TMR0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;R4_P2.c,28 :: 		aux_tempo++;
	INCF       _aux_tempo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _aux_tempo+1, 1
;R4_P2.c,29 :: 		if (aux_tempo == 125)
	MOVLW      0
	XORWF      _aux_tempo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt28
	MOVLW      125
	XORWF      _aux_tempo+0, 0
L__interrupt28:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;R4_P2.c,31 :: 		aux_tempo = 0;
	CLRF       _aux_tempo+0
	CLRF       _aux_tempo+1
;R4_P2.c,32 :: 		fim_1s = 1;
	BSF        _fim_1s+0, BitPos(_fim_1s+0)
;R4_P2.c,33 :: 		}
L_interrupt1:
;R4_P2.c,34 :: 		INTCON.TMR0IF = 0; //Restaura o sinalizador de interrupção por T0
	BCF        INTCON+0, 2
;R4_P2.c,35 :: 		INTCON.TMR0IE = 1; //Habilita novamente a interrupção
	BSF        INTCON+0, 5
;R4_P2.c,36 :: 		TMR0 = 131;                 //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;R4_P2.c,37 :: 		}
L_interrupt0:
;R4_P2.c,38 :: 		}
L_end_interrupt:
L__interrupt27:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;R4_P2.c,40 :: 		void main()
;R4_P2.c,42 :: 		TRISB = 0x00;                 //Configura a porta B como saída digital
	CLRF       TRISB+0
;R4_P2.c,43 :: 		TRISC = 0x00;                 //Configura a porta C como saída digital
	CLRF       TRISC+0
;R4_P2.c,44 :: 		PORTB = 0;                     //Ao energizar, incializa com 0 no PORTB
	CLRF       PORTB+0
;R4_P2.c,46 :: 		Lcd_Init();                       //Iniciliza o LCD
	CALL       _Lcd_Init+0
;R4_P2.c,47 :: 		Lcd_Cmd(_LCD_CLEAR);                  //Limpa todos os caracteres do LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P2.c,48 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     //Desabilita cursor piscando no LCD
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P2.c,51 :: 		Lcd_Out(1,1,"   Pratica 8   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,52 :: 		Lcd_Out(2,1,"Eng. Computacao");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,53 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;R4_P2.c,54 :: 		for (i=0; i<15; i++)
	CLRF       _i+0
L_main3:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      15
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;R4_P2.c,56 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW      24
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P2.c,57 :: 		Delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;R4_P2.c,54 :: 		for (i=0; i<15; i++)
	INCF       _i+0, 1
;R4_P2.c,58 :: 		}
	GOTO       L_main3
L_main4:
;R4_P2.c,59 :: 		for (i=0; i<15; i++)
	CLRF       _i+0
L_main7:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      15
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main8
;R4_P2.c,61 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P2.c,62 :: 		Delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
;R4_P2.c,59 :: 		for (i=0; i<15; i++)
	INCF       _i+0, 1
;R4_P2.c,63 :: 		}
	GOTO       L_main7
L_main8:
;R4_P2.c,64 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;R4_P2.c,65 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P2.c,66 :: 		Lcd_Out(1,1,"  Sequenciador  ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,68 :: 		OPTION_REG.T0CS = 0;    //BIT 5 Fonte de referência - CLK Interno
	BCF        OPTION_REG+0, 5
;R4_P2.c,69 :: 		OPTION_REG.T0SE = 0;    //BIT 4 Transição do Timer0 Borda subida
	BCF        OPTION_REG+0, 4
;R4_P2.c,70 :: 		OPTION_REG.PSA = 0;     //BIT 3 Seleciona o Prescaler parao T0
	BCF        OPTION_REG+0, 3
;R4_P2.c,71 :: 		OPTION_REG.PS2 = 1;
	BSF        OPTION_REG+0, 2
;R4_P2.c,72 :: 		OPTION_REG.PS1 = 0;
	BCF        OPTION_REG+0, 1
;R4_P2.c,73 :: 		OPTION_REG.PS0 = 1;      //BIT 2-0 Taxa de divisão PESCALER 011 (1:64)
	BSF        OPTION_REG+0, 0
;R4_P2.c,74 :: 		TMR0 = 131;                       //Inicia o contador do T0 com 131
	MOVLW      131
	MOVWF      TMR0+0
;R4_P2.c,76 :: 		INTCON = 0b00000000;     //Limpa o registro de controle de Interrupção
	CLRF       INTCON+0
;R4_P2.c,77 :: 		INTCON.TMR0IE = 1;        //BIT 5 Habilita interrupção do T0 Overflow
	BSF        INTCON+0, 5
;R4_P2.c,78 :: 		INTCON.TMR0IF = 0;        //BIT 2 Limpa indicador de interrupção por T0
	BCF        INTCON+0, 2
;R4_P2.c,79 :: 		INTCON.GIE = 1;               //BIT 7 Habilita interrupção Global
	BSF        INTCON+0, 7
;R4_P2.c,81 :: 		for (;;)
L_main12:
;R4_P2.c,83 :: 		if (fim_1s)  //Passou 1s ?
	BTFSS      _fim_1s+0, BitPos(_fim_1s+0)
	GOTO       L_main15
;R4_P2.c,85 :: 		fim_1s = 0;
	BCF        _fim_1s+0, BitPos(_fim_1s+0)
;R4_P2.c,86 :: 		switch (sel_saida)
	GOTO       L_main16
;R4_P2.c,88 :: 		case 1: Lcd_Out(2,5,"00000001");
L_main18:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,89 :: 		PORTB = 1;
	MOVLW      1
	MOVWF      PORTB+0
;R4_P2.c,90 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;R4_P2.c,91 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,92 :: 		break;
	GOTO       L_main17
;R4_P2.c,94 :: 		case 2: Lcd_Out(2,5,"00000010");
L_main19:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,95 :: 		PORTB = 2;
	MOVLW      2
	MOVWF      PORTB+0
;R4_P2.c,96 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;R4_P2.c,97 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,98 :: 		break;
	GOTO       L_main17
;R4_P2.c,100 :: 		case 3: Lcd_Out(2,5,"00000100");
L_main20:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,101 :: 		PORTB = 4;
	MOVLW      4
	MOVWF      PORTB+0
;R4_P2.c,102 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;R4_P2.c,103 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,104 :: 		break;
	GOTO       L_main17
;R4_P2.c,106 :: 		case 4: Lcd_Out(2,5,"00001000");
L_main21:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,107 :: 		PORTB = 8;
	MOVLW      8
	MOVWF      PORTB+0
;R4_P2.c,108 :: 		RC1_bit = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;R4_P2.c,109 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,110 :: 		break;
	GOTO       L_main17
;R4_P2.c,112 :: 		case 5: Lcd_Out(2,5,"00010000");
L_main22:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,113 :: 		PORTB = 16;
	MOVLW      16
	MOVWF      PORTB+0
;R4_P2.c,114 :: 		RC1_bit = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;R4_P2.c,115 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,116 :: 		break;
	GOTO       L_main17
;R4_P2.c,118 :: 		case 6: Lcd_Out(2,5,"00100000");
L_main23:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,119 :: 		PORTB = 32;
	MOVLW      32
	MOVWF      PORTB+0
;R4_P2.c,120 :: 		RC1_bit = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;R4_P2.c,121 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,122 :: 		break;
	GOTO       L_main17
;R4_P2.c,124 :: 		case 7: Lcd_Out(2,5,"01000000");
L_main24:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,125 :: 		PORTB = 64;
	MOVLW      64
	MOVWF      PORTB+0
;R4_P2.c,126 :: 		RC1_bit = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;R4_P2.c,127 :: 		sel_saida++;
	INCF       _sel_saida+0, 1
;R4_P2.c,128 :: 		break;
	GOTO       L_main17
;R4_P2.c,130 :: 		case 8: Lcd_Out(2,5,"10000000");
L_main25:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_R4_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P2.c,131 :: 		PORTB = 128;
	MOVLW      128
	MOVWF      PORTB+0
;R4_P2.c,132 :: 		RC1_bit = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;R4_P2.c,133 :: 		sel_saida = 1;
	MOVLW      1
	MOVWF      _sel_saida+0
;R4_P2.c,134 :: 		break;
	GOTO       L_main17
;R4_P2.c,135 :: 		}
L_main16:
	MOVF       _sel_saida+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _sel_saida+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _sel_saida+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _sel_saida+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _sel_saida+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _sel_saida+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _sel_saida+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _sel_saida+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main25
L_main17:
;R4_P2.c,136 :: 		}
L_main15:
;R4_P2.c,137 :: 		}
	GOTO       L_main12
;R4_P2.c,138 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
