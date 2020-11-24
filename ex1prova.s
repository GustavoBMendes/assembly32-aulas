#ALUNO: GUSTAVO BELANÇON MENDES - RA 99037
.section .data
	titulo: .asciz "\nProva 1 - exercício 1 de PIHS 2020\n"
	pedeTam: .asciz "\nDigite o tamanho do vetor => "
	pedeNum: .asciz "Entre com o elemento %d => "
	tipoNum: .asciz "%d"

	mostraVetInvertido: .asciz "Vetor Invertido: "
	mostraElem: .asciz "%d/"
	mostraVetInv: .asciz "Vetor invertido: "
	mostraSoma: .asciz "Soma do vetor: %d"
	pulaLin: .asciz "\n"
	pedeConsulta: .asciz "Digite um elemento para ser consultado: "
	mostraConsulta: .asciz "\nElemento %d encontrado na posicao %d\n"
	naoencontrado: .asciz "\nO elemento desejado nao foi encontrado!\n"

	tam: .int 0
	num: .int 0
	soma: .int 0
	alocacao: .int 0
	elemento: .int 0

	vetor: .int 0

.section .text

.globl _start
_start:

	pushl $titulo
	call printf
	
	call leTam
	call leVetor
	movl $mostraVetInvertido, %eax
	call mostraVetor
	call consultaVetor
	
fim:
	pushl $0
	call exit

leTam:
	pushl $pedeTam
	call printf
	pushl $tam
	pushl $tipoNum
	call scanf
	addl $12, %esp

	movl tam, %eax
	cmpl $0, %eax
	jle	leTam
	movl $4, %eax
	movl tam, %ebx
	movl %ebx, alocacao
	mull alocacao
	movl %eax, vetor

	ret

leVetor:
	movl tam, %ecx
	movl $vetor, %edi
	movl $1, %ebx

leNum:

	pushl %ebx
	pushl %ecx
	pushl %edi

	pushl %ebx
	pushl $pedeNum
	call printf
	pushl %edi
	pushl $tipoNum
	call scanf
	addl $16, %esp

	popl %edi
	popl %ecx
	popl %ebx

	movl (%edi), %eax
	cmpl $0, %eax
	jle leNum

	incl %ebx
	addl $4, %edi
	loop leNum

	subl $4, %edi
	ret

mostraVetor:
	pushl %eax
	call printf
	addl $4, %esp
	movl tam, %ecx

volta:
	pushl %ecx
	pushl %edi
	
	movl (%edi), %eax
	pushl %eax
	pushl $mostraElem
	call printf
	addl $8, %esp

	popl %edi
	popl %ecx

	subl $4, %edi
	loop volta

	pushl $pulaLin
	call printf
	addl $4, %esp

	ret

consultaVetor:
	pushl $pedeConsulta
	call printf
	pushl $elemento
	pushl $tipoNum
	call scanf
	addl $12, %esp
	movl $vetor, %edi
	movl tam, %ecx
	movl $1, %ebx

volta2:
	pushl %ecx
	pushl %edi
	
	movl (%edi), %eax

	cmpl elemento, %eax
	je igual

	popl %edi
	popl %ecx

	addl $4, %edi
	incl %ebx
	loop volta2

	pushl $pulaLin
	call printf
	addl $4, %esp

	pushl $naoencontrado
	call printf
	add $4, %esp
	ret

igual:
	pushl %ebx
	pushl elemento
	pushl $mostraConsulta
	call printf

	addl $12, %esp
	popl %edi
	popl %ecx

	ret
