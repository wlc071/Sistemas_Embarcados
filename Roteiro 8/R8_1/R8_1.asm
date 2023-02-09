
_inicia_sinal:

;R8_1.c,20 :: 		void inicia_sinal()
;R8_1.c,22 :: 		TRISD.F2 = 0;  //Configura RD2 como  saída
	BCF        TRISD+0, 2
;R8_1.c,23 :: 		PORTD.F2 = 0;  //RD2 envia 0 para o sensor
	BCF        PORTD+0, 2
;R8_1.c,24 :: 		Delay_ms(18);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      191
	MOVWF      R13+0
L_inicia_sinal0:
	DECFSZ     R13+0, 1
	GOTO       L_inicia_sinal0
	DECFSZ     R12+0, 1
	GOTO       L_inicia_sinal0
	NOP
	NOP
;R8_1.c,25 :: 		PORTD.F2 = 1;  //RD2 envia 1 para o sensor
	BSF        PORTD+0, 2
;R8_1.c,26 :: 		Delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_inicia_sinal1:
	DECFSZ     R13+0, 1
	GOTO       L_inicia_sinal1
	NOP
	NOP
;R8_1.c,27 :: 		TRISD.F2 = 1;  //Configura RD2 como entrada
	BSF        TRISD+0, 2
;R8_1.c,28 :: 		}
L_end_inicia_sinal:
	RETURN
; end of _inicia_sinal

_verifica_resposta:

;R8_1.c,30 :: 		void verifica_resposta()
;R8_1.c,32 :: 		a = 0;
	CLRF       _a+0
;R8_1.c,33 :: 		Delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_verifica_resposta2:
	DECFSZ     R13+0, 1
	GOTO       L_verifica_resposta2
	NOP
;R8_1.c,34 :: 		if (PORTD.F2 == 0)
	BTFSC      PORTD+0, 2
	GOTO       L_verifica_resposta3
;R8_1.c,36 :: 		Delay_us(80);
	MOVLW      53
	MOVWF      R13+0
L_verifica_resposta4:
	DECFSZ     R13+0, 1
	GOTO       L_verifica_resposta4
;R8_1.c,37 :: 		if (PORTD.F2 == 1)   a = 1;
	BTFSS      PORTD+0, 2
	GOTO       L_verifica_resposta5
	MOVLW      1
	MOVWF      _a+0
L_verifica_resposta5:
;R8_1.c,38 :: 		Delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_verifica_resposta6:
	DECFSZ     R13+0, 1
	GOTO       L_verifica_resposta6
	NOP
;R8_1.c,39 :: 		}
L_verifica_resposta3:
;R8_1.c,40 :: 		}
L_end_verifica_resposta:
	RETURN
; end of _verifica_resposta

_le_dados:

;R8_1.c,42 :: 		void le_dados()
;R8_1.c,44 :: 		for(b=0;b<8;b++)
	CLRF       _b+0
L_le_dados7:
	MOVLW      8
	SUBWF      _b+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_le_dados8
;R8_1.c,46 :: 		while(!PORTD.F2); //Espera até PORTD.F2 ficar HIGH
L_le_dados10:
	BTFSC      PORTD+0, 2
	GOTO       L_le_dados11
	GOTO       L_le_dados10
L_le_dados11:
;R8_1.c,47 :: 		Delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_le_dados12:
	DECFSZ     R13+0, 1
	GOTO       L_le_dados12
	NOP
	NOP
;R8_1.c,48 :: 		if(PORTD.F2 == 0)    i&=~(1<<(7-b));  //Clear bit (7-b)
	BTFSC      PORTD+0, 2
	GOTO       L_le_dados13
	MOVF       _b+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__le_dados27:
	BTFSC      STATUS+0, 2
	GOTO       L__le_dados28
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__le_dados27
L__le_dados28:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      _i+0, 1
	GOTO       L_le_dados14
L_le_dados13:
;R8_1.c,51 :: 		i|= (1<<(7-b));  //Set bit (7-b)
	MOVF       _b+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__le_dados29:
	BTFSC      STATUS+0, 2
	GOTO       L__le_dados30
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__le_dados29
L__le_dados30:
	MOVF       R0+0, 0
	IORWF      _i+0, 1
;R8_1.c,52 :: 		while(PORTD.F2); //Espera até PORTD.F2 ficar LOW
L_le_dados15:
	BTFSS      PORTD+0, 2
	GOTO       L_le_dados16
	GOTO       L_le_dados15
