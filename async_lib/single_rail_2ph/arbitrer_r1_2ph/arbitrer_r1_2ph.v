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
   wire   toogle_in1,toggle_in2;
   wire   cm1,cm2;
   wire   g1_released, g2_released;



   muller2 U_MULLER_1(.a(!g1_released),
                      .b(r1),
                      .rstn(rstn),
                      .z(cm1));
   muller2 U_MULLER_2(.a(!g2_released),
                      .b(r2),
                      .rstn(rstn),
                      .z(cm2));

   xor2 U_XOR2_1 (.a(cm1),.b(d1),.z(mutex_r1));
   xor2 U_XOR2_2 (.a(cm2),.b(d2),.z(mutex_r2));


   mutex U_MUTEX(
                 .r1(mutex_r1),
                 .r2(mutex_r2),
                 .g1(toggle_in1),
                 .g2(toggle_in2)
                 );
`ifndef USE_TOGGLE_SIMPLE
   toggle U_TOGGLE_1 (.in(toggle_in1),
                    .dot(g1),
                    .blank(g1_released),
                    .rstn(rstn));

   toggle U_TOGGLE_2 (.in(toggle_in2),
                      .dot(g2),
                      .blank(g2_released),
                      .rstn(rstn));
`else
   toggle_simple U_TOGGLE_1 (.in(toggle_in1),
                      .dot(g1),
                      .blank(g1_released),
                      .rstn(rstn));

   toggle_simple U_TOGGLE_2 (.in(toggle_in2),
                      .dot(g2),
                      .blank(g2_released),
                      .rstn(rstn));
`endif



   // ack feedback on input ports
   muller2 U_MULLER_ACK1(.a(r1),.b(d1),.rstn(rstn),.z(a1));
   muller2 U_MULLER_ACK2(.a(r2),.b(d2),.rstn(rstn),.z(a2));

`ifdef  DEBUG
   assign input_port1_ongoing_req = r1 ^ a1;
   assign input_port2_ongoing_req = r2 ^ a2;
   assign output_port1_unstable = g1 ^ d1;
   assign output_port2_unstable = g2 ^ d2;
   assign error = output_port1_unstable & output_port2_unstable;

   initial begin
      #1;
      @(posedge error);
      $display("-E arbitrer_r1_2ph : error found in protocol");
      #100;
      $finish;

   end

`endif

endmodule //
