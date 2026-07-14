module UART1_TX(

// operational inputs
input clk,
input start,

// data inputs
input [7:0] txin,
//input parity,

// module outputs 
output reg tx,
output reg txdone

);

// for TX logic
reg [9:0] txdata;
integer tindex;

// States for FSM
parameter idle = 0;
parameter send = 1;
parameter check = 2;
reg [1:0]state = idle;

// Baud Generation logic begins

parameter clk_freq = 100_000;
parameter baud = 9600;
parameter waitcount = clk_freq/baud;

reg bitdone = 0;
integer count = 0;

always @(posedge clk)begin
    if (state == idle)
        begin
        count <= 0;
        end
    else 
        begin
            if(count == waitcount-1)
            begin
                count <= 0;
                bitdone <= 1;
            end
            else
            begin
                count <= count + 1;
                bitdone <= 0;
            end
        end    
end

// Transmission TX logic begins

always @(posedge clk) begin 
    case(state)
    
        //IDLE
        idle:
        begin

            tx <= 1'b1;
            txdata <= 0;
            tindex <= 0;
            txdone <= 0;
            
            if (start) 
            begin
                txdata <= {1'b1,txin, 1'b0};
                state <= send;
            end
            else 
            begin
                state <= idle;
            end
        end
        
        //SEND
        send:
        begin
            tx <= txdata[tindex];
            state <= check;
        end
        
        //CHECK
        check:
        begin
            if (tindex < 9) 
            begin
                if (bitdone == 1) 
                begin
                     state <= send;
                     tindex <= tindex + 1;
                end
            end
            else
            begin
                state <= idle;
                txdone <= 1;
                tindex <= 0;
            end
        end
        default:state <= idle;
            
    endcase   
end



endmodule
