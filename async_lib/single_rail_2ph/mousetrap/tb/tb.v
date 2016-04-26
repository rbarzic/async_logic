`timescale 1ns/1ps
module tb;
`include "useful_tasks.v"  // some helper tasks

  reg rst_async_n; // asynchronous reset

   wire req0, req1, req2;
   wire ack0, ack1, ack2;


   reg  req0_reg;
   assign req0 = req0_reg;

   wire [7:0] data0;
   reg  [7:0] data0_reg;
   wire [7:0] data1;
   wire [7:0] data2;
   wire [7:0] data3;

   assign data0 = data0_reg;


//   two_phase_event_gen U_PORT1_EVENT_GEN (
//                                          .run(rst_async_n),
//                                          .req(req0),
//                                          .ack(a)
//                                          );


   mousetrap_elt U_MOUSETRAP_STAGE0(
                                    .ackNm1(a),
                                    .reqN(req0),
                                    .ackN(ack0),
                                    .doneN(done0),
                                    .datain(data0),
                                    .dataout(data1),
                                    .rstn(rst_async_n)
                             );

   buff #(.DELAY(20)) U_DELAY0(.i(done0), .z(req1));

   mousetrap_elt U_MOUSETRAP_STAGE1(
                                    .ackNm1(ack0),
                                    .reqN(req1),
                                    .ackN(ack1),
                                    .doneN(done1),
                                    .datain(data1),
                                    .dataout(data2),
                                    .rstn(rst_async_n)
                                    );

   buff #(.DELAY(20)) U_DELAY1(.i(done1), .z(req2));

   mousetrap_elt U_MOUSETRAP_STAGE2(
                                    .ackNm1(ack1),
                                    .reqN(req2),
                                    .ackN(ack2),
                                    .doneN(done2),
                                    .datain(data2),
                                    .dataout(data3),
                                    .rstn(rst_async_n)
                                    );


   buff #(.DELAY(20)) U_DELAY2(.i(done2), .z(req3));



   // two_phase_slave U_SLAVE(.req(req3), .ack(ack2));

   assign #30  ack2_tmp =  req3;
   assign ack2 = (ack2_tmp === 1'b1);

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
     data0_reg <= 8'h00;
     req0_reg <= 0;
     // Wait long enough for the X's in the delay elements to disappears
    #500;
    rst_async_n = 1'b1;
    $display("-I- Reset is released");
     #10;
     data0_reg <= 8'hAA;
     #1;
     req0_reg <= 1'b1;
     wait(a === 1'b1);
     #30;
     data0_reg <= 8'h55;
     #1;
     req0_reg <= !req0_reg;
     wait(a === 1'b0);

     #10;
     data0_reg <= 8'hBB;
     #1;
     req0_reg <= 1'b1;
     wait(a === 1'b1);

     #10;
     data0_reg <= 8'hCC;
     #1;
     req0_reg <= 1'b0;
     wait(a === 1'b0);

     #200000;



    $display("-I- Done !");

    $finish;
  end

endmodule // tb
