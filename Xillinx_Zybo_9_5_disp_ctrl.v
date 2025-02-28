/* Copyright(C) 2020 Cobac.Net All Rights Reserved. */
/* chapter: 第9章課題       */
/* project: display_xga     */
/* outline: AXI読み出し制御 */

module disp_ctrl
  (
    input           ACLK,
    input           ARST,
    output  [31:0]  ARADDR,
    output          ARVALID,
    input           ARREADY,
    input           RLAST,
    input           RVALID,
    output          RREADY,
    input           AXISTART,
    input           DISPON,
    input   [29:0]  DISPADDR,
    input           FIFOREADY
);

reg [29:0]  addrcnt;
wire        dispend;

/* ステートマシン（宣言部） */
localparam HALT = 2'b00, SETADDR = 2'b01,
           READING = 2'b10, WAITING = 2'b11;
reg [1:0]   cur, nxt;

// Read Address (AR)
assign ARADDR[31:30] = 2'b00;  /* 0x00000000〜0x3FFFFFFFに限定 */
assign ARADDR[29:0]  = addrcnt + DISPADDR;
assign ARVALID = (cur == SETADDR);

// Read and Read Response (R)
assign RREADY = RVALID;

/* VRAM読み出し開始（AXISTARTをACLKで同期化し立ち上がりを検出） */
reg [2:0]   axistart_ff;

always @( posedge ACLK ) begin
    if ( ARST )
        axistart_ff <= 3'b000;
    else begin
        axistart_ff[0] <= AXISTART;
        axistart_ff[1] <= axistart_ff[0];
        axistart_ff[2] <= axistart_ff[1];
    end
end

wire dispstart = DISPON & (axistart_ff[2:1] == 2'b01);

/* アドレスカウンタ */
always @( posedge ACLK ) begin
    if ( ARST )
        addrcnt <= 30'b0;
    else if ( cur==HALT && dispstart )
        addrcnt <= 30'b0;
    else if ( ARVALID & ARREADY )
        addrcnt <= addrcnt + 30'h80;
end

/* 表示終了 */
localparam integer VGA_MAX = 30'd1024 * 30'd768 * 30'd4;
assign dispend = (addrcnt == VGA_MAX);

/* 読み出しステートマシン */
always @( posedge ACLK ) begin
    if ( ARST )
        cur <= HALT;
    else
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:       if ( dispstart )
                        nxt = SETADDR;
                    else
                        nxt = HALT;
        SETADDR:    if ( ARREADY )
                        nxt = READING;
                    else
                        nxt = SETADDR;
        READING:    if ( RLAST & RVALID & RREADY ) begin
                        if ( dispend )
                            nxt = HALT;
                        else if ( !FIFOREADY )
                            nxt = WAITING;
                        else
                            nxt = SETADDR;
                    end
                    else
                        nxt = READING;
        WAITING:    if ( FIFOREADY )
                        nxt = SETADDR;
                    else
                        nxt = WAITING;
        default:    nxt = HALT;
    endcase
end

endmodule
