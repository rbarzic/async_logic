module sync_merge (/*AUTOARG*/
   // Outputs
   r2_r, r1_r, a0_r, a1, a2, r0,
   // Inputs
   r1, r2, a0, reset_n
   );

   input r1;
   output a1;
   input r2;
   output a2;

   output r0;
   input  a0;

   input  reset_n;                // To U_SYNC_R1 of dualffsync.v, ...
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output               a0_r;                   // From U_SYNC_A0 of dualffsync.v
   output               r1_r;                   // From U_SYNC_R1 of dualffsync.v
   output               r2_r;                   // From U_SYNC_R2 of dualffsync.v
   // End of automatics

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clk;                    // From U_PAUSIBLE_CLOCK of pausible_clock.v
   // End of automatics

   reg                 r0;
   reg                 a1;
   reg                 a2;
   


    /* dualffsync AUTO_TEMPLATE(
     .in(r@),
     .out_r(r@_r),
     ); */
   dualffsync U_SYNC_R1 (
                           /*AUTOINST*/
                         // Outputs
                         .out_r                 (r1_r),          // Templated
                         // Inputs
                         .in                    (r1),            // Templated
                         .clk                   (clk),
                         .reset_n               (reset_n));

   dualffsync U_SYNC_R2 (/*AUTOINST*/
                         // Outputs
                         .out_r                 (r2_r),          // Templated
                         // Inputs
                         .in                    (r2),            // Templated
                         .clk                   (clk),
                         .reset_n               (reset_n));
   /* dualffsync AUTO_TEMPLATE(
    .in(a@),
    .out_r(a@_r),
    ); */
   dualffsync U_SYNC_A0 (/*AUTOINST*/
                         // Outputs
                         .out_r                 (a0_r),          // Templated
                         // Inputs
                         .in                    (a0),            // Templated
                         .clk                   (clk),
                         .reset_n               (reset_n));


   assign unstable = (r1 ^ a1) | (r2 ^ a2) | (r1_r ^ a1) | (r2_r ^ a2) | (a0 ^ a0_r);
   assign clock_stopped = !unstable;
   

    /* pausible_clock AUTO_TEMPLATE(
     .clock              (clk),
     .rstn              (reset_n),
     ); */
   pausible_clock U_PAUSIBLE_CLOCK (
                                    .req                (clock_stopped),
                                    .grant              (),
                                    /*AUTOINST*/
                                    // Outputs
                                    .clock              (clk),           // Templated
                                    // Inputs
                                    .rstn               (reset_n));       // Templated


   // glitch-free output
   always @(posedge clk or negedge reset_n) begin
      if(reset_n == 1'b0) begin
         /*AUTORESET*/
         // Beginning of autoreset for uninitialized flops
         a1 = 1'h0;
         a2 = 1'h0;
         r0 = 1'h0;
         // End of automatics
      end
      else begin
         r0 = r1_r | r2_r;
         a1 = r1_r & a0_r;
         a2 = r2_r & a0_r;
         
      end
   end

   
   

endmodule // sync_merge
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../pausible_clock/"
 )
 End:
 */
