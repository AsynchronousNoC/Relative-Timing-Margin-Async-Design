`timescale 1ps/1ps

`include "system_defines"
`define NUM_MACROS 2
typedef union packed {
	logic [`DATAPATH_WIDTH + `DELAY_CTRL_BITS : 0] data;
	struct packed {
		bit [`DELAY_CTRL_BITS-1:0] delay_ctr_bits;
		bit req;
		bit [`DATAPATH_WIDTH-1:0] data;
	} value;
} scan_block;

module varExperiment_top_tb ();
localparam EXP_SCAN_LENGTH = `DATAPATH_WIDTH + 1 +  `DELAY_CTRL_BITS;
localparam TOTAL_SCAN_LENGTH = `NUM_MACROS *`NUM_EXPS * EXP_SCAN_LENGTH;

logic clk,scan_en,scan_out, scan_in ,scan_ext;
logic nreset;
logic [10:0] read_count; 
logic [10:0] write_count;

logic enable_l1, prime_l2;
logic req_state;
logic rd_op;
scan_block exp_out;
logic dut0_so_ext;

int ip_test_num;
int ip_exp_num;
scan_block [(`NUM_MACROS * `NUM_EXPS)-1:0]   tests[0:4*(2**`DELAY_CTRL_BITS)-1];

