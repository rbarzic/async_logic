`timescale 1ns/1ps

module mutex_tb;
    reg r0;
    reg r1;
    wire q0;
    wire q1;

    // Device under test
    mutex dut (
        .r0(r0),
        .r1(r1),
        .q0(q0),
        .q1(q1)
    );

`ifdef VCD
    initial begin
        $dumpfile("mutex_tb.vcd");
        $dumpvars(0, mutex_tb);
    end
`endif

    initial begin
        $display("%0t: Starting mutex arbitration demo", $time);
        $display("%7s %4s %4s", "time", "r0", "r1");
        $monitor("%0t: r0=%0b r1=%0b | q0=%0b q1=%0b", $time, r0, r1, q0, q1);

        r0 = 0;
        r1 = 0;
        #5;

        $display("\nSingle request on r0");
        r0 = 1;
        #10;
        r0 = 0;
        #10;

        $display("\nSingle request on r1");
        r1 = 1;
        #10;
        r1 = 0;
        #10;

        $display("\nSimultaneous requests (expect one grant)");
        r0 = 1;
        r1 = 1;
        #20;
        r0 = 0;
        r1 = 0;
        #10;

        $display("\nStaggered arrival: r0 holds grant, r1 waits");
        r0 = 1;
        #10;
        r1 = 1;
        #20;
        r0 = 0;
        #10;
        r1 = 0;
        #10;

        $display("\nAlternating requests");
        repeat (4) begin
            r0 = 1;
            #5;
            r0 = 0;
            r1 = 1;
            #5;
            r1 = 0;
            #5;
        end

        $display("\nEnd of stimulus");
        #10;
        $finish;
    end
endmodule
