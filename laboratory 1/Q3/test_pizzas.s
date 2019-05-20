.data
.include "pizzas.s"

.text

CALL_TESTS:
	# Testa a fun��o INIT
	call TEST_INIT
	addi a1, zero, 1
	beq  a0, zero, DEBUG
	
	call TEST_SORTEIO
	addi a1, zero, 1
	beq  a0, zero, DEBUG
	
	call FIM

# Fun��es devem retornar (TRUE = 1) se n�o houve nenhum erro (FALSE = 0) se houveram erros.
TEST_INIT: 
	call INIT
	

TEST_SORTEIO:
	call SORTEIO

# Deve mostrar na tela qual fun��o est� errada
DEBUG:
	call FIM

FIM:
	li a7, 10
	ecall