// From Demystifying Data-driven and Pausible Clocking Schemes
// Robert Mullins and Simon Moore
// Computer Laboratory, University of Cambridge

module pausible_clock (/*AUTOARG*/
  // Outputs
  grant, clock,
  // Inputs
  req, rstn
  );
  input req;
  output grant;
  output clock;
  
  input  rstn;

  parameter DELAY=10;
  
  /*AUTOINPUT*/
  /*AUTOOUTPUT*/
  
  /*AUTOREG*/
  /*AUTOWIRE*/

  wire                  clock;
  wire                  grant;

  inv U_INV1(.i(clock),.zn(clock_n));

  delay #(.DELAY(DELAY)) U_DELAY(.i(clock),.d(clock_d));
  inv U_INV2(.i(clock_d),.zn(clock_d_n));
  
  muller2 U_MULLER_1(.a(clock_n_grant),.b(clock_d_n),.rstn(rstn),.z(clock));
  
  mutex U_MUTEX(
                .r1(req),
                .r2(clock_n),
                .g1(grant),
                .g2(clock_n_grant)
                );

  
  
endmodule // pausible_clock
/*  
 Local Variables:
 verilog-library-directories:(
 "."
 )
 End:
 */
