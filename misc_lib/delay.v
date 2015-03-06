`timescale 1ns/1ps
module delay (/*AUTOARG*/);
  
  input i;
  output d;

  parameter DELAY = 1;
  
  assign #DELAY i = d;
  
endmodule // delay
/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
