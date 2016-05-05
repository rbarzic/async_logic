`timescale 1ns/1ps
module exe_stage (/*AUTOARG*/
   // Outputs
   done, qual_branch, qual_regwrite,
   // Inputs
   req, instruction
   );

   parameter DELAY1 = 15;

   input req;
   output done;


   input  [31:0] instruction;

   output qual_branch;
   output qual_regwrite;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/


   assign #1 qual_branch = (instruction == 32'hCAFEBABE);
   assign #1 qual_regwrite = 0;

   assign #delay1 done = req;


endmodule // exe_stage
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
