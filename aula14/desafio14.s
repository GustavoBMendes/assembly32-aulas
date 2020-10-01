.section .data
	abert: .asciz "\nPrograma para calculo de media de turma\n\n"
	pedeNroAl: .asciz "\nDigite o numero de alunos => "
	pedeMedia: .asciz "\nDigite a media do aluno %d => "
	mostra: .asciz "\nMedia da turma = %d\n"

	mostraMenor: .asciz "\nMenor nota da turma = %d\n"
	mostraMaior: .asciz "\nMaior nota da turma = %d\n"

	nroAl: .int 0
	mediaA: .int 0
	mediaT: .int 0
	alunoN: .int 0

	menor: .int 101
	maior: .int 0

	tipo1: .asciz "%d"

.section .text

.globl _start
_start:

	pushl $abert
	call printf
	
	pushl $pedeNroAl
	call printf
	pushl $nroAl
	pushl $tipo1
	call scanf
	
	movl nroAl, %ecx
	movl $1, %ebx

	volta:

		pushl %ecx

		pushl %ebx
		pushl $pedeMedia
		call printf
		pushl $mediaA
		pushl $tipo1
		call scanf

		movl mediaT, %eax
		addl mediaA, %eax
		movl %eax, mediaT

		movl menor, %edx
		cmpl mediaA, %edx
		jg trocaMenor

		continua:

			movl maior, %edx
			cmpl mediaA, %edx
			jl trocaMaior

		continua2:
			addl $12, %esp
			popl %ebx
			popl %ecx

			incl %ebx

			loop volta

	movl $0, %edx
	movl mediaT, %eax
	divl nroAl
	movl %eax, mediaT
	
	pushl %eax
	pushl $mostra
	call printf

	pushl menor
	pushl $mostraMenor
	call printf

	pushl maior
	pushl $mostraMaior
	call printf

	jmp fim

	trocaMenor:

		movl mediaA, %eax
		movl %eax, menor
		movl $0, %edx
		jmp continua	

	trocaMaior:
	
		movl mediaA, %eax
		movl %eax, maior
		movl $0, %edx
		jmp continua2

	fim:

		movl $1, %eax
		movl $0, %ebx
		int $0x80

