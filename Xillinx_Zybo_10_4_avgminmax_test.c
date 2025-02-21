/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��10�͉ۑ�                       */
/* project: avgminmax                        */
/* outline: ���ϒl�AMIN�AMAX�Z�o��H�̃e�X�g */

#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xavgminmax.h"

#define SIZE 16

/* �C���X�^���X�ϐ��̐錾 */
XAvgminmax Instance;

int main()
{
    u32 din[SIZE];
    int i, expmin, expmax;
    long long expavg=0;
    int average, min, max;

    /* ������ */
    if ( XAvgminmax_Initialize(&Instance,
                XPAR_XAVGMINMAX_0_DEVICE_ID)!=XST_SUCCESS ) {
        xil_printf("Init Error!\n");
        return XST_FAILURE;
    }
    
    /* �z��din�ɗ������� */
    for ( i=0; i<SIZE; i++ ) {
        din[i] = rand();
        xil_printf("din[%2d]=%d\n", i, din[i]);
    }
    /* ���Ғl���쐬 */
    expmin = din[0];
    expmax = din[0];
    for ( i=0; i<SIZE; i++ ) {
        expavg += din[i];
        if (expmin > din[i]) {
            expmin = din[i];
        }
        if (expmax < din[i]) {
            expmax = din[i];
        }
    }
    expavg /= SIZE;

    /* �|�[�g���o�R���Ĕz��din�ɏ������� */
    XAvgminmax_Write_din_Words(&Instance, 0, din, SIZE);

    /* �Z�o��H���N�� */
    XAvgminmax_Start(&Instance);
    while (XAvgminmax_IsDone(&Instance)==0);

    /* ���Z���ʂ��擾 */
    average = XAvgminmax_Get_average(&Instance);
    min     = XAvgminmax_Get_min(&Instance);
    max     = XAvgminmax_Get_max(&Instance);
    xil_printf("Average=%d  Minimum=%d  Maximum=%d\n", average, min, max);

    /* ���Z���ʂ����Ғl�Ɣ�r */
    if ( average==expavg && min==expmin && max==expmax ) {
        xil_printf("OK.\n");
    }
    else {
        xil_printf("*** NG ***\n");
        xil_printf("expavg=%d  expmin=%d  expmax=%d\n", expavg, expmin, expmax);
    }

    return 0;
}
