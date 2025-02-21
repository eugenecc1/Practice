/* �o�X�E�C���^�[�t�F�[�X�E�u���b�N                 */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module BUSIF(
    input               CLK, RST,
    input       [31:0]  IO_Address,
    output  reg [31:0]  IO_Read_Data,
    input               IO_Addr_Strobe,
    input               IO_Read_Strobe, IO_Write_Strobe,
    output              IO_Ready,
    output  reg [7:0]   WR,
    input       [31:0]  RDATA0, RDATA1, RDATA2, RDATA3,
                        RDATA4, RDATA5, RDATA6, RDATA7,
    input               MEMIORDY
);

/* �o���N�A�h���X */
wire [7:0] bank = IO_Address[31:24];

/* �e�u���b�N��Write�M���쐬 */
always @* begin
    WR = 8'b0;
    if ( IO_Addr_Strobe & IO_Write_Strobe )
        case ( bank )
            8'hc0:  WR = 8'b00000001;
            8'hc1:  WR = 8'b00000010;
            8'hc2:  WR = 8'b00000100;
            8'hc3:  WR = 8'b00001000;
            8'hc4:  WR = 8'b00010000;
            8'hc5:  WR = 8'b00100000;
            8'hc6:  WR = 8'b01000000;
            8'hc7:  WR = 8'b10000000;
        endcase
end

/* Read�f�[�^�M���̃Z���N�^ */
always @* begin
    case ( bank )
        8'hc0:  IO_Read_Data = RDATA0;
        8'hc1:  IO_Read_Data = RDATA1;
        8'hc2:  IO_Read_Data = RDATA2;
        8'hc3:  IO_Read_Data = RDATA3;
        8'hc4:  IO_Read_Data = RDATA4;
        8'hc5:  IO_Read_Data = RDATA5;
        8'hc6:  IO_Read_Data = RDATA6;
        8'hc7:  IO_Read_Data = RDATA7;
        default:IO_Read_Data = 32'hxxxx;
    endcase
end

/* IO_Ready�쐬 */
/* �o���N��C0�ȊO��1�N���b�N���1�ɂ��� */
reg ioready;

always @( posedge CLK ) begin
    if ( RST )
        ioready <= 1'b0;
    else
        ioready <= IO_Addr_Strobe &
                   (IO_Read_Strobe | IO_Write_Strobe);
end

assign IO_Ready = (bank==8'hc0) ? MEMIORDY: ioready;

endmodule
