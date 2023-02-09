
_main:

;R6_P2.c,19 :: 		void main()
;R6_P2.c,21 :: 		TRISA = 0xFF;    //Conf.todos os pinos do PORTA c/ entrada
	MOVLW      255
	MOVWF      TRISA+0
;R6_P2.c,22 :: 		TRISB = 0x00;    //Conf.todos os pinos do PORTB c/ saída
	CLRF       TRISB+0
;R6_P2.c,23 :: 		TRISC = 0x00;    //Conf.todos os pinos do PORTC c/ saída
	CLRF       TRISC+0
;R6_P2.c,26 :: 		ADCON0.ADCS0 = 0;
	BCF        ADCON0+0, 6
;R6_P2.c,27 :: 		ADCON0.ADCS1 = 0;
	BCF        ADCON0+0, 7
;R6_P2.c,28 :: 		ADCON1.ADCS2 = 0;
	BCF        ADCON1+0, 6
;R6_P2.c,30 :: 		ADCON0.CHS0 = 0;
	BCF        ADCON0+0, 3
;R6_P2.c,31 :: 		ADCON0.CHS1 = 0;
	BCF        ADCON0+0, 4
;R6_P2.c,32 :: 		ADCON0.CHS2 = 0;
	BCF        ADCON0+0, 5
;R6_P2.c,34 :: 		ADCON0.ADON = 1;
	BSF        ADCON0+0, 0
;R6_P2.c,36 :: 		ADCON1.ADFM = 0;
	BCF        ADCON1+0, 7
;R6_P2.c,39 :: 		ADCON1.PCFG0 = 0;
	BCF        ADCON1+0, 0
;R6_P2.c,40 :: 		ADCON1.PCFG1 = 1;
	BSF        ADCON1+0, 1
;R6_P2.c,41 :: 		ADCON1.PCFG2 = 1;
	BSF        ADCON1+0, 2
;R6_P2.c,42 :: 		ADCON1.PCFG3 = 1;
	BSF        ADCON1+0, 3
;R6_P2.c,45 :: 		CMCON.CM0 = 1;
	BSF        CMCON+0, 0
;R6_P2.c,46 :: 		CMCON.CM1 = 1;
	BSF        CMCON+0, 1
;R6_P2.c,47 :: 		CMCON.CM2 = 1;
	BSF        CMCON+0, 2
;R6_P2.c,49 :: 		PIE1 = 0b00000100; //Habilita o módulo CCP
	MOVLW      4
	MOVWF      PIE1+0
