`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_n; // asynchronous reset

   wire ack_clk1;
   wire ack_clk2;
   reg  req_clk1;
   reg  req_clk2;
   reg  select; // To be removed




    /* clock_sel AUTO_TEMPLATE(
     ); */
   clock_selector U_CLOCK_SELECTOR (
                           /*AUTOINST*/
                                    // Outputs
                                    .ack_clk1           (ack_clk1),
                                    .ack_clk2           (ack_clk2),
                                    .clkout             (clkout),
                                    // Inputs
                                    .clk1               (clk1),
                                    .clk2               (clk2),
                                    .req_clk1           (req_clk1),
                                    .req_clk2           (req_clk2),
                                    .select             (select),
                                    .rst_n              (rst_n));



   clock_gen #(.period(100)) U_CLK1(
                                    .clk(clk1)
                                    );
   clock_gen #(.period(250)) U_CLK2(
                                    .clk(clk2)
                                    );



  event dbg_finish;

  initial
    begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb);
     end
  // Start by pulsing the reset low for some nanoseconds
  initial begin
     rst_n = 1'b0;
     select = 1'b0;


    #5;
    rst_n = 1'b1;
    $display("-I- Reset is released");

     #500;
     select = 1'b1;


     #500;
     #500;
     select = 1'b0;
     #1000;

    $display("-I- Done !");

    $finish;
  end



endmodule // tb
/*
 Local Variables:
 verilog-library-directories:(
 "."
 ".."
 )
 End:
 */
