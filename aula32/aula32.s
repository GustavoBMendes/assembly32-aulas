/*
Esse exemplo � baseado na pr�tica anterior que testa chamadas ao sistema. Aqui, gravamos uma sequencia de strings lidos no teclado em um arquivo de saida. 
*/

.section .data
	msgAbertura: 		.ascii "\nPrograma para Ler uma Sequencia de Strings de Arquivo\n"
	fimMsgAbertura:

	msgPedeArqEntrada: 	.ascii "\nEntre com o nome do arquivo de entrada\n> "
	fimMsgPedeArqEntrada:

	msgMostraStringLida: 	.asciz "\nNome Lido:%s.\n"
	fimMsgMostraStringLida:

	msgAcabou: 		.asciz ".\n.\nAcabou Arquivo..."
	fimMsgAcabou:

	msgFim: 		.asciz "\nAll is done!\n"
	fimMsgFim:

	.equ tamMsgAbertura, fimMsgAbertura-msgAbertura
	.equ tamMsgPedeArqEntrada, fimMsgPedeArqEntrada-msgPedeArqEntrada
	.equ tamMsgMostraStringLida, fimMsgMostraStringLida-msgMostraStringLida
	.equ tamMsgAcabou, fimMsgAcabou-msgAcabou
	.equ tamMsgFim, fimMsgFim-msgFim

	enter: 		.byte 10 	# c�digo ascii do line feed (pulalinha) = '\n'
	return: 	.byte 13 	# c�digo ascii do carriage return
	NULL: 		.byte 0 	# c�digo ascii do NULL = '\0'
	espaco: 	.byte 32 	# espaco em branco

	nomeArqEntrada:	.space 50
	stringLida: 	.space 80	# para ler 80 caracteres do arquivo de entrada 
	
	descritor: 	.int 0 		# para armazenar o descritor do arquivo de entrada


/*
As constantes abaixo se referem aos servi�os disponibilizados pelas chamadas ao sistema, devendo serem
passadas no registrador %eax
*/

	SYS_EXIT: 	.int 1
	SYS_FORK: 	.int 2
	SYS_READ: 	.int 3
	SYS_WRITE: 	.int 4
	SYS_OPEN: 	.int 5
	SYS_CLOSE: 	.int 6
	SYS_CREAT: 	.int 8

/*
Descritores de arquivo para sa�da e entrada padr�o
*/

	STD_OUT: 	.int 1 # descritor do video
	STD_IN: 	.int 2 # descritor do teclado

/*
Constante usada na chamada exit() para t�rmino normal
*/

	SAIDA_NORMAL: 	.int 0 # codigo de saida bem sucedida

/*
Constantes de configura��o do parametro flag da chamada open(). Estes valores s�o dependentes deimplementa��o.
*/

	O_RDONLY: 	.int 0x0000 # somente leitura
	O_WRONLY: 	.int 0x0001 # somente escrita
	O_RDWR: 	.int 0x0002 # leitura e escrita
	O_CREAT: 	.int 0x0040 # cria o arquivo na abertura, caso ele n�o exista
	O_EXCL: 	.int 0x0080 # for�a a cria��o
	O_APPEND: 	.int 0x0400 # posiciona o cursor do arquivo no final, para adi��o
	O_TRUNC: 	.int 0x0200 # reseta o arquivo aberto, deixando com tamanho 0 (zero)

/*
Constantes de configura��o do parametro mode da chamada open().
*/

	S_IRWXU: 	.int 0x01C0# user (file owner) has read, write and execute permission
	S_IRUSR: 	.int 0x0100 # user has read permission
	S_IWUSR: 	.int 0x0080 # user has write permission
	S_IXUSR: 	.int 0x0040 # user has execute permission
	S_IRWXG: 	.int 0x0038 # group has read, write and execute permission
	S_IRGRP: 	.int 0x0020 # group has read permission
	S_IWGRP: 	.int 0x0010 # group has write permission
	S_IXGRP: 	.int 0x0008 # group has execute permission
	S_IRWXO: 	.int 0x0007 # others have read, write and execute permission
	S_IROTH: 	.int 0x0004 # others have read permission
	S_IWOTH: 	.int 0x0002 # others have write permission
	S_IXOTH: 	.int 0x0001 # others have execute permission
	S_NADA: 	.int 0x0000 # n�o altera a situa��o

