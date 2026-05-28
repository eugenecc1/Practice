#include <stdio.h>

#define LENGTH 3

int data[LENGTH];			// some integers
char *words[LENGTH];		// some strings

void PointerBasics(void);
void StringsAndPointers(void);
void ArraysAndAddresses(void);
void MultipleIndirection(void);
void MultipleIndirectionStrings(void);

int main(int argc, char **argv) {
    
    PointerBasics();
    StringsAndPointers();
    ArraysAndAddresses();
    MultipleIndirection();
    MultipleIndirectionStrings();
	return 0;
}

void PointerBasics(void){
 	int num;
	int *numPtr;
	int num2;
	num = 100;

	numPtr = &num;
	num2 = *numPtr;
	printf("num=%d, numPtr=%d, address of num=%d, num2=%d\n", num, numPtr, &num, num2);
	printf("%p - %p ; %d - %d\n", numPtr, numPtr+5, numPtr, numPtr + 5);   
}

void StringsAndPointers(void){
    char str1[] = "Hello world";
	printf("%s %c %d %d %d\n", str1, str1[0], &str1, &str1[0], str1);
}

void ArraysAndAddresses(void){
    char str1[] = "Hello";
	char *str2 = "Goodbye";
	 
	printf("%d %d %s\n", &str1, str1, str1);
	printf("%d %d %s\n", &str2, str2, str2);
}

void MultipleIndirection(void){
	int *pi;			// a simple pointer to an integer
	int **ppi;			// a pointer to a pointer to an integer

	printf("multiple indirection example\n");

	// initialize our integer array
	for (int i = 0; i < LENGTH; i++) {
		data[i] = i;
	}
	for (int i = 0; i < LENGTH; i++) {
		printf("%d\n", data[i]);
	}

	pi = data;								// set the pointer to an integer  to the start of the data array
	ppi = &pi;								// and set the pointer to a pointer to pi itself

	for (int i = 0; i < LENGTH; i++) {
		printf("array address is %p\n", data);
		printf("item pointed to by pi is %d\n", *pi);
		printf("item pointed to by ppi is %p\n", *ppi);
		printf("item pointed to by double indirection of ppi is %d\n\n", **ppi);
		printf("The address of pi is %p and the value of ppi (what it points to) is %p\n\n", &pi, ppi);

		pi += 1;		// advance the pointer to point to the next element of the data array
	}    
}

void MultipleIndirectionStrings(void){
	char *pc;			// a pointer to a character
	char **ppc;			// a pointer to a pointer to a character

	printf("multiple indirection example\n");

	// initialize our string array
	words[0] = "zero";
	words[1] = "one";
	words[2] = "two";
	for (int i = 0; i < LENGTH; i++) {
		printf("%s\n", words[i]);
	}

	ppc = words;							// initialize the pointer to a pointer to a character
	for (int i = 0; i < LENGTH; i++) {		// loop over each string
		ppc = words + i;
		pc = *ppc;		
		while (*pc != 0) {					// process each character in a string
			printf("%c ", *pc);				// print out each character of the string individually
			pc += 1;			
		}
		printf("\n");
	}   
}