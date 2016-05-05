`timescale 1ns/1ps


`define CODE_RAM U_CHIP.U_ASYNC_MEM.U_SSRAM

module tb;
`include "useful_tasks.v"  // some helper tasks

   parameter ROM_ADDRESS_SIZE = 14;


  reg rst_async_n; // asynchronous reset



   reg  req0_reg;
   reg  start;

   chip U_CHIP(.rstn(rst_async_n));



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
