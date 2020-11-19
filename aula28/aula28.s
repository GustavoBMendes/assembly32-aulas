.section .data

	titulo: .asciz "\nPrograma para calcular areas\n"
	menu: .asciz "\n1 - Quadratico\n2 - Circunferencia\n3 - Triangulo\n4 - Raízes da equacao\n5 - Sair\n> "
	msgerro: .asciz "\nOpcao invalida!\n"
	pedelado1: .asciz "\nDigite o lado 1: "
	pedelado2: .asciz "\nDigite o lado 2: "
	pederaio: .asciz "\nDigite o raio: "
	pedebase: .asciz "\nDigite a base: "
	pedealtura: .asciz "\nDigite a altura: "
	pedea: .asciz "\nCoeficiente a: "
	pedeb: .asciz "\nCoeficiente b: "
	pedec: .asciz "\nCoeficiente c: "

	mostraarea: .asciz "\nArea = %f\n"
	mostraraiz: .asciz "\nRaiz = %f"

	resp: .int 0

	a: .float 0
	b: .float 0
	c: .float 0

	lado1: .float 0
	lado2: .float 0

	base: .float 0
	altura: .float 0

	raio: .float 0

	dois: .float 2
	quatro: .float 4

	area: .double 0

	formanum: .asciz "%d"
	formanumf: .asciz "%f"

.section .text

.globl _start
_start:

	pushl $titulo
	call printf
	finit				#inicializa a FPU: reseta controle, status, flag e registradores

menuop:

	pushl $menu
	call printf
	pushl $resp
	pushl $formanum
	call scanf

	addl $16, %esp

	cmpl $1, resp
	jz calcquad
	cmpl $2, resp
	jz calccirc
	cmpl $3, resp
	jz calctri
	cmpl $4, resp
	jz calcraizes
	cmpl $5, resp
	jz fim

	pushl $msgerro 
	call printf
	jmp menuop

calcraizes:

	pushl $pedea
	call printf
	pushl $a
	pushl $formanumf
	call scanf	

	pushl $pedeb
	call printf
	pushl $b
	pushl $formanumf
	call scanf

	pushl $pedec
	call printf
	pushl $c
	pushl $formanumf
	call scanf

	flds a
	fmuls c
	fmuls quatro

	flds b
	fmuls b

	fsub %st(1), %st(0)

	fsqrt 

	fsubs b

	flds dois
	fmuls a

	fdiv %st(0), %st(1)

	subl $8, %esp
	fstpl (%esp)

	subl $8, %esp
	fstpl (%esp)

	pushl $mostraraiz
	call printf

	addl $40, %esp
	jmp menuop

calcquad:

	pushl $pedelado1
	call printf
	pushl $lado1
	pushl $formanumf
	call scanf

	pushl $pedelado2
	call printf
	pushl $lado2
	pushl $formanumf
	call scanf

	flds lado1
	fmuls lado2

	subl $8, %esp
	fstpl (%esp)

	pushl $mostraarea
	call printf

	addl $36, %esp

	jmp menuop

calccirc:

	pushl $pederaio	
	call printf
	pushl $raio
	pushl $formanumf
	call scanf

	flds raio
	fmuls raio
	fldpi
	fmul %st(1), %st(0)

	subl $8, %esp
	fstpl (%esp)
	pushl $mostraarea
	call printf

	addl $24, %esp
	jmp menuop

calctri:

	pushl $pedebase
	call printf
	pushl $base
	pushl $formanumf
	call scanf

	pushl $pedealtura
	call printf
	pushl $altura
	pushl $formanumf
	call scanf

	flds base
	fmuls altura 
	fdivs dois

	subl $8, %esp
	fstpl (%esp)
	pushl $mostraarea
	call printf

	addl $36, %esp
	jmp menuop

fim:

	pushl $0
	call exit
