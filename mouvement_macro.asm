;#######################################################################################
;			MOUVEMENT RIGHT
;#######################################################################################

.macro RIGHT
	lds		w, position
	subi	w, 1

;detecte une collision avec un ennemi
	COMPARE_COLOR	w, rouge1, rouge2, rouge3
	lds		w, comp_couleur
	cpi		w, 1
	breq	mort_int
	rjmp	PC+2
	mort_int :
	rjmp mort

;detecte une collision avec un mur
	lds		w, position
	subi	w, 1
	COMPARE_COLOR	w, violet1, violet2, violet3
	lds		w, comp_couleur
	cpi		w, 1
	breq	same_int
	rjmp PC+2
	same_int :
	rjmp same

;detecte une collision avec un bonus
	lds		w, position
	subi	w, 1
	COMPARE_COLOR	w, turquoise1, turquoise2, turquoise3
	lds		w, comp_couleur
	cpi		w, 1
	breq	points_int
	rjmp PC+2
	points_int :
	rjmp	points

;detecte une collision avec le bonus spécial
	lds		w, position
	subi	w, 1
	COMPARE_COLOR	w, bleu1, bleu2, bleu3
	lds		w, comp_couleur
	cpi		w, 1
	breq	bonus_sp_int
	rjmp	PC+2
	bonus_sp_int :
	rjmp	bonus_sp

;detecte une collision avec la sortie
	lds		w, position
	subi	w, 1
	COMPARE_COLOR	w, vert1, vert2, vert3
	lds		w, comp_couleur
	cpi		w, 1
	breq	fin_int
	rjmp	resume
	fin_int :
	rjmp	fin

;aucune collision a été détectée
resume :
	lds		w, position
	subi	w, 0x01
	sts		position, w
	rjmp	same

;collision avec ennemi
mort :
	lds		w, etat
	cpi		w, 2
	breq	mange

	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w

	rjmp	same

;super pouvoir --> mange un des deux ennemies
mange :
	lds		w, position
	subi	w, 1
	lds		a0, position_ennemi1
	cp		w, a0
	brne	mort_ennemi2 
mort_ennemi1 :
	ldi		w, 1
	sts		etat_ennemi1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume
mort_ennemi2 :
	ldi		w, 1
	sts		etat_ennemi2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume 

;collision avec bonus
points :
	lds		w, position
	subi	w, 0x01
	sts		position, w

	lds		a0, position_bonus1
	cp		w, a0
	breq	bonus1
	lds		a0, position_bonus2
	cp		w, a0
	breq	bonus2

bonus1 :
	ldi		w, 1
	sts		etat_bonus1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

bonus2 :
	ldi		w, 1
	sts		etat_bonus2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

;collision avec bonus spécial
bonus_sp :
	ldi		w, 1
	sts		etat_bonus_sp, w
	ldi		w, 2
	sts		etat, w
	rjmp resume

;colision avec sortie
fin :
	lds		w, etat_niveau
	ADDI	w, 1
	sts		etat_niveau, w
	cpi		w, 1
	breq	change_niveau
	cpi		w, 2
	breq	victoire
	rjmp	resume

change_niveau :
	ldi		w, 1
	sts		etat, w
	rjmp	same

victoire :
	ldi		w, 1
	sts		etat, w
	rjmp	same

;collision avec mur
same:

	;nothing happens

.endmacro

;#######################################################################################
;			MOUVEMENT LEFT
;#######################################################################################

.macro LEFT
	lds		w, position
	ADDI	w, 1

;detecte une collision avec un ennemi
	COMPARE_COLOR	w, rouge1, rouge2, rouge3
	lds		w, comp_couleur
	cpi		w, 1
	breq	mort_int
	rjmp	PC+2
	mort_int :
	rjmp mort

;detecte une collision avec un mur
	lds		w, position
	ADDI	w, 1
	COMPARE_COLOR	w, violet1, violet2, violet3
	lds		w, comp_couleur
	cpi		w, 1
	breq	same_int
	rjmp PC+2
	same_int :
	rjmp same

;detecte une collision avec un bonus
	lds		w, position
	ADDI	w, 1
	COMPARE_COLOR	w, turquoise1, turquoise2, turquoise3
	lds		w, comp_couleur
	cpi		w, 1
	breq	points_int
	rjmp PC+2
	points_int :
	rjmp	points

