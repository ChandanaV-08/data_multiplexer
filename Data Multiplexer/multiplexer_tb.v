



`timescale 1ns / 1ps // Set the timescale

module data_multiplexer_tb;

    // Parameters
    parameter CLK_PERIOD = 10;         // Clock period in ns
    parameter SIM_TIME = 500;          // Simulation time in ns

    // Signals
    reg clk = 0;                       // Internal clock signal
    reg symbol_clk = 0;                // External symbol clock
    reg [1:0] switch_clk_cycles;       // Switch clock cycles
    reg [2:0] DS1, DS2, DS3;           // Input data streams
    reg [1:0] mode;                    // Mode input
    wire [2:0] multiplexed_data;       // Output multiplexed data

    // Instantiate the module
    data_multiplexer dut(
        .clk(clk),
        .symbol_clk(symbol_clk),
        .switch_clk_cycles(switch_clk_cycles),
        .DS1(DS1),
        .DS2(DS2),
        .DS3(DS3),
        .mode(mode),
        .multiplexed_data(multiplexed_data)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk <= ~clk;
    always #(CLK_PERIOD) symbol_clk <= ~symbol_clk;

    // Test scenario
    initial begin
        // Initialize inputs
        switch_clk_cycles = 6;
        DS1 = 3'b101;   // data
        DS2 = 3'b110;   // data
        DS3 = 3'b111;   // data
        mode = 1;       // Mode 1
        
        #SIM_TIME;
        
        //Mode 2 DS1 half DS2 half
        switch_clk_cycles = 3;
        mode = 2;
        
        #SIM_TIME;

	//Mode 3 DS1, DS2, DS3
	switch_clk_cycles = 2;
	mode = 3;
	
	#SIM_TIME;
 
//        #5 switch_clk_cycles = 3;
 

        // Run simulation
        $finish;
    end

endmodule

