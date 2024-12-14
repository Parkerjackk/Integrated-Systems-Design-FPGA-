`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2024 10:43:14
// Design Name: 
// Module Name: fsm
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

//enter & exit should be asserted for 1 clock signal when car enters & exits carpark
module fsm(input clk, rst, a, b, 
            output reg enter, exit);
           //set A - G states as 3 bit long parameters 
           parameter A = 3'b000, B = 3'b001, 
                     C = 3'b010, D = 3'b011,
                     E = 3'b100, F = 3'b101,
                     G = 3'b110;
           //create next state reg 3 bits long
           reg[2:0] nst;
           
           always @ (posedge clk or posedge rst) begin
           //if rst is high, set everything to default
                if (rst) begin
                nst <= A;
                enter <= 0;
                exit <= 0;                 
                end else begin
                //else, check what the nst is and dpeending on the inputs a & b, move to next state...
                case (nst)
                A: begin
                enter <= 0;
                exit <= 0; 
                    if (a == 0 && b == 0)begin
                        nst = A;
                    end
                    if (a == 1 && b == 0)begin                   
                        nst = B;
                    end
                    if (a == 0 && b == 1)begin                    
                        nst = C;
                    end
                end
                
                B: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 0 && b == 0)begin
                        nst = A;
                    end
                    if (a == 1 && b == 0)begin
                        nst = B;
                    end
                    if (a == 1 && b == 1)begin
                        nst = D;
                    end
                end
                
                C: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 1 && b == 1)begin
                        nst = E;
                    end
                    if (a == 0 && b == 1)begin
                       nst = C;
                    end
                    if (a == 0 && b == 0)begin
                        nst = A;
                    end
                end
            
                D: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 1 && b == 1)begin
                        nst = D;
                    end
                    if (a == 0 && b == 1)begin
                        nst = F; 
                    end
                    if (a == 1 && b == 0)begin
                        nst = B;
                    end                            
                end
                
                E: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 1 && b == 1)begin
                        nst = E;
                    end
                    if (a == 0 && b == 1)begin
                        nst = C; 
                    end
                    if (a == 1 && b == 0)begin
                        nst = G;
                    end                            
                end
    
                F: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 1 && b == 1)begin
                        nst = D;
                    end
                    if (a == 0 && b == 1)begin
                        nst = F; 
                    end
                    //if this state is reached and the nst state is going to be A, enter is set to high. Car has passed through both sensors
                    if (a == 0 && b == 0)begin
                        nst = A;
                        enter <= 1;
                    end                            
                end

                G: begin
                enter <= 0;
                exit <= 0;                 
                    if (a == 1 && b == 1)begin
                        nst = E;
                    end
                    //if this state is reached and the nst state is going to be A, exit is set to high. Car has passed through both sensors                    
                    if (a == 0 && b == 0)begin
                        nst = A; 
                        exit <= 1;
                    end
                    if (a == 1 && b == 0)begin
                        nst = G;
                    end                            
                end                
                default: begin
                //set all values to default
                    nst = A; enter = 0; exit = 0; 
                end
                endcase
           end
           end        
endmodule
