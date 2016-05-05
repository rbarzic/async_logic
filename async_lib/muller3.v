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
   /*AUTOWIRE*/
   wire                 internal;
   wire                 z;


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
