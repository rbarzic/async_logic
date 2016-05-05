// Select module for 2-phase protocol
// as described in
// The Design and Implementation of an Asynchronous Microprocessor.
// PhD Thesis by Nigel Charles Paver
//  From figure 3.10, page 38
// http://apt.cs.manchester.ac.uk/publications/thesis/paver94_phd.php

module select (/*AUTOARG*/
   // Outputs
   false, true,
   // Inputs
   in, sel, rstn
   );

   input in;
   input sel;
   output false;
   output true;
   input  rstn;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire                 true, false;
   wire                 xor1, xor2;

   xor2 U_XOR2_1 (.a(in),.b(true),.z(xor1));
   xor2 U_XOR2_2 (.a(false),.b(in),.z(xor2));
   inv  U_INV_SEL(.i(sel), .zn(seln));

   latch U_LATCH1(.i(xor1), .en(seln), .q(false), .rstn(rstn));
   latch U_LATCH2(.i(xor2), .en(sel), .q(true), .rstn(rstn));



endmodule // select
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
