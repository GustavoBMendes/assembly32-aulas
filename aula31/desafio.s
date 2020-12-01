/*
Sobre as Chamadas ao Sistema

As operações de entrada e saída no linux são feitas por meio de operaçõesdenominadas "chamadas ao sistema", ou “system calls”, as quais são de fato interrupções de software (interrompem o SO para solicitar serviço) realizadas usando a instrução “int” para da classe de interrupcoes numero “0x80” e setando os parametros corretamente, os quais são passados por meio de registradores.

O primeiro parametro eh implícito e informa o numero da interrupcao (número do serviço requisitado), o qual deve estar em %eax. Os demais parametros são explícitos,ou seja, são as informações necessárias para a execução do serviço requisitado e sao passados na seguinte ordem de registradores: %ebx, %ecx, %edx, %esi e %edi, para o primeiro, segundo, terceiro, quarto e quinto parametro, respectivamente.

As chamadas existentes no linux podem ser encontradas no arquivo unistd.h e uma explicacao de cada uma pode ser encontrada no comando man, digitando: "man 2 nome_da_chamada". Ela é mostrada na forma de um protótipo de função de alto nivel com os parametros necessários entre parenteses. Observe neste exemplo que usamos a diretiva .equ para definir constantes. As constantes definidas dessa forma funcionam diferentes das variáveis normais no sentido de que o conteúdo é resgatado usando $, oque nas variáveis resgata o endereço.
*/
.section .data
	outvid: 	.ascii "\nMsg teste impressa no video usando chamada write()\n"
	fimoutvid:
	pedealgo: 	.ascii "\nDigite algo pelo teclado: "
	fimpedealgo:
	strarqout: 	.ascii "\nMsg teste impressa no arquivo usando chamada write()\n"
	fimstrarqout:
	pedearqin: 	.ascii "\nEntre com o nome do arquivo de entrada\n> "
	fimpedearqin:
	pedearqout: 	.ascii "\nEntre com o nome do arquivo de saida\n> "
	fimpedearqout:
	mostrain: 	.ascii "\nEntrada Original em Caracteres Suja = "
	fimmostrain:
	mostrainlimpa: 	.ascii "\nEntrada Original em Caracteres Limpa = "
	fimmostrainlimpa:
	buffer: 	.ascii "12345678901234567890123456789012345678901234567890"
	fimbuffer:
	pergunta: 	.asciz "\n\nConverter a entrada para:\n<1> Inteiro\n<2> Real\n > "
	mostratam: 	.asciz "\n\nTamanho da Entrada Valida: %d\n"
	mostraintoint: 	.asciz "\nEntrada Convertida para Numero Inteiro = %d\n"
	mostrastrarqin: .asciz "\nString Lida:\n%s\n"
	mostraintofloat: .asciz "\nEntrada Convertida para Numero PF = %.2lf\n"
	mostranomearq: 	.asciz "\nNome do Arquivo: %s\n"
	msgfim: 	.asciz "\nAll is done!"
	pedearqtam: 	.ascii "\nEntre com o numero de linhas do arquivo:\n> "

	.equ tamoutvid, fimoutvid-outvid
	.equ tamstrarqout, fimstrarqout-strarqout
	.equ tampedearqin, fimpedearqin-pedearqin
	.equ tampedearqout, fimpedearqout-pedearqout
	.equ tampedealgo, fimpedealgo-pedealgo
	.equ tambuffer, fimbuffer-buffer
	.equ tammostrain, fimmostrain-mostrain
	.equ tammostrainlimpa, fimmostrainlimpa-mostrainlimpa

	enter: 		.byte 10 	# código ascii do line feed (pulalinha) = '\n'
	return: 	.byte 13 	# código ascii do carriage return
	NULL: 		.byte 0 	# código ascii do NULL = '\0'
	espaco: 	.byte ' ' 	# espaco em branco
	formato: 	.asciz "%d" 	# formato de entrada para o scanf
	pulalin: 	.asciz "\n" 	# string com pulalinha linha para o printf
	nomearqin: 	.int 0
	nomearqout: 	.space 50
	opcao: 		.int 0
	tam: 		.int 0
	valorint: 	.int 0
	valorreal: 	.double 0.0

	#As constantes abaixo se referem aos serviços disponibilizados pelas chamadas ao sistema, devendo serem passadas no registrador %eax

	SYS_EXIT: 	.int 1
	SYS_FORK: 	.int 2
	SYS_READ: 	.int 3
	SYS_WRITE: 	.int 4
	SYS_OPEN: 	.int 5
	SYS_CLOSE: 	.int 6
	SYS_CREAT: 	.int 8

	#Descritores de arquivo para saída e entrada padrão
	STD_OUT: .int 1 # descritor do video
	STD_IN: .int 2 # descritor do teclado

	#Constante usada na chamada exit() para término normal
	SAIDA_NORMAL: .int 0 # codigo de saida bem sucedida

	#Constantes de configuração do parametro flag da chamada open(). Estes valores são dependentes de implementação. Para se ter certeza dos valores corretos, compile oprograma no final deste arquivo usando "gcc valoresopen.c -o valoresopen" e execute-o usando "./valoresopen". Caso seja diferente, corrija as definicoes abaixo.

	O_RDONLY: 	.int 0x0000 # somente leitura
	O_WRONLY:	.int 0x0001 # somente escrita
	O_RDWR: 	.int 0x0002 # leitura e escrita
	O_CREAT: 	.int 0x0040 # cria o arquivo na abertura, caso ele não exista
	O_EXCL: 	.int 0x0080 # força a criação
	O_APPEND: 	.int 0x0400 # adiciona n final do arquivo
	O_TRUNC: 	.int 0x0200 # reseta o arquivo (tamanho fica com 0)

	#Constantes de configuração do parametro mode da chamada open().

	S_IRWXU: 	.int 0x01C0 # user has read, write and execute permission
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
	S_NADA: 	.int 0x0000 # não altera a situação

	tamstrarqin: 	.int 80

