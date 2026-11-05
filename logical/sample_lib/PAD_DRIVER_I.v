`timescale 1ps/1ps

module PAD_DRIVER_I (
    input NDIN,
    input PAD,
    inout PWROK,
    output Y,
    input RXEN,
    inout IOPWROK,
    output NDOUT,
    inout RETC,
    inout BIAS,
    input SMT
);
    
    assign Y = RXEN  ? (((PAD===1'bZ)||(PAD===1'bx)) ? 1'bx : PAD ) : 1'bz;
    initial begin
        #1;
        if(((SMT===1'bz)||(SMT===1'bx )))
            $display("%m Schmitt trigger enable is not driven / unknown");
        if(!((NDIN===1'bz)||(NDIN===1'bx )))
            $display("%m NDIN unknown");
        end
endmodule