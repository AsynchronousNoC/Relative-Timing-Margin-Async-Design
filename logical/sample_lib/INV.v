`timescale 1ps/1ps
module INV ( 
    output Z,
    input A
);
    not #(12, 12) not0 (Z, A);
endmodule