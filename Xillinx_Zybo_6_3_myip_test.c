/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: 第6章                           */
/* project: blink_ip_mb                     */
/* outline: MYIPテストプログラム（LED点滅） */

#include "xparameters.h"
#include "xil_printf.h"

#define LED *((volatile unsigned int*) XPAR_MYIP_0_S00_AXI_BASEADDR)

int main()
{
    int i, j;

    xil_printf("Hello FPGA World!\r\n");
    while(1) {
        for ( i=0; i<5; i++ ) {
            xil_printf("i=%d\r\n", i);
            switch ( i ) {
                case  0: LED = 0x4; break;
                case  1: LED = 0x2; break;
                case  2: LED = 0x1; break;
                case  3: LED = 0x7; break;
                case  4: LED = 0x0; break;
                default: LED = 0x0;
            }
            for ( j=0; j<4000000; j++); /* 遅延を作成（MicroBlazeの速度に合わせた） */
        }
    }

    return 0;
}
