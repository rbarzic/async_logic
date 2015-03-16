`define OVL_ASSERT_ON
`define OVL_INIT_MSG

`include "assert_always.vlib"

module four_phase_assertion(/*AUTOARG*/
   // Inputs
   req, ack, rstn
   );
   input req;
   input ack;
   input rstn;



   assert_always #(
                   `OVL_ERROR       , // severity_level
                   `OVL_ASSERT      , // property_type
                   "ack_is_zero_when_posedge_req", // msg
                   `OVL_COVER_NONE    // coverage_level
                   ) A1 (
                                    .clk       (req),
                                    .reset_n   (rstn),
                                    .test_expr (!ack)
                                    );

   assert_always #(
                   `OVL_ERROR       , // severity_level
                   `OVL_ASSERT      , // property_type
                   "ack_is_one_when_negedge_req", // msg
                   `OVL_COVER_NONE    // coverage_level
                   ) A2 (
                                    .clk       (~req),
                                    .reset_n   (rstn),
                                    .test_expr (ack)
                                    );


   assert_always #(
                   `OVL_ERROR       , // severity_level
                   `OVL_ASSERT      , // property_type
                   "req_is_one_when_posedge_ack", // msg
                   `OVL_COVER_NONE    // coverage_level
                   ) A3 (
                                    .clk       (ack),
                                    .reset_n   (rstn),
                                    .test_expr (req)
                                    );

   assert_always #(
                   `OVL_ERROR       , // severity_level
                   `OVL_ASSERT      , // property_type
                   "req_is_zero_when_negedge_ack", // msg
                   `OVL_COVER_NONE    // coverage_level
                   ) A4 (
                                    .clk       (~ack),
                                    .reset_n   (rstn),
                                    .test_expr (~req)
                                    );





endmodule // four_phase_asssertion
