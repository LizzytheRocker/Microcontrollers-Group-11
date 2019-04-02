;
; Project1-1.asm
;
; Created: 3/24/2019 6:06:13 PM
; Author : warho
;


; Replace with your application code



.org 0

    LDI R16, 0xFF
	OUT DDRC, R16
	OUT DDRD, R16
	OUT DDRA, R16
	CBI DDRB, 0
	SBI PORTB, 0
	CBI DDRB, 1
	SBI PORTB, 1
	CBI DDRB, 2
	SBI PORTB, 2
	CBI DDRB, 3
	SBI PORTB, 3

	LDI R20, 0x00
	LDI R21, 0x00
	LDI R22, 0x00

START:
	SBIC PINB, 0
	RJMP INCREMENT_PRESS
	SBIC PINB, 1
	RJMP DECREMENT_PRESS
	SBIC PINB, 2
	RJMP BUZZ
	SBIC PINB, 3
	RJMP SPIN_WHEEL_PRESS
	RJMP START

INCREMENT_PRESS:
	SBIS PINB, 0
	RJMP INCREMENT
	RJMP INCREMENT_PRESS

INCREMENT:
	INC R20
	OUT PORTC, R20
	RJMP START

DECREMENT_PRESS:
	SBIS PINB, 1
	RJMP DECREMENT
	RJMP DECREMENT_PRESS

DECREMENT:
	DEC R20
	OUT PORTC, R20
	RJMP START

BUZZ:
	SBI PORTD, 0
	RCALL DELAY1
	NOP
	NOP
	CBI PORTD, 0
	RCALL DELAY1
	SBIC PINB, 2
	RJMP BUZZ
	RJMP START

SPIN_WHEEL_PRESS:
	OUT PORTA, R16
	LDI R22, 0x01
	SBIS PINB, 3
	RJMP SPIN_WHEEL
	INC R21
	RJMP SPIN_WHEEL_PRESS

SPIN_WHEEL:
	ROR R21
	BRCC SKIP_MULT1
	LSL R22
SKIP_MULT1:
	ROR R21
	BRCC SKIP_MULT2
	LSL R22
	LSL R22
SKIP_MULT2:
	ROR R21
	BRCC SKIP_MULT3
	LSL R22
	LSL R22
	LSL R22
	LSL R22
SKIP_MULT3:
	OUT PORTA, R22
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN1
	LDI R22, 0x01
FULL_SPIN1:
	OUT PORTA, R22
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN2
	LDI R22, 0x01
FULL_SPIN2:
	OUT PORTA, R22
	RCALL DELAY2
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN3
	LDI R22, 0x01
FULL_SPIN3:
	OUT PORTA, R22
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN4
	LDI R22, 0x01
FULL_SPIN4:
	OUT PORTA, R22
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RJMP START

DELAY1:
	LDI R17, 100
LOOP12:
	LDI R18, 13
LOOP11:
	DEC R18
	BRNE LOOP11
	DEC R17
	BRNE LOOP12
	RET

DELAY2:
	LDI R17, 9
LOOP23:
	LDI R18, 100
LOOP22:
	LDI R19, 100
LOOP21:
	DEC R19
	BRNE LOOP21
	DEC R18
	BRNE LOOP22
	DEC R17
	BRNE LOOP23
	RET