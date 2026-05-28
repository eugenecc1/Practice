#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define LENGTH 3
#define MAXSTRLEN 100

int data[LENGTH];					// some integers
char *words[LENGTH];				// some strings

void GenericPointers(void);
char *string_function(char *astring);

int main(int argc, char **argv) {
    
    GenericPointers();
	printf(string_function("Fred"));
	printf(string_function("Gussie Fink-Nottle"));
	
	return 0;
}

void GenericPointers(void){
	void *gp;					

	printf("generic pointer example\n");

	for (int i = 0; i < LENGTH; i++) {
		data[i] = i;
	}
	for (int i = 0; i < LENGTH; i++) {
		printf("%d\n", data[i]);
	}

	words[0] = "zero";
	words[1] = "one";
	words[2] = "two";
	for (int i = 0; i < LENGTH; i++) {
		printf("%s\n", words[i]);
	}

	gp = data;										
	printf("\ndata array address is %p\n", gp);		
													
	printf("item pointed to by gp is %d\n", *(int*)gp);	  
	
	gp = (int*)gp + 1;
	printf("item pointed to by gp is now %d\n", *(int*)gp);

	gp = words;										
	printf("\nwords array address is %p\n", gp);		
	
	printf("item pointed to by gp is %s\n", *(char**)gp); 
	
	gp = (char**)gp + 1;
	printf("item pointed to by gp is now %s\n", *(char**)gp);
}

char *string_function(char *astring) {
	char *s;

	s = (char*)malloc(MAXSTRLEN);
	s[0] = '\0';		                // need this to initialize the buffer created by malloc
	strcat(s, "Hello ");
	strcat(s, astring);
	strcat(s, "\n");

	return s;
}