#include <stdio.h>

void hello(int i, int j) {
	if (i && j)
		puts("heaveno world");
	else
		puts("dlrow onevaeh");
}

void hello_rev(void) {
	hello(0,0);
}
