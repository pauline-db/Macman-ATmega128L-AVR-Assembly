.include "macros.asm"		; include macro definitions
.include "definitions.asm"	; include register/constant definitions
.include "leds_macro.asm"
.include "mouvement_macro.asm"
.include "macro_keyboard.asm"

;###############  DEFINITION ZONES MEMOIRE SRAM  ##########################

.dseg
.org 0x0100
position :	.byte			1
position_ennemi1 : .byte	1
mouvement_ennemi1 : .byte	1
etat_ennemi1 : .byte		1		;0 vivant, 1 mort
position_ennemi2 : .byte	1
mouvement_ennemi2 : .byte	1		;0 right, 1 left
etat_ennemi2 : .byte		1		;0 vivant, 1 mort
etat :	.byte				1		;0 vivant, 1 mort, 2 spécial
comp_couleur : .byte		1
position_bonus_sp : .byte	1
etat_bonus_sp :	.byte		1		;0 vivant, 1 mort
position_bonus1 : .byte		1
etat_bonus1 : .byte			1		;0 vivant, 1 mort
position_bonus2 : .byte		1
etat_bonus2 : .byte			1		;0 vivant, 1 mort
score : .byte				1
etat_niveau : .byte			1		;0 niveau 1, 1 niveau 2
mode_mem: .byte				1; 
player_mem:  .byte			1;
temp_player_name: .byte		16
already_changed_name: .byte 1
niveau : .byte				192

;###############  DEFINITION ZONES MEMOIRE PROGRAMME  ##########################

.cseg

.org	0
	jmp reset

.org	OVF0addr
		in		_sreg, SREG
	;test ennemi 1
		lds		w, etat_ennemi1
		cpi		w, 1
		breq	dead_1_int
		rjmp	PC+2
	dead_1_int :
		rjmp dead_1
		MOV_ENNEMI_HOR			;for ennemi 1
	dead_1:
	;test ennemi 2
		lds		w, etat_ennemi2
		cpi		w, 1
		breq	dead_2_int
		rjmp	PC+2
	dead_2_int :
		rjmp dead
		MOV_ENNEMI_VER			;for ennemi 2

	dead:
		out		SREG, _sreg
		reti


.include "leds_sous_routines.asm"
.include "lcd.asm"			; include the LCD routines
.include "printf.asm"		; include formatted printing routines
.include "common_keyboard.asm"
.include "eeprom.asm"	
.include "sousroutine_keyboard.asm"
.include "routines_initiation.asm"
.include "eeprom_load_score.asm"
.include "mode_sous_routine.asm"


niveau1 :

.db		violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3		;ligne 1
.db		violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3									 				;ligne 2
.db		violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3											;ligne 3
.db		violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3											;ligne 4
.db		violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, violet1, violet2, violet3											;ligne 5
.db		violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3									;ligne 6
.db		violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3													;ligne 7
.db		violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, vert1, vert2, vert3, violet1, violet2, violet3			;ligne 8

niveau2 :

.db		violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3		;ligne 1
.db		violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3								 			;ligne 2
.db		violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3											;ligne 3
.db		violet1, violet2, violet3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3											;ligne 4
.db		violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3													;ligne 5
.db		violet1, violet2, violet3, violet1, violet2, violet3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, violet1, violet2, violet3									;ligne 6
.db		violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3, off1, off2, off3, off1, off2, off3, violet1, violet2, violet3													;ligne 7
.db		violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, violet1, violet2, violet3, vert1, vert2, vert3, violet1, violet2, violet3			;ligne 8

victoire_display :

.db		off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, vert1, vert2, vert3, off1, off2, off3, off1, off2, off3						;ligne 1
.db		off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, off1, off2, off3				;ligne 2
.db		off1, off2, off3, off1, off2, off3, off1, off2, off3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3		;ligne 3
.db		off1, off2, off3, off1, off2, off3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, off1, off2, off3, vert1, vert2, vert3, vert1, vert2, vert3		;ligne 4
.db		off1, off2, off3, vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, off1, off2, off3, off1, off2, off3, off1, off2, off3, vert1, vert2, vert3			;ligne 5
.db		vert1, vert2, vert3, vert1, vert2, vert3, vert1, vert2, vert3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3				;ligne 6
.db		vert1, vert2, vert3, vert1, vert2, vert3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3				;ligne 7
.db		vert1, vert2, vert3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3, off1, off2, off3					;ligne 8


