module SCCB_slave(SIO_D, SIO_C, start, data_pulse);
input SIO_C;
input start, data_pulse;
inout SIO_D;

parameter	IDLE	= 3'b000,
			START	= 3'b001,
			DEVICE	= 3'b010,
			SUBADDR	= 3'b011,
			WRITE	= 3'b100,
			READ	= 3'b101,
			STOP	= 3'b110;
			
reg [2:0] state_cur;
reg [2:0] state_nxt;
reg idle =  1'b1;
reg data_out;
reg [2:0] i = 3'b111;
reg [7:0] device_addr, sub_addr;
reg [7:0] read_data = 8'h56;

assign SIO_D = (idle)? 1'bz : data_out;

always @(posedge data_pulse) begin
	state_cur <= state_nxt;
	if(state_cur < DEVICE) i <= 3'b111;
	else i <= i - 1;
end

always @(posedge data_pulse) begin
	case(state_cur)
		IDLE	: begin
				if(start) state_nxt <= START;
				else state_nxt <= IDLE;
			end
		START	: begin
				state_nxt <= DEVICE;
			end
		DEVICE	: begin
				if(i == 0) begin
					state_nxt <= SUBADDR;
				end else begin
					state_nxt <= DEVICE;
					device_addr[i] <= SIO_D;
				end
			end
		SUBADDR	: begin
				if(i == 0) begin
					if(!device_addr[0]) state_nxt <= WRITE;
					if(device_addr[0]) state_nxt <= READ;
				end else begin
					state_nxt <= SUBADDR;
					sub_addr[i] <= SIO_D;
				end
			end
		WRITE	: begin
				if(i == 0) begin
					state_nxt <= STOP;
					if(device_addr[0]) state_nxt <= READ;
				end else begin
					state_nxt = SUBADDR;
				end
			end
		READ	: begin
				if(i == 0) begin
					state_nxt <= STOP;
				end else begin
					data_out <= read_data[i];
				end
			end
		STOP	: begin
		
			end
		default	: begin
				state_nxt <= IDLE;
			end
	endcase
end

endmodule