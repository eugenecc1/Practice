/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11��                           */
/* project: blink_hls                        */
/* outline: HLS�ō쐬����L�`�J�̃e�X�g�x���` */

#include <ap_int.h>

void blink(ap_uint<3>*);

int main()
{
    ap_uint<3> LED_RGB;

    blink( &LED_RGB );

    return 0;
}
