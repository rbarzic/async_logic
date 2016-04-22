// Single rail, 2-phase arbitrer
// From
// The Design and Implementation of an Asynchronous Microprocessor.
// PhD Thesis by Nigel Charles Paver
//  From figure 3.16, page 42
// http://apt.cs.manchester.ac.uk/publications/thesis/paver94_phd.php

// Modified to get acknowledge signals on the input ports

module arbitrer_r1_2ph(/*AUTOARG*/
   // Outputs
   a1, a2, g1, g2,
   // Inputs
   r1, r2, d1, d2, rstn
   );
   input r1;
   output a1;

   input  r2;
   output a2;

   output g1;
   input  d1;

   output g2;
   input  d2;


   input  rstn;

   wire   mutex_r1, mutex_r2;
   wire   latch_en1, latch_en2;


   xor2 U_XOR2_1 (.a(r1),.b(d1),.z(mutex_r1));
   xor2 U_XOR2_2 (.a(r2),.b(d2),.z(mutex_r2));


   mutex U_MUTEX(
                 .r1(mutex_r1),
                 .r2(mutex_r2),
                 .g1(latch_en1),
                 .g2(latch_en2)
                 );


   latch U_LATCH_1 (.i(r1),
                    .q(g1),
                    .en(latch_en1),
                    .rstn(rstn));

   latch U_LATCH_2 (.i(r2),
                    .q(g2),
                    .en(latch_en2),
                    .rstn(rstn));




   // ack feedback on input ports
   muller2 U_MULLER_1(.a(r1),.b(d1),.rstn(rstn),.z(a1));
   muller2 U_MULLER_2(.a(r2),.b(d2),.rstn(rstn),.z(a2));




endmodule //
