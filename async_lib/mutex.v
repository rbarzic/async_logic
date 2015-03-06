module mutex (/*AUTOARG*/
  // Outputs
  g1, g2,
  // Inputs
  r1, r2
  );
  parameter DELAY = 1;
  
  input r1;
  input r2;
  output g1;
  output g2;

  reg    g1_i,g2_i;
  
  initial begin
    g1_i <= 0;
    g2_i <= 0;
  end
  
  

  always @* begin
    if(r1 && !g2 && !g2_i) begin
      g1_i <= 1'b1;
      g2_i <= 1'b0;
      
    end
    else begin
      if(r2 && !g1 && !g1_i) begin
      g1_i <= 1'b0;
      g2_i <= 1'b1;      
      end
      else begin
        g1_i <= 1'b0;
        g2_i <= 1'b0;      
      end
    end      
  end
  
  assign #DELAY g1 = g1_i;
  assign #DELAY g2 = g2_i;
  


  
   
endmodule // mutex
/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
