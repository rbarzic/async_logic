`timescale 1ns/1ps


`define CODE_RAM U_ASYNC_MEM.U_SSRAM

module tb;
`include "useful_tasks.v"  // some helper tasks

   parameter ROM_ADDRESS_SIZE = 14;


  reg rst_async_n; // asynchronous reset

   wire req0, req1, req2;
   wire ack0, ack1, ack2;


   reg  req0_reg;
   reg  start;


   wire [31:0] data0;
   reg  [31:0] data0_reg;
   wire [31:0] data1;
   wire [31:0] data2;
   wire [31:0] pc_fetch;
   wire [31:0] next_pc_fetch;
   wire [31:0] instruction;
   wire [31:0] mem_dout;

   // assign data0 = data0_reg;


//   two_phase_event_gen U_PORT1_EVENT_GEN (
//                                          .run(rst_async_n),
//                                          .req(req0),
//                                          .ack(a)
//                                          );


   mousetrap_elt #(
                   .WIDTH(32),
                   .RESET_VALUE(32'hFFFF_FFFF)
                   ) U_MOUSETRAP_PC(
                                    .ackNm1(), // out
                                    .reqN(req_pc), // In
                                    .ackN(ack_pc), // In
                                    .doneN(pc_done), // Out
                                    .datain(next_pc_fetch),
                                    .dataout(pc_fetch),
                                    .rstn(rst_async_n)
                             );


   assign req_mem = pc_done;

    /* async_mem AUTO_TEMPLATE(
     ); */
   async_mem U_ASYNC_MEM (

                          .ack                  (mem_ack),
                          .dout                 (mem_dout),
                          .req                  (req_mem),
                          .addr                 (pc_fetch[11:0]),
                          .din                  (0),
                          .we                   (0));




   mousetrap_elt #(.WIDTH(32)) U_MOUSETRAP_INSTRUCTION(
                                                  .ackNm1(inst_ack), // out
                                                  .reqN(mem_ack), // In
                                                  .ackN(ack_inst), // In
                                                  .doneN(inst_done), // Out
                                                  .datain(mem_dout),
                                                  .dataout(instruction),
                                                  .rstn(rst_async_n)
                                                  );


   buff #(.DELAY(20)) U_DELAY0(.i(pc_done), .z(adder_ack));
   assign #10 next_pc_fetch  = pc_fetch + 1;


   muller2 U_MULLER_ACK_PC(.a(adder_ack),.b(inst_ack),.rstn(rstn),.z(ack_pc));



   // Nothing to do with the instruction right now
   assign #5 ack_inst = inst_done;


   inv U_INV(.i(ack_pc), .zn(req_pc));




   // two_phase_slave U_SLAVE(.req(req3), .ack(ack2));

   // assign #30  ack2_tmp =  req3;
   // assign ack2 = (ack2_tmp === 1'b1);

  // Dump all nets to a vcd file called tb.vcd



      task load_program_memory;
      reg [1024:0] filename;
      reg [7:0]    memory [1<<ROM_ADDRESS_SIZE:0]; // byte type memory
      integer      i;
      reg [31:0]   tmp;
      integer      dummy;

      begin
`ifndef NTL_SIM
         filename = 0;
         dummy = $value$plusargs("program_memory=%s", filename);
         if(filename ==0) begin
            $display("WARNING! No content specified for program memory");
         end
         else begin
            $display("-I- Loading <%s>",filename);
            $readmemh (filename, memory);
            for(i=0; i<((1<<ROM_ADDRESS_SIZE)/4); i=i+1) begin
               tmp[7:0] = memory[i*4+0];
               tmp[15:8] = memory[i*4+1];
               tmp[23:16] = memory[i*4+2];
               tmp[31:24] = memory[i*4+3];

               `CODE_RAM.RAM[i]  = tmp;

            end
         end // else: !if(filename ==0)
`endif
      end
   endtask // load_program_memory



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
   end // initial begin

   initial begin
      #1;
      load_program_memory();

      end




endmodule // tb
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../misc_lib"
 "../../async_lib/memories"
 )
 End:
 */
