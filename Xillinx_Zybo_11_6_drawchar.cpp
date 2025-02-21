/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11�͉ۑ�           */
/* project: drawchar             */
/* outline: �����p�^�[���`���H */

#include "ap_int.h"
#include "charpat.h"

#define XSIZE 640
#define MAXDOTSIZE 60

/* 1�������̕`����s�� */
void drawchar(
    volatile ap_uint<32> *dstout,
    ap_uint<11> xpos,
    ap_uint<11> ypos,
    ap_uint<8>  letter,
    ap_uint<8>  dotsize,
    ap_uint<32> color)
{
    int tempcol;
    ap_uint<32> buf[8][MAXDOTSIZE*8];

    /* 1�������������i��������dotsize�𔽉f�A�c������8�h�b�g�̂܂܁j */
    for( int y=0; y<8; y++ ) {
        int temp = pattern[letter][y];
        for ( int x=0; x<8; x++ ) {
            if ( (temp & (0x80>>x)) !=0 )
                tempcol = color;
            else
                tempcol = 0;
            /* dotsize���������ɃR�s�[ */
            xd_loop1: for ( int xd=0; xd<dotsize; xd++ )
                buf[y][x*dotsize+xd] = tempcol;
        }
    }
    /* 1�������`��i�c������dotsize�𔽉f�j */
    for ( int y=0; y<8; y++ ) {
        for ( int yd=0; yd<dotsize; yd++ ) {
            xd_loop2: for ( int xd=0; xd<8*dotsize; xd++ ) {
                dstout[(ypos + y*dotsize + yd)*XSIZE + xpos + xd] = buf[y][xd];
            }
        }
    }
}
