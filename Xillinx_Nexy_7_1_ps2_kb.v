/* PS/2接続の最上位階層（キーボード接続用）         */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module PS2(
    input   CLK100, RST,
    output  [7:0]   nSEG,
    output  [3:0]   nAN,
    output          TXD,
    inout   PS2CLK_KB, PS2DATA_KB,
    input   PS2CLK_MS, PS2DATA_MS  // 未使用マウス端子
);

/* CLK(50MHz)の作成 */
reg CLK;

always @( posedge CLK100 ) begin
    CLK <= ~CLK;
end

/* 内部信号宣言 */
wire [31:0] IO_Address, IO_Write_Data, IO_Read_Data;
wire [3:0]  IO_Byte_Enable;
wire        IO_Addr_Strobe, IO_Read_Strobe, IO_Write_Strobe;
wire        IO_Ready;
wire [31:0] RDATA3;
wire [7:0]  WR;
reg  [23:0] dispdata;

/* バンク番号の設定 */
parameter CELLRAM=3'h0, MEMMODE=3'h1, LEDBANK=3'h2, PS2BANK=3'h3,
          VGABANK=3'h4,   GRAPH=3'h5,  CAMPIC=3'h6, CAMCTRL=3'h7;

/* 各モジュールの接続 */
mcs mcs_0 (
    .Clk            (CLK),
    .Reset          (RST),
    .IO_Addr_Strobe (IO_Addr_Strobe),
    .IO_Read_Strobe (IO_Read_Strobe),
    .IO_Write_Strobe(IO_Write_Strobe),
    .IO_Address     (IO_Address),
    .IO_Byte_Enable (IO_Byte_Enable),
    .IO_Write_Data  (IO_Write_Data),
    .IO_Read_Data   (IO_Read_Data),
    .IO_Ready       (IO_Ready),
    .UART_Tx        (TXD)
);

BUSIF BUSIF(
    .CLK            (CLK),
    .RST            (RST),
    .IO_Address     (IO_Address),
    .IO_Read_Data   (IO_Read_Data),
    .IO_Addr_Strobe (IO_Addr_Strobe),
    .IO_Read_Strobe (IO_Read_Strobe),
    .IO_Write_Strobe(IO_Write_Strobe),
    .IO_Ready       (IO_Ready),
    .WR             (WR),
    .RDATA2         ({8'h00, dispdata}),
    .RDATA3         (RDATA3), 
    .RDATA0(32'b0), .RDATA1(32'b0),
    .RDATA4(32'b0), .RDATA5(32'b0),
    .RDATA6(32'b0), .RDATA7(32'b0),
    .MEMIORDY       (1'b0)
);

LEDDISP LEDDISP(
    .CLK    (CLK),
    .RST    (RST),
    .nSEG   (nSEG),
    .nAN    (nAN),
    .DIG3   (dispdata[15:12]),
    .DIG2   (dispdata[11:8]),
    .DIG1   (dispdata[7:4]),
    .DIG0   (dispdata[3:0]),
    .DP     (dispdata[19:16]),
    .EN     (dispdata[23:20])
);

/* ダイナミック点灯回路の入力に接続するレジスタ */
always @( posedge CLK ) begin
    if ( RST )
        dispdata <= 24'b0;
    else if ( WR[LEDBANK] && (IO_Address[23:2]==22'b0) ) begin
        if ( IO_Byte_Enable[0] )
            dispdata[7:0]   <= IO_Write_Data[7:0];
        if ( IO_Byte_Enable[1] )
            dispdata[15:8]  <= IO_Write_Data[15:8];
        if ( IO_Byte_Enable[2] )
            dispdata[23:16] <= IO_Write_Data[23:16];
    end
end


PS2IF PS2IF(
    .CLK            (CLK),
    .RST            (RST),
    .IO_Address     (IO_Address),
    .IO_Byte_Enable (IO_Byte_Enable),
    .IO_Write_Data  (IO_Write_Data),
    .WR             (WR[PS2BANK]),
    .RDATA          (RDATA3),
    .PS2CLK         (PS2CLK_KB),
    .PS2DATA        (PS2DATA_KB)
);

endmodule
