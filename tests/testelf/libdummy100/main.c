#include <stdio.h>

int count = 0;

void hello(int i, int j) {
	if (i && j)
		puts("hello world");
	else
		puts("dlrow olleh");
	count++;
}

void hello_rev(void) {
	hello(0,0);
}