.section .bss
	.lcomm strarqin, 80

.section .text
.globl _start

_start:

#7) Escreve no Arquivo de Saida.

#	Abre o arquivo, se ele não existir, cria-o, depois escreve uma string e fecha o arquivo. Os prototipos utilizados são mostrados a seguir. O número da chamada open() é 5 e da chamada close() é 6. Pathname é um endereço da string que contém o nome do arquivo a ser aberto, incluindo o caminho do diretório. Flags é um inteiro que indica o modo básico de acesso "somente leitura", "somente escrita" ou "leitura-escrita", que pode ser 0, 1 ou 2, respectivamente. Pode-se adicionar características específicas ao modo básico de abertura para especializar a abertura. Estas adições são feitas por uma operação "OR Bitwised". Mode descreve as opcoes de permissóes de abertura.

# int open(const char *pathname, int flags, mode_t mode)
# int close(int fd)

lenomearqin:
	movl 	SYS_WRITE, %eax
	movl 	STD_OUT, %ebx
	movl 	$pedearqin, %ecx
	movl 	$tampedearqin, %edx
	int 	$0x80
	movl 	SYS_READ, %eax
	movl 	STD_IN, %ebx
	movl 	$nomearqin, %ecx
	movl 	$50, %edx # le inclusive o enter
	int 	$0x80
	movl 	$nomearqin, %edi
	call 	tratanomearq
	jmp 	learqin

tratanomearq:
	pushl 	%edi # empilha a posicao inicial da string do nome
	movl 	$-1,%ebx
volta3:
	addl 	$1, %ebx
	movb 	(%edi), %al
	cmpb 	enter, %al
	jz 	concluinomearq
	cmpb 	espaco, %al
	jz 	concluinomearq
	addl 	$1, %edi
	jmp 	volta3

concluinomearq:
	pushl 	%edi 		# empilha a posição do caracter enter/espaco
	pushl 	%ebx 		# empilha o tamanho do nome do arquivo
	pushl 	$mostratam
	call 	printf
	addl 	$8, %esp 	# desempilha os 2 ultimos e a posicao do enter fica no topo; 
				# trunca o excesso da string, inserindo um NULL após a entrada útil, 
				# e imprime no vídeo o nome do arquivo usando printf

	popl 	%edi 		# resgata a posição do caracter enter/espaco
	movb 	NULL, %al 	# substitui o enter/espaco por fim de string
	movb 	%al, (%edi)
	pushl 	$mostranomearq
	call 	printf 		# imprime nome do arquivo com o caracter de fim de string
	addl 	$8, %esp 	# observe que no topo da pilha estava a posicao inicial da
				# string do nome. Retira-a
	pushl 	$pulalin
	call 	printf
	addl 	$4, %esp

	ret

#8) Le do arquivo de entrada. Abre o arquivo, le uma string da primeira linha, fecha o arquivo e mostra a string lida
learqin:

	movl 	SYS_OPEN, %eax # system call OPEN: retorna o descritor em %eax
	movl 	$nomearqin, %ebx
	movl 	O_RDONLY, %ecx
	int 	$0x80

	pushl 	%eax # guarda o descritor
	movl 	%eax, %ebx
	movl 	SYS_READ, %eax
	movl 	$strarqin, %ecx
	movl 	tamstrarqin, %edx
	int 	$0x80
	movl 	SYS_CLOSE, %eax
	popl 	%ebx # resgata o descritor
	int 	$0x80
	pushl 	$strarqin
	pushl 	$mostrastrarqin
	call 	printf
	addl 	$8, %esp

fim:
	pushl 	$msgfim
	call 	printf
	addl 	$4, %esp
	movl 	SYS_EXIT, %eax
	movl 	SAIDA_NORMAL, %ebx
	int 	$0x80
