`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

   reg cm0_a;
   reg cm0_b;


   cmuller CM0(.z(cm0_z),
               .a(cm0_a),
               .b(cm0_b),
               .rstn(rst_async_)
               );


  // Dump all nets to a vcd file called tb.vcd
  initial
    begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb);
     end









  // Start by pulsing the reset low for some nanoseconds
  initial begin
    rst_async_n = 1'b0;
     cm0_a <= 0;
     cm0_b <= 0;

    #5;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");

     #10;
     cm0_a <= 0;
     cm0_b <= 0;

     #10;
     cm0_a <= 1;
     cm0_b <= 0;

     #10;
     cm0_a <= 1;
     cm0_b <= 1;
     #10;
     cm0_a <= 1;
     cm0_b <= 0;

     #10;
     cm0_a <= 0;
     cm0_b <= 0;

     #10;

    $display("-I- Done !");

    $finish;
  end


endmodule // tb
