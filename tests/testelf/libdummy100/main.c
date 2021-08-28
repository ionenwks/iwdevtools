#include <stdio.h>

void hello(int i, int j) {
	if (i && j)
		puts("hello world");
	else
		puts("dlrow olleh");
}

void hello_rev(void) {
	hello(0,0);
}
