module inv (/*AUTOARG*/
  // Outputs
  zn,
  // Inputs
  i
  );
  parameter DELAY = 1;
  
  input i;
  output zn;

  assign #DELAY zn = !i;
  
endmodule // inv

module buff (/*AUTOARG*/
  // Outputs
  z,
  // Inputs
  i
  );
  parameter DELAY = 1;
  
  input i;
  output z;

  assign #DELAY z = i;
  
endmodule // buff



module and2 (/*AUTOARG*/
  // Outputs
  z,
  // Inputs
  a, b
  );

  parameter DELAY = 1;
  input a,b;
  output z;
  
  assign #DELAY z= a & b;
  
endmodule // and2

module and3 (/*AUTOARG*/
  // Outputs
  z,
  // Inputs
  a, b, c
  );

  parameter DELAY = 1;
  input a,b,c;
  output z;
  
  assign #DELAY z= a & b & c;
  
endmodule // and2



module or2 (/*AUTOARG*/
  // Outputs
  z,
  // Inputs
  a, b
  );

  parameter DELAY = 1;
  input a,b;
  output z;
  
  assign #DELAY z = a | b;
  
endmodule // and2

module rs_ff (/*AUTOARG*/
  // Outputs
  q, qn,
  // Inputs
  set, reset, async_rst_neg
  );
  
  parameter DELAY = 1;
  
  input set;
  input reset;
  input async_rst_neg;
  output q;
  output qn;
  
  /*AUTOINPUT*/
  /*AUTOOUTPUT*/
  
  /*AUTOREG*/
  /*AUTOWIRE*/

  wire                  set_i_n     = !(set & async_rst_neg);
  wire                  reset_i_n   = !(reset |  !async_rst_neg);
  reg                   q_i;
  wire                  q;

  always @(negedge reset_i_n or negedge set_i_n)
    if (!reset_i_n) 
      q_i <= 0; // asynchronous reset
    else 
      if (!set_i_n) 
        q_i <= 1; // asynchronous set

  // synopsys translate_off
  always @(reset_i_n or set_i_n)
    if (reset_i_n && !set_i_n) force q_i = 1;
    else release q_i;
  // synopsys translate_on


  assign #DELAY q =   q_i;
  assign #DELAY qn =  !q_i;
  
endmodule // rs_ff


module mux2 (/*AUTOARG*/
  // Outputs
  z,
  // Inputs
  a0, a1, s
  );
  
  input a0;
  input a1;
  input s;
  output z;

  parameter DELAY = 1;

  assign #DELAY z = s ? a1 : a0;
  
  /*AUTOINPUT*/
  
  /*AUTOOUTPUT*/
  
  /*AUTOREG*/
  
  /*AUTOWIRE*/
  
  
endmodule // mux2
/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */



/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */



/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */


