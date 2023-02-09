
_main:

;R5_P2.c,21 :: 		void main()
;R5_P2.c,23 :: 		TRISA = 0xFF;          //Conf.todos os pinos do PORTA c/ entrada
	MOVLW      255
	MOVWF      TRISA+0
;R5_P2.c,24 :: 		TRISB = 0x00;          //Conf.todos os pinos do PORTB c/ saída
	CLRF       TRISB+0
;R5_P2.c,25 :: 		TRISC = 0b00000001;    //Conf.todos os pinos do PORTC c/ saída
	MOVLW      1
	MOVWF      TRISC+0
;R5_P2.c,26 :: 		TRISD = 0b00000000;
	CLRF       TRISD+0
;R5_P2.c,27 :: 		RB0_bit = 0;              //Inicializa a saída do ventilador em 0
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;R5_P2.c,28 :: 		RD0_bit = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;R5_P2.c,30 :: 		ADCON0 = 0b00000001;   //Habilita A/D e seleciona a entrada AN0
	MOVLW      1
	MOVWF      ADCON0+0
;R5_P2.c,31 :: 		ADCON1 = 0b00001110;   //Seleciona apenas o pino AN0 como A/D
	MOVLW      14
	MOVWF      ADCON1+0
;R5_P2.c,32 :: 		ADC_Init();                        //Inicializa o módulo conversor A/D
	CALL       _ADC_Init+0
;R5_P2.c,33 :: 		CMCON = 0b00000111;    //Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;R5_P2.c,35 :: 		Lcd_Init();                //Iniciliza o LCD
	CALL       _Lcd_Init+0
;R5_P2.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);              //Limpa todos os caracteres do LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R5_P2.c,37 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  //Desabilita cursor piscando no LCD
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R5_P2.c,42 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;R5_P2.c,43 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R5_P2.c,44 :: 		Lcd_Out(1,1,"Temperatura:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_R5_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R5_P2.c,46 :: 		while(1)
L_main1:
;R5_P2.c,48 :: 		adc_AN0 = ADC_Read(0); //Lê o valor da porta AN0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_AN0+0
	MOVF       R0+1, 0
	MOVWF      _adc_AN0+1
;R5_P2.c,49 :: 		temperatura = (adc_AN0 / 1024.0) * 500.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      135
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _temperatura+0
	MOVF       R0+1, 0
	MOVWF      _temperatura+1
	MOVF       R0+2, 0
	MOVWF      _temperatura+2
	MOVF       R0+3, 0
	MOVWF      _temperatura+3
;R5_P2.c,50 :: 		FloatToStr(temperatura, txt_lcd);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt_lcd+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;R5_P2.c,51 :: 		Lcd_Out(1,13,txt_lcd);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R5_P2.c,53 :: 		if (x == 1) {
	MOVLW      0
	XORWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      1
	XORWF      _x+0, 0
L__main16:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;R5_P2.c,54 :: 		if (temperatura >= 50){
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _temperatura+0, 0
	MOVWF      R0+0
	MOVF       _temperatura+1, 0
	MOVWF      R0+1
	MOVF       _temperatura+2, 0
	MOVWF      R0+2
	MOVF       _temperatura+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;R5_P2.c,55 :: 		RB0_bit = 1;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;R5_P2.c,57 :: 		}
	GOTO       L_main5
L_main4:
;R5_P2.c,58 :: 		else if (temperatura <= 45) {
	MOVF       _temperatura+0, 0
	MOVWF      R4+0
	MOVF       _temperatura+1, 0
	MOVWF      R4+1
	MOVF       _temperatura+2, 0
	MOVWF      R4+2
	MOVF       _temperatura+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      52
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;R5_P2.c,59 :: 		RB0_bit = 0;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;R5_P2.c,61 :: 		}
L_main6:
L_main5:
;R5_P2.c,62 :: 		}
L_main3:
;R5_P2.c,63 :: 		if((RC0_bit == 0) && (fg_bt == 0)){
	BTFSC      RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main9
	BTFSC      _fg_bt+0, BitPos(_fg_bt+0)
	GOTO       L_main9
L__main14:
;R5_P2.c,64 :: 		x = ~ x;
	COMF       _x+0, 1
	COMF       _x+1, 1
;R5_P2.c,65 :: 		RD0_bit = ~ RD0_bit;
	MOVLW
	XORWF      RD0_bit+0, 1
;R5_P2.c,66 :: 		fg_bt=1;
	BSF        _fg_bt+0, BitPos(_fg_bt+0)
;R5_P2.c,67 :: 		}
L_main9:
;R5_P2.c,68 :: 		if((RC0_bit == 1)&&(fg_bt == 1)){
	BTFSS      RC0_bit+0, BitPos(RC0_bit+0)
	GOTO       L_main12
	BTFSS      _fg_bt+0, BitPos(_fg_bt+0)
	GOTO       L_main12
L__main13:
;R5_P2.c,69 :: 		fg_bt=0;
	BCF        _fg_bt+0, BitPos(_fg_bt+0)
;R5_P2.c,70 :: 		}
L_main12:
;R5_P2.c,72 :: 		}
	GOTO       L_main1
;R5_P2.c,73 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
