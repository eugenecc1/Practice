/* Copyright(C) 2020 Cobac.Net All Rights Reserved.          */
/* chapter: ��11�͉ۑ�                                       */
/* project: bitblt_trans_ip                                  */
/* outline: ���ߏ����t���r�b�g�u���b�N�`���H�̃e�X�g�x���` */

#include <stdio.h>
#include <ap_int.h>
#include "bitblt.h"

#define WIDTH  160
#define HEIGHT 120

/* �ǂݏo�����Ə������ݐ�̐擪�A�h���X */
#define SRC0 (  0 +   0 * XSIZE)
#define SRC1 (160 +   0 * XSIZE)
#define DST0 (  0 +   0 * XSIZE)
#define DST1 ( 80 +  60 * XSIZE)
#define DST2 (  0 + 240 * XSIZE)
#define DST3 ( 80 + 300 * XSIZE)

/* VRAM�ƃe�N�X�`����2��ʕ��̔z���p�� */
u32 VRAM[XSIZE*YSIZE];
u32  TEX[XSIZE*YSIZE];

void bitblt(volatile u32*, volatile u32*, volatile u32*, u8, u11, u11, u8);
void patblt(volatile u32*, u11, u11, u11, u11, u32);

int main()
{
    /* VRAM�N���A */
    patblt(VRAM, 0, 0, XSIZE, YSIZE, 0);
    /* �e�N�X�`����ʍ���ɐԐ̔������� */
    patblt(&TEX[SRC0], 0, 0, WIDTH, HEIGHT, 0x00ff0000);
    patblt(&TEX[SRC1], 0, 0, WIDTH, HEIGHT, 0xff0000ff);
    /* ������̃�=0�A����ȊO��=0xff */
    for (int y=0; y<60; y++) {
        for(int x=0; x<80; x++) {
            TEX[SRC1 + x + y*XSIZE] &= 0x00ffffff;
        }
    }

    /* �e�N�X�`��1�ڏ������� */
    bitblt(&TEX[SRC0], &VRAM[DST0], &VRAM[DST0], 255, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��2�ڂƔw�i��ǂݍ��݉�f�ԉ��Z */
    bitblt(&TEX[SRC1], &VRAM[DST1], &VRAM[DST1], 128, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��3�ڏ������� */
    bitblt(&TEX[SRC0], &VRAM[DST2], &VRAM[DST2], 255, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��4�ڂ̓��ߏ������s���w�i�ɏ��� */
    bitblt(&TEX[SRC1], &VRAM[DST3], &VRAM[DST3], 128, WIDTH, HEIGHT, 1);

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
