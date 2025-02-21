/* �v�b�V���{�^���̃`���^�����O����                 */
/* Copyright(C) 2013 Cobac.Net All Rights Reserved. */

module BTN_IN (
    input   CLK, RST,
    input       [2:0]   BIN,
    output reg  [2:0]   BOUT
);

/* 50MHz��1250000��������40Hz�����              */
/* en40hz�̓V�X�e���N���b�N1�������̃p���X��40Hz */
reg [20:0] cnt;

wire en40hz = (cnt==1250000-1);

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 21'b0;
    else if ( en40hz )
        cnt <= 21'b0;
    else
        cnt <= cnt + 21'b1;
end


/*  �{�^�����͂�FF2�Ŏ󂯂�*/
reg [2:0] ff1, ff2;

always @( posedge CLK ) begin
    if ( RST ) begin
        ff2 <=3'b0;
        ff1 <=3'b0;
    end
    else if ( en40hz ) begin
        ff2 <= ff1;
        ff1 <= BIN;
    end
end

/* �{�^���͉�����1�Ȃ̂ŁA���オ������o */
wire [2:0] temp = ff1 & ~ff2 & {3{en40hz}};


/* �O�̂���FF�Ŏ󂯂� */
always @( posedge CLK ) begin
    if ( RST )
        BOUT <=3'b0;
    else
        BOUT <=temp;
end

endmodule
