/* MicroBlaze MCS v1.2 I/Oモジュールのレジスタ定義   */
/* Copyright(C) 2013 Cobac.Net, All rights reserved. */

#define UART_RX      *((volatile unsigned int *) 0x80000000)
#define UART_TX      *((volatile unsigned int *) 0x80000004)
#define UART_STATUS  *((volatile unsigned int *) 0x80000008)
#define IRQ_MODE     *((volatile unsigned int *) 0x8000000C)
#define GPO1         *((volatile unsigned int *) 0x80000010)
#define GPO2         *((volatile unsigned int *) 0x80000014)
#define GPO3         *((volatile unsigned int *) 0x80000018)
#define GPO4         *((volatile unsigned int *) 0x8000001C)
#define GPI1         *((volatile unsigned int *) 0x80000020)
#define GPI2         *((volatile unsigned int *) 0x80000024)
#define GPI3         *((volatile unsigned int *) 0x80000028)
#define GPI4         *((volatile unsigned int *) 0x8000002C)
#define IRQ_STATUS   *((volatile unsigned int *) 0x80000030)
#define IRQ_PENDING  *((volatile unsigned int *) 0x80000034)
#define IRQ_ENABLE   *((volatile unsigned int *) 0x80000038)
#define IRQ_ACK      *((volatile unsigned int *) 0x8000003C)
#define PIT1_PRELOAD *((volatile unsigned int *) 0x80000040)
#define PIT1_COUNTER *((volatile unsigned int *) 0x80000044)
#define PIT1_CONTROL *((volatile unsigned int *) 0x80000048)
#define UART_BAUD    *((volatile unsigned int *) 0x8000004C)
#define PIT2_PRELOAD *((volatile unsigned int *) 0x80000050)
#define PIT2_COUNTER *((volatile unsigned int *) 0x80000054)
#define PIT2_CONTROL *((volatile unsigned int *) 0x80000058)
#define PIT3_PRELOAD *((volatile unsigned int *) 0x80000060)
#define PIT3_COUNTER *((volatile unsigned int *) 0x80000064)
#define PIT3_CONTROL *((volatile unsigned int *) 0x80000068)
#define PIT4_PRELOAD *((volatile unsigned int *) 0x80000070)
#define PIT4_COUNTER *((volatile unsigned int *) 0x80000074)
#define PIT4_CONTROL *((volatile unsigned int *) 0x80000078)