.section .text
.globl _start
_start:


aberturaPrograma:


	movl 	SYS_WRITE, %eax 	# seta o numero da chamada (do servi�o)
	movl 	STD_OUT, %ebx 		# seta o descritor do arquivo
	movl 	$msgAbertura, %ecx 	# seta o endere�o da string a ser mostrada
	movl 	$tamMsgAbertura, %edx 	# seta o n�mero de caracteres
	int 	$0x80 			# faz a chamada ao sistema

pedeArqEntrada:

	movl 	SYS_WRITE, %eax
	movl 	STD_OUT, %ebx
	movl 	$msgPedeArqEntrada, %ecx
	movl 	$tamMsgPedeArqEntrada, %edx
	int 	$0x80

leNomeArqEntrada:

/* Le tudo digitado ateh 50 caracteres, inclusive o caractere enter, mas nao coloca final
de string, oque eh exigido pelo printf.
*/

	movl 	SYS_READ, %eax
	movl 	STD_IN, %ebx
	movl 	$nomeArqEntrada, %ecx
	movl 	$50, %edx 		# le 50 caracteres no maximo
	int 	$0x80

insereFinalString:

/*
Sabe-se que %eax retorna a quantidade de caracteres lidos. O ultimo caracatere lido � o enter
*/
	movl 	$nomeArqEntrada, %edi
	subl	$1, %eax		# para compensar o deslocamento
	addl	%eax, %edi		# avan�a at� o enter
	movl	NULL, %eax
	movl	%eax, (%edi)		# coloca caracter final de string no lugar

abreArqLeitura:

	movl 	SYS_OPEN, %eax 		# system call OPEN
	movl 	$nomeArqEntrada, %ebx
	movl 	O_RDONLY, %ecx
	movl 	S_IRUSR, %edx
	int 	$0x80
	movl 	%eax, descritor 	# guarda o descritor retornado em %eax

leString:

/*
Faz a leitura de uma string de 80 caracteres do arquivo de entrada. Le continuamente strings de 80 caracteres, 
mas a ultima vez lida podera conter menos de 80 caracteres, pois ter� sido o final do arquivo.
*/

	movl 	SYS_READ, %eax
	movl 	descritor, %ebx
	movl 	$stringLida, %ecx
	movl 	$80, %edx
	int 	$0x80

imprimeString:

	pushl	%eax			# backup
	movl	%eax, %edx   		# %eax contem numero de caracteres lidos da ultima leitura
	movl 	SYS_WRITE, %eax
	movl 	STD_OUT, %ebx 		# recupera o descritor
	movl 	$stringLida, %ecx
	int 	$0x80
	popl	%eax			# recupera backup

/* ap�s a chamada, %eax retorna a quantidade de caracteres lidos. Compara-se com 80 para saber se o arquivo acabou */

	cmpl	$80, %eax
	jl	acabouArquivo

	jmp	leString		# volta para ler a proxima string

acabouArquivo:

	movl 	SYS_WRITE, %eax
	movl 	STD_OUT, %ebx 		# recupera o descritor
	movl 	$msgAcabou, %ecx
	movl 	$tamMsgAcabou, %edx
	int 	$0x80

fim:

	movl 	SYS_CLOSE, %eax		# fecha arquivo
	movl 	descritor, %ebx 	# recupera o descritor
	int 	$0x80

	movl 	SYS_WRITE, %eax
	movl 	STD_OUT, %ebx 		# recupera o descritor
	movl 	$msgFim, %ecx
	movl 	$tamMsgFim, %edx
	int 	$0x80

	movl 	SYS_EXIT, %eax
	movl 	SAIDA_NORMAL, %ebx
	int 	$0x80

