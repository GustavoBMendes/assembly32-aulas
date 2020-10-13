.section .data
	abertP: .asciz "\nPrograma para calculo de area de figuras\n\n"
	menuOp: .asciz "\nMenu de opcoes:\n<1>Retangulo\n<2>Triangulo\n<3>Circunferencia\n<Qualquer numero>Sair\n"
	abertR: .asciz "\nCalculo da area do retangulo\n"
	abertT: .asciz "\nCalculo da area do triangulo\n"
	abertC: .asciz "\nCalculo da area da circunferencia\n"

	pergR: .asciz "\nDigite o lado %d = "
	pergT1: .asciz "\nDigite a base = "
	pergT2: .asciz "\nDigite a altura = "
	pergC: .asciz "\nDigite o raio = "

	resp: .asciz "\nArea = %d\n\n"

	tipo: .asciz "%d"

	opcao: .int 0
	lado1: .int 0
	lado2: .int 0
	base: .int 0
	altura: .int 0
	raio: .int 0
	areaR: .int 0
	areaT: .int 0
	areaC: .int 0

	pi: .int 3

.section .text
.globl _start
_start:

	pushl $abertP
	call printf
	pushl $menuOp
	call printf
	pushl $opcao
	pushl $tipo
	call scanf

	movl opcao, %eax
	cmpl $1, %eax
	je _calc_ret

	cmpl $2, %eax
	je _calc_tri
	
	cmpl $3, %eax
	je _calc_circ

	jmp fim

	_calc_ret:
		call calc_ret
		jmp _start

	_calc_tri:
		call calc_tri
		jmp _start

	_calc_circ:
		call calc_circ
		jmp _start

	fim:
		pushl $0
		call exit

	calc_ret:
		pushl $abertR
                call printf

                pushl $1
                pushl $pergR
                call printf
                pushl $lado1
                pushl $tipo
                call scanf

                pushl $2
                pushl $pergR
                call printf
                pushl $lado2
                pushl $tipo
                call scanf

                movl lado2, %eax
                mull lado1

                movl %eax, areaR
                pushl %eax
                pushl $resp
                call printf

		add $44, %esp

                ret

	calc_tri:
		pushl $abertT
		call printf

		pushl $pergT1
		call printf
		pushl $base
		pushl $tipo
		call scanf
		
		pushl $pergT2
		call printf
		pushl $altura
		pushl $tipo
		call scanf

		movl altura, %eax
		mull base
		movl $2, %ebx
		divl %ebx

		movl %eax, areaT
		pushl %eax
		pushl $resp
		call printf

		addl $36, %esp

		ret

	calc_circ:
		pushl $abertC
		call printf
		
		pushl $pergC
		call printf
		pushl $raio
		pushl $tipo
		call scanf

		movl raio, %eax
		mull raio
		mull pi

		movl %eax, areaC
		pushl %eax
		pushl $resp
		call printf

		addl $24, %esp

		ret

