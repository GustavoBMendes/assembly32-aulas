# exemplo de registro
#	nome: string de ateh 43 caracteres + caractere de final de string = 44 bytes
#	data nascimento: 11 + 1 = 12 bytes
#	CPF:	23 caracteres + 1 final de string = 24 bytes
#	Genero: masculino ou feminimo -> M ou F -> 1 byte -> 4 bytes
# 	RG: 12 bytes
#	Rua: 20 bytes
#	num endereco: inteiro = 4 bytes
#	bairro: 20 bytes
#	cep: 9 bytes + caracter fim = 10 bytes
#	cidade: 15 bytes
#	telefone: 15 bytes
#	email: 35 bytes
#	data de contratacao: 10 caracteres + 1 final = 11 bytes
#	cargo: 20 bytes
#	salario: float = 4 bytes
#	prox: 4 bytes para conter o endereco do proximo registro
#	
#	total de bytes: 254 bytes

#MODOS:
#1 -> Inserção
#2 -> Remoção
#3 -> Consulta
#4 -> Relatório (printar todos regs)
#5 -> Reajuste salarial

#3) Acrescente no menu de opções mais duas opções: "Carregar de Arquivo" e "Gravar em Arquivo" 
# para carregar a lista com dados já gravados de uma execução anterior ou gravar o vetor atual 
# no arquivo para que possa ser carregado na próxima execução, respectivamente. 
# O carregamento a partir do arquivo deve reiniciar a lista para o conteúdo gravado no arquivo. 
# A gravação em arquivo deve atualizar o conteúdo do arquivo com a nova lista. 
# As operações de leitura e gravação devem ser implementadas por funções específicas que utilizam chamadas ao sistema e não chamadas de bibliotecas de funções.

.section .data

	titgeral: .asciz "\n*** APLICAÇÃO DE LISTA DE REGISTROS DE RH ***"
	titinser: .asciz "\nINSERÇÃO: "
	titremov: .asciz "\nREMOÇÃO: "
	titmostra: .asciz "\nREGISTROS DA LISTA: "
	titreg: .asciz "\n\nRegistro numero %d: "
	titreaj: .asciz "\nReajuste salarial dos funcionarios:"
	txtAberturaGravar: 	.asciz "\nGravacao de Registros no arquivo\n"
	txtPedeNomeArq: .asciz "\nEntre com o nome do arquivo de entrada/saida\n> "

	menu: .asciz "\n1-Inserção\n2-Remoção\n3-Consulta\n4-Relatório\n5-Reajuste Salarial\n6-Gravar registros no arquivo\n7-Ler registros do arquivo\n0-Sair\n> "

	abertura: .asciz "\nTrabalho prático 1 - Aluno: Gustavo Belançon Mendes ra 99037\n"

	msgerro: .asciz "\nOpcao incorreta!\n"
	msgvazia: .asciz "\nLista vazia"
	msgremov: .asciz "\nRegistro removido!"
	msginser: .asciz "\nRegistro inserido!"
	
	pedenome: .asciz "\nDigite o nome: "
	pedeidade: .asciz "\nDigite a idade: "
	pededatanasc: .asciz "\nDigite a data de nascimento: "
	pedesexo: .asciz "\nQual o sexo, <f>eminino ou <m>asculino? "
	pedecpf: .asciz "\nDigite o cpf: "
	pederg: .asciz "\nDigite o rg: "
	pededatacont: .asciz "\nDigite a data da contratação: "
	pedecargo: .asciz "\nDigite o nome do cargo: "
	pedesalario: .asciz "\nEntre com o valor do salario: "
	pederua: .asciz "\nEntre com o nome da rua: "
	pedenum: .asciz "\nInforme o número do endereço: "
	pedebairro: .asciz "\nDigite o nome do bairro: "
	pedecidade: .asciz "\nCidade: "
	pedetel: .asciz "\nInforme o número de telefone: "
	pedemail: .asciz "\nDigite o endereço de email: "
	pedecep: .asciz "\nDigite o cep do seu endereço: "

	nome_consulta:	.space 44
	nome_remove: 	.space 44
	nomeArq: 	.space 50

	mostranome: .asciz "\nNome: %s"
	mostradatanasc: .asciz "\nData de nascimento: %s"
	mostrasexo: .asciz "\nSexo: %c"
	mostracpf: .asciz "\nCPF: %s"
	mostrarg: .asciz "\nRG: %s"
	mostrarua: .asciz "\nNome da rua: %s"
	mostranum: .asciz "\nNumero do endereço: %d"
	mostrabairro: .asciz "\nBairo: %s"
	mostracep: .asciz "\nCEP: %s"
	mostracidade: .asciz "\nCidade: %s"
	mostratel: .asciz "\nTelefone: %s"
	mostraemail: .asciz "\nEmail: %s"
	mostradatacont: .asciz "\nData de contratação: %s"
	mostracargo: .asciz "\nCargo: %s"
	mostrasalario: .asciz "\nSalario: %f\n"
	abert_consulta:	.asciz	"\nEntre com um nome para consultar seu registro: "
	abert_remove:	.asciz	"\nEntre com um nome para remover seu registro: "
	abert_reaj: .asciz "\nEntre com a porcentagem do reajuste (Exemplo: Entre com 1.50 para 50 porcento de reajuste): "
	mostra_reaj: .asciz "\nDespesas adicionais após o reajuste: %f\n"

	mostrapt: .asciz "\nptlista = %d"

	formastr: .asciz "%s"
	formach: .asciz "%c"
	formanum: .asciz "%d"
	formafloat: .asciz "%f"
	float1: .space 4
	float2: .space 4
	float3: .float 0.0

	pulalin: .asciz "\n"

	NULL: .int 0

	opcao: .int 0
	regtam: .int 258
	lista: .int NULL
	ptreg: .int NULL
	ptratual: .int NULL
	ptrant: .int NULL
	ptrfim: .int NULL
	descritor: 	.int 0 # descritor do arquivo de entrada/saida
	listaTam: .int 0
	registro: .int 258

	# As constantes abaixo se referem aos servi�os disponibilizados pelas
