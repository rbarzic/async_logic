`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

  wire clock;
  reg  req;
  wire grant;


   pausible_clock_sync U_PAUSIBLE_CLOCK(
                             .grant(grant),
                             .clock(clock),
                             .req(req),
                             .ext_ref_clk(ext_ref_clk),
                             .rstn(rst_async_n)
                             );


   clock_gen U_EXT_CLK_GEN(
                           .clk(ext_ref_clk)
                           );


  event dbg_finish;

  initial
    begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb);
     end
  // Start by pulsing the reset low for some nanoseconds
  initial begin
     rst_async_n = 1'b0;
     req <= 0;

    #5;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");

     #100;
     $display("-I- step 1");
     req <= 1;

     #230;

    req <= 0;


     #300;

    $display("-I- Done !");

    $finish;
  end



endmodule // tb
