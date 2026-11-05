`timescale 1ps/1ps
module MUX4 ( 
    output reg Z,
    input  D0,
    input  D1,
    input  D2,
    input  D3,
    input  S0,
    input  S1
);
    always @(*) begin
        case ({S1,S0})
            2'b00 : Z=D0;
            2'b01 : Z=D1;
            2'b10 : Z=D2;
            2'b11 : Z=D3;
        endcase
    end
endmodule