# chamadas ao sistema, devendo serem passadas no registrador %eax

	SYS_EXIT: 	.int 1
	SYS_FORK: 	.int 2
	SYS_READ: 	.int 3
	SYS_WRITE: 	.int 4
	SYS_OPEN: 	.int 5
	SYS_CLOSE: 	.int 6
	SYS_CREAT: 	.int 8

# Descritores de arquivo para sa�da e entrada padr�o

	STD_OUT: 	.int 1 # descritor do video
	STD_IN:  	.int 2 # descritor do teclado

# Constante usada na chamada exit() para t�rmino normal

	SAIDA_NORMAL: 	.int 0 # codigo de saida bem sucedida

# Constantes de configura��o do parametro flag da chamada open(). Estes valores
# s�o dependentes de implementa��o. Para se ter certeza dos valores corretos, compile o
# programa no final deste arquivo usando "gcc valoresopen.c -o valoresopen" e execute-o
# usando "./valoresopen". Caso seja diferente, corrija as definicoes abaixo.

	O_RDONLY: .int 0x0000 # somente leitura
	O_WRONLY: .int 0x0001 # somente escrita
	O_RDWR:   .int 0x0002 # leitura e escrita
	O_CREAT:  .int 0x0040 # cria o arquivo na abertura, caso ele n�o exista
	O_EXCL:   .int 0x0080 # for�a a cria��o
	O_APPEND: .int 0x0400 # posiciona o cursor do arquivo no final, para adi��o
	O_TRUNC:  .int 0x0200 # reseta o arquivo aberto, deixando com tamanho 0 (zero)

# Constantes de configura��o do parametro mode da chamada open().

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
	S_NADA:  .int 0x0000 # n�o altera a situa��o


.section .text

.globl _start
_start:
	pushl $abertura
	call printf
	add $4, %esp
	finit
	 
	jmp main

#MOSTRAR ARQUIVO
mostraArq:
	pushl 	$txtPedeNomeArq
	call 	printf
	pushl 	$nomeArq
	call 	gets
	addl 	$8, %esp
	call 	abreArqE
	call 	mostraRegs
	jmp 	menuop

abreArqE:
	movl 	SYS_OPEN, %eax 	# system call OPEN: retorna o descritor em %eax
	movl 	$nomeArq, %ebx
	movl 	O_RDONLY, %ecx
	int 	$0x80
	movl 	%eax, descritor # guarda o descritor
	ret

