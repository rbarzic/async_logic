// Conditional fork (2 channels)



module fork_cond2_r1_2ph (/*AUTOARG*/
   // Outputs
   a, r1, r2,
   // Inputs
   r, a1, cond1, a2, cond2, rstn
   );
   parameter WIDTH = 8;

   input r;
   output a;

   output  r1;
   input a1;
   input cond1; // =0 , req is not propagated, = 1 : reg is propagated

   output r2;
   input  a2;
   input  cond2; // =0 , req is not propagated, = 1 : reg is propagated

   input               rstn;



   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   wire                 false1, false2;
   wire                 r1,r2;
   wire                 a;

   select U_SELECT1_OUT(
                    .in(r),
                    .sel(cond1),
                    .false(false1),
                    .true(r1),
                    .rstn(rstn)
                    );
   mux2 U_MUX1_IN(
                        .a0(false1),
                        .a1(a1),
                        .s(cond1),
                        .z(a1mux)
                        );


   select U_SELECT2_OUT(
                        .in(r),
                        .sel(cond2),
                        .false(false2),
                        .true(r2),
                        .rstn(rstn)
                        );
   mux2 U_MUX2_IN(
                  .a0(false2),
                  .a1(a2),
                  .s(cond2),
                  .z(a2mux)
                  );


   muller3 U_MULLER3(
                     .a(r),
                     .b(a1mux),
                     .c(a2mux),
                     .z(a),
                     .rstn(rstn)
                     );



endmodule // selector_r1_2ph
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
