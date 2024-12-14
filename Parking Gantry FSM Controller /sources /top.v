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


module top(input clk, input [2:0] btn, output [3:0] led);
    
    wire enter;
    wire exit;
    wire a, b, rst;
    wire [3:0] count;
    wire [2:0] button_db;
    //debounce buttons 0-2
    debouncer(.clk(clk), .reset(rst), .button(btn[0]) , .button_db(button_db[0]));
    debouncer(.clk(clk), .reset(rst), .button(btn[1]) , .button_db(button_db[1]));
    debouncer(.clk(clk), .reset(rst), .button(btn[2]) , .button_db(button_db[2]));
    
    //assign wires to debounce button
    assign a = button_db[0];
    assign b = button_db[1];
    assign rst = button_db[2];    
    
    //call fsm & counter modules
    fsm fsm(.clk(clk), .rst(rst), .a(a), .b(b), .enter(enter), .exit(exit));
    counter counter (.clk(clk), .rst(rst), .enter(enter), .exit(exit), .car_count(count));
    
    //assign leds to count value
    assign led = count;   
    
    //assign enter & exit values to enter & exit signals    
    assign enter_signal = enter;
    assign exit_signal = exit;
endmodule