;detecte une collision avec le bonus spécial
	lds		w, position
	ADDI	w, 1
	COMPARE_COLOR	w, bleu1, bleu2, bleu3
	lds		w, comp_couleur
	cpi		w, 1
	breq	bonus_sp_int
	rjmp	PC+2
	bonus_sp_int :
	rjmp	bonus_sp

;detecte une collision avec la sortie
	lds		w, position
	ADDI	w, 1
	COMPARE_COLOR	w, vert1, vert2, vert3
	lds		w, comp_couleur
	cpi		w, 1
	breq	fin_int
	rjmp	resume
	fin_int :
	rjmp	fin

;aucune collision a été détectée
resume :
	lds		w, position
	ADDI	w, 0x01
	sts		position, w
	rjmp	same

;collision avec ennemi
mort :
	lds		w, etat
	cpi		w, 2
	breq	mange

	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w

	rjmp	same

;super pouvoir --> mange un des deux ennemies
mange :
	lds		w, position+1
	lds		a0, position_ennemi1
	cp		w, a0
	brne	mort_ennemi2 
mort_ennemi1 :
	ldi		w, 1
	sts		etat_ennemi1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume
mort_ennemi2 :
	ldi		w, 1
	sts		etat_ennemi2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume

;collision avec bonus
points :
	lds		w, position
	ADDI	w, 0x01
	sts		position, w

	lds		a0, position_bonus1
	cp		w, a0
	breq	bonus1
	lds		a0, position_bonus2
	cp		w, a0
	breq	bonus2

bonus1 :
	ldi		w, 1
	sts		etat_bonus1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

bonus2 :
	ldi		w, 1
	sts		etat_bonus2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

;collision avec bonus spécial
bonus_sp :
	ldi		w, 1
	sts		etat_bonus_sp, w
	ldi		w, 2
	sts		etat, w
	rjmp resume

;colision avec sortie
fin :
	lds		w, etat_niveau
	ADDI	w, 1
	sts		etat_niveau, w
	cpi		w, 1
	breq	change_niveau
	cpi		w, 2
	breq	victoire
	rjmp	resume

change_niveau :
	ldi		w, 1
	sts		etat, w
	rjmp	same

victoire :
	ldi		w, 1
	sts		etat, w
	rjmp	same

;collision avec mur
same:
	;nothing happens
.endmacro
;#######################################################################################
;			MOUVEMENT UP
;#######################################################################################
.macro UP
	lds		w, position
	ADDI	w, 8

;detecte une collision avec un ennemi
	COMPARE_COLOR	w, rouge1, rouge2, rouge3
	lds		w, comp_couleur
	cpi		w, 1
	breq	mort_int
	rjmp	PC+2
	mort_int :
	rjmp mort

;detecte une collision avec un mur
	lds		w, position
	ADDI	w, 8
	COMPARE_COLOR	w, violet1, violet2, violet3
	lds		w, comp_couleur
	cpi		w, 1
	breq	same_int
	rjmp PC+2
	same_int :
	rjmp same

;detecte une collision avec un bonus
	lds		w, position
	ADDI	w, 8
	COMPARE_COLOR	w, turquoise1, turquoise2, turquoise3
	lds		w, comp_couleur
	cpi		w, 1
	breq	points_int
	rjmp PC+2
	points_int :
	rjmp	points

;detecte une collision avec le bonus spécial
	lds		w, position
	ADDI	w, 8
	COMPARE_COLOR	w, bleu1, bleu2, bleu3
	lds		w, comp_couleur
	cpi		w, 1
	breq	bonus_sp_int
	rjmp	PC+2
	bonus_sp_int :
	rjmp	bonus_sp

;detecte une collision avec la sortie
	lds		w, position
	ADDI	w, 8
	COMPARE_COLOR	w, vert1, vert2, vert3
	lds		w, comp_couleur
	cpi		w, 1
	breq	fin_int
	rjmp	resume
	fin_int :
	rjmp	fin

	;aucune collision a été détectée
resume :
	lds		w, position
	ADDI	w, 0x08
	sts		position, w
	rjmp	same

