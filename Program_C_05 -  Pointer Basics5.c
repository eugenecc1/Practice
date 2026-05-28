#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void malloc_test(void);
void calloc_test(void);
void realloc_test(void);

int main() {
    
    malloc_test();
    calloc_test();
    realloc_test();
    
	return 0;
}

void malloc_test(void){
  	char* s;
	int stringsize;

	stringsize = sizeof("hello");	// first work out how big "hello" is ...
	printf("size of 'hello' is %d\n", stringsize);	// note that it is SIX bytes long (not five) so as to allow for the terminating null character


	s = (char*)malloc(stringsize);	// now allocate some memory of sufficient size to hold the string "hello"
	if (s != NULL) {				// malloc will return NULL if it failed
		strncpy(s, "hello", stringsize); // now copy the string into the newly allocated memory
		printf("s is %s\n", s);
		s[0] = 'c';					// and change the first character (just to show we can)
		printf("s is now %s\n", s);
	}
	else {
		printf("malloc failed!\n");
	}  
}

void calloc_test(void){
	char *s;
	int i;
	int *p;

	// use malloc first to allocate some memory and see what is in it (usually rubbish)
	s = (char*)malloc(6);						// malloc will return NULL (0) if it fails, so we should check here, but we won't for brevity
	for (i = 0; i < 6; i++) printf("s[%d]=%d\n", i, s[i]);
	free(s);									// use 'free' to return the memory so that we don't get a memory leak

												// now we'll use calloc to do the same - note that the memory is 'zeroed out'
												// NOTE: the syntax of 'calloc' is different for 'malloc' - the second argument gives the size of the memory unit to allocate
	s = (char*)calloc(6, sizeof(char));			// calloc will return 0 if it fails, so we should check here, but we won't for brevity
	for (i = 0; i < 6; i++) printf("s[%d]=%d\n", i, s[i]);
	free(s);

	// in this last example, 'calloc' allocates 6 integers, or 24 bytes, since an integer is 4 bytes long
	p = (int*)calloc(6, sizeof(int));				// calloc will return 0 if it fails, so we should check here, but we won't for brevity
	for (i = 0; i < 6; i++) printf("p[%d]=%d\n", i, p[i]);
	free(p);
}

void realloc_test(void){
    	char *s;
	int i;

	i = sizeof("hello");			// as before first work out how big "hello" is ...
	s = (char*)malloc(i);			// malloc will return 0 if it fails, so we should check here, but we wont for brevity
	strncpy(s, "hello", i);			// now copy the string into the newly allocated memory
	printf("s is %s\n", s);

	// now suppose we want to add 'world' to 'hello' - we can't just do this ...
	// strcat(s, " world");			- disaster!!! 
	s = (char*)realloc(s, 12);		// but we can use 'realloc' which frees the original 6 bytes of memory and allocates a new 12 bytes (copying the old "hello"
	strcat(s, " world");			// now we can tag on the 'world'
	printf("s is now %s\n", s);
	
	free(s);						// and when we've finished we should always free up any memory by using 'free'

	/* NOTE: make a habit of using 'free' whan you've finished with some memory otherwise there will be 'memory leaks'
	   where memory that you have allocated will be 'lost' to your program.
	   These leaks are not as important as they used to be (a few bytes in several GB won't make much of a difference) 
	   but it is considered to be good programming practise to tidy up.
	 */
}