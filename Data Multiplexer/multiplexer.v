
module data_multiplexer(
    input wire clk,							// Internal clock signal operating at 100MHz
    input wire symbol_clk,       			// External symbol_clock
    input wire [1:0] switch_clk_cycles, 	// after what number of clk cycles to switch data 
    input wire [2:0] DS1, DS2, DS3,    		// data inputs
    input wire [1:0] mode,       			// modes of operation
    output reg [2:0] multiplexed_data 		// multiplexed data output
						);


reg [1:0] count;                // temp Counter for of clock cycles
reg [2:0] data_out;             // temp reg to store Output

always @(posedge clk) 
begin
    // Increment counter
    count <= count + 1;

    // Check if time to switch data based on switch_clk_cycles
    if (count == switch_clk_cycles)
	begin
        count <= 0;  
    end
end

always @(posedge symbol_clk) 
begin
    // Output multiplexed data synchronized with symbol_clk
    multiplexed_data <= {DS1,DS1,DS1};
    
    //output multiplexed data sync
    case(mode)
            1: multiplexed_data <= {DS1, DS1, DS1}; // Mode 1: DS1 repeated
            2: multiplexed_data <= {DS1, DS2, DS1}; // Mode 2: DS1 for half, DS2 for half
            3: multiplexed_data <= {DS1, DS2, DS3}; // Mode 3: DS1, DS2, DS3 for each third
            //default: data_out <= {DS1, DS1, DS1}; // Default to mode 1
        endcase
    
end

endmodule



