#include <stdio.h>

void *count = 0;
void *useless = 0;

void heaveno(void *p) {
	if (p)
		puts("dlrow onevaeh");
	else
		puts("heaveno world");
	count++;
}

int hello_rev(int i) {
	heaveno(NULL);
	return i;
}
