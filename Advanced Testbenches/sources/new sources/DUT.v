`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2024 10:54:27
// Design Name: 
// Module Name: DUT
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


module DUT(input clk, rst, a, b, output reg[3:0] car_count);

    wire enter;
    wire exit;
    wire [3:0]car_count;
    //call fsm & counter modules
    fsm fsm(.clk(clk), .rst(rst), .a(a), .b(b), .enter(enter), .exit(exit));
    counter counter (.clk(clk), .rst(rst), .enter(enter), .exit(exit), .car_count(car_count));    


endmodule