mostraRegs:
	movl 	SYS_READ, %eax # %eax retorna numero de bytes lidos
	movl 	descritor, %ebx # recupera o descritor
	movl 	$registro, %ecx
	movl 	regtam, %edx
	int 	$0x80 # le registro do arquivo
	movl 	$registro, %edi
	cmpl 	$0, %eax
	je 	fimMostra

	pushl %edi		#endereco inicial do registro, contendo todos os campos
	
	pushl $mostranome
	call printf
	addl $4, %esp

	popl %edi		#recupera %edi
	addl $44, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na lista

	pushl %edi
	pushl $mostradatanasc
	call printf
	addl $8, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostrasexo
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostracpf
	call printf
	addl $4, %esp

	popl %edi
	addl $24, %edi
	pushl %edi

	pushl $mostrarg
	call printf
	addl $4, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl $mostrarua
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostranum
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostrabairro
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $mostracep
	call printf
	addl $4, %esp

	popl %edi
	addl $10, %edi
	pushl %edi

	pushl $mostracidade
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostratel
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostraemail
	call printf
	addl $4, %esp

	popl %edi
	addl $35, %edi
	pushl %edi

	pushl $mostradatacont
	call printf
	addl $4, %esp

	popl %edi
	addl $11, %edi
	pushl %edi

	pushl $mostracargo
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	flds (%edi)
	subl $8, %esp
	fstl (%esp)
	pushl $mostrasalario
	call printf
	addl $16, %esp

	popl %edi
	subl $246, %edi

fimMostra:
	RET

#GRAVAR REGISTROS NO ARQUIVO
abreArqS:
	movl 	SYS_OPEN, %eax 	# system call OPEN: retorna o descritor em %eax
	movl 	$nomeArq, %ebx
	movl 	O_WRONLY, %ecx
	orl 	O_CREAT, %ecx
	orl 	O_APPEND, %ecx
	movl 	S_IRUSR, %edx
	orl 	S_IWUSR, %edx
	int 	$0x80
	movl 	%eax, descritor # guarda o descritor
	ret

gravaReg:
	movl 	SYS_WRITE, %eax
	movl 	descritor, %ebx # recupera o descritor
	movl 	$lista, %ecx
	movl 	regtam, %edx
	int 	$0x80
	ret

gravar:
	pushl 	$txtAberturaGravar
	call 	printf
	pushl 	$txtPedeNomeArq
	call 	printf
	pushl 	$nomeArq
	call 	gets
	addl 	$12, %esp
	call 	abreArqS
	call 	gravaReg

	jmp menuop

#REAJUSTE SALARIAL#
reajuste:
	pushl $titreaj
	call printf
	pushl $abert_reaj
	call printf
	pushl $float1
	pushl $formafloat
	call scanf
	addl $16, %esp

	flds float3

	addl $8, %esp

	jmp inicia_reaj

altera_dados: 

	pushl %edi		#endereco inicial do registro, contendo todos os campos

	popl %edi		#recupera %edi
	addl $44, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na lista

	popl %edi
	addl $12, %edi
	pushl %edi

	popl %edi
	addl $4, %edi
	pushl %edi

	popl %edi
	addl $24, %edi
	pushl %edi

	popl %edi
	addl $12, %edi
	pushl %edi

	popl %edi
	addl $20, %edi
	pushl %edi

	popl %edi
	addl $4, %edi
	pushl %edi

	popl %edi
	addl $20, %edi
	pushl %edi

	popl %edi
	addl $10, %edi
	pushl %edi

	popl %edi
	addl $15, %edi
	pushl %edi

	popl %edi
	addl $15, %edi
	pushl %edi

	popl %edi
	addl $35, %edi
	pushl %edi

	popl %edi
	addl $11, %edi
	pushl %edi

	popl %edi
	addl $20, %edi

	movl (%edi), %eax
	movl %eax, float2
	flds float1
	fmuls float2

	fstps (%edi)

	subl $246, %edi

	addl $246, %edi

	flds (%edi)
	fsubs float2
	fadd %st(0), %st(1) #st1 <- st1 + st0
	subl $8, %esp
	fstpl (%esp)
	addl $8, %esp

	subl $246, %edi

	RET

inicia_reaj:

	movl lista, %edi 
	cmpl $NULL, %edi	#compara se a lista eh vazia
	jnz continua_reaj

	pushl $msgvazia
	call printf
	addl $4, %esp

	jmp menuop

continua_reaj:
	movl lista, %edi
	movl $1, %ecx

percorre_regs:
	cmpl $NULL, %edi
	jz fimreajuste

	pushl %edi
	pushl %ecx

	movl 4(%esp), %edi		#recupera %edi sem desempilhar
	call altera_dados

	popl %ecx
	incl %ecx
	popl %edi
	movl 254(%edi), %edi	#avança para o proximo reg

	jmp percorre_regs

	jmp menuop

