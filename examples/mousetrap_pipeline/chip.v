`timescale 1ns/1ps
module chip (/*AUTOARG*/
   // Inputs
   rstn
   );
   parameter ROM_ADDRESS_SIZE = 14;

   input rstn;


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


   wire [31:0] pc_fetch;
   wire [31:0] next_pc_fetch;
   wire [31:0] next_pc_inc;
   wire [31:0] instruction;
   wire [31:0] mem_dout;
   wire [31:0] target_address;

   // Port #1 handles regular PC increments
   // Port #2 is for branch
   // Arbitrer will select which port should be active
   arbitrer_r1_2ph U_ARBITRER_PC(
                                 // Input port #1
                                 .r1(pc_inc_req),
                                 .a1(pc_inc_ack),

                                 // Input port #2
                                 .r2(exe_pc_branch_req),
                                 .a2(pc_branch_exe_ack),

                                 // Output port #1
                                 .g1(arb_pc_req),
                                 .d1(pc_arb_ack),

                                 // Output port #2
                                 .g2(arb_pc_branch_req),
                                 .d2(pc_arb_branch_ack),

                                 // Misc
                                 .rstn(rstn)
                                 );

   // Because of arbitrer, there is only one active port
   // at a time, so it is easy to select which value
   // should be forwarded
   // Note : The delay accross this cell i snot taken in account
   // (This cell has no feddback output). It has to be handled
   // outside
   selector_r1_2ph
     #(.WIDTH(32))
   U_SELECT_PC(
               // Input port #1
               .r1(arb_pc_req),
               .a1(pc_arb_ack),
               .datain1(next_pc_inc),

               // Input port #2
               .r2(arb_pc_branch_req),
               .a2(pc_arb_branch_ack),
               .datain2(target_address),

               // output
               .dataout(next_pc_fetch),

               // Misc
               .rstn(rstn)
               );


   call U_CALL_PC(
                  // Input port #1
                  .r1(arb_pc_req),
                  .d1(pc_arb_ack),
                  // Input port #2
                  .r2(arb_pc_branch_req),
                  .d2(pc_arb_branch_ack),

                  // output port
                  .r(req_pc_left),
                  .d(pc_ack_left),
                  // Misc
                  .rstn(rstn)
                  );
   // We nee some extra delay
   // FIXME : is the dalay on the correct signal ?
   // (should it be on arbitrer outputs ?)
   assign #3 req_pc_left_d = req_pc_left;

   // The mousetrap element that represents the PC
   // Fixme : this should probably be put in // with the
   // code memory block (because the code memory latches the PC anyway)
   // like the synchronous version
   mousetrap_elt #(
                   .WIDTH(32),
                   .RESET_VALUE(32'hFFFF_FFFF)
                   ) U_MOUSETRAP_PC(
                                    .ackNm1(pc_ack_left), // out
                                    .reqN(req_pc_left_d), // In
                                    .ackN(ack_pc), // In
                                    .doneN(pc_done), // Out
                                    .datain(next_pc_fetch),
                                    .dataout(pc_fetch),
                                    .rstn(rstn)
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



   // The "Instruction" register
   mousetrap_elt #(.WIDTH(32)) U_MOUSETRAP_INSTRUCTION(
                                                  .ackNm1(inst_ack), // out
                                                  .reqN(mem_ack), // In
                                                  .ackN(ack_inst), // In
                                                  .doneN(inst_done), // Out
                                                  .datain(mem_dout),
                                                  .dataout(instruction),
                                                  .rstn(rstn)
                                                  );

   wire        exe_done;
   wire        exe_qual_branch;
   wire        exe_qual_regwrite;

   exe_stage U_EXE_STAGE(
                         .req(inst_done),
                         .instruction(instruction),
                         .qual_branch(exe_qual_branch),
                         .qual_regwrite(exe_qual_regwrite),
                         .target_address(target_address),
                         .done(exe_done)
                         );

   // Currently a 2-way fork
   // path #1 is for the branch
   // path #2 is for the register write
   // Normally a third one is needed for the
   // data memory access (with the problem of the load)
   // that should write to the register file after the data
   // is available
   fork_cond2_r1_2ph U_FORK_EXE(
                     // input port
                     .r(exe_done),
                     .a(ack_inst),
                     // conditions
                     .cond1(exe_qual_branch),
                     .cond2(exe_qual_regwrite),
                     // output ports
                     .r1(exe_pc_branch_req),
                     .a1(pc_branch_exe_ack),
                     .r2(exe_regwrite_req),
                     .a2(regwrite_exe_ack),
                     .rstn(rstn)
                     );

   // assign #8 branch_exe_ack = exe_branch_req;
   assign #12 regwrite_exe_ack = exe_regwrite_req;


   buff #(.DELAY(20)) U_DELAY0(.i(pc_done), .z(adder_ack));
   assign #10 next_pc_inc  = pc_fetch + 1;


   muller2 U_MULLER_ACK_PC(.a(adder_ack),.b(inst_ack),.rstn(rstn),.z(ack_pc));



   // Nothing to do with the instruction right now
   // assign #5 ack_inst = inst_done;


   inv U_INV(.i(pc_inc_ack), .zn(pc_inc_req));





endmodule // chip
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../async_lib/single_rail_2ph/fork_cond_r1_2ph"
 )
 End:
 */
