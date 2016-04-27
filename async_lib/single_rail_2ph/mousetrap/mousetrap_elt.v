// A mousetrap pipeline stage as describe in
// MOUSETRAP: High-Speed Transition-Signaling Asynchronous Pipelines
// IEEE Transactions on Very Large Scale Integration (VLSI) Systems  (Volume:15 ,  Issue: 6 )
// 684 - 698 - June 2007

module mousetrap_elt (/*AUTOARG*/
   // Outputs
   ackNm1, doneN, dataout,
   // Inputs
   reqN, ackN, datain, rstn
   );
   parameter WIDTH=8;
   parameter RESET_VALUE={WIDTH{1'b0}};

   // Left side
   output ackNm1;
   input  reqN;

   // Right side
   input  ackN;
   output doneN;

   input  [WIDTH-1:0] datain;
   output [WIDTH-1:0] dataout;

   input              rstn;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire                 latch_en_n;
   wire           [WIDTH:0]      l_in;
   wire           [WIDTH:0]      l_out;

   xor2 U_XOR(.a(ackN), .b(doneN), .z(latch_en_n));
   inv U_INV( .i(latch_en_n), .zn(latch_en));


   assign l_in = {reqN,datain};
   assign dataout = l_out[WIDTH-1:0];
   assign doneN   = l_out[WIDTH];
   assign ackNm1  = doneN;


   latches #(.LATCH_BITS(WIDTH+1),
             .RESET_VALUE({1'b0,RESET_VALUE})
             ) U_LATCHES(
                     .q(l_out),
                     .i(l_in),
                     .en(latch_en),
                     .rstn(rstn)
                     );

endmodule // mousetrap_elt
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
