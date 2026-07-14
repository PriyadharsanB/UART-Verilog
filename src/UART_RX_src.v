module UART1_RX(
    input clk,
    input rx,

    output [7:0] rxout,
    output reg rxdone

);

parameter idle = 0;
parameter rec = 1;
parameter check = 2;

reg[1:0] state = idle;
integer rindex;
reg [9:0] rxdata=0;

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
        bitdone <= 0;
        rxdone <= 0;
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


integer rcount;

always @(posedge clk)begin
    case(state)
        idle:begin 
                rindex<=0;
                rcount<=0;

                if(rx==1'b0)begin
                    state<=rec;
                end
                else begin
                    state<=idle;
                end

        end
        

        rec:begin 
            if(rcount==waitcount/2-1)begin 
                rxdata<={rx,rxdata[9:1]};
                state<=check;
                rcount<=0;
            end
            else begin
                rcount<=rcount+1;
                state<=rec;
            end
        end

        check:begin 
            
            if(rindex < 9)begin
                if(bitdone)begin
                    rindex<=rindex+1;
                    state<=rec;
                end    
            end
            else begin
                state<=idle;
                rxdone <= 1;
                rindex<=0;
            end    

        end

        default:state<=idle;
    endcase

end    

assign rxout = rxdata[8:1];

endmodule
