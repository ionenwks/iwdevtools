#include <stdio.h>

int count = 0;
int harmlessvar;

void hello(int i, int j) {
	if (i && j)
		puts("heaveno world");
	else
		puts("dlrow onevaeh");
	count++;
}

void hello_rev(void) {
	hello(0,0);
}

void harmless(void) {
	puts("new in this version");
}
