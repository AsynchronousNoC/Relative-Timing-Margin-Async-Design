`timescale 1ps/1ps
`include "system_defines"

module VE_block 
( 
	input CLK,
	input NRESET,
	input ENABLE_L1,
	input PRIME_L2,

	input SI,
	input SE,
	input  SO_RET,
	output SO_EXT,
	output SO,
	
	output CLK_TIEHI,
	output NRESET_TIEHI,
	output ENABLE_L1_TIEHI,
	output PRIME_L2_TIEHI,
	output SI_TIEHI,
	output SE_TIEHI,
	output SO_TIEHI,
	output SO_TIELOW


);
localparam NUM_EXPS = `NUM_EXPS ;
//synthesis  asynchro_reset NRESET

logic [NUM_EXPS-1:0] s_in;
logic [NUM_EXPS-1:0] s_out;
logic [NUM_EXPS-1:0] exp_s_out;
logic [NUM_EXPS-1:0] enable_exp;

logic [NUM_EXPS-1:0] active_exps;
logic [NUM_EXPS-1:0] active_enable_l1s;
logic [NUM_EXPS-1:0] active_prime_l2s;
logic [NUM_EXPS-1:0] active_ses;

logic enable_l1 , prime_l2;
logic nnormal_op;
logic muxed_exp_so;
logic se_delayed, auto_prime;
logic active_block;
assign CLK_TIEHI =1'b1;
assign SE_TIEHI =1'b1;
assign SI_TIEHI =1'b1;
assign ENABLE_L1_TIEHI =1'b1;
assign PRIME_L2_TIEHI =1'b1;
assign NRESET_TIEHI =1'b1;
assign SO_TIELOW =1'b0;
assign SO_TIEHI  =1'b1;
// scan into the pipelines when SE is high and PRIME_L2 is low
assign scan_pipelines = SE && !PRIME_L2  ;


// load the enable_exp if needed 
assign load_selects   = SE &&  PRIME_L2;
always @(posedge CLK or negedge NRESET) begin
	if(NRESET==0) begin
		{nnormal_op,enable_exp}<=0;
		se_delayed <=0;
	end else begin
		se_delayed<=SE;
		if ( load_selects )
			{nnormal_op,enable_exp} <= {SI, nnormal_op,enable_exp[NUM_EXPS-1:1]};
	end
end 
assign auto_prime = se_delayed && ! SE;

//we use that register so we can isolate an experiment if we want
assign active_exps 		  =  {NUM_EXPS{!nnormal_op}}    |   enable_exp;
assign active_enable_l1s  = {NUM_EXPS{enable_l1}}  	  &   active_exps;
assign active_prime_l2s   = {NUM_EXPS{auto_prime}}  	  &   active_exps;
assign active_ses		  = {NUM_EXPS{scan_pipelines}}  &   active_exps;

// In normal_op each experiment streams through the exps
// if we are not in normal then SI is presented  to all exps   
assign s_in[NUM_EXPS-1:0] = (nnormal_op==0) ? { SI, s_out[NUM_EXPS-1:1] } : {NUM_EXPS{SI}};

//SO_EXT is the output od the scna chain for this block -it can be looped back to SO_RET to use as a standalone block
//or be passed to SO in of another block 
//if we are setting up single test then passs the enable chain out!
assign SO_EXT = (load_selects  ? enable_exp[0] : ((!nnormal_op) ? s_out[0] : SI )) ;


//SO from normaly SO_RET  but for in single mode it comes from  muxed_exp_so
assign SO = !nnormal_op ? SO_RET : muxed_exp_so;

//only allow enable_l1 and enable_l2 when we are done configuring
assign enable_l1 = (ENABLE_L1 && !SE);
assign prime_l2  = (PRIME_L2  && !SE);

//enable_exp is one hot and will select one output from the experiments
// This block is has an active single exp
assign active_block = |enable_exp;

//this should block any outputs that arent enabled enable_expshould have max 1 bit set
assign exp_s_out =  s_out & enable_exp;

// if the block is active use the use the output of the exp else take from downstream
assign muxed_exp_so = active_block ? |exp_s_out : SO_RET;

		pipeline u_pipeline[NUM_EXPS-1 :0]
		(
			.NRESET(NRESET),
			.ENABLE_L1(active_enable_l1s),
			.PRIME_L2(active_prime_l2s),
			.CLK(CLK),
			.SI(s_in),
			.SO(s_out),
			.SE(active_ses)

		);
endmodule