#Esse exemplo � baseado na pr�tica anterior que testa chamadas ao sistema. Aqui, gravamos uma sequencia de strings lidos no teclado em um arquivo de saida. 


.section .data
	msgAbertura: .ascii "\nPrograma para Gravar uma Sequ�ncia de Strings em Arquivo\n"
	fimMsgAbertura:
	msgPedeNomeArqSaida: .ascii "\nEntre com o nome do arquivo de saida\n> "
	fimMsgPedeNomeArqSaida:
	msgPedeString: .ascii "\nDigite uma String pelo teclado: "
	fimMsgPedeString:
	msgMostraStringLida: .asciz "\nString Lida: %s Tamanho: %d\n"
	fimMsgMostraStringLida:
	msgDesejaContinuar: .asciz "\nDeseja Continuar: <0>Nao ou <1>Sim? => "
	fimMsgDesejaContinuar:
	msgFim: .asciz "\nAll is done!"
	fimMsgFim:

	.equ tamMsgAbertura, fimMsgAbertura-msgAbertura
	.equ tamMsgPedeString, fimMsgPedeString-msgPedeString
	.equ tamMsgPedeNomeArqSaida, fimMsgPedeNomeArqSaida-msgPedeNomeArqSaida
	.equ tamMsgMostraStringLida, fimMsgMostraStringLida-msgMostraStringLida
	.equ tamMsgDesejaContinuar, fimMsgDesejaContinuar-msgDesejaContinuar
	.equ tamMsgFim, fimMsgFim-msgFim
	enter: .byte 10 # c�digo ascii do line feed (pulalinha) = '\n'
	return: .byte 13 # c�digo ascii do carriage return
	NULL: .byte 0 # c�digo ascii do NULL = '\0'
	espaco: .byte ' ' # espaco em branco
	pulalin: .asciz "\n" # string com pulalinha linha para o printf
	nomeArqSaida: .space 50
	stringLida: .space 80
	opcao: .int 0
	tam: .int 0
	formato: .asciz "%d"
	descritor: .int 0

#As constantes abaixo se referem aos servi�os disponibilizados pelas chamadas ao sistema, devendo serem
#passadas no registrador %eax

	SYS_EXIT: .int 1
	SYS_FORK: .int 2
	SYS_READ: .int 3
	SYS_WRITE: .int 4
	SYS_OPEN: .int 5
	SYS_CLOSE: .int 6
	SYS_CREAT: .int 8

#Descritores de arquivo para sa�da e entrada padr�o

	STD_OUT: .int 1 # descritor do video
	STD_IN: .int 2 # descritor do teclado

#Constante usada na chamada exit() para t�rmino normal

	SAIDA_NORMAL: .int 0 # codigo de saida bem sucedida

#Constantes de configura��o do parametro flag da chamada open(). Estes valores s�o dependentes deimplementa��o.

	O_RDONLY: .int 0x0000 # somente leitura
	O_WRONLY: .int 0x0001 # somente escrita
	O_RDWR: .int 0x0002 # leitura e escrita
	O_CREAT: .int 0x0040 # cria o arquivo na abertura, caso ele n�o exista
	O_EXCL: .int 0x0080 # for�a a cria��o
	O_APPEND: .int 0x0400 # posiciona o cursor do arquivo no final, para adi��o
	O_TRUNC: .int 0x0200 # reseta o arquivo aberto, deixando com tamanho 0 (zero)

#Constantes de configura��o do parametro mode da chamada open().

	S_IRWXU: .int 0x01C0# user (file owner) has read, write and execute permission
	S_IRUSR: .int 0x0100 # user has read permission
	S_IWUSR: .int 0x0080 # user has write permission
	S_IXUSR: .int 0x0040 # user has execute permission
	S_IRWXG: .int 0x0038 # group has read, write and execute permission
	S_IRGRP: .int 0x0020 # group has read permission
	S_IWGRP: .int 0x0010 # group has write permission
	S_IXGRP: .int 0x0008 # group has execute permission
	S_IRWXO: .int 0x0007 # others have read, write and execute permission
	S_IROTH: .int 0x0004 # others have read permission
	S_IWOTH: .int 0x0002 # others have write permission
	S_IXOTH: .int 0x0001 # others have execute permission
	S_NADA: .int 0x0000 # n�o altera a situa��o

.section .text
.globl _start
_start:

#Abertura do Programa.

	movl SYS_WRITE, %eax # seta o numero da chamada (do servi�o)
	movl STD_OUT, %ebx # seta o descritor do arquivo
	movl $msgAbertura, %ecx # seta o endere�o da string a ser mostrada
	movl $tamMsgAbertura, %edx # seta o n�mero de caracteres
	int $0x80 # faz a chamada ao sistema

#Leitura do Nome do Arquivo de Saida

	movl SYS_WRITE, %eax
	movl STD_OUT, %ebx
	movl $msgPedeNomeArqSaida, %ecx
	movl $tamMsgPedeNomeArqSaida, %edx
	int $0x80

