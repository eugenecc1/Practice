/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��10�͉ۑ�              */
/* project: avgminmax               */
/* outline: avgminmax�̃e�X�g�x���` */

#include <stdio.h>
#include <stdlib.h>
#define SIZE 16

void avgminmax( int [], int *, int *, int * );

int main( )
{
    int din[SIZE];
    int i, retval=0, expmin, expmax;
    long long expavg=0;
    int average, min, max;

    /* �z��din�ɗ������� */
    for ( i=0; i<SIZE; i++ ) {
        din[i] = rand();
        printf("din[%2d]=%d\n", i, din[i]);
    }
    /* ���Ғl���쐬 */
    expmin = din[0];
    expmax = din[0];
    for ( i=0; i<SIZE; i++ ) {
        expavg += din[i];
        if (expmin > din[i]) {
            expmin = din[i];
        }
        if (expmax < din[i]) {
            expmax = din[i];
        }
    }
    expavg /= SIZE;

    avgminmax(din, &average, &min, &max);
    printf("Average=%d  Minimum=%d  Maximum=%d\n", average, min, max);

    /* ���Z���ʂ����Ғl�Ɣ�r */
    if ( average==expavg && min==expmin && max==expmax ) {
        printf("OK.\n");
    }
    else {
        printf("*** NG ***\n");
        retval = 1;
    }

    return retval;
}
