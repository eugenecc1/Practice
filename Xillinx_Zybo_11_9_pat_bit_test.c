/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11�͉ۑ�             */
/* project: display                */
/* outline: Patblt��Bitblt�̃e�X�g */

#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xil_cache.h"
#include "xpatblt.h"
#include "xbitblt.h"

/* GPIO�̃`���l���i�P�n�܂�j */
#define DISPADDR 1
#define DISPON   2
#define VBLANK   1
#define CLRVBLNK 2

/* �T�C�Y�A�擪�A�h���X */
#define XSIZE 640
#define YSIZE 480
#define WIDTH  160
#define HEIGHT 120
#define VRAM 0x10000000     /* page 0 */
#define TEX  0x1012c000     /* page 1 */

/* �ǂݏo�����Ə������ݐ�̃I�t�Z�b�g�A�h���X */
#define SRC0 (  0 +   0 * XSIZE)*4
#define SRC1 (160 +   0 * XSIZE)*4
#define DST0 (  0 +   0 * XSIZE)*4
#define DST1 ( 80 +  60 * XSIZE)*4
#define DST2 (  0 + 240 * XSIZE)*4
#define DST3 ( 80 + 300 * XSIZE)*4

/* �C���X�^���X�ϐ� */
XGpio GpioAddrOn, GpioBlank;
XPatblt PatInstance;
XBitblt BitInstance;

/* VBLANK�҂� */
void wait_vblank(void) {
    XGpio_DiscreteWrite(&GpioBlank, CLRVBLNK, 1);
    XGpio_DiscreteWrite(&GpioBlank, CLRVBLNK, 0);
    while (XGpio_DiscreteRead(&GpioBlank, VBLANK)==0);
}

/* patblt_ip�𐧌䂵�ăI���W�i����patblt�֐����Č� */
void patblt( int xpos, int ypos, int width, int height, int color ) {
    XPatblt_Set_xpos(&PatInstance, xpos);
    XPatblt_Set_ypos(&PatInstance, ypos);
    XPatblt_Set_width(&PatInstance, width);
    XPatblt_Set_height(&PatInstance, height);
    XPatblt_Set_color(&PatInstance, color);
    XPatblt_Start(&PatInstance);
    while (XPatblt_IsDone(&PatInstance)==0);
}

/* bitblt_ip�𐧌䂵�ăI���W�i����bitblt�֐����Č� */
void bitblt( int srcin, int dstin, int dstout,
             int alpha, int width, int height, int transparent ) {
    XBitblt_Set_srcin(&BitInstance, srcin);
    XBitblt_Set_dstin(&BitInstance, dstin);
    XBitblt_Set_dstout(&BitInstance, dstout);
    XBitblt_Set_alpha(&BitInstance, alpha);
    XBitblt_Set_width(&BitInstance, width);
    XBitblt_Set_height(&BitInstance, height);
    XBitblt_Set_transparent(&BitInstance, transparent);
    XBitblt_Start(&BitInstance);
    while (XBitblt_IsDone(&BitInstance)==0);
}

int main()
{
    int Status;

    /* GPIO_0�i�\���A�h���X�A�\��ON/OFF�j�̏����� */
    Status = XGpio_Initialize(&GpioAddrOn, XPAR_GPIO_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XGpio_SetDataDirection(&GpioAddrOn, DISPADDR, 0);
    XGpio_SetDataDirection(&GpioAddrOn, DISPON,   0);

    /* GPIO_1�iVBLANK�֘A�j�̏����� */
    Status = XGpio_Initialize(&GpioBlank, XPAR_GPIO_1_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XGpio_SetDataDirection(&GpioBlank, VBLANK,   1);
    XGpio_SetDataDirection(&GpioBlank, CLRVBLNK, 0);

    /* �\��ON */
    wait_vblank();
    XGpio_DiscreteWrite(&GpioAddrOn, DISPADDR, VRAM);
    XGpio_DiscreteWrite(&GpioAddrOn, DISPON, 1);

    /* Patblt�̏����� */
    Status = XPatblt_Initialize(&PatInstance, XPAR_PATBLT_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XPatblt_Set_dstout(&PatInstance, VRAM);

    /* Bitblt�̏����� */
    Status = XBitblt_Initialize(&BitInstance, XPAR_BITBLT_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /* ��ʃN���A */ 
    patblt(  0,   0, 640, 480, 0);

    /* Bitblt�̃e�X�g�x���`�Ɠ������e�ŕ`�� */

    /* �e�N�X�`����ʍ���ɐԐ̔������� */
    XPatblt_Set_dstout(&PatInstance, TEX+SRC0);
    patblt(   0, 0, WIDTH, HEIGHT, 0x00ff0000);
    XPatblt_Set_dstout(&PatInstance, TEX+SRC1);
    patblt(   0, 0, WIDTH, HEIGHT, 0xff0000ff);
    /* ������̃�=0�A����ȊO��=0xff */
    for (int y=0; y<60; y++) {
        for(int x=0; x<80; x++) {
            *(unsigned int *)(TEX + SRC1 + (x + y*XSIZE)*4) &= 0x00ffffff;
        }
    }
    Xil_DCacheFlush();

    /* �e�N�X�`��1�ڏ������� */
    bitblt(TEX+SRC0, VRAM+DST0, VRAM+DST0, 255, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��2�ڂƔw�i��ǂݍ��݉�f�ԉ��Z */
    bitblt(TEX+SRC1, VRAM+DST1, VRAM+DST1, 128, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��3�ڏ������� */
    bitblt(TEX+SRC0, VRAM+DST2, VRAM+DST2, 255, WIDTH, HEIGHT, 0);

    /* �e�N�X�`��4�ڂ̓��ߏ������s���w�i�ɏ��� */
    bitblt(TEX+SRC1, VRAM+DST3, VRAM+DST3, 128, WIDTH, HEIGHT, 1);

    /* �\�����I�t���ďI�� */
    wait_vblank();    /* �����̍s�Ƀu���[�N�|�C���g�� */
    XGpio_DiscreteWrite(&GpioAddrOn, DISPON, 0);

    return 0;
}
