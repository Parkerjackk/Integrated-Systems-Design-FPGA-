`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 16:29:17
// Design Name: 
// Module Name: testGen
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


module testGen #(parameter T = 20)
                (
                output reg clk, rst, a, b,
                inc_exp, dec_exp
                );
initial
begin
    clk = 1'b0; // Start clock at 0
    forever
    begin
        #2 clk = ~clk; // Toggle clock every 2ns
    end
end
    //test procedure
    initial
    begin
        rst = 1'b0;
        //initialize variables
        initialize();
        //pass test
        signal (5, 1, 0);
        @(negedge clk);
        signal (4, 0, 1);
        @(negedge clk);
        signal (5, 1, 0);
        @(negedge clk);
        //this case will trigger an error as there are already 6 cars in the car park, and there is a limit of 15 while we are trying to insert 15 more (6 over the limit)
        signal (15, 1, 0);
        //adding extra delays to allow for the last signal to be displayed correctly.
        #(T*3);      
        initialize();

        
        $stop;
    end
    
    task initialize();
    // system initialization
    begin
        reset();
        a = 1'b0; b = 1'b0; inc_exp = 0; dec_exp = 0; 
    end
    endtask
    
    task reset();
    begin 
    @(negedge clk);
        rst = 1'b1;
        #T;
        rst = 1'b0;
    end
    endtask

    task enter_exit(input integer enter, input integer exit);
    //setting enter or exit signals
    begin
        @(posedge clk);
            if (enter == 1)begin
                a = 1'b0; b = 1'b0;
                //#(T/4);
                @(posedge clk);
                a = 1'b1; b = 1'b0;                
                //#(T/4);
                @(posedge clk);
                a = 1'b1; b = 1'b1;             
                //#(T/4);
                @(posedge clk);
                a = 1'b0; b = 1'b1;             
                //#(T/4);
                @(posedge clk);
                a = 1'b0; b = 1'b0;
                inc_exp = 1;
                dec_exp = 0;
                @(posedge clk);
                inc_exp = 0;
            end
            if (exit == 1)begin
                a = 1'b0; b = 1'b0;
                // #(T/4);
                @(posedge clk);
                a = 1'b0; b = 1'b1;
                @(posedge clk);              
                //#(T/4);
                a = 1'b1; b = 1'b1;             
                //#(T/4);
                @(posedge clk);
                a = 1'b1; b = 1'b0;             
                //#(T/4);
                @(posedge clk);
                a = 1'b0; b = 1'b0;
                @(posedge clk);
                inc_exp = 0;
                dec_exp = 1;
                @(posedge clk);
                dec_exp = 0;
            end            
    end
endtask

    task signal(input integer C, input integer enter, input integer exit);
    // signal setting task
    begin: ts
        integer k;
        k = 0;
        @(negedge clk);
        while (k < C) begin
            repeat(10) @(negedge clk);
            enter_exit(enter, exit);
            k = k + 1;
        end
    end
    endtask
        
endmodule
