`timescale 1ns / 1ps

module UART1_RX_TB;

reg clk;
reg rx;

wire [7:0] rxout;
wire rxdone;

// Instantiation
UART1_RX DUT(
    .clk(clk),
    .rx(rx),
    .rxout(rxout),
    .rxdone(rxdone)
);

// Clock = 10 ns period
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rx  = 1;          
    
    #100;

    
    // Binary = 01010100
    // UART sends LSB first
    // Frame:
    // Start : 0
    // D0    : 0
    // D1    : 0
    // D2    : 1
    // D3    : 0
    // D4    : 1
    // D5    : 0
    // D6    : 1
    // D7    : 0
    // Stop  : 1
    
    rx = 0;    #100;   // Start
    rx = 0;    #100;   // D0
    rx = 0;    #100;   // D1
    rx = 1;    #100;   // D2
    rx = 0;    #100;   // D3
    rx = 1;    #100;   // D4
    rx = 0;    #100;   // D5
    rx = 1;    #100;   // D6
    rx = 0;    #100;   // D7
    rx = 1;    #100;   // Stop
    
    // Idling 
    rx = 1;

    #500;

    $finish;
end

endmodule