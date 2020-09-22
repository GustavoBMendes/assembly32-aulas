.section .data
	lado1: .int 0
	lado2: .int 0
	area: .int 0

	abert: .asciz "Programa para calculo de area de triangulo"
	perg1: .asciz "Digite a base = "
	perg2: .asciz "Digite a altura = "
	res: .asciz "Area do triangulo = %d\n"

	tipo: .asciz "%d"

.section .text
.globl _start
_start:

	
	pushl $abert
	call printf

	pushl $perg1
	call printf

	pushl $lado1
	pushl $tipo
	call scanf

	pushl $perg2
	call printf

	pushl $lado2
	pushl $tipo
	call scanf

	movl lado1, %eax
	mull lado2

	movl $2, %ebx
	divl %ebx

	pushl %eax
	pushl $res
	call printf

	addl $36, %esp

	pushl $0
	call exit

