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


module nand2 (/*AUTOARG*/
   // Outputs
   zn,
   // Inputs
   a, b
   );

   parameter DELAY = 1;
   input a,b;
   output zn;

   assign #DELAY zn= !(a & b);

endmodule // nand2



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

endmodule // and3

module nand3 (/*AUTOARG*/
   // Outputs
   zn,
   // Inputs
   a, b, c
   );

   parameter DELAY = 1;
   input a,b,c;
   output zn;

   assign #DELAY zn= !(a & b & c);

endmodule // nand3



module nand4 (/*AUTOARG*/
   // Outputs
   zn,
   // Inputs
   a, b, c, d
   );

   parameter DELAY = 1;
   input a,b,c,d;
   output zn;

   assign #DELAY zn= !(a & b & c & d);

endmodule // nand4






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

endmodule // or2


module xor2 (/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   a, b
   );

   parameter DELAY = 1;
   input a,b;
   output z;

   assign #DELAY z = a ^ b;

endmodule // xor2



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

// RS latch with inverted inputs
module rs_latch_ii(/*AUTOARG*/
   // Outputs
   q, qn,
   // Inputs
   sn, rn, rstn
   );
   input sn;
   input rn;
   input rstn;
   output q;
   output qn;


   nand2 U_NAND2(.zn(q),.a(sn),.b(qn));
   nand3 U_NAND3(.zn(qn),.a(rn),.b(q),.c(rstn));



endmodule // rs_latch


module latch (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   en, i, rstn
   );
   input en;
   input i;
   input rstn;
   output q;
   reg    q;

   always @* begin
      if(rstn == 1'b0)
        q <= 0;
      else
        if(en)
          q <= i;

   end
endmodule // latch
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