;collision avec ennemi
mort :
	lds		w, etat
	cpi		w, 2
	breq	mange

	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w
	rjmp	same

;super pouvoir --> mange un des deux ennemies
mange :
	lds		w, position
	ADDI	w,8
	lds		a0, position_ennemi1
	cp		w, a0
	brne	mort_ennemi2 
mort_ennemi1 :
	ldi		w, 1
	sts		etat_ennemi1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume
mort_ennemi2 :
	ldi		w, 1
	sts		etat_ennemi2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume

;collision avec bonus
points :
	lds		w, position
	ADDI	w, 0x08
	sts		position, w

	lds		a0, position_bonus1
	cp		w, a0
	breq	bonus1
	lds		a0, position_bonus2
	cp		w, a0
	breq	bonus2

bonus1 :
	ldi		w, 1
	sts		etat_bonus1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

bonus2 :
	ldi		w, 1
	sts		etat_bonus2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

;collision avec bonus spécial
bonus_sp :
	ldi		w, 1
	sts		etat_bonus_sp, w
	ldi		w, 2
	sts		etat, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp resume

;colision avec sortie
fin :
	lds		w, etat_niveau
	ADDI	w, 1
	sts		etat_niveau, w
	cpi		w, 1
	breq	change_niveau
	cpi		w, 2
	breq	victoire
	rjmp	resume

change_niveau :
	ldi		w, 1
	sts		etat, w
	rjmp	same

victoire :
	ldi		w, 1
	sts		etat, w
	rjmp	same

;collision avec mur
same:
	;nothing happens
.endmacro
;#######################################################################################
;			MOUVEMENT DOWN
;#######################################################################################
.macro DOWN
	lds		w, position
	subi	w, 8

;detecte une collision avec un ennemi
	COMPARE_COLOR	w, rouge1, rouge2, rouge3
	lds		w, comp_couleur
	cpi		w, 1
	breq	mort_int
	rjmp	PC+2
	mort_int :
	rjmp mort

;detecte une collision avec un mur
	lds		w, position
	subi	w, 8
	COMPARE_COLOR	w, violet1, violet2, violet3
	lds		w, comp_couleur
	cpi		w, 1
	breq	same_int
	rjmp PC+2
	same_int :
	rjmp same

;detecte une collision avec un bonus
	lds		w, position
	subi	w, 8
	COMPARE_COLOR	w, turquoise1, turquoise2, turquoise3
	lds		w, comp_couleur
	cpi		w, 1
	breq	points_int
	rjmp PC+2
	points_int :
	rjmp	points

;detecte une collision avec le bonus spécial
	lds		w, position
	subi	w, 8
	COMPARE_COLOR	w, bleu1, bleu2, bleu3
	lds		w, comp_couleur
	cpi		w, 1
	breq	bonus_sp_int
	rjmp	PC+2
	bonus_sp_int :
	rjmp	bonus_sp

;detecte une collision avec la sortie
	lds		w, position
	subi	w, 8
	COMPARE_COLOR	w, vert1, vert2, vert3
	lds		w, comp_couleur
	cpi		w, 1
	breq	fin_int
	rjmp	resume
	fin_int :
	rjmp	fin

;aucune collision a été détectée
resume :
	lds		w, position
	subi	w, 0x08
	sts		position, w
	rjmp same

;collision avec ennemi
mort :
	lds		w, etat
	cpi		w, 2
	breq	mange

	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w

	rjmp	same

;super pouvoir --> mange un des deux ennemies
mange :
	ldi		w, position-8
	lds		a0, position_ennemi1
	cp		w, a0
	brne	mort_ennemi2 
mort_ennemi1 :
	ldi		w, 1
	sts		etat_ennemi1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume
mort_ennemi2 :
	ldi		w, 1
	sts		etat_ennemi2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	resume

;collision avec bonus
points :
	lds		w, position
	subi	w, 0x08
	sts		position, w

	lds		a0, position_bonus1
	cp		w, a0
	breq	bonus1
	lds		a0, position_bonus2
	cp		w, a0
	breq	bonus2

bonus1 :
	ldi		w, 1
	sts		etat_bonus1, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

bonus2 :
	ldi		w, 1
	sts		etat_bonus2, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp	same

