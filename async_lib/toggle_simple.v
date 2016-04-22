// implementation of a toggle element
// See Micropipelines, 	I. E. Sutherland	Sutherland, Sproull, and Associates, Palo Alto, CA
// Published in:
// Communications of the ACM
//      Volume 32 Issue 6, June 1989
//        Pages 720-738
//          ACM New York, NY, USA
// For the implementation, see :
// The Design and Implementation of an Asynchronous Microprocessor
// PhD thesis by Nigel Charles Paver

// trivial implementation - not robust

module toggle_simple (/*AUTOARG*/
   // Outputs
   dot, blank,
   // Inputs
   in, rstn
   );

   input in;
   output dot;
   output blank;

   input  rstn;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire                 dot;

   wire   blank, blank_n;


   latch U_LATCH_1 (.i(blank_n),
                    .q(dot),
                    .en(in),
                    .rstn(rstn));
   latch U_LATCH_2 (.i(dot),
                    .q(blank),
                    .en(!in),
                    .rstn(rstn));

   inv U_INV(.i(blank), .zn(blank_n));




endmodule // toggle_simple
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