fimreajuste:
	subl $8, %esp
	fstpl (%esp)
	pushl $mostra_reaj
	call printf
	addl $12, %esp

	jmp menuop

#CONSULTA NOME#
consulta:
	pushl $abert_consulta
	call printf
	pushl $nome_consulta
	call gets
	addl $8, %esp

	jmp procura

mostra_reg:
	pushl $mostranome
	call printf
	addl $4, %esp

	popl %edi		#recupera %edi
	addl $44, %edi		#avanca para o proximo campo
	pushl %edi		#salva na pilha de exec

	pushl %edi
	pushl $mostradatanasc
	call printf
	addl $8, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostrasexo
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostracpf
	call printf
	addl $4, %esp

	popl %edi
	addl $24, %edi
	pushl %edi

	pushl $mostrarg
	call printf
	addl $4, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl $mostrarua
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostranum
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostrabairro
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $mostracep
	call printf
	addl $4, %esp

	popl %edi
	addl $10, %edi
	pushl %edi

	pushl $mostracidade
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostratel
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostraemail
	call printf
	addl $4, %esp

	popl %edi
	addl $35, %edi
	pushl %edi

	pushl $mostradatacont
	call printf
	addl $4, %esp

	popl %edi
	addl $11, %edi
	pushl %edi

	pushl $mostracargo
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	flds (%edi)
	subl $8, %esp
	fstl (%esp)
	pushl $mostrasalario
	call printf
	addl $16, %esp

	popl %edi
	subl $246, %edi		#volta ao estado inicial do edi

	jmp fimconsulta

percorre_dados:
	pushl %edi		#endereco inicial do registro, contendo todos os campos
	pushl $nome_consulta
	call strcmp
	addl $4, %esp
	cmpl $0, %eax	#resultado de strcmp armazenado em eax, se igual retorna 0
	jz mostra_reg	#igual, entao mostra registro

	popl %edi
	subl $246, %edi	#retorna edi ao estado original

	RET

procura:
	pushl $titmostra
	call printf

	movl lista, %edi 
	cmpl $NULL, %edi
	jnz continua3	#lista nao esta vazia, entao procura o registro

	pushl $msgvazia
	call printf
	addl $4, %esp

	ret

continua3:
	movl lista, %edi
	movl $1, %ecx

volta2:
	cmpl $NULL, %edi
	jz menuop

	pushl %edi
	pushl %ecx

	movl 4(%esp), %edi		#recupera %edi sem desempilhar
	call percorre_dados

	popl %ecx
	incl %ecx
	popl %edi
	movl 254(%edi), %edi	#avança para o proximo registro

	jmp volta2

	ret

fimconsulta:
	ret
	
#INSERIR REG#
procura_pos:

	movl %eax, ptrant
	movl 254(%eax), %ebx
	movl %ebx, ptratual		#utiliza o ponteiro anterior como atual

	pushl lista		#ponteiro pro primeiro registro da lista
	pushl %edi
	call strcasecmp	#compara o registro a ser inserido com o primeiro da lista
	addl $8, %esp
	cmpl $0, %eax
	jle inserirnoinicio
	
	pushl ptrfim	#ponteiro pro ultimo registro da lista
	pushl %edi
	call strcasecmp	#compara registro a ser inserido com o ultimo da lista
	addl $8, %esp
	cmpl $0, %eax
	jge inserirnofim

avanca:
	movl ptratual, %eax
	cmpl %eax, ptrfim	#compara se o ponteiro atual está no ultimo registro
	je inserenomeio

	movl %eax, ptratual
	pushl ptratual
	pushl %edi
	call strcasecmp		#compara se o ponteiro atual é menor ou igual ao registro novo
	addl $8, %esp
	cmpl $0, %eax
	jle inserenomeio

	movl ptratual, %eax
	movl %eax, ptrant
	movl 254(%eax), %ebx 	#avanca pro final do registro, pegando o prox registro do edi
	movl %ebx, ptratual	
	jmp avanca

inserenomeio:
	movl ptratual, %eax
	movl ptrant, %esi
	movl %edi, 254(%esi)	#move o reg novo para o final do registro anterior
	movl %eax, 254(%edi)	#move o ponteiro atual para o fim do reg novo
	pushl $msginser
	call printf
	addl $4, %esp
	jmp menuop

