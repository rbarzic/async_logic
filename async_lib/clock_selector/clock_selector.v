// Select between clk1 and clk2
// clk1 is expected to have higher priority compared to clk2
// (if clk1 and clk2 are requested we output clk1)
module clock_selector (/*AUTOARG*/
   // Outputs
   ack_clk1, ack_clk2, clkout,
   // Inputs
   clk1, clk2, req_clk1, req_clk2, select, rst_n
   );

   input clk1;
   input clk2;

   input req_clk1;
   output ack_clk1;

   input req_clk2;
   output ack_clk2;

   output clkout;
   input  select; // To be removed

   input  rst_n; // Fixme - synchronized reset for clk1/clk2 is needed (or a POR like reset)



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  ack_clk1;
   reg                  ack_clk2;
   // End of automatics
   /*AUTOWIRE*/

   // for now a very simple implementation without the arbitration done correctly


   wire   select; // 0 : clk1, 1 : clk2
   wire    select1_a;
   reg    select1_m;
   reg    select1_r;
   wire   select2_a;
   reg    select2_m;
   reg    select2_r;
   wire   clkout;

   assign select1_a = !select &!select2_r;
   assign select2_a = select &!select1_r;


   // We use posedge DFFs
   always @(posedge clk1 or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         select1_m <= 1'h0;
         select1_r <= 1'h0;
         // End of automatics
      end
      else begin
         select1_m <= select1_a;
         select1_r <= select1_m;

      end
   end


   always @(posedge clk2 or negedge rst_n) begin
      if(rst_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         select2_m <= 1'h0;
         select2_r <= 1'h0;
         // End of automatics
      end
      else begin
         select2_m <= select2_a;
         select2_r <= select2_m;
      end
   end

   // we use posedge FF above, so we have to be carefull
   assign clkout = ((!clk1 & select1_r) |  (!clk2 & select2_r));



endmodule // clock_selector
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
