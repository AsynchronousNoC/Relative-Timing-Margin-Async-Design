`timescale 1ps/1ps

module BUFFER ( 
    output Z,
    input  A
);
    buf #(12, 12) buf0 (Z, A);
endmodule