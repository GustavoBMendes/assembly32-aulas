.section .data 
	mostra1: .asciz "\nTeste %d: O conteudo do registrador eh = %X\n"
	mostra2: .asciz "\nTeste %d: Os valores dos registradores sao: %X e %X\n"
	mostra3: .asciz "\nTste %d:\n EAX = %X\n EBX = %X\n ECX = %X\n EDX = %X\n ESI = %X\n EDI = %X\n\n"

.section .text

.globl _start
_start:

	teste1:

		movl $0x12345678, %ebx
		pushl %ebx
		pushl $1
		pushl $mostra1
		call printf

	teste2:

		movw $0xABCD, %bx
		pushl %ebx
		pushl $2
		pushl $mostra1
		call printf

	teste3:

		movb $0xEE, %bh
		movb $0xFF, %bl
		pushl %ebx
		pushl $3
		pushl $mostra1
		call printf

		addl $36, %esp

	teste4:

		pushw %bx
		pushw %bx

		pushl $4
		pushl $mostra1
		call printf

	teste5:

		movl $0x12345678, %ebx

		roll $16, %ebx
		pushl %ebx
		pushl $5
		pushl $mostra1
		call printf

		#teste 6

		rolw $8, %bx
		pushl %ebx
		pushl $6
		pushl $mostra1
		call printf

		#teste 7

		rolb $4, %bl
		pushl %ebx
		pushl $7
		pushl $mostra1
		call printf

	teste8:

		movl $0x12345678, %ebx

		rorl $16, %ebx
		pushl %ebx
		pushl $8
		pushl $mostra1
		call printf

		#teste 9

		rorw $8, %bx
		pushl %ebx
		pushl $9
		pushl $mostra1
		call printf

		#teste 10

		rorb $4, %bl
		pushl %ebx
		pushl $10
		pushl $mostra1
		call printf

	teste11:

		movl $0x12345678, %ebx

		sall $16, %ebx
		pushl %ebx
		pushl $11
		pushl $mostra1
		call printf

		#teste 12

		movl $0x12345678, %ebx
		salw $8, %bx
		pushl %ebx
		pushl $12
		pushl $mostra1
		call printf

		#teste 13

		movl $0x12345678, %ebx
		salb $4, %bl
		pushl %ebx
		pushl $13
		pushl $mostra1
		call printf

	teste14:

		movl $0x12345678, %ebx

		sarl $16, %ebx
		pushl %ebx
		pushl $14
		pushl $mostra1
		call printf

		#teste 15

		movl $0x12345678, %ebx
		sarw $8, %bx
		pushl %ebx
		pushl $15
		pushl $mostra1
		call printf

		#teste 16

		movl $0x12345678, %ebx
		sarb $4, %bl
		pushl %ebx
		pushl $16
		pushl $mostra1
		call printf

	teste17:

		movl $0xAAAAAAAA, %eax
		movl $0xBBBBBBBB, %ebx
		movl $0xCCCCCCCC, %ecx
		movl $0xDDDDDDDD, %edx
		movl $0xEEEEEEEE, %esi
		movl $0xFFFFFFFF, %edi

		pushl %edi
		pushl %esi
		pushl %edx
		pushl %ecx
		pushl %ebx
		pushl %eax
		pushl $17
		pushl $mostra3
		call printf

		#teste18

		addl $8, %esp

		popl %eax
		popl %ebx
		popl %ecx
		popl %edx
		popl %esi
		popl %edi

		pushl %edi
		pushl %esi
		pushl %edx
		pushl %ecx
		pushl %ebx
		pushl %eax
		pushl $18
		pushl $mostra3
		call printf

	teste19:

		movl $0xAAAAAAAA, %ebx
		movl $0xBBBBBBBB, %esi

		pushl %esi
		pushl %EBX
		pushl $19
		pushl $mostra2
		call printf

		#teste20

		xchgl %ebx, %esi
		xchgw %bx, %si

		pushl %esi
		pushl %ebx
		pushl $20
		pushl $mostra2
		call printf


	pushl $0
	call exit
