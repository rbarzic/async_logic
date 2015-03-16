// implementation of a toggle element
// See Micropipelines, 	I. E. Sutherland	Sutherland, Sproull, and Associates, Palo Alto, CA
// Published in:
// Communications of the ACM 
//      Volume 32 Issue 6, June 1989 
//        Pages 720-738 
//          ACM New York, NY, USA 
// For the implementation, see :
// The Design and Implementation of an Asynchronous Microprocessor
// PhD thesis by Nigel Charles Paver



module toggle(/*AUTOARG*/);
   input in;
   output dot;
   output blank;
   
   input  rstn;

   nand2 NAND2_B1(.a(n3),.b(n1),.zn(blank));
   nand3 NAND3_B1(.a(blank),.b(rstn),.c(in),.zn(n1));

   nand4 NAND4_B2(.a(n1),.b(rstn),.c(in),.d(n3),.zn(n2));
   nand2 NAND2_B2(.a(n2),.b(dot),.zn(n3));

   nand3 NAND3_B3(.a(rstn),.b(n1),.c(dot),.zn(n4));
   nand2 NAND2_B3(.a(n4),.b(n2),.zn(dot));
   

   
   

endmodule
