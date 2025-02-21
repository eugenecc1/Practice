/* CMOS�J�������W���[����SCCB�R���g���[��           */
/* Copyright(C) 2013 Cobac.Net All rights reserved. */

module SCCB(
    input           CLK, RST,
    /* BUS I/F */
    input   [31:0]  IO_Address, IO_Write_Data,
    input   [3:0]   IO_Byte_Enable,
    output  [31:0]  RDATA,
    input           WR,
    /* SCCB out */
    output  reg     SCL,
    output          SDA
);

/* ���W�X�^�������ݐM�� */
assign sccbtrig = WR && IO_Address[15:2]==14'h0000
                     && (&IO_Byte_Enable[1:0]);

/* BUSY�t���O�ǂݏo�� */
reg     sccbbusy;
assign RDATA = (IO_Address[15:2]==14'h0001) ? {31'b0, sccbbusy}: 32'b0;

/* �X�e�[�g�}�V���i�錾���j */
parameter HALT=2'h0, STBIT=2'h1, SEND=2'h2, POSDLY=2'h3;
reg [1:0]   cur, nxt;

/* �e��C�l�[�u���M���쐬�p�J�E���^�i100kHz�j */
parameter CNTMAX=9'd500;
reg [8:0]   cnt9;

always @( posedge CLK ) begin
    if ( RST )
        cnt9 <= 9'h0;
    else if ( cnt9==CNTMAX-1 )
        cnt9 <= 9'h0;
    else
        cnt9 <= cnt9 + 9'h1;
end

/* �e��C�l�[�u���M�� */
wire state_en = (cnt9==CNTMAX-1);
wire sclset0  = (cnt9==2);
wire sclset1  = (cnt9==CNTMAX/2+2);
wire sft_en   = (cnt9==CNTMAX/4-1) && (cur!=HALT);

/* �f�[�^�V�t�g���W�X�^ */
reg [29:0] dsft;

always @( posedge CLK ) begin
    if ( RST )
        dsft <= 30'h3fff_ffff;
    else if ( sccbtrig )
        dsft <= { 2'b10, 8'h42, 1'b0, IO_Write_Data[15:8], 1'b0,
                                      IO_Write_Data[7:0],  1'b0, 1'b0};
    else if ( sft_en )
        dsft <= {dsft[28:0], 1'b1};
end

/* Hi-Z�V�t�g���W�X�^ */
parameter HIZPOS=30'b00_000000001_000000001_000000001_0;
reg [29:0] zsft;

always @( posedge CLK ) begin
    if ( RST )
        zsft <= 30'b0;
    else if ( sccbtrig )
        zsft <= HIZPOS;
    else if ( sft_en )
        zsft <= {zsft[28:0], 1'b0};
end

/* SDA�o�͍쐬 */
assign SDA = (zsft[29]==1'b1) ? 1'bz: dsft[29];

/* SCL�o�͍쐬 */
always @( posedge CLK ) begin
    if ( RST )
        SCL <= 1'b1;
    else if ( cur==SEND ) begin
        if ( sclset0 )
            SCL <= 1'b0;
        else if ( sclset1 )
            SCL <= 1'b1;
    end
    else
        SCL <= 1'b1;
end

/* �f�[�^���o�J�E���^ */
reg [4:0] sendcnt;

always @( posedge CLK ) begin
    if ( RST )
        sendcnt <= 5'h00;
    else if ( cur==HALT )
        sendcnt <= 5'h00;
    else if ( cur==SEND && state_en )
        sendcnt <= sendcnt + 5'h01;
end

wire sendend = (sendcnt==5'd27);

/* sccbbusy�x���p�J�E���^   */
/* 1�J�E���g������10��s�x�� */
reg [7:0] busycnt;
parameter BUSYCNTMAX = 20;

always @( posedge CLK ) begin
    if ( RST )
        busycnt <= 8'h00;
    else if ( cur==HALT )
            busycnt <= 8'h00;
    else if ( state_en && cur==POSDLY )
        if ( busycnt==BUSYCNTMAX )
            busycnt <= 8'h00;
        else
            busycnt <= busycnt + 8'h01;
end

/* sccbbusy�M�� */
always @( posedge CLK ) begin
    if ( RST )
        sccbbusy <= 1'b0;
    else if ( sccbtrig )
        sccbbusy <= 1'b1;
    else if ( state_en && cur==POSDLY && busycnt==BUSYCNTMAX )
        sccbbusy <= 1'b0;
end

/* ��ԑJ�ڂ̊J�n�M��                     */
/* sccbtrig������state_en�܂ŐL�΂��č쐬 */
/* sccbtrig��state_en�������ł��L�т�     */
reg     regwrite;

always @(  posedge CLK ) begin
    if ( RST )
        regwrite <= 1'b0;
    else if ( sccbtrig )
        regwrite <= 1'b1;
    else if ( state_en )
        regwrite <= 1'b0;
end

/* �X�e�[�g�}�V�� */
always @( posedge CLK ) begin
    if ( RST )
        cur <= HALT;
    else if ( state_en )
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:   if ( regwrite )
                    nxt = STBIT;
                else
                    nxt = HALT;
        STBIT: nxt = SEND;
        SEND:   if ( sendend )
                    nxt = POSDLY;
                else
                    nxt = SEND;
        POSDLY: if ( busycnt==BUSYCNTMAX )
                    nxt = HALT;
                else
                    nxt = POSDLY;
        default:nxt = HALT;
    endcase
end

endmodule
