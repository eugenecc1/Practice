/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11�͉ۑ�                         */
/* project: bitblt_trans_ip                    */
/* outline: ���ߏ����t���r�b�g�u���b�N�`���H */

#include <ap_int.h>
#include "bitblt.h"

/* ��f�ԉ��Z */
u32 calc(u32 src, u32 dst, u8 alpha, u8 transparent)
{
    /* RGB�e8�r�b�g�Ŏ��o�� */
    u32 src_r = (src>>16) & 0xff;
    u32 src_g = (src>> 8) & 0xff;
    u32 src_b =  src      & 0xff;

    u32 dst_r = (dst>>16) & 0xff;
    u32 dst_g = (dst>> 8) & 0xff;
    u32 dst_b =  dst      & 0xff;

    /* src�̃��l��0�̕����𓧉߂����� */
    u8 temp = (transparent!=0 && (src & 0xff000000)==0) ? (u8)0: alpha;

    /* �e�F���Ƃɉ�f�ԉ��Z */
    dst_r = (temp*src_r + (255-temp)*dst_r)/255;
    dst_g = (temp*src_g + (255-temp)*dst_g)/255;
    dst_b = (temp*src_b + (255-temp)*dst_b)/255;

    return ((dst_r<<16) & 0xff0000) | ((dst_g<<8) & 0xff00) | (dst_b & 0xff);
}

/* bitblt�{�� */
void bitblt(
    volatile u32 *srcin,
    volatile u32 *dstin,
    volatile u32 *dstout,
    u8  alpha,
    u11 width,
    u11 height,
    u8 transparent)
{
    u32 src[XSIZE], dst[XSIZE];

    height_loop: for (int y=0; y<height; y++) {
        src_loop: for (int x=0; x<width; x++) {     /* �e�N�X�`�� */
            src[x] = srcin[x + y*XSIZE];
        }
        dstin_loop: for (int x=0; x<width; x++) {   /* �w�i */
            dst[x] = dstin[x + y*XSIZE];
        }
        dstout_loop: for (int x=0; x<width; x++) {  /* ���Z���ʂ����� */
            dstout[x + y*XSIZE] = calc(src[x], dst[x], alpha, transparent);
        }
    }
}
