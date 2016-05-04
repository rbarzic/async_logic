// Conditional fork (2 channels)



module fork_cond2_r1_ph (/*AUTOARG*/
   // Outputs
   r1, r2,
   // Inputs
   r, a, a1, cond1, a2, cond2, rstn
   );
   parameter WIDTH = 8;

   input r;
   input a;

   output  r1;
   input a1;
   input cond1; // =0 , req is not propagated, = 1 : reg is propagated

   output r2;
   input  a2;
   input  cond2; // =0 , req is not propagated, = 1 : reg is propagated

   input               rstn;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  r1;
   reg                  r2;
   // End of automatics
   /*AUTOWIRE*/

   wire                port1_active;
   wire                port2_active;
   wire                muxsel;
   wire                rstn;
   wire [WIDTH-1:0]    dataout;

   assign port1_active  = r1 ^a1;
   assign port2_active  = r2 ^a2;

   rs_ff U_RS(
              .set(port2_active),
              .reset(port1_active),
              .q(muxsel),
              .qn(),
              .async_rst_neg(rstn)
              );


   assign dataout = muxsel ? datain2 : datain1;



endmodule // selector_r1_2ph
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
