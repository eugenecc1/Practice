/* �ʐ^�摜�\���̃v���O����                         */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

#include <stdio.h>
#include "platform.h"

#define MEMC     ((volatile unsigned char *) 0xc0000000)
#define MODEREG  *((volatile unsigned int *) 0xc1000000)
#define DISPPAGE *((volatile unsigned int *) 0xc5000000)
#define DBLANK   *((volatile unsigned int *) 0xc5000004)
#define PICT     ((volatile unsigned char *) 0xc0800000)

#define DISPMODE 0
#define MCSMODE  2

#define XSIZE 640
#define YSIZE 480

void wait_dblank( void );

int main()
{
    int i, R, G, B;

    init_platform();
    DISPPAGE = 0;
    wait_dblank();
    MODEREG = MCSMODE;
    /* �摜�t�H�[�}�b�g�̕ϊ� */
    for (i=0; i<XSIZE*YSIZE; i++) {
        R = PICT[i*3  ];
        G = PICT[i*3+1];
        B = PICT[i*3+2];
        MEMC[i] = (R & 0xe0) | ((G & 0xe0)>>3) | ((B & 0xc0)>>6);
    }
    /* �\�����[�h�ؑ� */
    wait_dblank();
    MODEREG = DISPMODE;

    cleanup_platform();
    return 0;
}

/* ��ʕ\���̏I����҂� */
void wait_dblank( void )
{
    DBLANK = 0;
    while ( DBLANK == 0 );
}