L_le_dados16:
;R8_1.c,53 :: 		}
L_le_dados14:
;R8_1.c,44 :: 		for(b=0;b<8;b++)
	INCF       _b+0, 1
;R8_1.c,54 :: 		}
	GOTO       L_le_dados7
L_le_dados8:
;R8_1.c,55 :: 		}
L_end_le_dados:
	RETURN
; end of _le_dados

_main:

;R8_1.c,57 :: 		void main()
;R8_1.c,59 :: 		TRISB = 0;        //Configura PORTB com saída
	CLRF       TRISB+0
;R8_1.c,60 :: 		PORTB = 0;        //Inicializa  valor 0 PORTB
	CLRF       PORTB+0
;R8_1.c,61 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;R8_1.c,62 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); //Desliga cursorLCD
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R8_1.c,63 :: 		Lcd_Cmd(_LCD_CLEAR);      //Limpa  todo  LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R8_1.c,64 :: 		while(1)
L_main17:
;R8_1.c,66 :: 		inicia_sinal();
	CALL       _inicia_sinal+0
;R8_1.c,67 :: 		verifica_resposta();
	CALL       _verifica_resposta+0
;R8_1.c,68 :: 		if (a == 1)
	MOVF       _a+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;R8_1.c,70 :: 		le_dados();
	CALL       _le_dados+0
;R8_1.c,71 :: 		rh1 =i;
	MOVF       _i+0, 0
	MOVWF      _rh1+0
;R8_1.c,72 :: 		le_dados();
	CALL       _le_dados+0
;R8_1.c,73 :: 		rh2 =i;
	MOVF       _i+0, 0
	MOVWF      _rh2+0
;R8_1.c,74 :: 		le_dados();
	CALL       _le_dados+0
;R8_1.c,75 :: 		t1 =i;
	MOVF       _i+0, 0
	MOVWF      _t1+0
;R8_1.c,76 :: 		le_dados();
	CALL       _le_dados+0
;R8_1.c,77 :: 		t2 =i;
	MOVF       _i+0, 0
	MOVWF      _t2+0
;R8_1.c,78 :: 		le_dados();
	CALL       _le_dados+0
;R8_1.c,79 :: 		sum = i;
	MOVF       _i+0, 0
	MOVWF      _sum+0
;R8_1.c,80 :: 		if(sum == rh1+rh2+t1+t2)
	MOVF       _rh2+0, 0
	ADDWF      _rh1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _t1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _t2+0, 0
	ADDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       R2+0, 0
	XORWF      _i+0, 0
L__main32:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;R8_1.c,82 :: 		text = "Temperatura:   C";
	MOVLW      ?lstr1_R8_1+0
	MOVWF      _text+0
;R8_1.c,83 :: 		Lcd_Out(1,1,text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R8_1.c,84 :: 		text = "    Umidade:   %";
	MOVLW      ?lstr2_R8_1+0
	MOVWF      _text+0
;R8_1.c,85 :: 		Lcd_Out(2,1,text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R8_1.c,86 :: 		ByteToStr(t1,mytext);
	MOVF       _t1+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _mytext+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;R8_1.c,87 :: 		Lcd_Out(1,14,Ltrim(mytext));
	MOVLW      _mytext+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;R8_1.c,88 :: 		ByteToStr(rh1,mytext);
	MOVF       _rh1+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _mytext+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;R8_1.c,89 :: 		Lcd_Out(2,14,Ltrim(mytext));
	MOVLW      _mytext+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;R8_1.c,90 :: 		}
	GOTO       L_main21
L_main20:
;R8_1.c,93 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R8_1.c,94 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R8_1.c,95 :: 		text = "Erro de CheckSum";
	MOVLW      ?lstr3_R8_1+0
	MOVWF      _text+0
;R8_1.c,96 :: 		Lcd_Out(1,1,text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R8_1.c,97 :: 		}
L_main21:
;R8_1.c,98 :: 		}
	GOTO       L_main22
L_main19:
;R8_1.c,101 :: 		text="  Sem resposta  ";
	MOVLW      ?lstr4_R8_1+0
	MOVWF      _text+0
;R8_1.c,102 :: 		Lcd_Out(1,3,text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R8_1.c,103 :: 		text = "    do sensor   ";
	MOVLW      ?lstr5_R8_1+0
	MOVWF      _text+0
;R8_1.c,104 :: 		Lcd_Out(2,1,text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R8_1.c,105 :: 		}
L_main22:
;R8_1.c,106 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
	NOP
;R8_1.c,107 :: 		}
	GOTO       L_main17
;R8_1.c,108 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
