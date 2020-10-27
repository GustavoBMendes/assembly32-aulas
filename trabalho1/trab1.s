# exemplo de registro
#	nome: string de ateh 30 caracteres + caractere de final de string = 31 bytes
#	idade: tipo inteiro de 4 bytes
#	CPF:	11 caracteres + 1 final de string = 12 bytes ou 4 bytes para 1 inteiro
#	Genero: masculino ou feminimo -> M ou F -> 1 byte -> 4 bytes
#	prox: 4 bytes para conter o endereco do proximo registro
#	
#	total de bytes: 55 bytes

#nome completo, 
#endereço (rua, número, bairro, CEP, cidade, telefone, Email), 
#data de nascimento, 
#gênero, 
#CPF, RG, data de contratação, cargo e salário.

#MODOS:
#1 -> Inserção
#2 -> Remoção
#3 -> Consulta
#4 -> Relatório (printar todos regs)

.section .data

	msg_inicial: 	.asciz	"\nSELECIONE UMA DAS OPÇÕES ABAIXO:\n"
	menu:		.asciz	"1-Inserção\n2-Remoção\n3-Consulta\n4-Relatório\n0-Sair"
	msg_escolha:	.asciz	"\nDigite apenas o número da opção desejada: "
	abertura:	.asciz	"\nLeitura de Registro\n\n"
	pedenome:	.asciz	"\nDigite o nome: "
	pedeidade:	.asciz	"\nDigite sua idade: "
	pedecpf:	.asciz	"\nDigite o CPF: "
	pedegenero:	.asciz	"\nDigite o genero <M>asculino/<F>eminino "

	abert_remove:	.asciz	"\nEntre com um nome para remover seu registro."
	abert_consulta:	.asciz	"\nEntre com um nome para consultar seu registro."

	mostranome:	.asciz	"\nNome: %s"
	mostraidade:	.asciz	"\nIdade: %d"
	mostracpf:	.asciz	"\nCPF: %s"
	mostragenero:	.asciz	"\nGenero: %c"
	mostraprox:	.asciz	"\nEndereco do Proximo: %X\n\n"

	tamreg:		.int	55
	opcao:		.int 	0
	cont:		.int 	0
	nregs:		.int	0

	nome_consulta:	.asciz "gustavo" #exemplo

	tipoint:	.asciz	"%d"
	tipocar:	.asciz	"%c"
	tipostr:	.ASCIZ	"%S"

	lista:		.int	NULL
	prt_lista:	.int	0

	NULL:		.int	0

.section .text


.globl _start
_start:
	jmp 	main

call_ler:
	call	ler_registro
	jmp 	main

call_remocao:
	call 	remover_reg
	jmp		main

call_consulta:
	call 	consulta_reg
	jmp		main

call_relatorio:
	movl 	lista, %edi
	movl	nregs, %ebx
	call	relatorio
	movl	$0, cont
	jmp		main

main:
	pushl 	$msg_inicial
	call 	printf
	pushl 	$menu
	call 	printf
	pushl 	$msg_escolha
	call 	printf

	pushl 	$opcao
	pushl 	$tipoint
	call 	scanf

	addl	$20, %esp

	movl 	opcao, %eax
	cmpl 	$1, %eax
	je		call_ler

	cmpl	$2, %eax
	je		call_remocao

	cmpl	$3, %eax
	je		call_consulta

	cmpl	$4, %eax
	je		call_relatorio

	jmp 	fim

fim:
	pushl	$0
	call	exit

relatorio:
	pushl 	%edi

	pushl 	$mostranome
	call 	printf
	addl 	$4, %esp

	popl	%edi
	addl	$31, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostraidade
	call	printf
	addl	$8, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$mostracpf
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$12, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostragenero
	call	printf
	addl	$8, %esp

	popl 	%edi

	subl	$47, %edi
	movl	51(%edi), %edi

	pushl 	%ebx
	incl	cont
	cmpl 	cont, %ebx
	popl	%ebx
	jne		relatorio

	ret

remover_reg:
	pushl	$abert_remove
	call 	printf
	
	addl 	$4, %esp

	ret

consulta_reg:
	pushl 	$abert_consulta
	call 	printf

	#pushl	$nome_consulta
	#movl 	lista, %edi
	#pushl	%edi
	#call 	strcmp
	#cmpl	$0, %eax
	#je		ler_registro

	addl 	$4, %esp

	ret

ler_registro:

	pushl	$abertura
	call	printf
	
	pushl	tamreg
	call	malloc
	movl	%eax, lista
	addl	$8, %esp

	pushl	$pedenome
	call	printf
	addl	$4, %esp

	movl	lista, %edi
	pushl	%edi
	call 	gets
	call	gets

	popl	%edi
	addl	$31, %edi

	pushl	%edi

	pushl	$pedeidade
	call	printf
	addl	$4, %esp

	pushl	$tipoint
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi

	pushl	%edi

	pushl	$pedecpf
	call	printf
	addl	$4, %esp

	call	gets
	call	gets

	popl	%edi
	addl	$12, %edi

	pushl	%edi

	pushl	$pedegenero
	call	printf
	addl	$4, %esp

	pushl	$tipocar
	call	scanf
	addl	$4, %esp
	
	popl	%edi

	addl	$4, %edi

	movl	$NULL, (%edi)

	subl	$51, %edi
	movl 	prt_lista, %eax
	movl	%eax, 51(%edi)
	movl	%edi, prt_lista

	addl	$1, nregs

	ret

mostrar_registro:

	pushl	%edi

	pushl	$mostranome
	call	printf
	addl	$4, %esp
	
	popl	%edi
	addl	$31, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostraidade
	call	printf
	addl	$8, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$mostracpf
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$12, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostragenero
	call	printf
	addl	$8, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$mostraprox
	call	printf
	addl	$4, %esp

	popl	%edi


	ret



