// Muller C-Element 3 inputs, symetric

module muller3 (/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   a, b, c, rstn
   );
   input a;
   input b;
   input c;

   output z;
   input  rstn;




   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  z;
   // End of automatics
   /*AUTOWIRE*/
   wire                 internal;

   muller2 U_MULLER0(.a(a), .b(b), .rstn(rstn), .z(internal));
   muller2 U_MULLER1(.a(internal), .b(c), .rstn(rstn), .z(z));



endmodule // muller3
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
