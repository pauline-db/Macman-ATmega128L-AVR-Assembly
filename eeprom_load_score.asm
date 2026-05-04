
;compare le score actuel et celui en mémoire et enregistre le plus grand
.macro COMPARE_SCORE ;arg : score
	rcall init_x
	rcall select_adress_eeprom
	rcall eeprom_load
	cp @0,a0
	brsh PC+2
	rjmp end_compare
	rcall init_x
	rcall select_adress_eeprom
	mov a0, @0
	rcall eeprom_store
end_compare:
	
.endmacro


;appel COMPARE_SCORE et affiche le score
main_eeprom: ;compares current score and shows it
	lds a1,score
	COMPARE_SCORE a1
	rcall affiche_score

	ret




select_adress_eeprom:
	ld w,x
	cpi w,1
	brne PC+3
	ldi xl, low(0)
	ldi xh, high (0)
	cpi w,2
	brne PC+3
	ldi xl, low(1)
	ldi xh, high (1)
	cpi w,3
	brne PC+3
	ldi xl, low(2)
	ldi xh, high (2)
	cpi w,4
	brne PC+3
	ldi xl, low(3)
	ldi xh, high (3)
	ret


affiche_score:
	call init_x
	rcall select_adress_eeprom
	call eeprom_load
	lds a1, score
	call lcd_clear
	call lcd_home
	PRINTF LCD
.db "Score: ", FDEC, 19,0
	rcall lcd_lf
	PRINTF LCD
.db "Best score:",FDEC,18,0
	WAIT_MS 100
	ret

/*
affiche_score:
	push r30
	push r31
	call init_x
	rcall select_adress_eeprom
	call eeprom_load
	
	call lcd_clear
	call lcd_home
	PRINTF LCD
	lds a1, score
.db "score: ", FDEC, 19,0,0
	rcall lcd_lf
.db "High score:",FDEC,18,0
	WAIT_MS 100
	pop r31
	pop r30
	ret*/