####################################################
#  Programa de exemplo de interrup�ao do teclado   #
#  usando o Keyboard Display MMIO Tool		   #
#  ISC Nov 2017				           #
#  Marcus Vinicius			           #
####################################################

N�O FUNCIONA E N�O ENTENDI AINDA PORQUE.

.text
# programa do usu�rio
	li t1,0xFF200000	# Endere�o de controle do KDMMIO
	li t0,0x02		# bit 1 habilita/desabilita a interrup��o
	sw t0,0(t1)   		# Habilita interrup��o do teclado

 	la t0,KDInterrupt	# carrega em t0 o endere�o base das rotinas do sistema ECALL
 	csrrw zero,5,t0 	# seta utvec (reg 5) para o endere�o t0
 	csrrsi zero,0,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)
 
	li s0,0		# zera contador
CONTA:	   	# incrementa contador
	j CONTA			# volta ao loop
	

# rotina de tratamento da interrup��o
KDInterrupt: 	li t1,0xFF200000		# carrega o endere�o base do KDMMIO
  		lw t2,4(t1)  			# le a tecla
		sw t2,12(t1) 			# escreve no display

E_FIM:	csrrw t0, 65, zero	# le o valor de EPC salvo no registrador uepc (reg 65)
	addi t0, t0, 4		# soma 4 para obter a instru��o seguinte ao ecall
	csrrw zero, 65, t0	# coloca no registrador uepc
	uret			# retorna PC=uepc		
