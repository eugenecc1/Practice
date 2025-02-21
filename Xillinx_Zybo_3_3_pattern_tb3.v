/* Copyright(C) 2020 Cobac.Net All Rights Reserved.        */
/* chapter: ��3��                                          */
/* project: pattern                                        */
/* outline: �p�^�[���\����H�̃^�C�~���O���ؗp�e�X�g�x���` */

`timescale 1ns/1fs

module pattern_tb3;

/* �N���b�N������Sim�N���b�N�����` */
localparam STEP = 8;
localparam CLKNUM = (800*525+12000)*5;

/* �ڑ��M���̐錾 */
reg             CLK;
reg             RST;
wire            HDMI_CLK_N, HDMI_CLK_P;
wire    [2:0]   HDMI_N, HDMI_P;

/* �p�^�[���\����H�̍ŏ�ʊK�w��ڑ� */
pattern_hdmi pattern_hdmi(
    .CLK        (CLK),
    .RST        (RST),
    .HDMI_CLK_N (HDMI_CLK_N),
    .HDMI_CLK_P (HDMI_CLK_P),
    .HDMI_N     (HDMI_N),
    .HDMI_P     (HDMI_P)
);

/* �N���b�N�̐��� */
always begin
    CLK = 0; #(STEP/2);
    CLK = 1; #(STEP/2);
end

/* ���ؑΏۂւ̓��͂��쐬 */
initial begin
                RST = 0;
    #(STEP*600) RST = 1;
    #(STEP*20)  RST = 0;
    #(STEP*CLKNUM);
    $stop;
end

endmodule
