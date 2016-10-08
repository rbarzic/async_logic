// From :
// How to Synchronize a Pausible Clock to a Reference
//  Robert Najvirt and Andreas Steininger
//    Vienna University of Technology
//      1040 Vienna, Austria
//        {rnajvirt, steininger}@ecs.tuwien.ac.at

module pausible_clock_sync (/*AUTOARG*/
   // Outputs
   grant, clock,
   // Inputs
   req, ext_ref_clk, rstn
   );
  input req;
  output grant;
  output clock;

   input ext_ref_clk;

  input  rstn;

  parameter DELAY=10;

  /*AUTOINPUT*/
  /*AUTOOUTPUT*/

  /*AUTOREG*/
  /*AUTOWIRE*/

   wire  clock;
   wire  grant;
   wire                 sync;

  inv U_INV1(.i(clock),.zn(clock_n));

  delay #(.DELAY(DELAY)) U_DELAY(.i(clock_n),.d(clock_d_n));


  // muller2 U_MULLER_1(.a(clock_n_grant),.b(clock_d_n),.rstn(rstn),.z(clock));
  muller3 U_MULLER_1(.a(clock_n_grant),.b(clock_d_n), .c(sync), .rstn(rstn),.z(clock));
  muller2 U_MULLER_2(.a(ext_ref_clk),.b(clock_n),.rstn(rstn),.z(sync));

  mutex U_MUTEX(
                .r1(req),
                .r2(clock_n),
                .g1(grant),
                .g2(clock_n_grant)
                );



endmodule // pausible_clock_sync
/*
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
