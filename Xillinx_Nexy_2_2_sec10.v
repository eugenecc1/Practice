/*   1�b���\��                                      */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module SEC10(
    input   CLK100, RST,
    output  reg [7:0]   nSEG,
    output      [3:0]   nAN
);

/* CLK(50MHz)�̍쐬 */
reg CLK;

always @( posedge CLK100 ) begin
    CLK <= ~CLK;
end

/* �R�����[�q�̌Œ� */
assign nAN = 4'b1110;

/* 1Hz�̃C�l�[�u���M�������i�N���b�N���g��: 50MHz�j */
reg  [25:0] cnt;
wire en1hz = (cnt==26'd49_999_999);

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( en1hz )
        cnt <= 26'b0;
    else
        cnt <= cnt + 26'b1;
end

/* 10�i�J�E���^�i1�b���j */
reg  [3:0] sec;

always @( posedge CLK ) begin
    if ( RST )
        sec <= 4'h0;
    else if ( en1hz )
        if ( sec==4'h9 )
            sec <= 4'h0;
        else
            sec <= sec + 4'h1;
end

/* 7�Z�O�����g�\���f�R�[�_              */
/* �e�Z�O�����g��gfedcba�̕��т�0�œ_�� */
always @* begin
    case ( sec )
        4'h0:   nSEG = 8'b11000000;
        4'h1:   nSEG = 8'b11111001;
        4'h2:   nSEG = 8'b10100100;
        4'h3:   nSEG = 8'b10110000;
        4'h4:   nSEG = 8'b10011001;
        4'h5:   nSEG = 8'b10010010;
        4'h6:   nSEG = 8'b10000010;
        4'h7:   nSEG = 8'b11011000;
        4'h8:   nSEG = 8'b10000000;
        4'h9:   nSEG = 8'b10010000;
        default:nSEG = 8'bxxxxxxxx;
    endcase
end

endmodule