;collision avec bonus spécial
bonus_sp :
	ldi		w, 1
	sts		etat_bonus_sp, w
	ldi		w, 2
	sts		etat, w
	lds		w, score
	ADDI	w, 1
	sts		score, w
	rjmp resume

;colision avec sortie
fin :
	lds		w, etat_niveau
	ADDI	w, 1
	sts		etat_niveau, w
	cpi		w, 1
	breq	change_niveau
	cpi		w, 2
	breq	victoire
	rjmp	resume

change_niveau :
	ldi		w, 1
	sts		etat, w
	rjmp	same

victoire :
	ldi		w, 1
	sts		etat, w
	rjmp	same

;collision avec mur
same:
	;nothing happens
.endmacro

;#######################################################################################
;			MOUVEMENT ENNEMI HORIZONTAL
;#######################################################################################

.macro MOV_ENNEMI_HOR

;test si le mouvement doit être effectué à droite ou à gauche
	lds		w,mouvement_ennemi1			;test for zero
	tst		w
	breq	testright

	lds		w, position_ennemi1		;testleft
	ADDI	w, 1
	GET_COLOR w
	rjmp same1

testright :
	lds		w, position_ennemi1		
	subi	w, 1
	GET_COLOR w

;detecte s'il y a une collision avec un mur ou le joueur dans la direction du déplacement
same1:
	cpi		b0, violet1
	breq	same2
	cpi		b0, jaune1
	breq	same2
	rjmp	resume

same2:
	cpi		b1, violet2
	breq	same3
	cpi		b1, jaune2
	breq	same3
	rjmp	resume

same3:
	cpi		b2, violet3
	breq	same
	cpi		b2, jaune3
	breq	mange
	rjmp	resume

;mange le joueur
mange :
	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w

;effectue le mouvement
resume:
	lds		w, mouvement_ennemi1
	tst		w			;test for zero
	breq	right

left:
	lds		w, position_ennemi1		;left
	ADDI	w, 0x01
	sts		position_ennemi1, w
	rjmp	end

right:
	lds		w, position_ennemi1
	subi	w, 0x01
	sts		position_ennemi1, w
	rjmp	end

;change de direction du mouvement
same:
	lds		w, mouvement_ennemi1
	tst		w
	breq	left_to_right

right_to_left :
	ldi		w, 0
	sts		mouvement_ennemi1, w
	rjmp	end

left_to_right :
	ldi		w, 1
	sts		mouvement_ennemi1, w
	rjmp	end

end:

.endmacro

;#######################################################################################
;			MOUVEMENT ENNEMI VERTICAL
;#######################################################################################


.macro MOV_ENNEMI_VER

;test si le mouvement doit être effectué en haut ou en bas
	lds		w,mouvement_ennemi2			;test for zero
	tst		w
	breq	testdown

	lds		w, position_ennemi2		;testleft
	ADDI	w, 8
	GET_COLOR w
	rjmp same1

testdown :
	lds		w, position_ennemi2		
	subi	w, 8
	GET_COLOR w

;detecte s'il y a une collision avec un mur ou le joueur dans la direction du déplacement
same1:
	cpi		b0, violet1
	breq	same2
	cpi		b0, jaune1
	breq	same2
	rjmp	resume

same2:
	cpi		b1, violet2
	breq	same3
	cpi		b1, jaune2
	breq	same3
	rjmp	resume

same3:
	cpi		b2, violet3
	breq	same
	cpi		b2, jaune3
	breq	mange
	rjmp	resume

;mange le joueur
mange :
	ldi		w, 1
	sts		etat, w

	ldi		w, 0
	sts		score, w

;effectue le mouvement
resume:
	lds		w, mouvement_ennemi2
	tst		w			;test for zero
	breq	down

up:
	lds		w, position_ennemi2		;left
	ADDI	w, 0x08
	sts		position_ennemi2, w
	rjmp	end

down:
	lds		w, position_ennemi2
	subi	w, 0x08
	sts		position_ennemi2, w
	rjmp	end

;change de direction du mouvement
same:
	lds		w, mouvement_ennemi2
	tst		w
	breq	up_to_down

down_to_up :
	ldi		w, 0
	sts		mouvement_ennemi2, w
	rjmp end

up_to_down :
	ldi		w, 1
	sts		mouvement_ennemi2, w
end:

.endmacro
