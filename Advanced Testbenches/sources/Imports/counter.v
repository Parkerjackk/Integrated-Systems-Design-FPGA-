`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2024 12:16:26
// Design Name: 
// Module Name: counter
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


module counter(input clk, rst, enter, exit, output reg[3:0] car_count);

//initilise car_count to 0
initial begin
    car_count = 0;
    end

always @(posedge clk or posedge rst)begin
    //if rst is high, set count to 0
    if (rst) begin
        car_count <= 4'b0000;
    //otherwise: 
    end else begin
            //if enter is high && car count is < 16 (max capacity == 15), increase count
            if (enter && car_count < 16)begin
            car_count <= car_count+1;
            end
            //else if exit is high && car count is > 0, decrease count
            else if(exit && car_count > 0)begin
            car_count <= car_count-1;
            end
        end
    end

endmodule
