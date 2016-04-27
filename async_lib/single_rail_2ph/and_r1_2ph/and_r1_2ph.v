//  Experiment about implementing of a 100% asynchronous  "AND" function between
// request signals
// THis is just a arbitrer with the equivalent of a call function
// where xor gates have been replaced by AND gates
// using arbitrer_r1_2ph

module and_r1_2ph (/*AUTOARG*/
   // Outputs
   a1, a2, r,
   // Inputs
   r1, r2, a, rstn
   );

   // Input pandts
   input r1;
   output a1;

   input  r2;
   output a2;

   // output pandt
   output r;
   input  a;

   input  rstn;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTANDEG*/
   /*AUTOWIRE*/
   wire                 r;
   wire                 r1,r2;
   wire                 a1,a2;
   wire                 g1,g2;
   wire                 d1,d2;

   arbitrer_r1_2ph U_ARBITRER(
                              // Input pandts
                              .r1               (r1),
                              .a1               (a1),
                              .r2               (r2),
                              .a2               (a2),
                              // Output pandts
                              .g1               (g1),
                              .g2               (g2),

                              .d1               (d1),
                              .d2               (d2),
                              .rstn             (rstn));


   // Structure is similar to the call block
   // replacing the xor by an and
   // and also inside the decision-wait element
   // UPDATE : this does not work
   // The following code seems to work way better

   // If port #2 is zero, then the output r
   // is already zero and not ready (a==1)
   // else we have to wait for a

   mux2 U_MUX2_1(.z(d1pre),
                 .s(d2),
                 .a0(g1),
                 .a1(a));

   mux2 U_MUX2_2(.z(d2pre),
                 .s(d1),
                 .a0(g2),
                 .a1(a));

   // and2 U_AND2_1(.z(d1pre), .a(a), .b(d2));
   // and2 U_AND2_2(.z(d2pre), .a(d1), .b(a));




   // We need some memory to keep the feedback when state change
   // on the other port
   muller2 U_MULLER_ACK1(.a(g1),.b(d1pre),.rstn(rstn),.z(d1));
   muller2 U_MULLER_ACK2(.a(g2),.b(d2pre),.rstn(rstn),.z(d2));


   and2 U_AND2_OUT(.z(r), .a(g1), .b(g2));

endmodule // and_r1_2ph
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
