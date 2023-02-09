
_main:

;R6_P1.c,4 :: 		void main()
;R6_P1.c,7 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;R6_P1.c,10 :: 		CCP1CON.CCP1M0 = 1;
	BSF        CCP1CON+0, 0
;R6_P1.c,11 :: 		CCP1CON.CCP1M1 = 1;
	BSF        CCP1CON+0, 1
;R6_P1.c,12 :: 		CCP1CON.CCP1M2 = 1;
	BSF        CCP1CON+0, 2
;R6_P1.c,13 :: 		CCP1CON.CCP1M3 = 1;
	BSF        CCP1CON+0, 3
;R6_P1.c,16 :: 		T2CON.T2CKPS0 = 0;
	BCF        T2CON+0, 0
;R6_P1.c,17 :: 		T2CON.T2CKPS1 = 0;
	BCF        T2CON+0, 1
;R6_P1.c,18 :: 		T2CON.TMR2ON  = 0;
	BCF        T2CON+0, 2
;R6_P1.c,21 :: 		T2CON.TOUTPS0 = 0;
	BCF        T2CON+0, 3
;R6_P1.c,24 :: 		T2CON.TOUTPS1 = 0;
	BCF        T2CON+0, 4
;R6_P1.c,25 :: 		T2CON.TOUTPS2 = 0;
	BCF        T2CON+0, 5
;R6_P1.c,26 :: 		T2CON.TOUTPS3 = 0;
	BCF        T2CON+0, 6
;R6_P1.c,29 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;R6_P1.c,32 :: 		CCP1CON.CCP1Y = 0;  //Bit0
	BCF        CCP1CON+0, 4
;R6_P1.c,33 :: 		CCP1CON.CCP1X = 0;  //Bit1
	BCF        CCP1CON+0, 5
;R6_P1.c,34 :: 		CCPR1L = 0;          //Bit 2 ao 9
	CLRF       CCPR1L+0
;R6_P1.c,36 :: 		while(1)
L_main0:
;R6_P1.c,38 :: 		CCPR1L = i;
	MOVF       _i+0, 0
	MOVWF      CCPR1L+0
;R6_P1.c,39 :: 		i = i + j;
	MOVF       _j+0, 0
	ADDWF      _i+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _i+0
;R6_P1.c,41 :: 		if (i == 255){
	MOVF       R1+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;R6_P1.c,42 :: 		j = j * -1;
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	MOVLW      255
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
;R6_P1.c,43 :: 		}
L_main2:
;R6_P1.c,44 :: 		if (i == 0) {
	MOVF       _i+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;R6_P1.c,45 :: 		j = j * -1;
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	MOVLW      255
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
;R6_P1.c,46 :: 		}
L_main3:
;R6_P1.c,47 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
;R6_P1.c,48 :: 		}
	GOTO       L_main0
;R6_P1.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
