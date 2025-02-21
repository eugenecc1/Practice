/* 1Hz�����2Hz�M���̍쐬                           */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module CNT1SEC(
    input  CLK, RST,
    output EN1HZ,
    output reg SIG2HZ
);

/* 50MHz�J�E���^ */
reg [25:0] cnt;

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( EN1HZ )
        cnt <= 26'b0;
    else
        cnt <= cnt + 1'b1;
end

/* 1Hz�̃C�l�[�u���M�� */
assign EN1HZ = (cnt==26'd49999999);

/* 2Hz�A�f���[�e�B50%�̐M���쐬 */
wire cnt37499999 = (cnt==26'd37499999);
wire cnt24999999 = (cnt==26'd24999999);
wire cnt12499999 = (cnt==26'd12499999);

always @( posedge CLK ) begin
    if( RST )
        SIG2HZ <= 1'b0;
    else if( cnt12499999 | cnt24999999 | cnt37499999 | EN1HZ )
        SIG2HZ <= ~SIG2HZ;
end

endmodule
