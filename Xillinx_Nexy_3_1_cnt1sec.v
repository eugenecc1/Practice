/* 1Hz�M���̍쐬                                    */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module CNT1SEC(
    input  CLK, RST,
    output EN1HZ
);

/* 50MHz�J�E���^ */
reg [25:0] cnt;

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( EN1HZ )
        cnt <= 26'b0;
    else
        cnt <= cnt + 26'b1;
end

/* 1Hz�̃C�l�[�u���M�� */
assign EN1HZ = (cnt==26'd49_999_999);

endmodule
