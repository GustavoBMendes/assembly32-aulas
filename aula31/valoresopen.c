//------------------------------------------
// Programa para imprimir as constantes das flag e mode da chamada ao sistema open()
// Copie o codigo abaixo, salve com o nome valoresopen.c e compile-o da seguinte forma:
// gcc valoresopen.c -o valoresopen
//------------------------------------------
#include "stdio.h"
#include <fcntl.h>
int main() {
	printf("\nO_WRONLY = %X\n",O_WRONLY);
	printf("\nO_RDONLY = %X\n",O_RDONLY);
	printf("\nO_RDWR = %X\n",O_RDWR);
	printf("\nO_APPEND = %X\n",O_APPEND);
	printf("\nO_CREAT = %X\n",O_CREAT);
	printf("\nO_TRUNC = %X\n",O_TRUNC);
	printf("\nO_EXCL = %X\n\n",O_EXCL);
	printf("\nS_IRWXU = %X\n",S_IRWXU);
	printf("\nS_IRUSR = %X\n",S_IRUSR);
	printf("\nS_IWUSR = %X\n",S_IWUSR);
	printf("\nS_IXUSR = %X\n",S_IXUSR);
	printf("\nS_IRWXG = %X\n",S_IRWXG);
	printf("\nS_IRGRP = %X\n",S_IRGRP);
	printf("\nS_IWGRP = %X\n",S_IWGRP);
	printf("\nS_IXGRP = %X\n",S_IXGRP);
	printf("\nS_IRWXO = %X\n",S_IRWXO);
	printf("\nS_IROTH = %X\n",S_IROTH);
	printf("\nS_IWOTH = %X\n",S_IWOTH);
	printf("\nS_IXOTH = %X\n",S_IXOTH);
}