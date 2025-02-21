/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��9��                                */
/* project: display                              */
/* outline: �O���t�B�b�N�\����HIP�̃e�X�g�x���` */

`timescale 1ns/1ps

import axi_vip_pkg::*;
import design_1_axi_vip_0_0_pkg::*;

module disp_ip_tb;

/* �ڑ��M���̐錾 */
logic ACLK;
logic ARESETN;
logic [7:0]     VGA_R,  VGA_G,  VGA_B;
logic           VGA_HS, VGA_VS, VGA_DE;
logic [29:0]    DISPADDR;
logic           PCK, DISPON, VBLANK, CLRVBLNK;
logic           FIFO_OVER, FIFO_UNDER;

/* ���ؑΏۂ̐ڑ� */
design_1_wrapper dut (.*);

/* �N���b�N�̐��� */
localparam integer STEP  = 10;
localparam CLKNUM = (800*525+12000)*4;

always begin
    ACLK = 0; #(STEP/2);
    ACLK = 1; #(STEP/2);
end

/* VRAM�̐擪�A�h���X */
localparam MEMBASE = 32'h1000_0000;

/* �e�X�g�x���`�{�� */
integer fd;

initial begin
    fd = $fopen("imagedata.raw", "wb");
    ARESETN = 1;
    DISPON = 0;
    DISPADDR = MEMBASE;
    CLRVBLNK = 0;
    #(STEP*200) ARESETN = 0;
    #(STEP*20)  ARESETN = 1;
    #(STEP*20)  DISPON  = 1;
    #(STEP*CLKNUM);
    $fclose(fd);
    $stop;
end

/* �t�@�C���o�� */
always @(posedge PCK) begin
    if ( VGA_DE ) begin
        $fwrite(fd, "%c", VGA_R);
        $fwrite(fd, "%c", VGA_G);
        $fwrite(fd, "%c", VGA_B);
    end
end

/* VIP Slave�p�̃G�[�W�F���g��錾���X���[�u���N�� */
design_1_axi_vip_0_0_slv_mem_t agent;

initial begin
    agent = new("AXI Slave Agent", dut.design_1_i.axi_vip_0.inst.IF);
    agent.start_slave();
    meminit_incr();
end

/* �����l0��1��f���Ƃ�+1�����f�[�^������ */
task meminit_incr();
begin
    for( integer i=0; i<640*480; i++ ) begin
        agent.mem_model.backdoor_memory_write_4byte
                                        ( MEMBASE+i*4, i, 4'b1111 );
    end
end
endtask

endmodule
