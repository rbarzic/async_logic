//   Project     : async
//   File        : p4r2_and2.v
//   Description : 4-phase dual-rail 2-input AND gate
//   Copyright 2009 Ronan BARZIC

module  p4r2_and2(/*AUTOARG*/
  // Outputs
  y,
  // Inputs
  a, b, rstn
  );
  input [1:0] a;
  input [1:0] b;
  input rstn;

  output [1:0] y;

  // d.f : 0
  // d.t : 1

  wire          wc00,wc01,c10,c11;
  
/*AUTOINPUT*/
/*AUTOOUTPUT*/
/*AUTOWIRE*/
  
  cmuller C00(
              .rstn(rstn),
              .a(a[0]),
              .b(b[0]),
              .c(wc00));


  cmuller C01(
              .rstn(rstn),
              .a(a[1]),
              .b(b[0]),
              .c(wc01));
  
  cmuller C10(
              .rstn(rstn),
              .a(a[0]),
              .b(b[1]),
              .c(wc10));
  cmuller C11(
              .rstn(rstn),
              .a(a[1]),
              .b(b[1]),
              .c(wc11));

  assign y[0] = wc00 | wc01 | wc10;
  assign y[1] = wc11;
  
              
endmodule