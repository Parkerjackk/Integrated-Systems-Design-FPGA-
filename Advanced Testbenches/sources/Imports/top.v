`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 10:52:52
// Design Name: 
// Module Name: top
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

//creating a top module with no inputs (as can be seen in diagram)
module top( );
//declare all necesary variables seen in lab handout figure 2.
    wire clk, rst, a, b;   
    wire inc_exp, dec_exp;
    wire [3:0]car_count;

//call DUT (contains FSM & Counter)
    DUT dut(.clk(clk), .rst(rst), .a(a), .b(b), .car_count(car_count));
//call test stimulus generator created
    testGen #(.T(20)) test(.clk(clk), .rst(rst), .a(a), .b(b), .inc_exp(inc_exp), .dec_exp(dec_exp));
//call monitor module created
    monitor mon(.clk(clk), .rst(rst), .inc_exp(inc_exp), .dec_exp(dec_exp), .car_count(car_count));

//all variables passed to the different modules are those visible in figure 2 in the lab handout        
endmodule
