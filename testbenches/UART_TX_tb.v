`timescale 1ns / 1ps

module UART1_TX_TB;

    
    reg clk;
    reg start;
    reg [7:0] txin;

    
    wire tx;
    wire txdone;

    // Instantiation
    UART1_TX DUT(
        .clk(clk),
        .start(start),
        .txin(txin),
        .tx(tx),
        .txdone(txdone)
    );

    // Clock Generation (100 MHz)
    always #5 clk = ~clk;

    // Test Stimulus
    initial
    begin

        // starting the process
        clk = 0;
        start = 0;
        txin = 8'h00;
        
        #20;

        // data
        txin = 10'b101010100;
        start = 1;

        // Keep start high for one clock cycle
        #10;
        start = 0;

        // Wait for transmission to complete
        wait(txdone);
        
        #10000000;
       

    end

endmodule