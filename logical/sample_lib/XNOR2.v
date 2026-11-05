`timescale 1ps/1ps
module XNOR2 ( 
    output Z,
    input  A,
    input  B
);
    assign #(12) Z =  !(A^B);

endmodule