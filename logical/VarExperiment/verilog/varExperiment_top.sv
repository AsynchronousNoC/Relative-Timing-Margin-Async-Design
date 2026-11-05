`define USE_IO_DRIVERS
`define IP_DRIVER PAD_DRIVER_I
`define IO_DRIVER PAD_DRIVER_IO
`ifdef USE_PWR
	`define POWER_PINS .VDDC(VDDC),.VSSC(VSSC),.VDDIO(VDDIO),.VSSIO(VSSIO),
`else	
	`define POWER_PINS
`endif
module varExperiment_top 
( 
	input CLK_PAD,
	input NRESET_PAD,
	input ENABLE_L1_PAD,
	input PRIME_L2_PAD,

	input SI_PAD,
	input SE_PAD,
	output SO_PAD,

	//Pad signals / supplies from rings
	`ifdef USE_PWR
		input VDDC,
		input VSSC,
		input VDDIO,
		input VSSIO,
	`endif
	input PWROK, 
	input IOPWROK,
	input BIAS,
	input RETC
	);

wire dut0_exp_end;
wire dut1_so_ext;
wire dut0_scan_out;

wire nreset;
wire prime_l2;
wire enable_l1;
wire se;
wire si;
wire so;
wire clk;

wire clk_tiehi;
wire se_tiehi;
wire si_tiehi;
wire enable_l1_tiehi;
wire prime_l2_tiehi;
wire so_tiehi, so_tielow;

	`IP_DRIVER u_ipin_clk ( 
		`POWER_PINS 
		.NDOUT(), .Y(clk),    .IOPWROK(IOPWROK), .PAD(CLK_PAD),    .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC), 		   
		.NDIN(clk_tiehi),  .RXEN(clk_tiehi), .SMT(clk_tiehi )
	 );
	`IP_DRIVER u_ipin_nreset ( 
		`POWER_PINS 
		.NDOUT(), .Y(nreset), .IOPWROK(IOPWROK), .PAD(NRESET_PAD), .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC),
		.NDIN(nreset_tiehi),  .RXEN(nreset_tiehi), .SMT(nreset_tiehi)
	);
	`IP_DRIVER u_ipin_se (
		`POWER_PINS 
		.NDOUT(), .Y(se), .IOPWROK(IOPWROK), .PAD(SE_PAD), .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC),             		   
		.NDIN(se_tiehi),      .RXEN(se_tiehi), 	  .SMT(se_tiehi)
	);
	`IP_DRIVER u_ipin_si (
		`POWER_PINS 
		.NDOUT(), .Y(si), .IOPWROK(IOPWROK), .PAD(SI_PAD), .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC),
	 	.NDIN(si_tiehi),      .RXEN(si_tiehi),     .SMT(si_tiehi)
	);
	`IP_DRIVER u_ipin_prime_l2  ( 
		`POWER_PINS
		.NDOUT(), .Y(prime_l2),  .IOPWROK(IOPWROK), .PAD(PRIME_L2_PAD),  .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC),  
		.NDIN(prime_l2_tiehi),  .RXEN(prime_l2_tiehi), .SMT(prime_l2_tiehi)
	);
	`IP_DRIVER u_ipin_enable_l1 (
		`POWER_PINS 
		.NDOUT(), .Y(enable_l1), .IOPWROK(IOPWROK), .PAD(ENABLE_L1_PAD), .BIAS(BIAS), .PWROK(PWROK), .RETC(RETC),
		.NDIN(enable_l1_tiehi),  .RXEN(enable_l1_tiehi), .SMT(enable_l1_tiehi)
	);
	
	`IO_DRIVER u_opin_so  (
		`POWER_PINS 
		.NDOUT(), .Y(), .IOPWROK(IOPWROK), .PAD(SO_PAD), .PWROK(PWROK),  .RETC(RETC), .BIAS(BIAS),  .DATA(so), .DRV(), 	
		.NDIN(so_tielow), .PDEN(so_tielow), .PUEN(so_tielow), .RXEN(so_tielow), .TRIEN(so_tielow), .SMT(so_tielow), .SLW(so_tiehi)
	 );

	VE_block  dut1 ( 
		`ifdef USE_PWR
			.VDD(VDDC),
			.VSS(VSSC),
		`endif
		.CLK(clk),
		.NRESET(nreset),

		.ENABLE_L1(enable_l1),
		.PRIME_L2(prime_l2),
		
		.SE(se),
		.SI(si),
		.SO(so),

		.SO_EXT(dut1_so_ext ),
		.SO_RET(dut0_scan_out ),
		
		.CLK_TIEHI(clk_tiehi),
		.NRESET_TIEHI(nreset_tiehi),
		.SE_TIEHI(se_tiehi),
		.SI_TIEHI(si_tiehi),
		.ENABLE_L1_TIEHI(enable_l1_tiehi),
		.PRIME_L2_TIEHI(prime_l2_tiehi),

		.SO_TIEHI(so_tiehi),
		.SO_TIELOW(so_tielow)
	);

	VE_block  dut0 ( 
		`ifdef USE_PWR
			.VDD(VDDC),
			.VSS(VSSC),
		`endif
		.CLK(clk),
		.NRESET(nreset),
		.ENABLE_L1(enable_l1),
		.PRIME_L2(prime_l2),
		
		.SE(se),
		.SI(dut1_so_ext),
		.SO(dut0_scan_out),

		.SO_EXT(dut0_exp_end ),
		.SO_RET(dut0_exp_end ),

		.CLK_TIEHI(),
		.NRESET_TIEHI(),
		.SE_TIEHI(),
		.SI_TIEHI(),
		.ENABLE_L1_TIEHI(),
		.PRIME_L2_TIEHI(),
		.SO_TIEHI(),
		.SO_TIELOW()
	);
endmodule