#include <stdio.h>

void heaveno(void *p) {
	if (p)
		puts("dlrow onevaeh");
	else
		puts("heaveno world");
}

int hello_rev(int i) {
	heaveno(NULL);
	return i;
}
