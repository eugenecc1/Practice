/* Copyright(C) 2020 Cobac.Net All Rights Reserved.    */
/* chapter: ��8��                                      */
/* project: axisim                                     */
/* outline: AR#37425�}�X�^�[��VIP�X���[�u��ڑ�����Sim */

`timescale 1ns/1ps

import axi_vip_pkg::*;
import design_1_axi_vip_0_0_pkg::*;

module axisim_tb;

/* �ڑ��M���̐錾 */
logic ACLK, ARESETN, ERROR;

/* ���ؑΏۂ̐ڑ� */
design_1_wrapper dut (.*);

/* �N���b�N�̐��� */
localparam integer STEP  = 10;

always begin
    ACLK = 0; #(STEP/2);
    ACLK = 1; #(STEP/2);
end

/* ���ؑΏۂւ̓��͂��쐬 */
initial begin
    ARESETN = 1;
    #(STEP*5);
    ARESETN = 0;
    #(STEP*20);
    ARESETN = 1;
    #(STEP*500);
    $stop;
end

/* VIP Slave�p�̃G�[�W�F���g��錾���N�� */
design_1_axi_vip_0_0_slv_mem_t agent;

initial begin
    agent = new("AXI Slave Agent", dut.design_1_i.axi_vip_0.inst.IF);
    agent.start_slave();
end

endmodule
