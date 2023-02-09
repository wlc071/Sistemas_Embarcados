
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;R4_P1.c,23 :: 		void interrupt()
;R4_P1.c,25 :: 		if (INTCON.INTF==1)
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;R4_P1.c,27 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;R4_P1.c,28 :: 		contador++;
	INCF       _contador+0, 1
	BTFSC      STATUS+0, 2
	INCF       _contador+1, 1
;R4_P1.c,29 :: 		if (contador > 1000) contador = 0;
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _contador+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt13
	MOVF       _contador+0, 0
	SUBLW      232
L__interrupt13:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
	CLRF       _contador+0
	CLRF       _contador+1
L_interrupt1:
;R4_P1.c,30 :: 		}
L_interrupt0:
;R4_P1.c,31 :: 		}
L_end_interrupt:
L__interrupt12:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;R4_P1.c,33 :: 		void main()
;R4_P1.c,35 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;R4_P1.c,36 :: 		TRISC = 0x00;                          //Configura a porta C como saída digital
	CLRF       TRISC+0
;R4_P1.c,37 :: 		OPTION_REG.INTEDG = 0;   //Configura borda inter. externa Descida
	BCF        OPTION_REG+0, 6
;R4_P1.c,38 :: 		INTCON = 0;                            //Escreve 0 em todos os bits de INTCON
	CLRF       INTCON+0
;R4_P1.c,39 :: 		INTCON.INTE = 1;                  //Habilita as interrupções externas
	BSF        INTCON+0, 4
;R4_P1.c,40 :: 		INTCON.PEIE = 1;                  //Habilita todas interrup. periféricas
	BSF        INTCON+0, 6
;R4_P1.c,41 :: 		INTCON.GIE = 1;                    //Habilita as interrupções globais
	BSF        INTCON+0, 7
;R4_P1.c,42 :: 		INTCON.INTF = 0;                 //Limpa Flag de Interrupção Externa
	BCF        INTCON+0, 1
;R4_P1.c,44 :: 		Lcd_Init();                                 //Iniciliza o LCD
	CALL       _Lcd_Init+0
;R4_P1.c,45 :: 		Lcd_cmd(_LCD_CLEAR);              //Limpa todos os caracteres do LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P1.c,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); //Desabilita cursor piscando no LCD
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R4_P1.c,48 :: 		Lcd_Out(1,1,"  Seja bem-vindo   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,49 :: 		Lcd_Out(2,2,"Inicializando...");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,50 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;R4_P1.c,51 :: 		Lcd_Out(1,1,"  Roteiro Prático   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,52 :: 		Lcd_Out(2,2,"Sist. Embarcados");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,53 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;R4_P1.c,54 :: 		contador = 1;
	MOVLW      1
	MOVWF      _contador+0
	MOVLW      0
	MOVWF      _contador+1
;R4_P1.c,55 :: 		for(i = 1; i<=16; i++){
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main4:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       _i+0, 0
	SUBLW      16
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main5
;R4_P1.c,56 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
;R4_P1.c,57 :: 		lcd_Chr(2,i,0xff);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      255
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;R4_P1.c,55 :: 		for(i = 1; i<=16; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;R4_P1.c,58 :: 		}
	GOTO       L_main4
L_main5:
;R4_P1.c,59 :: 		do
L_main8:
;R4_P1.c,61 :: 		Lcd_Out(1,1,"  Uniube 2022  ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,62 :: 		Lcd_Out(2,2,"Contador:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_R4_P1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,63 :: 		IntToStr(contador, texto_LCD);
	MOVF       _contador+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _contador+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _texto_LCD+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;R4_P1.c,64 :: 		Lcd_Out(2,11, texto_LCD);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _texto_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R4_P1.c,66 :: 		}while(1);
	GOTO       L_main8
;R4_P1.c,68 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
