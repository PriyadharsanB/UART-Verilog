`timescale 1ns / 1ps

module UART1_TOP_TB;

reg clk;
reg start;
reg [7:0] txin;

wire tx;
wire [7:0] rxout;
wire txdone;
wire rxdone;

UART1_TOP DUT(

    .clk(clk),
    .start(start),
    .txin(txin),
    .tx(tx),
    .rxout(rxout),
    .txdone(txdone),
    .rxdone(rxdone)

);

// Clock
always #5 clk = ~clk;

initial
begin

    clk = 0;
    start = 0;
    txin = 8'h00;

    #50;

    
    // Send first sample
    

    txin = 8'h54;
    start = 1;

    #10;
    start = 0;

    
    #1500;
    
    // Send second sample

    txin = 8'hA5;
    start = 1;

    #10;
    start = 0;

    #1500;

   
    // Send third sample
    
    txin = 8'h3C;
    start = 1;

    #10;
    start = 0;

    #1500;

    $finish;

end

endmodule