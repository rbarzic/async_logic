//   Project     : async
//   File        : muller2.v
//   Description : Verilog model of a Muller/C-element (2 inputs)
//   Copyright 2009 Ronan BARZIC

`timescale 1ns/1ns

module muller2(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   a, b, rstn
   );
  input  a;
  input  b;
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
      if(a == b)
        z <= #1 a;
    end

  end



endmodule // muller2
