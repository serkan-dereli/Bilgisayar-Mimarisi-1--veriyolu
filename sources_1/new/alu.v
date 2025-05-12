`timescale 1ns / 1ps

module alu(
    input [2:0] islem_in,
    input [7:0] s1_in, s2_in,
    output [7:0] s_out
    );
    
    reg [7:0] sx;
    
    assign s_out=sx;
    
    always @(*) begin
        case(islem_in)
            3'b000: sx=s1_in+s2_in;
            3'b001: sx=s1_in-s2_in;
            3'b010: sx=s2_in+1;
            3'b011: sx=s1_in*s1_in;
            3'b100: begin
                if(s1_in<=s2_in)
                    sx=8'h00;
                else
                    sx=8'h01;
            end
        endcase
    end
endmodule