inserirnoinicio:
	movl lista, %esi
	movl %esi, 254(%edi) 	#move a lista inteira para o fim do reg novo
	movl %edi, lista	#copia da lista atualizada para a variavel lista
	pushl $msginser
	call printf
	addl $4, %esp
	jmp menuop

inserirnofim:
	movl ptrfim, %eax
	movl %edi, 254(%eax)	#move o reg novo para o fim do ultimo reg da lista
	movl %edi, ptrfim
	pushl $msginser
	call printf
	addl $4, %esp
	jmp menuop

novo_reg:

	pushl $titinser
	call printf
	movl regtam, %eax
	addl %eax, listaTam

	movl regtam, %ecx
	pushl %ecx
	call malloc
	movl %eax, ptreg

	addl $8, %esp
	movl ptreg, %edi	#aloca o tamanho do registro em edi
	call le_dados

	movl lista, %eax
	cmpl $NULL, %eax
	jne procura_pos

	#lista vazia, insere primeiro reg
	movl %eax, 262(%edi)	#move ponteiro para o final do novo reg
	movl %edi, lista	#move uma copia de edi para lista
	movl %edi, ptrfim	#move edi para ponteiro de fim da lista

	pushl $msginser
	call printf
	addl $4, %esp

	jmp menuop

le_dados:
	pushl %edi		#endereço inicial registro

	pushl $pedenome
	call printf
	addl $4, %esp
	call gets

	popl %edi		#recupera %edi
	addl $44, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na lista

	pushl $pededatanasc
	call printf
	addl $4, %esp
	call gets

	popl %edi		#recupera %edi
	addl $12, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na lista

	pushl $pedesexo
	call printf
	addl $4, %esp
	pushl $formach
	call scanf
	addl $4, %esp

	popl %edi		#recupera %edi
	addl $4, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na pilha

	pushl $formach		#para remover o enter
	call scanf
	addl $4, %esp
	
	pushl $pedecpf
	call printf
	addl $4, %esp
	call gets

	popl %edi		#recupera %edi
	addl $24, %edi		#avanca para o proximo campo
	pushl %edi

	pushl $pederg
	call printf
	addl $4, %esp
	call gets

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl $pederua
	call printf
	addl $4, %esp
	call gets

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $pedenum
	call printf
	addl $4, %esp
	pushl $formanum
	call scanf
	addl $4, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $formach	#para remover o enter
	call scanf
	addl $4, %esp

	pushl $pedebairro
	call printf
	addl $4, %esp
	call gets

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $pedecep
	call printf
	addl $4, %esp
	call gets

	popl %edi 
	addl $10, %edi
	pushl %edi

	pushl $pedecidade
	call printf
	addl $4, %esp
	call gets
	
	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $pedetel
	call printf
	addl $4, %esp
	call gets
	
	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $pedemail
	call printf
	addl $4, %esp
	call gets
	
	popl %edi
	addl $35, %edi
	pushl %edi

	pushl $pededatacont
	call printf
	addl $4, %esp
	call gets

	popl %edi
	addl $11, %edi
	pushl %edi

	pushl $pedecargo
	call printf
	addl $4, %esp
	call gets

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $pedesalario
	call printf
	addl $4, %esp
	pushl $formafloat
	call scanf
	addl $4, %esp

	popl %edi
	addl $8, %edi

	movl $NULL, (%edi)
	
	subl $254, %edi		#retorna o edi para o estado inicial

	RET

#REMOVER REG#
remover_reg:
	pushl $titremov
	call printf
	addl $4, %esp

	pushl $abert_remove
	call printf
	pushl $nome_remove
	call gets
	addl $8, %esp

	movl lista, %edi
	cmpl $NULL, %edi	#verifica se a lista esta vazia
	jnz continua

	pushl $msgvazia
	call printf
	addl $4, %esp

	jmp menuop

removeprimeiro:
	movl lista, %edi
	pushl %edi
	movl 254(%edi), %edi	#remove movendo final do primeiro registro para o inicio da lista
	movl %edi, lista

	pushl $msgremov
	call printf
	addl $4, %esp

	call free		#desalocar memória
	addl $4, %esp

	jmp menuop

remove:
	movl ptrant, %esi
	movl 254(%edi), %eax
	movl %eax, 254(%esi)	#remove passando o final do registro a ser removido para o final do registro anterior
	pushl %edi
	call free		#desalocar memória

	pushl $msgremov
	call printf
	addl $8, %esp
	jmp menuop

