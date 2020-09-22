.section .data 
	pedeDado: .asciz "\nEntre com um numero inteiro: "
	pedeN: .asciz "\nEntre com um valor inteiro de n: "
	mostraSoma: .asciz "\nConteudo do reg depois da soma: %d\n"

	dado: .int 0
	n: .int 0

	formato: .asciz "%d"

.section .text

.globl _start
_start:

	pushl $pedeDado
	call printf

	pushl $dado
	pushl $formato
	call scanf

	pushl $pedeN
	call printf

	pushl $n
	pushl $formato
	call scanf

	movl dado, %ebx

	addb %bh, %bl

	pushl %ebx
	pushl $mostraSoma
	call printf

	soma:
		

	pushl $0
	call exit
