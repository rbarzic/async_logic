module tb_sync_merge;
   
   
   
   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 a0_r;                   // From U_SYNC_MERGE of sync_merge.v
   wire                 a1;                     // From U_SYNC_MERGE of sync_merge.v
   wire                 a2;                     // From U_SYNC_MERGE of sync_merge.v
   wire                 r0;                     // From U_SYNC_MERGE of sync_merge.v
   wire                 r1_r;                   // From U_SYNC_MERGE of sync_merge.v
   wire                 r2_r;                   // From U_SYNC_MERGE of sync_merge.v
   // End of automatics

   reg                  r1,r2;
   reg                  reset_n;
   

    /* sync_merge AUTO_TEMPLATE(
     ); */
   sync_merge U_SYNC_MERGE (
                           /*AUTOINST*/
                            // Outputs
                            .a1                 (a1),
                            .a2                 (a2),
                            .r0                 (r0),
                            .a0_r               (a0_r),
                            .r1_r               (r1_r),
                            .r2_r               (r2_r),
                            // Inputs
                            .r1                 (r1),
                            .r2                 (r2),
                            .a0                 (a0),
                            .reset_n            (reset_n));
   
   assign #120 a0 =  r0;

   
   initial begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb_sync_merge);
     end

   initial begin
      reset_n <= 'b0;
      r1 <= 'b0;
      r2 <= 'b0;
      #100;
      reset_n <= 'b1;
      #1000;
      r1 <= 'b1;
      #1000;
      r1 <= 'b0;
      #1000;
      r2 <= 'b1;
      #1000;
      r2 <= 'b0;
      #1000;
      $display("-I- Done !");

      $finish;
   end
   

   
endmodule // tb_sync_merge
/*
 Local Variables:
 verilog-library-directories:(
 "."
 ".."
 )
 End:
 */