reset:
	LDSP	RAMEND			; Load Stack Pointer (SP)
	call	ws2812b4_init	; initialize the LED matrix 
	call	LCD_init		; initialize the LCD
	call init_eeprom

	OUTI	DDRB, 0x00		;initialize buttons

	OUTI	TIMSK, (1<<TOIE0) ;timer 0 overflow 1 seconde
	OUTI	ASSR, (1<<AS0)
	OUTI	TCCR0, 5
	sei 

	ldi		r16, 0
	sts		etat_niveau, r16

	ldi		r16, 0
	sts		mode_mem, r16

	ldi		r16, 0
	sts		temp_player_name, r16

	ldi		r16, 0
	sts		player_mem, r16

	ldi		r16, 0
	sts		score, r16


initialisation:	; on compare la valeur du reg de z avec des valeurs pour choisir le mode de jeu 
	
;#######################################################################################
;			INITIALISATION JEU

	INIT_ETAT

;test niveau  1 ou 2 ou victoire
	lds		r16, etat_niveau
	cpi		r16, 0
	brne	niveau_2_vic
	rjmp	niveau_1_init
niveau_2_vic :
	lds		r16, etat_niveau
	cpi		r16, 2
	breq	victoire_int
	rjmp	PC+2
victoire_int :
	rjmp	victoire_niv
	rjmp	niveau_2_init

niveau_1_init :

	INIT_NIV_1

	LED_INIT_NIV1

	rjmp	mode_selec

niveau_2_init :

	INIT_NIV_2

	LED_INIT_NIV2

	rjmp	mode_selec

victoire_niv :

	LED_INIT_VICTOIRE

;#######################################################################################
;			SELECTION DE L'ETAT DE LA FSM

mode_selec :
	lds r0, mode_mem
	ldi w,3
	cp r0, w
	brlo continue_selec
	ldi w,0
	sts mode_mem,w
	lds r0, mode_mem
	ldi w,0
	sts etat_niveau,w
	sts score,w 
	sts player_mem,w

continue_selec:
	ldi w, mode_selec_joueur
	cp r0, w
	brne mode_jeu_int
	rjmp selec_joueur

mode_jeu_int :
	ldi w,1
	cp r0, w
	brne mode_fin
	rjmp jeu

mode_fin :
	rjmp fin_jeu

;#######################################################################################
;			MODE SELECTION  DE JOUEUR

selec_joueur:
	call lcd_clear
	call lcd_home
	PRINTF LCD
.db "Select player ",0 ,0
	call lcd_lf
	PRINTF LCD
.db "1,2, 3 or 4",0 
	WAIT_MS 100

;attend une selection d'un profil de joueur

loop_selec:

	call main_keyboard          ; attend une touche
	lds w, player_mem
	cpi w, 0
	brne PC+2
	jmp loop_selec             ; si aucun joueur sélectionné, on reboucle
	call welcome_player       ; sinon on affiche le message

;attend le lancement du jeu avec la touche espace

attente_space:
	
	call main_keyboard          ; attend encore une touche
	lds w, mode_mem
	cpi w, 0
	breq attente_space          ; tant qu'on n'a pas appuyé sur espace (qui met mode_mem à 1), on attend
	jmp mode_selec              ; ensuite, on quitte vers le mode jeu


;#######################################################################################
;			MODE JEU

jeu:
	lds _w, score
	call LCD_clear
	call	LCD_home
	PRINTF	LCD
	.db "your score is:",FDEC,17, 0, 0
	WAIT_MS 10
	call main_jeu	;appel la sous-routine qui excecute le jeu
	lds		w, mode_mem
	cpi		w, 1
	brne PC+2
	rjmp jeu
	jmp mode_selec


;#######################################################################################
;			MODE FIN
	
fin_jeu:
	call main_eeprom
	call main_keyboard
	lds		w, mode_mem
	cpi		w, 2
	brne PC+2
	rjmp fin_jeu
	
	jmp mode_selec



