.section .data 

	pedido1: .asciz "\nTeste %d: Digite um valore inteiro => "
	mostra1: .asciz "Teste %d: Número digitado = %d\n"
	numero: .int 0
	formato1: .asciz "%d"
	pedido2: .asciz "\nTeste %d: Digite um caractere => "
	mostra2: .asciz "Teste %d: Caractere digitado = %c\n"
	tecla: .int 'A'
	formato2: .asciz "%c"
	pedido3: .asciz "\nTeste %d: Digite uma string => "
	mostra3: .asciz "Teste %d: String digitada = %s\n"
	frase: .space 64
	formato3: .asciz "%s"
	pedido4: .asciz "\nTeste %d: Digite 2 números:\n N1 = "
	pedido5: .asciz " N2 = "
	n1: .int 0
	n2: .int 0
	formatox: .asciz " %c" #despreza o <enter> e pega o próximo
	mostra4: .asciz "Teste %d: Números lidos: n1 = %d e n2 = %d\n"
	mostra5: .asciz "Teste %d: n1 igual a n2\n"
	mostra6: .asciz "Teste %d: n2 menor que n1\n"
	mostra7: .asciz "Teste %d: n2 maior que n1\n"
	mostra8: .asciz "Teste %d: Acabou as comparações!\n"
	pedido6: .asciz "\nTeste %d: Quantos giros quer no loop? "
	mostra9: .asciz "Teste %d: Girando %d...\n"
	mostra10: .asciz "Teste %d: Acabou o loop!\n\n"
	ngiros: .int 0

.section .text
.globl _start
_start:

	pushl $1
	pushl $pedido2
	call printf
	pushl $tecla
	pushl $formato2
	call scanf
	pushl tecla
	pushl $1
	pushl $mostra2
	call printf

	pushl $2
	pushl $pedido1
	call printf
	pushl $numero
	pushl $formato1
	call scanf
	pushl numero
	pushl $2
	pushl $mostra1
	call printf	

	pushl $3
	pushl $pedido3
	call printf
	pushl $frase
	pushl $formato3
	call scanf
	pushl $frase
	pushl $3
	pushl $mostra3
	call printf

	pushl $4
	pushl $pedido1
	call printf
	pushl $numero
	pushl $formato1
	call scanf
	pushl numero
	pushl $4
	pushl $mostra1
	call printf
	pushl $4
	pushl $pedido2
	call printf
	pushl $tecla
	pushl $formato2
	call scanf
	pushl tecla
	pushl $4
	pushl $mostra2
	call printf
	pushl $4
	pushl $pedido3
	call printf
	pushl $frase
	pushl $formato3
	call scanf

	pushl $frase
	pushl $4
	pushl $mostra3
	call printf
	pushl $4
	pushl $pedido2
	call printf
	pushl $tecla
	pushl $formato2
	call scanf
	pushl tecla
	pushl $4
	pushl $mostra2
	call printf

	pushl $5
	pushl $pedido1
	call printf
	pushl $numero
	pushl $formato1
	call scanf
	pushl numero
	pushl $5
	pushl $mostra1
	call printf
	pushl $5
	pushl $pedido2
	call printf
	pushl $tecla
	pushl $formatox
	call scanf
	pushl tecla
	pushl $5
	pushl $mostra2
	call printf
	pushl $5
	pushl $pedido3
	call printf
	pushl $frase
	pushl $formato3
	call scanf
	pushl $frase
	pushl $5	
	pushl $mostra3
	call printf
	pushl $5
	pushl $pedido2
	call printf

	pushl $tecla
	pushl $formatox
	call scanf
	pushl tecla
	pushl $5
	pushl $mostra2
	call printf

	pushl $6
	pushl $pedido4
	call printf
	pushl $n1
	pushl $formato1
	call scanf
	pushl $6
	pushl $pedido5
	call printf
	pushl $n2
	pushl $formato1
	call scanf
	pushl n2
	pushl n1
	pushl $6
	pushl $mostra4
	call printf
	movl n2, %ebx # %eax e %ecx são alterados no printf. %ebx não.
	cmpl n1, %ebx
	je saoiguais #aqui tambem serve o jz
	jl n2menorn1
	jmp n1menorn2
	
	saoiguais:
		pushl $6
		pushl $mostra5
		call printf
		jmp fim

	n2menorn1:
		pushl $6
		pushl $mostra6
		call printf
		jmp fim

	n1menorn2:
		pushl $6
		pushl $mostra7
		call printf
		jmp fim

	fim:
		pushl $6
		push $mostra8
		call printf

	pushl $7
	pushl $pedido6
	call printf
	pushl $ngiros
	pushl $formato1
	call scanf
	movl ngiros, %ecx

	volta2:
		movl %ecx, %ebx # backup de %ecx, pois ele eh alterado no printf
		pushl %ecx
		pushl $7
		pushl $mostra9
		call printf
		movl %ebx, %ecx
		loop volta2
		pushl $7
		pushl $mostra10
		call printf

	pushl $0
	call exit

