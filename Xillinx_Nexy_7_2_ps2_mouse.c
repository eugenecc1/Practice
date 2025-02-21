/* PS/2�}�E�X�̃e�X�g�v���O����                     */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

#include <stdio.h>
#include "platform.h"

#define LED       *((volatile unsigned int *) 0xc2000000)
#define PS2STATUS *((volatile unsigned int *) 0xc3000000)
#define PS2RDATA  *((volatile unsigned int *) 0xc3000004)
#define PS2WDATA  *((volatile unsigned int *) 0xc3000008)

#define PS2VALID  0x01
#define PS2EMPTY  0x02

void putdata( int data );
int getdata(void);


int main()
{
    int data1, data2, data3, L, R;
    int posx=0, posy=0, dx, dy;
    int piodata=0xf00000;

    init_platform();
    LED = piodata;

    putdata(0xFF);      /* ���Z�b�g�R�}���h���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
    data2 = getdata();
    data3 = getdata();
//    xil_printf("res1=%x %x %x\n", data1, data2, data3);

    putdata(0xF4);      /* �C�l�[�u���R�}���h���M */
    data1 = getdata();  /* �}�E�X��������M�i�`�F�b�N���Ȃ��j */
//    xil_printf("res2=%x\n", data1);

    while(1) {
        /* �}�E�X����3�f�[�^��M */
        data1 = getdata();
        data2 = getdata();
        data3 = getdata();

        /* X�AY�̕����r�b�g�����o���A9�r�b�g�̈ړ��ʂƂ��� */
        if ( (data1 & 0x10) != 0)
            dx = data2 | 0xffffff00;
        else
            dx = data2;
        if ( (data1 & 0x20) != 0)
            dy = data3 | 0xffffff00;
        else
            dy = data3;

        /* �ړ��ʂ����݈ʒu�ɉ��Z */
        posx = posx + dx;
        posy = posy + dy;

        /* ���E�{�^���̌��o */
        L = ( (data1 & 0x01) != 0) ? 1: 0;
        R = ( (data1 & 0x02) != 0) ? 1: 0;

        /* �\���p�̃f�[�^��� */
        piodata = 0xf00000 | ((posx << 8) & 0xff00) | (posy & 0xff);
        if ( L==1 )
            piodata |= 0x040000;
        if ( R==1 )
            piodata |= 0x010000;
        if ( L==1 && R==1 )
            posx = posy = 0;    /* ���������ꂽ�猻�݈ʒu�����Z�b�g */

        /* LED�\�� */
        LED = piodata;
//        xil_printf("posx=%x posy=%x L=%x R=%x\n", posx, posy, L, R);
    }

    cleanup_platform();

    return 0;
}

/* �}�E�X��1�o�C�g���o */
void putdata( int data )
{
    while ( (PS2STATUS & PS2EMPTY)==0 );
    PS2WDATA = data;
}

/* �}�E�X����1�o�C�g��M */
int getdata(void)
{
    while ( (PS2STATUS & PS2VALID)==0 );
    PS2STATUS = 0;
    return PS2RDATA;
}
