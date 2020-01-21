`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2016 10:27:24 PM
// Design Name: 
// Module Name: Motor
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


module Motor(
    input logic clk, enable,
    input direction,
    input logic [1:0] speed,
    output logic A, B, Ab, Bb,
    output logic a, b, c, d, e, f, g, dp,
    output [3:0] an
    ); 
    
    typedef enum logic [3:0] {S0, S1, S2, S3} State;
    State [1:0] currentState, nextState;
    
    reg direction;
    // clock divider
    logic clk_en;
    logic [20:0] divider;
    logic [20:0] count = 21'd0;
    always@(posedge clk) begin
            case(speed)
                2'b00: divider = 21'd800000;
                2'b01: divider = 21'd600000;
                2'b10: divider = 21'd400000;
                2'b11: divider = 21'd200000;
            endcase
            count <= count + 1;
            if (count == divider) 
            begin
                count <= 21'd0;
                clk_en <= 1;
            end
            else
                clk_en <= 0;
    end    
    
    // state register
    always_ff@(posedge clk_en)
        if(~enable) begin
            currentState <= S0;
            divider <= 3'b000;
        end
        else
            currentState <= nextState;
    
    always_comb
    if(direction)  //direction 1 then move through   
       begin     
    // next state logic  
    if(currentState == S0)
        nextState = S1;
     else if(currentState == S1)
        nextState = S2;
     else if(currentState == S2)       
        nextState = S3;
     else if(currentState == S3)       
        nextState = S0;  
    end
    else //direction 0 then move back  
        begin     
        // next state logic   
         if(currentState == S0)
               nextState = S3;
            else if(currentState == S1)
               nextState = S0;
            else if(currentState == S2)       
               nextState = S1;
            else if(currentState == S3)       
               nextState = S2;  
        end
       //Speed Variables
         logic [3:0] sV0, sV1, sV2, sV3;     
         assign {sV3, sV2, sV1, sV0} = speed;     
              SevSeg_4digit sevenSegCall(clk, sV0, sV1, sV2, sV3, a, b, c, d, e, f, g, dp, an);   
       
    // Output 
    always_comb
    if(currentState == S0)
    begin 
    A = 1; 
    B = 1;
    Ab = ~A; 
    Bb = ~B; 
    end
    else if(currentState == S1)            
    begin 
    A = 0; 
    B = 1; 
    Ab = ~A; 
    Bb = ~B; 
    end
     else if(currentState == S2)          
      begin A = 0;
      B = 0; 
      Ab = ~A; 
      Bb = ~B; 
      end
      else if(currentState == S3)
      begin 
      A = 1; 
      B = 0; 
      Ab = ~A; 
      Bb = ~B;
      end 
       /* case(currentState)
            S0: begin A = 1; B = 1; Ab = ~A; Bb = ~B; end
            S1: begin A = 0; B = 1; Ab = ~A; Bb = ~B; end
            S2: begin A = 0; B = 0; Ab = ~A; Bb = ~B; end
            S3: begin A = 1; B = 0; Ab = ~A; Bb = ~B; end
        endcase*/

endmodule