.section .data

	abert: .asciz "\nPrograma para ordenar 3 numeros\n\n"
	
	pedeN: .asciz "\nDigite o numero %d => "
	mostra: .asciz "\nNumeros ordenados: %d, %d, %d\n\n"
	perg: .asciz "\nDeseja executar novamente? <S>im ou <N>ao? "

	tipoN: .asciz "%d"
	tipoC: .asciz " %c"

	n1: .int 0
	n2: .int 0
	n3: .int 0

	resp: .byte 'n'

.section .text

.globl _start
_start:

	pushl $abert
	call printf

	pushl $1
	pushl $pedeN
	call printf
	pushl $n1
	pushl $tipoN
	call scanf

	pushl $2
        pushl $pedeN
        call printf
        pushl $n2
        pushl $tipoN
        call scanf

	pushl $3
        pushl $pedeN
        call printf
        pushl $n3
        pushl $tipoN
        call scanf 
	
	addl $52, %esp

	movl n1, %eax
	movl n2, %ebx
	movl n3, %ecx

	cmpl %eax, %ebx
	jg n1_n2

n2_n1:
	xchgl %eax, %ebx

n1_n2:
	cmpl %ebx, %ecx
	jg print_regs
	xchgl %ebx, %ecx
	cmpl %eax, %ebx
	jg print_regs
	xchgl %eax, %ebx

print_regs:
	pushl %ecx
	pushl %ebx
	pushl %eax

fim:
	pushl $mostra
	call printf

	pushl $perg
	call printf
	pushl $resp
	pushl $tipoC
	call scanf

	add $28, %esp

	movb resp, %al
	cmpb $'s', %al
	je _start
	

	pushl $0
	call exit

