module dualffsync (/*AUTOARG*/
   // Outputs
   out_r,
   // Inputs
   in, clk, reset_n
   );

   input in;
   output out_r;

   input clk;
   input reset_n;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   reg   in_m;
   reg   in_r;

   always @(posedge clk or negedge reset_n) begin
      if(reset_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         in_m <= 1'h0;
         in_r <= 1'h0;
         // End of automatics
      end
      else begin
         in_m <= in;
         in_r <= in_m;
      end
   end
   assign out_r = in_r;

endmodule // dualffsync
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
