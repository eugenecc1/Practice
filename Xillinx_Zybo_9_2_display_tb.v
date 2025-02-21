/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: ��9��                              */
/* project: display                            */
/* outline: �O���t�B�b�N�\����H�̃e�X�g�x���` */
/*          Zynq VIP�𗘗p                     */

`timescale 1ns/1ps

`define PSINST   dut.design_1_i.processing_system7_0.inst
`define DISPINST dut.design_1_i.display_0.inst

module display_tb;

/* �ڑ��M���̐錾 */
reg ACLK;
reg ARESETN;

wire temp_ACLK    = ACLK;
wire temp_ARESETN = ARESETN;

/* ���ؑΏۂ̐ڑ� */
design_1_wrapper dut (
    .DDR_addr   (),
    .DDR_ba (),
    .DDR_cas_n  (),
    .DDR_ck_n   (),
    .DDR_ck_p   (),
    .DDR_cke    (),
    .DDR_cs_n   (),
    .DDR_dm     (),
    .DDR_dq     (),
    .DDR_dqs_n  (),
    .DDR_dqs_p  (),
    .DDR_odt    (),
    .DDR_ras_n  (),
    .DDR_reset_n(),
    .DDR_we_n   (),
    .FIXED_IO_ddr_vrn   (),
    .FIXED_IO_ddr_vrp   (),
    .FIXED_IO_mio       (),
    .FIXED_IO_ps_clk    (temp_ACLK),
    .FIXED_IO_ps_porb   (temp_ARESETN),
    .FIXED_IO_ps_srstb  (temp_ARESETN),
    .HDMI_CLK_N (),
    .HDMI_CLK_P (),
    .HDMI_N     (),
    .HDMI_P     (),
    .LED        ()
);

/* �N���b�N�̐��� */
localparam integer STEP  = 10;
localparam CLKNUM = (800*525+12000)*4;

always begin
    ACLK = 0; #(STEP/2);
    ACLK = 1; #(STEP/2);
end

/* ���W�X�^�������݃^�X�N */
task write_reg;
input [31:0] addr;
input [31:0] data;
reg resp;
begin
    `PSINST.write_data(addr, 4, data, resp);
end
endtask

/* VRAM�̐擪�A�h���X */
localparam MEMBASE = 32'h1000_0000;

/* ���W�X�^�A�h���X */
localparam DISPADDR = 32'h4120_0000;
localparam DISPON   = 32'h4120_0008;
localparam VBLANK   = 32'h4121_0000;
localparam CLRVBLNK = 32'h4121_0008;

/* �����l0��1��f���Ƃ�+1�����f�[�^������ */
task meminit_incr;
integer i;
begin
    for( i=0; i<640*480; i=i+1 ) begin
        `PSINST.write_mem( i, MEMBASE+i*4, 4);
    end
end
endtask

/* �e�X�g�x���`�{�� */
integer fd;

initial begin
    fd = $fopen("imagedata.raw", "wb");
    ARESETN = 1;
    #(STEP*200) ARESETN = 0;
    #(STEP*20)  ARESETN = 1;
    #(STEP*20)  meminit_incr;
    /* PL�̃��Z�b�g */
    `PSINST.fpga_soft_reset(32'h1);
    `PSINST.fpga_soft_reset(32'h0);
    /* ���C�e���V�̐ݒ� */
    `PSINST.set_slave_profile("S_AXI_HP0", 2'b00);
    #(STEP*100);
    /* DISPON */
    write_reg( DISPADDR, MEMBASE );
    write_reg( CLRVBLNK, 32'h0 );
    write_reg( DISPON,   32'h1 );
    #(STEP*CLKNUM);
    $fclose(fd);
    $stop;
end

/* �t�@�C���o�� */
always @(negedge `DISPINST.PCK) begin
    if ( `DISPINST.VGA_DE ) begin
        $fwrite(fd, "%c", `DISPINST.VGA_R);
        $fwrite(fd, "%c", `DISPINST.VGA_G);
        $fwrite(fd, "%c", `DISPINST.VGA_B);
    end
end

endmodule
