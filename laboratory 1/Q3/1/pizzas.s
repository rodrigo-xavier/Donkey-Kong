.data

N: .word 6 	# N�mero de Casas/Clientes
C: .space 160 	# Espa�o em bytes correspondente a 2 coordenadas x 20 casas (m�x) x 4 bytes, 

.text

INIT: 
	la t0, N
	lw a0, 0(t0)
	la a1, C
	jal SORTEIO

SORTEIO:
	call FIM
	

FIM:
	li a7, 10
	ecall