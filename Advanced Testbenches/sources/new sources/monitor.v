`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 18:21:38
// Design Name: 
// Module Name: monitor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module monitor(input wire clk, rst, inc_exp, dec_exp, input wire [3:0] car_count);
    
    reg [3:0] count;
    reg [39:0] msg;
    integer file;
    
    initial begin
        $display("time   / inc_exp / dec_exp / count / car_count / msg\n");
        file = $fopen("logs.txt", "w");
        $fwrite(file, "time   / inc_exp / dec_exp / count / car_count / msg\n");
        end
        always @(posedge clk)
        begin
        #4;    
        if(rst)
            count <= 0;
        else if( inc_exp != 0 && count != 15)begin
            count <= count + 1; 
        end
        else if (dec_exp != 0 && count != 0)begin
            count <= count - 1;
        end
        
        if(count == car_count)
            msg = " PASS ";
        else 
            msg = " FAIL ";
        
            
        $display("%5d,    %b        %b         %b         %b        %s\n",
                $time, inc_exp, dec_exp, count, car_count, msg);
        $fwrite(file, "%5d,    %b        %b         %b         %b        %s\n", $time, inc_exp, dec_exp, count, car_count, msg);
   end
endmodule
