

.section .data
	pedido1: .asciz "\nEntrada de Dados:\n\nDigite A (single float) => "
	pedido2: .asciz "Digite B (double float) => "
	mostra1: .asciz "\nValor de A = %.4f\n"
	mostra2: .asciz "Valor de B = %.4lf\n"
	mostrasom: .asciz "\nOperacoes Realizadas:\n\B + A = %.4lf\n"
	mostrasub: .asciz "B - A = %.4lf\n"
	mostradiv: .asciz "B / A = %.4lf\n"
	mostramul: .asciz "B * A = %.4lf\n"
	mostratudo: .asciz "\nTudo Junto:\n\nmultiplicacao = %.2lf divisao = %.2lf subtracao = %.2lf soma = %.2lf\n\n"
	pulalin: .asciz "\n"
	formato1: .asciz "%f" # para simples precisão
	formato2: .asciz "%lf" # para dupla precisão
	float1: .space 4 # aqui tbem pode ser .single 0
	float2: .space 8 # aqui tbem pode ser .double 0

.section .text
.globl _start
_start:

1) lê um número ponto flutuante single (4 bytes) e o mostra como um número double (8 bytes)

	pushl $pedido1
	call printf
	pushl $float1
	pushl $formato1
	call scanf 		# le um valor em simples precisao (4 bytes)
	addl $12, %esp 		# limpa a Pilha do Sistema de 3 pushls
	flds float1 		# carrega variavel single float no topo da
				# Pilha PFU, convertendo 4 bytes em 80 bits
	subl $8, %esp 		# abre espaco de 8 bytes no topo da Pilha
				# do Sistema
	fstl (%esp) 		# copia do topo da pilha PFU para o topo da
				# Pilha do Sistema, convertendo 80 bits em 8
				# bytes
	pushl $mostra1
	call printf
	addl $4, %esp

Observacao 1: no trecho de código anterior, foi lido um float de 4 bytes, mas o mesmo foi mostrado como um float de 8 bytes. Isso foi feito porque printf sempre considera 8 bytes para floats, seja formatado com %f ou %lf 

Observacao 2: note que para mostrar o número lido com scanf usamos a sequencia de instrucoes fldx+subl+fstx


	pushl $0
	call exit

