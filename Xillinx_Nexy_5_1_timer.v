/* MicroBlaze MCS�V�X�e���̍ŏ�ʊK�w                */
/* Copyright(C) 2013 Cobac.Net, All rights reserved. */

module TIMER(
    input           CLK100, RST,
    input   [3:0]   SW,
    output  [7:0]   nSEG,
    output  [3:0]   nAN,
    output          TXD
);

assign nAN = 4'b1110;

/* CLK(50MHz)�̍쐬 */
reg CLK;

always @( posedge CLK100 ) begin
    CLK <= ~CLK;
end

mcs mcs_0 (
    .Clk    (CLK),
    .Reset  (RST),
    .GPO1   (nSEG),
    .GPI1   (SW),
    .UART_Tx(TXD)
);

endmodule
