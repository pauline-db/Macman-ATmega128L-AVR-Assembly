

;met la LED à la position @0 aux couleurs @1, @2, @3

.macro LED_SETUP
	; @0 = pixel index
	; @1 =  couleur 1
	; @2 = couleur 2
	; @3 = couleur 3
	ldi r17, 0x00
	ldi zl, low(niveau)
	ldi zh, high(niveau)
	add zl, @0
	adc zh, r17
	add zl, @0
	adc zh,r17
	add zl, @0
	adc zh, r17

	ldi	a0, @1	
	st	z+,a0
	ldi a0, @2
	st	z+,a0
	ldi	a0, @3
	st z+,a0
	.endmacro

;position d'une LED en entré, envoie le code RGB de celle-ci sur b0, b1, b2 en sortie
.macro GET_COLOR 
	ldi zl, low(niveau)
	ldi zh, high(niveau)
	ldi a0, 0x00

	add zl, @0				;multiplie par 3
	adc zh, a0
	add zl, @0	
	adc zh, a0	
	add zl, @0	
	adc zh, a0		
	
	ld	b0, z+
	ld	b1, z+
	ld	b2, z+
.endmacro

;compare une le code RGB d'une certaine LED en entrée avec les valeurs enregistrées sur b0, b1, b2
.macro COMPARE_COLOR
	GET_COLOR @0
	cpi		b0, @1
	brne	notequal
	cpi		b1, @2
	brne	notequal
	cpi		b2, @3
	brne	notequal

	ldi		w, 1
	sts		comp_couleur, w
	rjmp PC+3
notequal:
	ldi		w, 0
	sts		comp_couleur, w
.endmacro



;intialise les LEDS pour le niveau 1

.macro	LED_INIT_NIV1 
	ldi yl,low(niveau)
	ldi yh,high(niveau)
	ldi	zl,low(2*niveau1)
	ldi zh,high(2*niveau1)

	ldi b0, 64

imgld_loop1:
	lpm	a0, z+	; pixel 0-63, off
	st	y+,a0
	lpm a0,z+
	st	y+,a0
	lpm	a0, z+
	st y+,a0
	dec b0
	brne imgld_loop1

.endmacro

;initialise les LEDs pour le niveau 2

.macro	LED_INIT_NIV2 
	ldi yl,low(niveau)
	ldi yh,high(niveau)
	ldi	zl,low(2*niveau2)
	ldi zh,high(2*niveau2)

	ldi b0, 64

imgld_loop1:
	lpm	a0, z+	; pixel 0-63, off
	st	y+,a0
	lpm a0,z+
	st	y+,a0
	lpm	a0, z+
	st y+,a0
	dec b0
	brne imgld_loop1

.endmacro

;initialise les LEDs pour l'écran de victoire
.macro	LED_INIT_VICTOIRE 
	ldi yl,low(niveau)
	ldi yh,high(niveau)
	ldi	zl,low(2*victoire_display)
	ldi zh,high(2*victoire_display)

	ldi b0, 64

imgld_loop1:
	lpm	a0, z+	; pixel 0-63, off
	st	y+,a0
	lpm a0,z+
	st	y+,a0
	lpm	a0, z+
	st y+,a0
	dec b0
	brne imgld_loop1

.endmacro

;#######################################################################################
;			INITIALISATION ETAT RESET

.macro	INIT_ETAT

	ldi		r16, 0
	sts		etat_bonus_sp, r16
	
	ldi		r16, 0
	sts		etat_bonus1, r16
	
	ldi		r16, 0
	sts		etat_bonus2, r16
	
	ldi		r16, 0
	sts		etat, r16

	ldi		r16, 0
	sts		comp_couleur, r16


.endmacro

;#######################################################################################
;			INITIALISATION POSITION + ETAT NIVEAU 1

.macro INIT_NIV_1

	ldi		r16, 0
	sts		etat_ennemi1, r16
	
	ldi		r16, 0
	sts		etat_ennemi2, r16

	ldi		r16, 9
	sts		position, r16
	
	ldi		r16, 49
	sts		position_ennemi1, r16
	
	ldi		r16, 35
	sts		position_ennemi2, r16
	
	ldi		r16, 0
	sts		mouvement_ennemi1, r16
	
	ldi		r16, 0
	sts		mouvement_ennemi2, r16
	
	ldi		r16, 35
	sts		position_bonus_sp, r16
	
	ldi		r16, 52
	sts		position_bonus1, r16
	
	ldi		r16, 14
	sts		position_bonus2, r16

