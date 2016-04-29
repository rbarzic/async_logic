`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

   wire r1,r2;
   wire g1,g2;
   wire d1,d2;

   wire a1,a2,r0;


   wire [7:0] dataout;


   two_phase_event_gen U_PORT1_EVENT_GEN (
                                          .run(rst_async_n),
                                          .req(r1),
                                          .ack(a1)
                                          );

   two_phase_event_gen U_PORT2_EVENT_GEN (
                                          .run(rst_async_n),
                                          .req(r2),
                                          .ack(a2)
                                          );



   arbitrer_r1_2ph U_ARBITER(
                             // Input ports (req/ack)
                             .r1(r1),
                             .a1(a1),
                             .r2(r2),
                             .a2(a2),

                             // Output ports
                             .g1(g1),
                             .d1(d1),
                             .g2(g2),
                             .d2(d2),
                             .rstn(rst_async_n)
                             );


   selector_r1_2ph U_SELECTOR(
                              .r1(g1),
                              .a1(d1),
                              .r2(g2),
                              .a2(d2),
                              .datain1(8'hAA),
                              .datain2(8'h55),
                              .dataout(dataout),
                              .rstn(rst_async_n)
                              );




   assign #12 d1 =  g1;
   assign #55 d2 =  g2;

  // Dump all nets to a vcd file called tb.vcd
   event dbg_finish;

   reg   clk;
   initial clk = 0;

   always
     #100 clk = ~clk;

  initial
    begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb);
     end
  // Start by pulsing the reset low for some nanoseconds
  initial begin
     rst_async_n = 1'b0;

    #5;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");

     #200000;



    $display("-I- Done !");

    $finish;
  end

   // four_phase_assertion U_CHECKER0(.req(r0),.ack(a0),.rstn(rst_async_n));
   // four_phase_assertion U_CHECKER1(.req(r1),.ack(a1),.rstn(rst_async_n));
   // four_phase_assertion U_CHECKER2(.req(r2),.ack(a2),.rstn(rst_async_n));

   // just for debug
   assign input_port1_ongoing_req = r1 ^ a1;
   assign input_port2_ongoing_req = r2 ^ a2;
   assign output_port1_unstable = g1 ^ d1;
   assign output_port2_unstable = g2 ^ d2;
   assign error = output_port1_unstable & output_port2_unstable;

   initial begin
      #1;
      @(posedge error);
      $display("-E error found in protocol");
      #100;
      $finish;

   end



endmodule // tb
