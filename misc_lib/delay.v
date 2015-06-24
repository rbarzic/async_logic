`timescale 1ns/1ps
module delay (/*AUTOARG*/
   // Outputs
   d,
   // Inputs
   i
   );
  
  input i;
  output d;

  parameter DELAY = 1;
  
  assign #DELAY d = i;
  
endmodule // delay
/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