int result_test_num=0;
int result_exp_num;
scan_block [(`NUM_MACROS * `NUM_EXPS)-1:0]  results[0:4*(2**`DELAY_CTRL_BITS)-1];
logic sample;
logic dut0_exp_end;
int single_mode;

varExperiment_top 
	DUT
( 
	`ifdef USE_PWR
		.VDDC(1'b1),
		.VDDIO(1'b1),
		.VSSC(1'b0),
		.VSSIO(1'b0),
	`endif
	.CLK_PAD(clk),
	.NRESET_PAD(nreset),
	.ENABLE_L1_PAD(enable_l1),
	.PRIME_L2_PAD(prime_l2),

	.SI_PAD(scan_in),
	.SE_PAD(scan_en),
	.SO_PAD(scan_out),

	.PWROK(1'b1), 
	.IOPWROK(1'b1),
	.RETC(1'b0),
	.BIAS(1'b0)

);


task flushScanChain();
		if(single_mode==-1) begin
			for(int i=0; i<(`NUM_MACROS * `NUM_EXPS) ; i++) begin
				setupTest(0, 0, (i==(`NUM_MACROS * `NUM_EXPS)));
			end
		end else begin
			setupTest(0, 0, 1);
		end
		runTest();
		scan_en=0;
		ip_test_num = ip_test_num -1; //the last test was just to flush the last test
endtask

task configSingle(int exp);
	static int bitnum=0;
	static  integer sent=0;
	@(posedge clk);
	scan_en=1;
	@(negedge clk);
	prime_l2 =1;
	//We are now in config mode
	scan_in=0;
	single_mode=exp;
	sent=0;
	bitnum=0;
	for(int j=0; j<`NUM_MACROS ;j++) begin
		for(int i=0; i<=`NUM_EXPS;i++) begin
			if( (i ==`NUM_EXPS) || (exp == bitnum) )
				scan_in=1;
			else 
				scan_in=0;
			@(posedge clk);
			if(i!=`NUM_EXPS)
				bitnum = bitnum+1;
			sent=sent+1;
		end
	end

	prime_l2 = 0;	
	@(negedge clk);
	scan_en=0;	
	$display("Configured in single mode: %d sent %d bits", single_mode, sent);
	sent=0;
endtask
task configMultiple(int exp);
	static int e=0;
	@(posedge clk);
	scan_en=1;
	@(negedge clk);
	prime_l2 =1;
	//We are now in config mode
	scan_in=0;
	for(int i=0; i<=(`NUM_MACROS * `NUM_EXPS);i++) begin
		scan_in=0;
		@(posedge clk);
	end

	prime_l2 = 0;	
	@(negedge clk);
	single_mode=-1;
	scan_en=0;	
	$display("Configured in full mode");
endtask
task setupTest(int data, int delay_select, logic last);
	scan_block in;
	in.value.data=data;
	in.value.delay_ctr_bits=delay_select;
	in.value.req=req_state;
	rd_op=(ip_test_num>0);
	scan_en=1;
	enable_l1=0;
	prime_l2=0;
	tests[ip_test_num][ip_exp_num] = in.data;

	for(int i=0; i<$size(in);i++) begin
		scan_in = in.data[0];
		if(last && (i==($size(in)-1)))
			rd_op=0;
		@(posedge(clk));
		in.data = in.data>>1;
	end
	if (single_mode == -1 ) begin
		if(ip_exp_num == ((`NUM_MACROS * `NUM_EXPS) - 1)) begin
			ip_test_num = ip_test_num +1;
			ip_exp_num=0;
		end else begin
			ip_exp_num=ip_exp_num+1;
		end
	end else begin
		ip_test_num = ip_test_num +1;
		ip_exp_num = single_mode;
	end

	if(last) begin
		req_state=!req_state;
		scan_en = 0;
	end
	
endtask

task runTest();
	for(int i=0 ; i< 50; i++)
		@(posedge clk);
	prime_l2=1;
	@(posedge clk);
	prime_l2=0;
	@(posedge clk);
	#5 enable_l1=1;
	@(posedge clk);
	#5 enable_l1=0;
	for(int i=0 ; i< 50; i++)
		@(posedge clk);
endtask

task analyzeResults();
	int pass;
	int fail;
	int test;
	int exp;
	scan_block stimulus;
	scan_block result;
	pass=0;
	fail=0;
	if(ip_test_num > result_test_num) begin
		flushScanChain();
	end


	$display("TESTS: ");
	$display("  Num tests: %0d ", ip_test_num);
	$display("  Number of experiments: %0d ", (single_mode==-1) ? (`NUM_MACROS * `NUM_EXPS) :0);

	//$display(" + mux delays");
	//$display ("  Datapath elements: %0d ", `DATAPATH_ELEMENTS);
	for(test=0; test<ip_test_num; test++) begin
		for(exp=0; exp<(`NUM_MACROS*`NUM_EXPS); exp++) begin


			stimulus.data = tests[test][exp].data;
			result.data = results[test][exp].data;
			if((stimulus.data != result.data) || (^stimulus.data === 1'bx)  || (^result.data === 1'bx) ) begin
					$display("  Test:%4d  Exp: :%3d  Req Delay: %2d elements  FAILED",
						test,
						exp,
						(stimulus.value.delay_ctr_bits)) ;
					if(stimulus.value.req != result.value.req)
						$display("    input req: %b result req: %b", stimulus.value.req, result.value.req);
					if(stimulus.value.data != result.value.data)
						$display("    input data: 0x%x result data: 0x%x", stimulus.value.data, result.value.data);
					if(stimulus.value.delay_ctr_bits != result.value.delay_ctr_bits)
						$display("    input delay_ctrl: %d result delay_ctrl: %d  THIS INDICATES ERROR IN READING SCAN CHAIN BACK", stimulus.value.delay_ctr_bits, result.value.delay_ctr_bits);
					fail=fail+1;
			end else begin
				$display("  Test:%4d  Exp: :%4d  Req Delay: %2d elements  PASSED",
					test,
					exp,
					(stimulus.value.delay_ctr_bits  )) ;
					$display("    input req: %b result req: %b", stimulus.value.req, result.value.req);
					$display("    input data: 0x%x result data: 0x%x", stimulus.value.data, result.value.data);
					$display("    input delay_ctrl: %d result delay_ctrl: %d  THIS INDICATES ERROR IN READING SCAN CHAIN BACK", stimulus.value.delay_ctr_bits, result.value.delay_ctr_bits);

				pass=pass+1;
			end
			@(posedge clk);
		end

	end
	if( (pass>0) && (fail==0)) 
		$display("OUTCOME: SUCCESS all tests passed");
	else 
		$display("OUTCOME: FAIL %0d experiments out of %0d failed",fail, fail+pass);
endtask

always @(posedge clk or negedge nreset) begin
	if(nreset==0) begin
		write_count<=0;
	end else begin
		if(scan_en ) begin 
			if(write_count < TOTAL_SCAN_LENGTH-1)
				write_count <= write_count  + 1;
		end else begin
			write_count <= 0;
		end
	end
end

always @(posedge clk or negedge nreset) begin
	if(nreset==0) begin
		read_count <= 0;
		scan_ext <= 0;
		exp_out <= 0;
		result_exp_num<=0;
		result_test_num<=0;
	end else begin
		if((ip_test_num>0) &&  (!prime_l2 && scan_en==1 )) begin
			
			if(write_count%EXP_SCAN_LENGTH == EXP_SCAN_LENGTH-1) begin
				results[ip_test_num-1][write_count/EXP_SCAN_LENGTH].data <= {scan_out, exp_out.data[EXP_SCAN_LENGTH-1:1]}; 	
				$display($time,"Test %d exp: %d  result: %x" ,ip_test_num,write_count/EXP_SCAN_LENGTH, exp_out.data[`DATAPATH_WIDTH:1]);
				exp_out.data <= 0;
			end else begin
				exp_out.data <= {scan_out, exp_out.data[EXP_SCAN_LENGTH-1:1]};
			end
			
		end 
	end
end
assign sample=rd_op && (read_count%EXP_SCAN_LENGTH == (EXP_SCAN_LENGTH -1));

always forever
	#1000 clk<=!clk;

initial begin
	clk=0;
	req_state=1;
	ip_exp_num=0;
	ip_test_num=0;
	single_mode=-1;
	nreset=0;
	scan_en=0;
	scan_in=0;
	enable_l1= 0 ;
	prime_l2=0;
	
	@(posedge clk);
	nreset=1;
	@(posedge clk);



	@(posedge clk);

   	for(int i=0; i<((`NUM_MACROS * `NUM_EXPS)) ; i++) begin		
		setupTest(-1, 3, (i==((`NUM_MACROS*`NUM_EXPS)-1)));
	end
	scan_en= 0;
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);

	@(posedge clk);

   	for(int i=0; i<((`NUM_MACROS * `NUM_EXPS)) ; i++) begin		
		setupTest(0, 2, (i==((`NUM_MACROS*`NUM_EXPS)-1)));
	end
	scan_en= 0;
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);

	@(posedge clk);

   	for(int i=0; i<((`NUM_MACROS * `NUM_EXPS)) ; i++) begin		
		setupTest(-1, 1, (i==((`NUM_MACROS*`NUM_EXPS)-1)));
	end
	scan_en= 0;
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);


	@(posedge clk);
  	for(int i=0; i<((`NUM_MACROS * `NUM_EXPS)) ; i++) begin		
		setupTest(0, 0, (i==((`NUM_MACROS*`NUM_EXPS)-1)));
	end
	scan_en= 0;
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);
	$display("flushing results");
	flushScanChain;

	$display("TESTING SINGLES");
	$display($time,"Config for single test 1 exp 9");
	@(posedge clk);
	nreset=0;
	req_state=1;
	@(posedge clk);
	nreset=1;

	configSingle(9); 
	@(posedge clk);
	req_state=1;
	setupTest(-1, 3, 1);
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);	
	$display("fGetting results");
	setupTest(0, 3, 1);




	$display($time,"Config for single test 2 exp 7");
	@(posedge clk);
	nreset=0;
	req_state=1;
	@(posedge clk);
	nreset=1;

	configSingle(7); 
	@(posedge clk);
	req_state=1;
	setupTest(-1, 3, 1);
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);	
	setupTest(0, 3, 1);


	@(posedge clk);
	@(posedge clk);


	
	$display($time,"Config for single test 2 exp 3");
	@(posedge clk);
	nreset=0;
	req_state=1;
	@(posedge clk);
	nreset=1;
	configSingle(3); 
	@(posedge clk);
	req_state=1;
	setupTest(-1, 0, 1);
	runTest();
	setupTest(0, 1, 1);
	runTest();
	setupTest(-1, 2, 1);
	runTest();
	setupTest(0, 3, 1);	
	runTest();
	setupTest(-1, 3, 1);	

/*

   	for(int i=0; i<((`NUM_MACROS * `NUM_EXPS)) ; i++) begin		
		setupTest(-1, i&3, (i==((2*`NUM_EXPS)-1)));
	end
	scan_en= 0;
	$display($time,"Test %d loaded",ip_test_num);
	runTest();
	$display($time,"Test %d executed",ip_test_num);



	for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest(0, 2, (i==(`NUM_EXPS-1)));
	end
	$display($time,"Test %d loaded",ip_test_num);

	scan_en= 0;
	runTest();

    //This should end up with the 10th exp operating
	configSingle(9);
	setupTest(-1, 1, 1);
	runTest();

		for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest(0, 0, (i==(`NUM_EXPS-1)));
	end
	runTest();
*/
/*
	for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest((`NUM_EXPS*ip_test_num)+1+i, 3, (i==(`NUM_EXPS-1)));
	end
	runTest();

	for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest((`NUM_EXPS*ip_test_num)+1+i, 2, (i==(`NUM_EXPS-1)));
	end
	runTest();

	for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest((`NUM_EXPS*ip_test_num)+1+i, 1, (i==(`NUM_EXPS-1)));
	end	
	runTest();

	for(int i=0; i<`NUM_EXPS ; i++) begin
		setupTest((`NUM_EXPS*ip_test_num)+1+i, 0, (i==(`NUM_EXPS-1)));
	end
	runTest();
*/
	
	$stop;
end



endmodule