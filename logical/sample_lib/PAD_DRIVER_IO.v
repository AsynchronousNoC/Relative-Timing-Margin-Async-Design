`timescale 1ps/1ps

module PAD_DRIVER_IO (
  input TRIEN,
  input NDIN,
  input  [1:0] DRV,
  inout PAD,
  inout PWROK,
  output Y,
  input RXEN,
  input PDEN,
  input DATA,
  inout IOPWROK,
  output NDOUT,
  input PUEN,
  inout RETC,
  inout BIAS,
  input SMT,
  input SLW
);

    assign PAD = TRIEN ? (PUEN ? (PDEN ? PAD : 1'b1) : ( PDEN ? 1'b0 : 1'bz)) : DATA;
    assign Y = !TRIEN  ? (((PAD===1'bZ)||(PAD===1'bx)) ? 1'bx : PAD ) : 1'bx;
    initial begin
        
        if(((SMT===1'bz)||(SMT===1'bx)))
            $display("%m Schmitt trigger enable (SMT) is not driven / unknown");
        if(((SLW===1'bz)||(SLW===1'bx)))
            $display("%m Slew control (SLW) is not driven / unknown");
        if(((TRIEN===1'bz)||(TRIEN===1'bx )))
            $display("%m Tristate enable (TRIEN) is not driven / unknown");              
        if(((PUEN===1'bz)||(PUEN===1'bx )))
            $display("%m Pullup enable (PUEN) is not driven / unknown");
        if(((PDEN===1'bz)||(PDEN===1'bx)))
            $display("%m Pulldown enable (PDEN) is not driven / unknown");
        if((($countbits(DRV, 'z))||($countbits(DRV, 'x))))
            $display("%m drive strength input (DRV) is not driven / unknown");
    end
endmodule