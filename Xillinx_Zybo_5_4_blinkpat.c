/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��5��                                  */
/* Vivado : second                                 */
/* Vitis  : blinkpat                               */
/* outline: �F�̑g�ݍ��킹���v�b�V��SW�Ő؂�ւ��� */

#include "xparameters.h"
#include "xgpio.h"
#include "xscutimer.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_printf.h"

#define TIMER_LOAD_VALUE 8333333
#define LED_CHANNEL      1
#define BTN_CHANNEL      2

#define UPBTN 1

/* �e���Ӊ�H�̃C���X�^���X�ϐ� */
XGpio Gpio;
XScuTimer TimerInstance;
XScuGic IntcInstance;

int cnt, colpat;

/* LED�\���p�^�[���쐬 */
int led_rgb(int cnt, int colpat)
{
    int led;
    switch ( cnt%5 ) {
        case 0: led = (colpat==0) ? 0x4: 0x6; break;
        case 1: led = (colpat==0) ? 0x2: 0x3; break;
        case 2: led = (colpat==0) ? 0x1: 0x5; break;
        case 3: led = 0x7; break;
        case 4: led = 0x0; break;
        default:led = 0x0;
    }
    return led;
}

/* �^�C�}�[���荞�݊֐� */
void TimerCounterHandler(void *CallBackRef)
{
    volatile static int preBTN, nowBTN;
    XScuTimer *TimerInstancePtr = (XScuTimer *) CallBackRef;

    if (XScuTimer_IsExpired(TimerInstancePtr)) {
        XScuTimer_ClearInterruptStatus(TimerInstancePtr);
        ++cnt;
        preBTN = nowBTN;
        nowBTN = XGpio_DiscreteRead(&Gpio, BTN_CHANNEL) & 1;
        if ( (preBTN & UPBTN)==0 && (nowBTN & UPBTN)==UPBTN ) {
            if ( colpat == 0 )
                colpat = 1;
            else
                colpat = 0;
            xil_printf("BTNON  colpat = %d\n", colpat);
        }
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
    int Status;
    XScuTimer_Config *ConfigPtr;

    xil_printf("Timer Interrupt Test.\n\n");

    /* GPIO�̏����� */
    Status = XGpio_Initialize(&Gpio, XPAR_GPIO_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XGpio_SetDataDirection(&Gpio, LED_CHANNEL, 0);
    XGpio_SetDataDirection(&Gpio, BTN_CHANNEL, 1);

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

    while(1) {
        XGpio_DiscreteWrite(&Gpio, LED_CHANNEL, led_rgb(cnt/32, colpat));
    }

    return 0;
}
