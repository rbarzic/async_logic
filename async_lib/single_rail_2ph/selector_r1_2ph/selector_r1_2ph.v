// Bus selector/mux
// select between two buses
// depending on which input port
// was last active
// To be used after an arbitrer


module selector_r1_2ph (/*AUTOARG*/
   // Outputs
   dataout,
   // Inputs
   r1, a1, r2, a2, datain1, datain2, rstn
   );
   parameter WIDTH = 8;

   input r1;
   input a1;

   input  r2;
   input a2;

   input  [WIDTH-1:0 ]datain1;
   input  [WIDTH-1:0] datain2;
   output  [WIDTH-1:0] dataout;

   input               rstn;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
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
