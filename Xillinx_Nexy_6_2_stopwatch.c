/* �X�g�b�v�E�H�b�`�̃v���O����                      */
/* Copyright(C) 2013 Cobac.Net, All rights reserved. */

#include <stdio.h>
#include "platform.h"
#include "IO_Module.h"
#include "mb_interface.h"

#define LED *((volatile unsigned int *) 0xc2000000)
#define FIT1_int 0x80
#define SW GPI1

#define SW1_MASK 0x01
#define SW2_MASK 0x02

/* �����֐���` */
void timer_int_handler( void * );
void disp( void );

static unsigned long system_timer;
unsigned long nowtime;
unsigned char SwPort_25ms;
int running;

int main()
{
    unsigned char pre_sw, now_sw;
    init_platform();

    nowtime = system_timer = running = 0;
    pre_sw = now_sw = 0;

    microblaze_register_handler(timer_int_handler, (void *)0);
    microblaze_enable_interrupts();
    IRQ_ENABLE = FIT1_int;

    while(1) {
        /* LED�\�� */
        disp();
        /* �X�C�b�`���̓`�F�b�N */
        pre_sw = now_sw;
        now_sw = SwPort_25ms;
        if ( (pre_sw & SW1_MASK)==0 && (now_sw & SW1_MASK)!=0 )
            running ^= 1;
        if ( (pre_sw & SW2_MASK)==0 && (now_sw & SW2_MASK)!=0 )
            nowtime = 0;
    }

    cleanup_platform();
    return 0;
}

/* ���荞�ݏ��� */
void timer_int_handler( void *arg )
{
    /* 1ms���ƂɃJ�E���g�A�b�v */
    system_timer++;
    /* 25ms���ƂɃX�C�b�`�|�[�g����荞�� */
    if ( (system_timer % 25) == 0 )
        SwPort_25ms = SW;
    /* �v���J�E���^�̃C���N�������g�Ə���`�F�b�N */
    if ( (system_timer % 10) == 0 && running == 1 ) {
        if ( nowtime++ >= 6000 )
            nowtime = 0;
    }
    IRQ_ACK = FIT1_int;
}

/* LED�\���֐� */
void disp( void )
{
    unsigned int pioout;
    pioout = ( nowtime/1000   << 12) | ((nowtime/100)%10 << 8) |
             ((nowtime/10)%10 <<  4) |   nowtime%10;
    LED = 0xf40000 | pioout;
}