;R6_P2.c,50 :: 		PWM1_Init(10000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;R6_P2.c,52 :: 		Lcd_Init();                //Iniciliza o LCD
	CALL       _Lcd_Init+0
;R6_P2.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);       //Limpa todos os caracteres do LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R6_P2.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  //Desabilita cursor piscando no LCD
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R6_P2.c,57 :: 		Lcd_Out(1,1," Gerando sinal ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,58 :: 		Lcd_Out(2,1,"PWM de 0 a 100%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,59 :: 		Delay_ms(2000);
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
;R6_P2.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;R6_P2.c,61 :: 		Lcd_Out(1,1,"AN0:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,62 :: 		Lcd_Out(2,1,"PWM:      DC:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,64 :: 		while(1)
L_main1:
;R6_P2.c,66 :: 		adc_AN0 = ADC_Read(0); //Lê o valor da porta AN0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+4
	MOVF       R0+1, 0
	MOVWF      FLOC__main+5
	MOVF       FLOC__main+4, 0
	MOVWF      _adc_AN0+0
	MOVF       FLOC__main+5, 0
	MOVWF      _adc_AN0+1
;R6_P2.c,67 :: 		out_PWM = (float)((adc_AN0 / 1023.0) * 255.0);
	MOVF       FLOC__main+4, 0
	MOVWF      R0+0
	MOVF       FLOC__main+5, 0
	MOVWF      R0+1
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _out_PWM+0
	MOVF       R0+1, 0
	MOVWF      _out_PWM+1
;R6_P2.c,68 :: 		duty_cycle = (float)((adc_AN0 / 1023.0) * 100.0);
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _duty_cycle+0
	MOVF       R0+1, 0
	MOVWF      _duty_cycle+1
;R6_P2.c,70 :: 		IntToStr(adc_AN0, txt_lcd);
	MOVF       FLOC__main+4, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FLOC__main+5, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_lcd+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;R6_P2.c,71 :: 		Ltrim(txt_lcd);
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;R6_P2.c,72 :: 		Lcd_Out(1,5,txt_lcd);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,73 :: 		if ((adc_AN0 < 1000) && (adc_AN0 > 99)) Lcd_Out(1,8," ");
	MOVLW      3
	SUBWF      _adc_AN0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      232
	SUBWF      _adc_AN0+0, 0
L__main23:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
	MOVF       _adc_AN0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVF       _adc_AN0+0, 0
	SUBLW      99
L__main24:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
L__main21:
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main5:
;R6_P2.c,74 :: 		if ((adc_AN0 < 100) && (adc_AN0 > 9)) Lcd_Out(1,7," ");
	MOVLW      0
	SUBWF      _adc_AN0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      100
	SUBWF      _adc_AN0+0, 0
L__main25:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
	MOVF       _adc_AN0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVF       _adc_AN0+0, 0
	SUBLW      9
L__main26:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
L__main20:
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main8:
;R6_P2.c,75 :: 		if (adc_AN0 < 10) Lcd_Out(1,6," ");
	MOVLW      0
	SUBWF      _adc_AN0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      10
	SUBWF      _adc_AN0+0, 0
L__main27:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main9:
;R6_P2.c,77 :: 		IntToStr(out_PWM, txt_lcd);
	MOVF       _out_PWM+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _out_PWM+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_lcd+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;R6_P2.c,78 :: 		Ltrim(txt_lcd);
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;R6_P2.c,79 :: 		Lcd_Out(2,5,txt_lcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,80 :: 		if ((out_PWM < 100) && (out_PWM > 9)) Lcd_Out(2,7," ");
	MOVLW      0
	SUBWF      _out_PWM+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVLW      100
	SUBWF      _out_PWM+0, 0
L__main28:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
	MOVF       _out_PWM+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVF       _out_PWM+0, 0
	SUBLW      9
L__main29:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
L__main19:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main12:
;R6_P2.c,81 :: 		if (out_PWM < 10) Lcd_Out(2,6,"  ");
	MOVLW      0
	SUBWF      _out_PWM+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      10
	SUBWF      _out_PWM+0, 0
L__main30:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main13:
;R6_P2.c,83 :: 		IntToStr(duty_cycle, txt_lcd);
	MOVF       _duty_cycle+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _duty_cycle+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_lcd+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;R6_P2.c,84 :: 		Ltrim(txt_lcd);
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;R6_P2.c,85 :: 		Lcd_Out(2,14,txt_lcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_lcd+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;R6_P2.c,86 :: 		if ((duty_cycle < 100) && (duty_cycle > 9)) Lcd_Out(2,16," ");
	MOVLW      0
	SUBWF      _duty_cycle+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      100
	SUBWF      _duty_cycle+0, 0
L__main31:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
	MOVF       _duty_cycle+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _duty_cycle+0, 0
	SUBLW      9
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
L__main18:
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main16:
;R6_P2.c,87 :: 		if (duty_cycle < 10) Lcd_Out(2,15,"  ");
	MOVLW      0
	SUBWF      _duty_cycle+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      10
	SUBWF      _duty_cycle+0, 0
L__main33:
	BTFSC      STATUS+0, 0
	GOTO       L_main17
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_R6_P2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main17:
;R6_P2.c,89 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;R6_P2.c,90 :: 		PWM1_Set_Duty(out_PWM);
	MOVF       _out_PWM+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;R6_P2.c,91 :: 		}
	GOTO       L_main1
;R6_P2.c,92 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
