#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define LENGTH 3
#define COUNT 4

typedef struct {
	int a;           // 4 bytes    
	double b;        // 8 bytes    
	int c;           // 4 bytes    
	long long int d; // 8 bytes
} MYSTRUCT;

int a[COUNT];
float b[COUNT];
double c[COUNT];
long long int d[COUNT];
short int e[COUNT];
long int f[COUNT];

void AddressArithmetic1(void);
void AddressArithmetic2(void);
void AddressArithmetic3(void);

int main(int argc, char **argv) {
    
	AddressArithmetic1();
	AddressArithmetic2();
	AddressArithmetic3();

	return 0;
}

void AddressArithmetic1(void){
	int *p;
	int a[COUNT];

	printf("size of an 'int' is %d\n", sizeof(int));


	for (int i = 0; i < COUNT; i++) a[i] = i;

	p = a;						
	printf("address of a is %p; value of p is %p [%d]; value pointed to by p is %d\n", a, p, p, *p);

	p = p + 1;
	printf("address of a is %p; value of p is %p [%d]; value pointed to by p is %d\n", a, p, p, *p);

	p = p + 2;
	printf("address of a is %p; value of p is %p [%d]; value pointed to by p is %d\n", a, p, p, *p);

	p = p + 1;
	printf("address of a is %p; value of p is %p [%d]; value pointed to by p is %d\n", a, p, p, *p);

}

void AddressArithmetic2(void){
	int *pa;
	float *pb;
	double *pc;
	long long int *pd;
	short int *pe; 
	long int *pf;


	printf("sizes are: int %d; float %d; double %d; long long int %d; short int %d; long int %d\n", sizeof(int),
		sizeof(float), sizeof(double), sizeof(long long int), sizeof(short int), sizeof(long int));
		
	pa = a;
	pb = b;
	pc = c;
	pd = d;
	pe = e;
	pf = f;
	for (int i = 0; i < COUNT; i++) {
		a[i] = i;
		b[i] = (float)i;
		c[i] = (double)i;
		d[i] = i;
		e[i] = i;
		f[i] = i;
	}

	pa += 1;
	pb += 1;
	pc += 1;
	pd += 1;
	pe += 1;
	pf += 1;

	printf("address of a is %p [%d]; value of pa is %p [%d]; value pointed to by pa is %d\n", a, a, pa, pa, *pa);
	printf("address of b is %p [%d]; value of pb is %p [%d]; value pointed to by pb is %f\n", b, b, pb, pb, *pb);
	printf("address of c is %p [%d]; value of pc is %p [%d]; value pointed to by pc is %f\n", c, c, pc, pc, *pc);
	printf("address of d is %p [%d]; value of pd is %p [%d]; value pointed to by pd is %lld\n", d, d, pd, pd, *pd);
	printf("address of e is %p [%d]; value of pe is %p [%d]; value pointed to by pe is %hd\n", e, e, pe, pe, *pe);
	printf("address of f is %p [%d]; value of pf is %p [%d]; value pointed to by pf is %ld\n", f, f, pf, pf, *pf);
}

voidAddressArithmetic3(void){
	MYSTRUCT *p, *q;
	void* v;

	printf("size of MYSTRUCT = %d\n", sizeof(MYSTRUCT));
	
	 p = (MYSTRUCT*)calloc(COUNT, sizeof(MYSTRUCT));

	for (int i = 0; i < COUNT; i++) {
		p[i].a = i;
		p[i].b = 10000000000.0 + i;
		p[i].c = i * 20;
		p[i].d = 4294967296 + i;
	}

	q = p;
	printf("[0] values:\na is %d\nb is %f\nc is %d\nd is %lld\n", q->a, q->b, q->c, q->d);
	printf("addresses:\na is %p\nb is %p\nc is %p\nd is %p\n", &q->a, &q->b, &q->c, &q->d);
	q = p + 3;
	
	printf("\n[3] values:\na is %d\nb is %f\nc is %d\nd is %lld\n", q->a, q->b, q->c, q->d);
	printf("addresses:\na is %p\nb is %p\nc is %p\nd is %p\n\n", &q->a, &q->b, &q->c, &q->d);

	v = p + 3; 

	printf("Struct at index 3\n");
	for (int i = 0; i < sizeof(MYSTRUCT) / sizeof(int); i++) {
		printf("v[%d]=%d\n", i, ((int*)v)[i]);		
	}
}