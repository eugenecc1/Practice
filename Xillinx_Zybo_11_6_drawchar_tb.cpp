/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11�͉ۑ�                              */
/* project: drawchar                                */
/* outline: �����p�^�[���`���H�̃e�X�g�x���`      */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ap_int.h"

#define XSIZE 640
#define YSIZE 480

void drawchar(volatile ap_uint<32>*, ap_uint<11>, ap_uint<11>, ap_uint<8>, ap_uint<8>, ap_uint<32>);

ap_uint<32> VRAM[XSIZE*YSIZE];

/* �e�X�g�x���`�{�� */
int main()
{
    /* ��ʃN���A */
    for (int i=0; i<XSIZE*YSIZE; i++) {
        VRAM[i] = 0;
    }

    /* �F�Ƒ傫����ς���3�����`�� */
    drawchar(VRAM,   0,   0, 'A', 10, 0x00ff0000);
    drawchar(VRAM,  80,  80, 'B',  5, 0x0000ff00);
    drawchar(VRAM, 160, 160, 'C', 20, 0x000000ff);

    /* �t�@�C���o�� */
    FILE *fd = fopen("imagedata.raw", "wb");

    for (int y=0; y<YSIZE; y++) {
        for (int x=0; x<XSIZE; x++) {
            int temp = VRAM[y*XSIZE+x];
            fprintf( fd, "%c", (temp>>16) & 0xff );
            fprintf( fd, "%c", (temp>>8 ) & 0xff );
            fprintf( fd, "%c", (temp    ) & 0xff );
        }
    }
    fclose(fd);

    return 0;

}
