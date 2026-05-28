 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #define _CRT_NONSTDC_NO_WARNINGS

 #define MAX 20

 int intcmp(const void *v1, const void *v2);
 int comp(const void *s1, const void *s2);
 void searchandsort(void);
 void searchandsort2(void);
 
 int main( void )
 {
	searchandsort();
	searchandsort2();
	return(0);
 }

 int intcmp(const void *v1, const void *v2)
 {
      return (*(int *)v1 - *(int *)v2);
 }
 
  int comp(const void *s1, const void *s2)
 {
     return (strcmp(*(char **)s1, *(char **)s2));
 }
 
 void searchandsort(void){
       int arr[MAX], count, key, *ptr;

      // Enter some integers from the user.

      printf("Enter %d integer values; press Enter after each.\n", MAX);

      for (count = 0; count < MAX; count++)
          scanf("%d", &arr[count]);

      puts("Press Enter to sort the values.");
      getc(stdin);

      // Sort the array into ascending order.

      qsort(arr, MAX, sizeof(arr[0]), intcmp);

      // Display the sorted array.

      for (count = 0; count < MAX; count++)
          printf("\narr[%d] = %d.", count, arr[count]);

      puts("\nPress Enter to continue.");
      getc(stdin);

      // Enter a search key.

      printf("Enter a value to search for: ");
      scanf("%d", &key);

      // Perform the search.

      ptr = (int *)bsearch(&key, arr, MAX, sizeof(arr[0]),intcmp);

      if ( ptr != NULL )
          printf("%d found at arr[%d].\n", key, (ptr - arr));
      else
          printf("%d not found.\n", key);     
  }

 void searchandsort2(void){
  char *data[MAX], buf[80], *ptr, *key, **key1;
     int count;

     // Input a list of words or phrases.

     printf("Enter %d words or phrases, pressing Enter after each.\n",MAX);

     for (count = 0; count < MAX; count++)
     {
         printf("Word %d: ", count+1);
         gets(buf);
         data[count] = malloc(strlen(buf)+1);
         strcpy(data[count], buf);
     }

     // Sort the words (actually, sort the pointers).

     qsort(data, MAX, sizeof(data[0]), comp);

     // Display the sorted words.

     for (count = 0; count < MAX; count++)
         printf("\n%d: %s", count+1, data[count]);

     // Get a search key.

     printf("\n\nEnter a search key: ");
     gets(buf);

     // Perform the search. First, make key1 a pointer
     // to the pointer to the search key.

     key = buf;
     key1 = &key;
     ptr = bsearch(key1, data, MAX, sizeof(data[0]), comp);

     if (ptr != NULL)
         printf("%s found.\n", buf);
     else
         printf("%s not found.\n", buf);   
     
 }