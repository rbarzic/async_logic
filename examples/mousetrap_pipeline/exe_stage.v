`timescale 1ns/1ps
module exe_stage (/*AUTOARG*/
   // Outputs
   done, target_address, qual_branch, qual_regwrite,
   // Inputs
   req, instruction
   );

   parameter DELAY1 = 15;

   input req;
   output done;


   input  [31:0] instruction;
   output [31:0] target_address;

   output qual_branch;
   output qual_regwrite;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


   assign #1 qual_branch = (instruction == 32'hCAFEBABE);
   assign #1 qual_regwrite = 0;
   assign #1 target_address = qual_branch ? 0 : 32'hDEAFBEEF;

   assign #delay1 done = req;


endmodule // exe_stage
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
