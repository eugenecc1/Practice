/* ����p�X�e�[�g�}�V��                             */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module STATE(
    input   CLK, RST,
    input   SIG2HZ,
    input   MODE, SELECT, ADJUST,
    output  SECCLR, MININC, HOURINC,
    output  SECON, MINON, HOURON
);

/* �X�e�[�g�}�V���֘A */
reg [1:0] cur, nxt;
parameter NORM=2'b00, SEC=2'b01, MIN=2'b10, HOUR=2'b11;

/* �����C���M�� */
assign SECCLR  = (cur==SEC)  & ADJUST;
assign MININC  = (cur==MIN)  & ADJUST;
assign HOURINC = (cur==HOUR) & ADJUST;

/* �C�����_�ŐM�� */
assign SECON  = ~((cur==SEC)  & SIG2HZ);
assign MINON  = ~((cur==MIN)  & SIG2HZ);
assign HOURON = ~((cur==HOUR) & SIG2HZ);

/* �X�e�[�g���W�X�^ */
always @( posedge CLK ) begin
    if( RST )
        cur <= NORM;
    else
        cur <= nxt;
end

/* �X�e�[�g������H */
always @* begin
    case( cur )
        NORM:   if ( MODE )
                    nxt = SEC;
                else
                    nxt = NORM;
        SEC   : if ( MODE )
                    nxt = NORM;
                else if( SELECT )
                    nxt = HOUR;
                else
                    nxt = SEC;
        MIN   : if ( MODE )
                    nxt = NORM;
                else if( SELECT )
                    nxt = SEC;
                else
                    nxt = MIN;
        HOUR  : if ( MODE )
                    nxt = NORM;
                else if( SELECT )
                    nxt = MIN;
                else
                    nxt = HOUR;
        default:nxt = 2'bxx;
  endcase
end

endmodule
