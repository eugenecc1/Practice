/* Copyright(C) 2020 Cobac.Net All Rights Reserved.     */
/* chapter: ��11��                                      */
/* project: pattern_hls                                 */
/* outline: HLS�ō쐬�����p�^�[���\����H�̃e�X�g�x���` */

#include <ap_int.h>
#include "pattern.h"

void pattern(u8*, u8*, u8*, u1*, u1*, u1*);

int main()
{
    u8 VGA_R,  VGA_G,  VGA_B;
    u1 VGA_HS, VGA_VS, VGA_DE;

    pattern(&VGA_R, &VGA_G, &VGA_B, &VGA_HS, &VGA_VS, &VGA_DE);

    return 0;
}
