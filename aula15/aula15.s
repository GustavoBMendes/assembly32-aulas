.section .data

	abert: .asciz "\nPrograma para classificar triangulos\n\n"

	pedeL1: .asciz "\nEntre com o valor do lado 1: "
	pedeL2: .asciz "\nEntre com o valor do lado 2: "
	pedeL3: .asciz "\nEntre com o valor do lado 3: "

	esca: .asciz "\nO triangulo de lados %d, %d, %d eh escaleno.\n"
	iso: .asciz "\nO triangulo de lados %d, %d, %d eh isosceles.\n"
	equi: .asciz "\nO triangulo de lados %d, %d, %d eh equilatero.\n"

	formato: .asciz "%d"

	lado1: .int 0
	lado2: .int 0
	lado3: .int 0

.section .text

.globl _start
_start:

	pushl $abert
	call printf

	pushl $pedeL1
	call printf
	pushl $lado1
	pushl $formato
	call scanf

	pushl $pedeL2
	call printf
	pushl $lado2
	pushl $formato
	call scanf

	pushl $pedeL3
	call printf
	pushl $lado3
	pushl $formato
	call scanf

	addl $40, %esp

	movl lado2, %eax
	cmpl lado1, %eax
	jne n1DIFn2
	jmp n1IGUALn2

	n1IGUALn2:
		movl lado3, %eax
		cmpl lado1, %eax
		jne isosceles
		jmp equilatero

	n1DIFn2:
		movl lado3, %eax
		cmpl lado1, %eax
		jne n1DIFn3
		jmp isosceles

	n1DIFn3:
		movl lado3, %eax
		cmpl lado2, %eax
		jne escaleno
		jmp isosceles

	equilatero:
		pushl lado3
		pushl lado2
		pushl lado1
		pushl $equi
		jmp fim

	isosceles:
		pushl lado3
		pushl lado2
		pushl lado1
		pushl $iso
		jmp fim

	escaleno:
		pushl lado3
		pushl lado2
		pushl lado1
		pushl $esca
		jmp fim

	fim:
		call printf
		pushl $0
		call exit

