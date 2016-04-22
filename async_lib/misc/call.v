module call (/*AUTOARG*/
   // Outputs
   d1, d2, r,
   // Inputs
   r1, r2, d, rstn
   );
   // Input ports
   input r1,r2;
   output d1,d2;
   // Output ports
   output r;
   input  d;

   input  rstn;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  d1;
   reg                  d2;
   reg                  r;
   // End of automatics
   /*AUTOWIRE*/

   xor2 U_XOR2 (.a(r1),.b(r2),.z(r));
   decision_wait U_DW(
                      .a1(r1),
                      .a2(r2),

                      .z1(d1),
                      .z2(d2),

                      .fire(d),
                      .rstn(rstn),

                      );


endmodule // call
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
