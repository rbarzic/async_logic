`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

   wire req0, req1, req2;
   wire ack0, ack1, ack2;


   reg  req0_reg;
   reg  start;


   wire [7:0] data0;
   reg  [7:0] data0_reg;
   wire [7:0] data1;
   wire [7:0] data2;
   wire [7:0] data3;

   // assign data0 = data0_reg;


//   two_phase_event_gen U_PORT1_EVENT_GEN (
//                                          .run(rst_async_n),
//                                          .req(req0),
//                                          .ack(a)
//                                          );


   mousetrap_elt U_MOUSETRAP_STAGE0(
                                    .ackNm1(), // out
                                    .reqN(req0), // In
                                    .ackN(a), // In
                                    .doneN(done0), // Out
                                    .datain(data0),
                                    .dataout(data1),
                                    .rstn(rst_async_n)
                             );

   buff #(.DELAY(20)) U_DELAY0(.i(done0), .z(done0_d));
   assign #10 data0 = data1 + 4;

   inv U_INV(.i(done0_d), .zn(req0_tmp));
   assign req0 = req0_tmp;


   assign a =done0_d ;




   // two_phase_slave U_SLAVE(.req(req3), .ack(ack2));

   // assign #30  ack2_tmp =  req3;
   // assign ack2 = (ack2_tmp === 1'b1);

  // Dump all nets to a vcd file called tb.vcd
   event dbg_finish;

   initial
    begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb);
     end
  // Start by pulsing the reset low for some nanoseconds
  initial begin
     rst_async_n <= 1'b0;
     start <= 1'b0;
     // Wait long enough for the X's in the delay elements to disappears
    #50;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");
     #5;
     start <= 1'b1;
     #5;

     #200000;
     start <= 1'b0;


    $display("-I- Done !");

    $finish;
  end

endmodule // tb