procurareg:
	pushl %edi
	pushl $nome_remove
	call strcmp
	addl $4, %esp
	cmpl $0, %eax
	jz remove
	movl %edi, ptrant
	popl %edi
	pushl %edi
	popl %edi

	ret

continua:
	movl lista, %edi
	movl $1, %ecx

#primeiro procura se o registro é o primeiro da lista, tratar caso a parte
procurainicio:
	cmpl $NULL, %edi
	jz menuop
	pushl %edi
	pushl %ecx
	movl 4(%esp), %edi

	pushl %edi
	pushl $nome_remove
	call strcmp
	addl $4, %esp
	cmpl $0, %eax
	jz removeprimeiro
	movl %edi, ptrant

	popl %edi
	popl %ecx
	incl %ecx
	popl %edi
	movl 254(%edi), %edi

voltaremove:
	cmpl $NULL, %edi
	jz menuop
	
	pushl %edi
	pushl %ecx

	movl 4(%esp), %edi
	call procurareg

	popl %ecx
	incl %ecx
	popl %edi
	movl 254(%edi), %edi

	jmp voltaremove
	ret

#RELATORIO#
mostra_dados: 

	pushl %edi		#endereco inicial do registro, contendo todos os campos
	
	pushl $mostranome
	call printf
	addl $4, %esp

	popl %edi		#recupera %edi
	addl $44, %edi		#avanca para o proximo campo
	pushl %edi		#armazena na lista

	pushl %edi
	pushl $mostradatanasc
	call printf
	addl $8, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostrasexo
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostracpf
	call printf
	addl $4, %esp

	popl %edi
	addl $24, %edi
	pushl %edi

	pushl $mostrarg
	call printf
	addl $4, %esp

	popl %edi
	addl $12, %edi
	pushl %edi

	pushl $mostrarua
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	pushl $mostranum
	call printf
	addl $8, %esp

	popl %edi
	addl $4, %edi
	pushl %edi

	pushl $mostrabairro
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl $mostracep
	call printf
	addl $4, %esp

	popl %edi
	addl $10, %edi
	pushl %edi

	pushl $mostracidade
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostratel
	call printf
	addl $4, %esp

	popl %edi
	addl $15, %edi
	pushl %edi

	pushl $mostraemail
	call printf
	addl $4, %esp

	popl %edi
	addl $35, %edi
	pushl %edi

	pushl $mostradatacont
	call printf
	addl $4, %esp

	popl %edi
	addl $11, %edi
	pushl %edi

	pushl $mostracargo
	call printf
	addl $4, %esp

	popl %edi
	addl $20, %edi
	pushl %edi

	pushl (%edi)
	flds (%edi)
	subl $8, %esp
	fstl (%esp)
	pushl $mostrasalario
	call printf
	addl $16, %esp

	popl %edi
	subl $246, %edi

	RET

relatorio:

	pushl $titmostra
	call printf

	movl lista, %edi 
	cmpl $NULL, %edi	#compara se a lista eh vazia
	jnz continua2

	pushl $msgvazia
	call printf
	addl $4, %esp

	jmp menuop

continua2:
	movl lista, %edi
	movl $1, %ecx

volta:
	cmpl $NULL, %edi
	jz menuop

	pushl %edi

	pushl %ecx
	pushl $titreg
	call printf
	addl $4, %esp

	movl 4(%esp), %edi		#recupera %edi sem desempilhar
	call mostra_dados

	popl %ecx
	incl %ecx
	popl %edi
	movl 254(%edi), %edi	#avança para o proximo reg

	jmp volta

	jmp menuop

#MENU#
menuop:

	pushl $menu
	call printf
	
	pushl $opcao	
	pushl $formanum
	call scanf

	addl $12, %esp
	
	pushl $formach			#para remover o enter
	call scanf
	addl $4, %esp

	cmpl $1, opcao
	jz novo_reg

	cmpl $2, opcao
	jz remover_reg

	cmpl $3, opcao
	jz consulta

	cmpl $4, opcao
	jz relatorio

	cmpl $5, opcao
	jz reajuste

	cmpl $6, opcao
	jz gravar

	cmpl $7, opcao
	jz mostraArq

	cmpl $0, opcao
	jz fim

	pushl $msgerro
	call printf
	addl $4, %esp

	jmp menuop

main:
	pushl $titgeral
	call printf
	jmp menuop

fim:
	pushl $0 
	call exit
