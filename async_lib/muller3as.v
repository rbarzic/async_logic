//   Project     : async
//   File        : muller3as.v
//   Description : Verilog model of a Muller/C-element (3 inputs, assymetric)
//   Copyright 2016 Ronan BARZIC

`timescale 1ns/1ns

module muller3as(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   a, p, n, rstn
   );
  input  a;
  input  p;
  input  n;
  input  rstn;
  output z;

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg                   z;
  // End of automatics

  always @* begin
    if(rstn == 1'b0) begin
      z <= 0;
    end
    else begin
      if((a==1'b1) & (p==1'b1)) begin
        z <= #1 1'b1;
      end
      else if((a==1'b0) & (n==1'b0)) begin
         z <= #1 1'b0;
      end
    end

  end



endmodule // muller3as
