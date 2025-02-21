/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��11�͉ۑ�           */
/* project: display              */
/* outline: �h�b�g�����Ŏ��v�\�� */

#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xscutimer.h"
#include "xscugic.h"
#include "xil_cache.h"
#include "xdrawchar.h"

/* GPIO�̃`���l���i�P�n�܂�j */
#define DISPADDR 1
#define DISPON   2
#define VBLANK   1
#define CLRVBLNK 2

#define XSIZE 640
#define YSIZE 480
#define VRAM ((volatile unsigned int *) 0x10000000)

#define TIMER_LOAD_VALUE 333333333  /* CPU���g��667MHz��1/2 */

/* �F */
#define WHITE   0x00ffffff
#define RED     0x00ff0000
#define GREEN   0x0000ff00
#define BLUE    0x000000ff
#define YELLOW  0x00ffff00
#define MAGENTA 0x00ff00ff
#define CYAN    0x0000ffff

/* �C���X�^���X�ϐ� */
XGpio GpioAddrOn, GpioBlank;
XScuTimer TimerInstance;
XScuGic IntcInstance;
XDrawchar Instance;

int hour=12, min=58, sec=0;

/* VBLANK�҂� */
void wait_vblank(void) {
    XGpio_DiscreteWrite(&GpioBlank, CLRVBLNK, 1);
    XGpio_DiscreteWrite(&GpioBlank, CLRVBLNK, 0);
    while (XGpio_DiscreteRead(&GpioBlank, VBLANK)==0);
}

void drawchar( short xpos, short ypos, char letter, char dotsize, int col ) {
    XDrawchar_Set_xpos(&Instance, xpos);
    XDrawchar_Set_ypos(&Instance, ypos);
    XDrawchar_Set_letter(&Instance, letter);
    XDrawchar_Set_dotsize(&Instance, dotsize);
    XDrawchar_Set_color(&Instance, col);
    XDrawchar_Start(&Instance);
    while (XDrawchar_IsDone(&Instance)==0);
}

void inctime_draw(void) {
    if ( ++sec>=60 ) {
        sec = 0;
        if ( ++min>=60 ) {
            min = 0;
            if ( ++hour>=24 )
                hour = 0;
        }
    }
    drawchar(  0, 200, hour/10+'0', 12, GREEN);
    drawchar( 96, 200, hour%10+'0', 12, GREEN);
    drawchar(192, 200, ':',         12, GREEN);
    drawchar(288, 200, min/10+'0',  12, GREEN);
    drawchar(384, 200, min%10+'0',  12, GREEN);
    drawchar(480, 216, sec/10+'0',  10, GREEN);
    drawchar(560, 216, sec%10+'0',  10, GREEN);
    xil_printf("%2d:%2d:%2d\n", hour, min, sec);
}

/* �^�C�}�[���荞�݊֐� */
void TimerCounterHandler(void *CallBackRef)
{
    XScuTimer *TimerInstancePtr = (XScuTimer *) CallBackRef;

    if (XScuTimer_IsExpired(TimerInstancePtr)) {
        XScuTimer_ClearInterruptStatus(TimerInstancePtr);
        inctime_draw();
    }
}

/* ���荞�݃R���g���[���̃h���C�o������ */
int ScuGicInt_Init( void )
{
    int Status;
    XScuGic_Config *ConfigPtr;
    ConfigPtr = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
    Status = XScuGic_CfgInitialize(&IntcInstance, ConfigPtr,
            ConfigPtr->CpuBaseAddress);
    if (Status != XST_SUCCESS) return XST_FAILURE;
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
            (Xil_ExceptionHandler) XScuGic_InterruptHandler,
            &IntcInstance);
    Xil_ExceptionEnable();
    return XST_SUCCESS;
}

/* ���荞�ݏ����֐��̓o�^ */
int ScuGicInt_Reg(u32 Int_Id, void *InstancePtr, void *IntHandler)
{
    int Status;
    Status = XScuGic_Connect(&IntcInstance,
            Int_Id,
            (Xil_ExceptionHandler)IntHandler,
            (void *)InstancePtr);
    if (Status != XST_SUCCESS) return XST_FAILURE;
    XScuGic_Enable(&IntcInstance, Int_Id);
    return XST_SUCCESS;
}

int main()
{
    int i, Status;
    XScuTimer_Config *ConfigPtr;

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
    XGpio_DiscreteWrite(&GpioAddrOn, DISPADDR, 0x10000000);
    XGpio_DiscreteWrite(&GpioAddrOn, DISPON, 1);

    /* ��ʃN���A */
    for ( i=0; i<XSIZE*YSIZE; i++) {
        VRAM[i] = 0;
    }
    Xil_DCacheFlush();

    /* drawchar�̏����� */
    Status = XDrawchar_Initialize(&Instance, XPAR_XDRAWCHAR_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XDrawchar_Set_dstout(&Instance, (u32)0x10000000);

    drawchar(  80,   0, 'D', 20, MAGENTA);
    drawchar( 240,   0, 'O', 20, YELLOW);
    drawchar( 400,   0, 'T', 20, CYAN);
    drawchar(   0, 320, 'C', 16, WHITE);
    drawchar( 128, 320, 'l', 16, WHITE);
    drawchar( 256, 320, 'o', 16, WHITE);
    drawchar( 384, 320, 'c', 16, WHITE);
    drawchar( 512, 320, 'k', 16, WHITE);


    /* �^�C�}�[�̃h���C�o������ */
    ConfigPtr = XScuTimer_LookupConfig(XPAR_XSCUTIMER_0_DEVICE_ID);
    Status = XScuTimer_CfgInitialize(&TimerInstance, ConfigPtr,
                    ConfigPtr->BaseAddr);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    /* ���荞�݊֘A�������Ɗ��荞�ݏ����֐��̓o�^ */
    Status = ScuGicInt_Init();
    if (Status != XST_SUCCESS) return XST_FAILURE;
    Status = ScuGicInt_Reg(XPAR_SCUTIMER_INTR, &TimerInstance,
                           TimerCounterHandler);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    /* �^�C�}�[�̏����ݒ�ƊJ�n */
    XScuTimer_EnableAutoReload(&TimerInstance);
    XScuTimer_LoadTimer(&TimerInstance, TIMER_LOAD_VALUE);
    XScuTimer_EnableInterrupt(&TimerInstance);
    XScuTimer_Start(&TimerInstance);

    while(1);

    return 0;
}
