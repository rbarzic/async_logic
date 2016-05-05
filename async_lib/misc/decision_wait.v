// From
// The Design and Implementation of an Asynchronous Microprocessor.
// PhD Thesis by Nigel Charles Paver
//  From figure 3.11, page 38
// http://apt.cs.manchester.ac.uk/publications/thesis/paver94_phd.php

module decision_wait (/*AUTOARG*/
   // Outputs
   z1, z2,
   // Inputs
   a1, a2, fire, rstn
   );

   input a1;
   input a2;
   input fire;
   input rstn;

   output z1;
   output z2;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   wire   xor1, xor2;
   wire   z1, z2;


   xor2 U_XOR2_1 (.a(in),.b(z2),.z(xor1));
   xor2 U_XOR2_2 (.a(z1),.b(in),.z(xor2));


   // ack feedback on input ports
   muller2 U_MULLER1(.a(a1),.b(xor1),.rstn(rstn),.z(z1));
   muller2 U_MULLER2(.a(xor2),.b(a2),.rstn(rstn),.z(z2));

endmodule // decision_wait
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
