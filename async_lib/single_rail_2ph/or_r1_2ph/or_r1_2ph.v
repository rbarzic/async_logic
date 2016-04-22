//  Implementation of a 100% asynchronous  "OR" function between
// request signals
// using arbitrer_r1_2ph

module or_r1_2ph (/*AUTOARG*/
   // Outputs
   a1, a2, r,
   // Inputs
   r1, r2, a, rstn
   );

   // Input ports
   input r1;
   output a1;

   input  r2;
   output a2;

   // output port
   output r;
   input  a;

   input  rstn;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/
   wire                 r;
   wire                 r1,r2;
   wire                 a1,a2;
   wire                 g1,g2;
   wire                 d1,d2;

   arbitrer_r1_2ph U_ARBITRER(
                              // Input ports
                              .r1               (r1),
                              .a1               (a1),
                              .r2               (r2),
                              .a2               (a2),
                              // Output ports
                              .g1               (g1),
                              .g2               (g2),

                              .d1               (d1),
                              .d2               (d2),
                              .rstn             (rstn));

   // Structure is similar to the call block
   // replacing the xor by an or
   // and also inside the decision-wait element


   // If port #2 is one, then the output r
   // is already one and ready (a==1)
   // else we have to wait for a
   //mux2 U_MUX2_1(.z(d1pre),
   //              .s(d2),
   //              .a0(a),
   //              .a1(g1));
   //
   //mux2 U_MUX2_2(.z(d2pre),
   //              .s(d1),
   //              .a0(a),
   //              .a1(g2));

   or2 U_OR2_1(.z(d1pre), .a(a), .b(d2));
   or2 U_OR2_2(.z(d2pre), .a(d1), .b(a));




   // We need some memory to keep the feedback when state change
   // on the other port
   muller2 U_MULLER_ACK1(.a(g1),.b(d1pre),.rstn(rstn),.z(d1));
   muller2 U_MULLER_ACK2(.a(g2),.b(d2pre),.rstn(rstn),.z(d2));


   or2 U_OR2_OUT(.z(r), .a(g1), .b(g2));

endmodule // or_r1_2ph
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