.endmacro

;#######################################################################################
;			INITIALISATION POSITION + ETAT NIVEAU 2

.macro INIT_NIV_2
	
	ldi		r16, 0
	sts		etat_ennemi1, r16
	
	ldi		r16, 0
	sts		etat_ennemi2, r16

	ldi		r16, 11
	sts		position, r16
	
	ldi		r16, 19
	sts		position_ennemi1, r16
	
	ldi		r16, 30
	sts		position_ennemi2, r16
	
	ldi		r16, 0
	sts		mouvement_ennemi1, r16
	
	ldi		r16, 0
	sts		mouvement_ennemi2, r16
	
	ldi		r16, 13
	sts		position_bonus_sp, r16
	
	ldi		r16, 9
	sts		position_bonus1, r16
	
	ldi		r16, 51
	sts		position_bonus2, r16

.endmacro

;############### ETAT + POSITION DES BONUS NIVEAU 1 ##########################

.macro MAJ_NIV1

	lds			r16, etat
	cpi			r16, 1
	brne		notdead_1
	jmp		initialisation
notdead_1:
	lds			r16, etat_bonus1
	tst			r16
	brne		pasbonus1_1
	lds			r16, position_bonus1
	LED_SETUP	r16, turquoise1, turquoise2, turquoise3
pasbonus1_1:
	lds			r16, etat_bonus2
	tst			r16
	brne		pasbonus2_1
	lds			r16, position_bonus2
	LED_SETUP	r16, turquoise1, turquoise2, turquoise3
pasbonus2_1:
	lds			r16, etat_bonus_sp
	tst			r16
	brne		pasbonus_sp_1
	lds			r16, position_bonus_sp
	LED_SETUP	r16, bleu1, bleu2, bleu3
pasbonus_sp_1:

;###############  NIVEAU 1 ENNEMI  ##########################
	
	lds			r16, etat_ennemi1						;pas d'ennemi 1 dans niveau 1
	tst			r16
	brne		pasennemi1_1
	lds			r16, position_ennemi1
	LED_SETUP	r16, rouge1, rouge2, rouge3
pasennemi1_1: 
	lds			r16, etat_ennemi2
	tst			r16
	brne		pasennemi2_1
	lds			r16, position_ennemi2
	LED_SETUP	r16, rouge1, rouge2, rouge3
pasennemi2_1:

;###############  NIVEAU 1 JOUEUR  ##########################

	lds			r16, position
	LED_SETUP	r16, jaune1, jaune2, jaune3


.endmacro

;############### NIVEAU 2 ETAT + POSITION DES BONUS  ##########################

.macro	MAJ_NIV2

	lds			r16, etat
	cpi			r16, 1
	brne		notdead_2
	jmp		initialisation
notdead_2 :
	lds			r16, etat_bonus1
	tst			r16
	brne		pasbonus1_2
	lds			r16, position_bonus1
	LED_SETUP	r16, turquoise1, turquoise2, turquoise3
	pasbonus1_2:
	lds			r16, etat_bonus2
	tst			r16
	brne		pasbonus2_2
	lds			r16, position_bonus2
	LED_SETUP	r16, turquoise1, turquoise2, turquoise3
	pasbonus2_2:
	lds			r16, etat_bonus_sp
	tst			r16
	brne		pasbonus_sp_2
	lds			r16, position_bonus_sp
	LED_SETUP	r16, bleu1, bleu2, bleu3
	pasbonus_sp_2: 
	
;############### NIVEAU 2 ENNEMI 1 + 2  ##########################

	lds			r16, etat_ennemi1
	tst			r16
	brne		pasennemi1_2
	lds			r16, position_ennemi1
	LED_SETUP	r16, rouge1, rouge2, rouge3
	pasennemi1_2: 
	lds			r16, etat_ennemi2
	tst			r16
	brne		pasennemi2_2
	lds			r16, position_ennemi2
	LED_SETUP	r16, rouge1, rouge2, rouge3
	pasennemi2_2:

;############### NIVEAU 2 JOUEUR  ##########################

	lds			r16, position
	LED_SETUP	r16, jaune1, jaune2, jaune3


.endmacro