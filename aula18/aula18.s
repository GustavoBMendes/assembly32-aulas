.section .data
	titulo: .asciz "\nPrograma para inverter vetor\n"
	pedeTam: .asciz "\nDigite o tamanho do vetor (maximo=%d) => "
	pedeNum: .asciz "Entre com o elemento %d => "
	tipoNum: .asciz "%d"

	mostraVet: .asciz "Vetor Original: "
	mostraElem: .asciz " %d"
	mostraVetInv: .asciz "Vetor invertido: "
	mostraSoma: .asciz "Soma do vetor: %d"
	pulaLin: .asciz "\n"

	maxTam: .int 30
	tam: .int 0
	num: .int 0
	soma: .int 0
	alocacao: .int 0

	vetor: .space 0 #4 bytes para cada numero a ser armazenado

.section .text

.globl _start
_start:

	pushl 	$titulo
	call 	printf
	
	call 	leTam
	call 	leVetor
	movl	$mostraVet, %eax
	call 	mostraVetor
	call	inverteVetor
	movl 	$mostraVetInv, %eax
	call 	mostraVetor
	call 	somaVet
	
	fim:
		pushl 	$0
		call 	exit

	leTam:
		pushl 	maxTam
		pushl 	$pedeTam
		call	printf
		pushl	$tam
		pushl 	$tipoNum
		call 	scanf
		addl 	$16, %esp
	
		movl	tam, %eax
		cmpl	$0, %eax
		jle	leTam
		movl $4, %eax
		movl tam, %ebx
		movl %ebx, alocacao
		mull alocacao
		movl %eax, vetor

		ret
	
	leVetor:
		movl 	tam, %ecx
		movl 	$vetor, %edi
		movl	$1, %ebx

	leNum:

		pushl 	%ebx
		pushl 	%ecx
		pushl 	%edi

		pushl 	%ebx
		pushl 	$pedeNum
		call 	printf
		pushl 	%edi
		pushl 	$tipoNum
		call	scanf
		addl 	$16, %esp

		popl	%edi
		popl	%ecx
		popl	%ebx

		incl	%ebx
		addl 	$4, %edi
		loop	leNum
	
		ret

	mostraVetor:
		pushl 	%eax
		call	printf
		addl 	$4, %esp
		movl	$vetor, %edi
		movl	tam, %ecx

	volta:
		pushl 	%ecx
		pushl	%edi
		
		movl	(%edi), %eax
		pushl	%eax
		pushl 	$mostraElem
		call	printf
		addl	$8, %esp

		popl	%edi
		popl	%ecx

		addl 	$4, %edi
		loop 	volta

		pushl 	$pulaLin
		call 	printf
		addl 	$4, %esp

		ret

	inverteVetor:
		movl 	$vetor, %esi
		movl 	%esi, %edi

		movl 	tam, %eax
		decl	%eax
		movl	$4, %ebx
		mull	%ebx
		addl 	%eax, %edi

		movl 	$0, %edx
		movl 	tam, %eax
		movl 	$2, %ebx
		divl	%ebx
		movl 	%eax, %ecx

	volta2:

		movl 	(%esi), %eax
		movl 	(%edi), %ebx
		movl	%ebx, (%esi)
		movl	%eax, (%edi)
		
		addl	$4, %esi
		subl	$4, %edi
	
		loop 	volta2

		ret
	
	somaVet:
		movl    $vetor, %edi
                movl    tam, %ecx

        volta3:
                pushl   %ecx
                pushl   %edi

                movl    (%edi), %eax
		addl	soma, %eax
        	movl 	%eax, soma

                popl    %edi
                popl    %ecx

                addl    $4, %edi
                loop    volta3

		pushl 	soma
		pushl 	$mostraSoma
		call printf
                pushl   $pulaLin
                call    printf
                addl    $12, %esp
		
		ret
	
