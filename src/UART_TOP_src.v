`timescale 1ns / 1ps

module UART1_TOP(

    input clk,
    input start,
    input [7:0] txin,

    output tx,
    output [7:0] rxout,
    output txdone,
    output rxdone

);

UART1_TX TX(

    .clk(clk),
    .start(start),
    .txin(txin),
    .tx(tx),
    .txdone(txdone)

);

UART1_RX RX(

    .clk(clk),
    .rx(tx),          // connecting the transmission bridges tx and rx together
    .rxout(rxout),
    .rxdone(rxdone)

);

endmodule
