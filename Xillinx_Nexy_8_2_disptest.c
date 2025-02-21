/* �O���t�B�b�N�\���̃e�X�g�v���O����               */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

#include <stdio.h>
#include "platform.h"

#define MEMC     ((volatile unsigned char *) 0xc0000000)
#define MODEREG  *((volatile unsigned int *) 0xc1000000)
#define DISPPAGE *((volatile unsigned int *) 0xc5000000)
#define DBLANK   *((volatile unsigned int *) 0xc5000004)

#define DISPMODE 0
#define MCSMODE  2

#define XSIZE 640
#define YSIZE 480

void wait_dblank( void );

int main()
{
    int x, y, i;

    init_platform();
    DISPPAGE = 0;
    wait_dblank();
    MODEREG = MCSMODE;

    /* �y�[�W0�Ƀ^�C���͗l������ */
    for (y=0; y<YSIZE; y++) {
        for ( x=0; x<XSIZE; x++) {
            MEMC[x+y*XSIZE] = ((x/80)<<5) | ((y/60)<<2) | 3;
        }
    }
    /* �y�[�W1�ɎȖ͗l������ */
    for (i=0; i<XSIZE*YSIZE; i++)
        MEMC[i+XSIZE*YSIZE] = i;

    wait_dblank();
    MODEREG = DISPMODE;

    /* 60�t���[�����Ƃɕ\���y�[�W��؂�ւ��� */
    while (1) {
        for ( i=0; i<60; i++)
            wait_dblank();
        DISPPAGE ^= 1;
    }
    cleanup_platform();
    return 0;
}

/* ��ʕ\���̏I����҂� */
void wait_dblank( void )
{
    DBLANK = 0;
    while ( DBLANK == 0 );
}
