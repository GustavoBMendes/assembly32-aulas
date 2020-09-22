.section .data 
	pedeDado: .asciz "\nEntre com um numero inteiro: "
	pedeN: .asciz "\nEntre com um valor inteiro de n: "
	mostraSoma: .asciz "\nConteudo do reg depois da soma: %d\n"
	mostraMult: .asciz "\nConteudo do reg depois da multiplicacao: %d\n"

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

	soma:
		movl dado, %ebx
		movl dado, %eax
		rorl $16, %eax

		addw %ax, %bx
		pushl %ebx
		pushl $mostraSoma
		call printf

	multiplicacao:
		movl n, %ecx
		sall %cl, %ebx
		pushl %ebx
		pushl $mostraMult
		call printf

	pushl $0
	call exit
