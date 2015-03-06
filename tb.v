`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

   reg cm0_a;
   reg cm0_b;


   reg mut0_r1;
   reg mut0_r2;


   cmuller U_CM0(.z(cm0_z),
               .a(cm0_a),
               .b(cm0_b),
               .rstn(rst_async_)
               );


   mutex U_MUTEX0(
                  .g1(mut0_g1),
                  .g2(mut0_g2),
                  .r1(mut0_r1),
                  .r2(mut0_r2)
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

     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b0;


    #5;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");
     // Muller C-Element
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

     // Mutex
     mut0_r1 <= 1'b1;
     mut0_r2 <= 1'b0;
     #10;
     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b0;
     #10;
     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b1;
     #10;
     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b0;
     #10;
     mut0_r1 <= 1'b1;
     mut0_r2 <= 1'b1;
     #10;
     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b1;
     #10;
     mut0_r1 <= 1'b0;
     mut0_r2 <= 1'b0;
     #10;





    $display("-I- Done !");

    $finish;
  end


endmodule // tb
