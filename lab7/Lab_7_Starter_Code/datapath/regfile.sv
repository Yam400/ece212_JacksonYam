//--------------------------------------------------------------
// datapath.sv - single-cycle MIPS datapath
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
//--------------------------------------------------------------

module regfile(
    input  logic        clk,
    input  logic        w_en,
    input  logic [4:0]  adr1, adr2, wadr3,
    input  logic [31:0] wd3,
    output logic [31:0] rd1, rd2
    );

    logic [31:0] rf[31:0];

    // MIPS style three-port register file
    // read two ports combinationally
    // write third port on rising edge of clock (CHANGE to falling edge for pipeline)
    // register 0 hardwired to 0

    always_ff @(posedge clk) begin
        if (w_en) rf[wadr3] <= wd3;
    end

    assign rd1 = (adr1 != 0) ? rf[adr1] : 0;
    assign rd2 = (adr2 != 0) ? rf[adr2] : 0;
endmodule
