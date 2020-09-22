.section .data
	saida: .asciz "Soma: %d + %d + %d = %d\n"
	n1: .int 10
	n2: .int 25
	n3: .int 5
	v1: .int 10, 25, 5

.section .bss
	.lcomm res, 4

.section .text
.globl _start
_start:

	pushl res
	pushl n3
	pushl n2
	push n1
	pushl $saida
	call printf
	addl $20, %esp

	movl $v1, %edi
	movl (%edi), %eax
	addl $4, %edi
	addl (%edi), %eax
	addl $4, %edi
	addl (%edi), %eax
	movl %eax, res

	pushl res
	pushl n3
	pushl n2
	pushl n1
	pushl $saida
	call printf
	pushl $0
	call exit
	
