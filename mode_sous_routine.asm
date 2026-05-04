;#######################################################################################
;			SOUS ROUTINE DES DIFFERENTS MODES
;#######################################################################################

;#######################################################################################
;			MODE WELCOME PLAYER

;affiche le bon "welcome" en fonction du profile choisi, ainsi que le "best score" correspondant

welcome_player:
	call init_x
	call select_adress_eeprom
	call eeprom_load
	push a0
	call lcd_clear
	call lcd_init
	PRINTF LCD
.db "Welcome ",0,0
	lds w, player_mem
	cpi w, 1
	brne print1_skip

	pop a0
	PRINTF LCD
.db "Player 1",0,0
	call lcd_lf
	PRINTF LCD
.db "Best score: ", FDEC, 18,0 ,0
	WAIT_MS 10
	rjmp fin_welcome

print1_skip:
	lds w, player_mem
	cpi w, 2
	brne print2_skip
	pop a0
	PRINTF LCD
.db "Player 2",0,0
	call lcd_lf
	PRINTF LCD
.db "Best score: ", FDEC, 18, 0, 0
	WAIT_MS 10
	rjmp fin_welcome

print2_skip:
	lds w, player_mem
	cpi w, 3
	brne print3_skip
	pop a0
	PRINTF LCD
.db "Player 3",0,0
	call lcd_lf
	PRINTF LCD
.db "Best score: ", FDEC, 18,0 ,0
	WAIT_MS 10
	rjmp fin_welcome

print3_skip:
	pop a0
	PRINTF LCD
.db "Player 4",0,0
	call lcd_lf
	PRINTF LCD
.db "Best score: ", FDEC, 18, 0, 0
	WAIT_MS 10

fin_welcome:
	ret

;#######################################################################################
;			MODE JEU

main_jeu:
; ------ part 1: store image that will be displayed into SRAM

;test niveau 1 ou 2
	lds		r16, etat_niveau
	cpi		r16, 0
	brne	niveau_2_int_2
	rjmp	niveau_1
niveau_2_int_2 :
	cpi		r16, 1
	brne	victoire_int_2
	rjmp	niveau_2
victoire_int_2 :
	rjmp	victoire

;###############  NIVEAU 1  ##########################

niveau_1 :

	LED_INIT_NIV1

	MAJ_NIV1

	rjmp	affichage

;###############  NIVEAU 2  ##########################

niveau_2 :

	LED_INIT_NIV2

	MAJ_NIV2

;###############  AFFICHAGE  ##########################

rjmp affichage

victoire :

	ldi _w,2
	sts mode_mem,_w
	
	LED_INIT_VICTOIRE

affichage :

	WAIT_MS 100
	call display_leds
	lds		w, etat_niveau
	cpi		w, 2
	brne	PC+2
	rjmp mode_selec

;###############  BOUTONS  ##########################

switch :

	sbis	PINB, 0
	rjmp	myright

	sbis	PINB, 1
	rjmp	myleft

	sbis	PINB, 2
	rjmp	myup

	sbis	PINB, 3
	rjmp	mydown

	sbis	PINB, 7
	rjmp	reset

	ret

myright :
	RIGHT
	ret

myleft :
	LEFT
	ret

myup :
	UP
	ret

mydown :
	DOWN
	ret