#O segmento a seguir le tudo digitado ateh 50 caracteres, inclusive o caractere enter, mas nao coloca final
#de string, conforme padrao do printf.

	movl SYS_READ, %eax
	movl STD_IN, %ebx
	movl $nomeArqSaida, %ecx
	movl $50, %edx # le 50 caracteres no maximo
	int $0x80
	movl $nomeArqSaida, %edi

#Vamos imprimir qual o tamanho da string segundo a biblioteca C. Observe que o tamanho eh 1 a mais do que o numero de caracteres lidos validos de fato. Entretando, apohs o ultimo caracetere (enter) existem varios 0's (final de string) na memoria, "por sorte", na verdade, apenas quando os programas iniciam e por isso as chamadas a strlen e printf nao causaram segmentation fault.

	pusha
	pushl $nomeArqSaida
	call strlen
	addl $4, %esp
	movl %eax, tam
	popa
	pushl tam
	pushl $nomeArqSaida
	pushl $msgMostraStringLida
	call printf
	addl $12, %esp

#Para corrigir o tamanho, o segmento a seguir coloca o final de string no lugar do enter usando o tamanho
#retornado pela funcao strlen. Entretanto, observe que strlen somente funcionara devido aos 0s na
#memoria, existentes apos o caractere enter.

	movb NULL, %al # substitui o ultimo caracter (enter) por fim de string
	movl $nomeArqSaida, %edi
	decl tam # ajusta o tamanho em 1 a menos
	addl tam, %edi
	movb %al, (%edi) # coloca o final de string
	pushl tam
	pushl $nomeArqSaida
	pushl $msgMostraStringLida
	call printf
	addl $12, %esp

#O segmento a seguir faz a leitura de Strings via Teclado. Le strings de no maximo 80 caracteres, mas podem ser menores. A string lida tamb�m cont�m o enter no final, mas podemos deixa-lo na string e colocarmos um final de string apohs o enter para garantir finalizacao correta e nao por acaso, e aproveitar para pular linha na gravacao do arquivo. Primeiro cria e/ou abre o arquivo resetando.

	movl SYS_OPEN, %eax # system call OPEN: retorna o descritor em %eax
	movl $nomeArqSaida, %ebx
	movl O_WRONLY, %ecx
	orl O_CREAT, %ecx
	orl O_TRUNC, %ecx
	movl S_IRUSR, %edx
	orl S_IWUSR, %edx
	int $0x80
	movl %eax, descritor # guarda o descritor

leStrings:

	movl SYS_WRITE, %eax
	movl STD_OUT, %ebx
	movl $msgPedeString, %ecx
	movl $tamMsgPedeString, %edx
	int $0x80
	movl SYS_READ, %eax
	movl STD_IN, %ebx
	movl $stringLida, %ecx
	movl $80, %edx
	int $0x80

#Como diversas strings sao lidas na sequencia, a memoria fica suja e os 0s j� nao funcionam mais. Nao existirah garantia de que as funcoes strlen e printf, e todas aquelas que dependem do caractere de "final de string", funcionem. O correto eh percorrer a string lida ateh encontrar o enter e inserir apohs o caractere final de string Coloca Final de String

	movl $stringLida, %edi # posicao do primeiro caractere
	movl $0,%ecx # inicia contador de posicoes

localizaEnter:

	addl $1, %ecx
	movb (%edi), %al
	cmpb enter, %al
	jz concluiStringLida
	addl $1, %edi
	jmp localizaEnter

concluiStringLida:

	movl %ecx, tam
	movb NULL, %al # substitui o ultimo caracter (enter) por fim de string
	incl %edi # avanca a frente do caractere enter, mantendo-o
	movb %al, (%edi) # coloca/reforca o final de string
	pushl tam
	pushl $stringLida
	pushl $msgMostraStringLida
	call printf
	addl $12, %esp

#Escreve a String Lida no Arquivo de Saida.

	movl SYS_WRITE, %eax
	movl descritor, %ebx # recupera o descritor
	movl $stringLida, %ecx
	movl tam, %edx
	int $0x80

#Pergunta por continuidade da escrita

	pushl $msgDesejaContinuar
	call printf
	pushl $opcao
	pushl $formato
	call scanf
	addl $12, %esp
	movl opcao, %eax
	cmpl $0, %eax
	jne leStrings

fim:
	#Antes fecha o arquivo

	movl SYS_CLOSE, %eax
	movl descritor, %ebx # recupera o descritor
	int $0x80
	pushl $msgFim
	call printf
	addl $4, %esp
	movl SYS_EXIT, %eax
	movl SAIDA_NORMAL, %ebx
	int $0x80

#DESAFIO: Fa�a um programa similar, que leia strings de um arquivo de entrada e as imprima no video.
