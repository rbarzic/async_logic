// Single rail, 4-phase arbitrer
// From
// PRINCIPLES OF ASYNCHRONOUS CIRCUIT DESIGN
//    – A Systems Perspective
//   JENS SPARSØ - STEVE FURBER
// Fig 5.21, p 79

module arbitrer_r1_4ph(/*AUTOARG*/
   // Outputs
   a1, a2, r0,
   // Inputs
   r1, r2, a0, rstn
   );
   input r1;
   output a1;

   input  r2;
   output a2;

   output r0;
   input  a0;

   input  rstn;


   mutex U_MUTEX(
                 .r1(r1),
                 .r2(r2),
                 .g1(g1),
                 .g2(g2)
                 );

   inv U_INV1(.i(a1),.zn(a1_n));
   inv U_INV2(.i(a2),.zn(a2_n));




   and2 U_AND2_1 (.a(g1),.b(a2_n),.z(y1));
   and2 U_AND2_2 (.a(g2),.b(a1_n),.z(y2));

   muller2 U_MULLER_1(.a(y1),.b(a0),.rstn(rstn),.z(a1));
   muller2 U_MULLER_2(.a(y2),.b(a0),.rstn(rstn),.z(a2));

   or2 U_OR2(.a(y1),.b(y2),.z(r0));


endmodule //
