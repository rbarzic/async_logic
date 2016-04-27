// An asynchronous generic memory wrapper around a synchronous memory

module async_mem (/*AUTOARG*/
   // Outputs
   ack, dout,
   // Inputs
   req, addr, din, we
   );

   parameter ACCESS_TIME = 10;

   parameter SIZE = 1024;
   parameter ADDR_WIDTH = 12;
   parameter filename = "code.hex";

   localparam COL_WIDTH = 8;
   localparam NB_COL = 4;

   localparam CLOCK_PULSE_WIDTH = 5;


   input req;
   output ack;

   input [ADDR_WIDTH-1:0] addr;                 // To U_SSRAM of bytewrite_ram_32bits.v
   input [NB_COL*COL_WIDTH-1:0] din;            // To U_SSRAM of bytewrite_ram_32bits.v
   input [NB_COL-1:0]   we;                     // To U_SSRAM of bytewrite_ram_32bits.v

   output [NB_COL*COL_WIDTH-1:0] dout;          // From U_SSRAM of bytewrite_ram_32bits.v


   /*AUTOINPUT*/
   /*AUTOOUTPUT*/

   /*AUTOREG*/
   /*AUTOWIRE*/

   // local clock
   wire                 ack_clk;

   wire                 ack;

   assign #1 clk = req ^ ack ;
   delay #(.DELAY(CLOCK_PULSE_WIDTH)) U_DELAY_CLOCK_PULSE(.i(req), .d(ack_clk));
   delay #(.DELAY(ACCESS_TIME))       U_DELAY_ACCESS_TIME(.i(req), .d(ack));


    /* bytewrite_ram_32bits AUTO_TEMPLATE(
     ); */
   bytewrite_ram_32bits #(
                          .SIZE(SIZE),
                          .ADDR_WIDTH(ADDR_WIDTH),
                          .filename(filename)
                          ) U_SSRAM (
                                     .clk               (clk),
                           /*AUTOINST*/
                                     // Outputs
                                     .dout              (dout[NB_COL*COL_WIDTH-1:0]),
                                     // Inputs
                                     .we                (we[NB_COL-1:0]),
                                     .addr              (addr[ADDR_WIDTH-1:0]),
                                     .din               (din[NB_COL*COL_WIDTH-1:0]));




endmodule // async_mem
/*
 Local Variables:
 verilog-library-directories:(
 "."
 "../../misc_lib"
 )
 End:
 */
