// Cross-coupled-NAND MUTEX (primitive-only)
module mutex (
    input  r0,
    input  r1,
    output q0,
    output q1
);

    supply1 VDD;
    supply0 VSS;

    // Cross-coupled NAND outputs
    wire pre0, pre1;

    // Final latch/drive nodes after the inverter pair
    wire n0, n1;

    // 1) Cross-coupled NANDs
    nand g0(pre0, r0, pre1);  // pre0 depends on r0 and the OTHER side (pre1)
    nand g1(pre1, r1, pre0);  // pre1 depends on r1 and pre0

    // 2) Two CMOS inverters (the 4 transistors seen in the drawing)
    pmos p0(n0, VDD, pre0);
    nmos n0_(n0, VSS, pre0);

    pmos p1(n1, VDD, pre1);
    nmos n1_(n1, VSS, pre1);

    // 3) Outputs
    buf b0(q0, n0);
    buf b1(q1, n1);

endmodule
