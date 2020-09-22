.section .data 

	saida: .asciz "Teste %d: Resultado = H: %X D: %d\n\n"
	saida2: .asciz "Teste %d: Quoc > H: %X D: %d e Resto > H: %X D: %d\n\n"
	saida3: .asciz "Teste %d: Resultado = %X:%X\n\n"

.section .text
.globl _start
_start:

	movl $0x12340000, %eax
	movl $0x00005678, %ebx
	addl %ebx, %eax
	pushl %eax
	pushl %eax
	pushl $1
	pushl $saida
	call printf

	movl $0xCFFF1234, %eax
	movl $0xDFFF5678, %ebx
	addl %ebx, %eax
	pushl %eax
	pushl %eax
	pushl $2
	pushl $saida
	call printf

	movl $0x11001234, %eax
	movl $0x00114321, %ebx
	addw %bx, %ax
	pushl %eax
	pushl %eax
	pushl $3
	pushl $saida
	call printf

	movl $0xFFFFF456, %eax
	movl $0xFFFFFCBB, %ebx
	addw %bx, %ax
	pushl %eax
	pushl %eax
	pushl $4
	pushl $saida
	call printf

	movl $0x11005534, %eax
	movl $0x0011AA21, %ebx
	addb %bl, %al
	pushl %eax
	pushl %eax
	pushl $5
	pushl $saida
	call printf

	movl $0xFFFFFF56, %eax
	movl $0xFFFFFFBB, %ebx
	addb %bl, %al
	pushl %eax
	pushl %eax
	pushl $6
	pushl $saida
	call printf

	movl $0x11005534, %eax
	movl $0x0011AA21, %ebx
	addb %bh, %ah
	pushl %eax
	pushl %eax
	pushl $7
	pushl $saida
	call printf

	movl $0xFFFFFF56, %eax
	movl $0xFFFFFFBB, %ebx
	addb %bh, %ah
	pushl %eax
	pushl %eax
	pushl $8
	pushl $saida
	call printf

	movl $0x12345678, %eax
	movl $0x02040608, %ebx
	subl %ebx, %eax
	pushl %eax
	pushl %eax
	pushl $9
	pushl $saida
	call printf

	movl $-1412627919, %eax
	movl $-2627000, %ebx
	subl %ebx, %eax
	pushl %eax
	pushl %eax
	pushl $10
	pushl $saida
	call printf

	movl $0x12345678, %eax
	movl $0x02040608, %ebx
	subw %bx, %ax
	pushl %eax
	pushl $11
	pushl $saida
	call printf

	movl $-0x1234ABFF, %eax
	movl $-0xABFF, %ebx
	subw %bx, %ax
	pushl %eax
	pushl %eax
	pushl $12
	pushl $saida
	call printf

	movl $0x12345678, %eax
	movl $0x02040608, %ebx
	subb %bl, %al
	pushl %eax
	pushl %eax
	pushl $13
	pushl $saida
	call printf

	movl $-0x1234ABFF, %eax
	movl $-0xABFF, %ebx
	subb %bl, %al
	pushl %eax
	pushl %eax
	pushl $14
	pushl $saida
	call printf

	movl $0x12345678, %eax
	movl $0x02040608, %ebx
	subb %bh, %ah
	pushl %eax
	pushl %eax
	pushl $15
	pushl $saida
	call printf

	movl $-0x1234ABFF, %eax
	movl $-0xABFF, %ebx
	subb %bh, %ah
	pushl %eax
	pushl %eax
	pushl $16
	pushl $saida
	call printf

	movl $0xA4, %eax
	incl %eax
	incw %ax
	incb %al
	pushl %eax
	pushl %eax
	pushl $17
	pushl $saida
	call printf

	movl $0xA4, %eax
	decl %eax
	decw %ax
	decb %al
	pushl %eax
	pushl %eax
	pushl $18
	pushl $saida
	call printf

	movl $0x0000A4C8, %edx
	movl $0x00001234, %eax
	movl $0xA4C80, %ebx
	divl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $19
	pushl $saida2
	call printf

	movl $0x0000A4C8, %edx
	movl $0x00001234, %eax
	movl $-0xA4C80, %ebx
	idivl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $20
	pushl $saida2
	call printf
	
	movl $-0x0000A4C8, %edx
	subl $1, %edx
	movl $-0x00001234, %eax
	movl $0xA4C80, %ebx
	idivl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $21
	pushl $saida2
	call printf

	movl $0, %edx
	movl $0x24682467, %eax
	movl $2, %ebx
	divl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $22
	pushl $saida2
	call printf

	movl $0, %edx
	movl $0x24682467, %eax
	movl $-2, %ebx
	idivl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $23
	pushl $saida2
	call printf

	movl $-0x24682467, %eax
	movl $2, %ebx
	cdq
	idivl %ebx
	pushl %edx
	pushl %edx
	pushl %eax
	pushl %eax
	pushl $24
	pushl $saida2
	call printf

	movl $0, %eax
	movl $0x1, %edx
	movl $0xFF17, %ax
	movl $0xFF00, %bx
	divw %bx
	pushl %edx
	pushl %eax
	pushl $25
	pushl $saida
	call printf

	movl $0, %eax
	movl $0, %edx
	movw $0x01F7, %ax
	movb $0xF0, %bl
	divb %bl
	movl %eax, %edx
	sarw $8, %dx
	pushl %edx
	andw $0x00FF, %ax
	pushl %eax
	pushl $26
	pushl $saida2
	call printf

	movl $0xFFFFFFFF, %eax
	movl $0x2, %ebx
	mull %ebx
	pushl %eax
	pushl %edx
	pushl $27
	pushl $saida3
	call printf

	movl $0, %edx
	movl $0, %eax
	movw $0xFFFF, %ax
	movw $0x2, %bx
	mulw %bx
	pushl %eax
	pushl %edx
	pushl $28
	pushl $saida3
	call printf

	movl $0, %edx
	movl $0, %eax
	movb $0xFF, %al
	movb $0x2, %bl
	mulb %bl
	pushl %eax
	pushl $29
	pushl $saida
	call printf			

	pushl $0
	call exit
