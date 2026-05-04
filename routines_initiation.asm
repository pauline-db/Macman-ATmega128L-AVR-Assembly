;initialisation du pointeur z sur l'adresse qui contient le numéro du mode de la FSM
init_z:
	ldi zl, low(mode_mem)
	ldi zh, high(mode_mem)
	ret

;initialisation du pointeur x sur l'adresse qui contient le numéro du profile de joueur qui est utilisé
init_x:
	ldi xl,low(player_mem)
	ldi xh,high(player_mem) 
	ret

;initialisation de la mémoire aux adresses utilisées pour enregistré le score des joueurs à 0
init_eeprom:
	push r30
	push r31
	push w
	mov xl, w
	ldi xh, 0
	rcall select_adress_eeprom
	rcall eeprom_load
	cpi a0, 0xff
	brne PC+3
	ldi a0,0
	rcall eeprom_store
	pop w
	ADDI w,1
	pop r31
	pop r30
	cpi w, 4
	brne PC+2
	ret
	rjmp init_eeprom

