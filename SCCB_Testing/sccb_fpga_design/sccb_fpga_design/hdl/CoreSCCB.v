// CoreSCCB.v
module CoreSCCB (
	input clk,
	input resetn,
	output pwdn,
	input start,
	input rw,
	input [6:0] ip_addr,
	input [7:0] sub_addr,
	input [7:0] data_in,
	output reg [7:0] data_out,
	output sioc,
	input siod_i,
	output reg siod_o,
	output reg done,
	input mid_pulse,
	output reg siod_o_en
	//input sccb_clk
);

localparam  WAIT        = 7'd0,
            INIT		= 7'd1,
        	START_W		= 7'd2,
        	IPADDR_W	= 7'd3,
        	RW_WRITE	= 7'd4,
        	IPADDR_W_DC	= 7'd5,
        	SUBADDR		= 7'd6,
        	SUBADDR_DC	= 7'd7,
        	WDATA		= 7'd8,
        	WDATA_DC 	= 7'd9,
        	STOP_2W_L	= 7'd10,
        	STOP_2W_H	= 7'd11,
            WAIT2       = 7'd12,
        	START_R		= 7'd13,
        	IPADDR_R	= 7'd14,
            RW_READ		= 7'd15,
            IPADDR_R_DC	= 7'd16,
            RDATA		= 7'd17,
            RDATA_NA	= 7'd18,
            STOP_3W2R_L	= 7'd19,
            STOP_3W2R_H	= 7'd20,
            DONE		= 7'd21;

			
reg [7:0] state;
reg [4:0] count_index;
reg sioc_en = 0;

reg [6:0] ip_addr_saved;
reg [7:0] sub_addr_saved;
reg [7:0] data_in_saved;
reg rw_saved;
reg [15:0] count_delay = 0;

// wait for 300 ms
// 10
localparam DELAY    = 10;


assign pwdn = 0;
assign sioc = (sioc_en)? ~clk : 1;

// siod_o: open drain
//  - 1: input or Z
//  - 0: output or pulled to ground
assign siod_o = siod_o_en;


// sioc block
always @(negedge clk) begin
	if(!resetn) begin
		sioc_en <= 0;
	end else begin
		if((state > START_W && state <= STOP_2W_L) ||
           (state > START_R && state <= STOP_3W2R_L)) begin
			sioc_en <= 1;
		end else begin
			sioc_en <= 0;
		end
	end
end

// siod_o block
always @(posedge clk) begin
	if(!resetn) begin
		state = WAIT;
		siod_o_en = 1;
		count_index = 0;
		data_out = 0;
		done = 0;
        ip_addr_saved = 0;
        sub_addr_saved = 0;
        data_in_saved = 0;
        rw_saved = 0;
        count_delay = 0;
	end else begin
        //siod_o_en = (state == IPADDR_W_DC || state == SUBADDR_DC ||
		//			state == WDATA_DC || state == IPADDR_R_DC ||
		//			state == RDATA)? 0 : 1;
        if(start && !done) begin
            case(state)
                WAIT : begin
                        siod_o_en = 1;
                        state = WAIT;
                        if(count_delay < DELAY-1)
                            count_delay = count_delay + 1;
                        else begin
                            count_delay = 0;
                            state = INIT;
                        end
                    end
                INIT : begin
                        siod_o_en = 1;
                        state = START_W;
                        ip_addr_saved = ip_addr;
                        sub_addr_saved = sub_addr;
                        data_in_saved = data_in;
                        rw_saved = rw;
                    end
                START_W : begin
                        siod_o_en = 0;
                        count_index = 6;
                        state = IPADDR_W;
                    end
                IPADDR_W : begin
                        siod_o_en = ip_addr_saved[count_index];
                        if(count_index == 0) state = RW_WRITE;
                        else count_index = count_index - 1;
                    end
                RW_WRITE : begin
                        siod_o_en = 0; // RW = 0 (Write)
                        state = IPADDR_W_DC;
                        count_delay = 0;
                    end
                IPADDR_W_DC : begin
                        siod_o_en = 1;
                        count_index = 7;
                        state = SUBADDR;
                    end
                SUBADDR : begin
                        siod_o_en = sub_addr_saved[count_index];
                        if(count_index == 0) state = SUBADDR_DC;
                        else count_index = count_index - 1;
                    end
                SUBADDR_DC : begin
                        siod_o_en = 1;
                        count_index = 7;
                        if(!rw_saved) state = WDATA;
                        else state = STOP_2W_L;
                    end
                WDATA : begin
                        siod_o_en = data_in_saved[count_index];
                        if(count_index == 0) state = WDATA_DC;
                        else count_index = count_index - 1;
                    end
                WDATA_DC : begin
                        siod_o_en = 1;
                        state = STOP_3W2R_L;
                    end
                STOP_2W_L : begin // stop for 2-phase write
                        siod_o_en = 0;
                        state = STOP_2W_H;
                    end
                STOP_2W_H : begin // stop for 2-phase write
                        siod_o_en = 1;
                        count_delay = 0;
                        state = WAIT2;
                    end
                WAIT2 : begin
                        siod_o_en = 1;
                        state = WAIT2;
                        if(count_delay < DELAY-1)
                            count_delay = count_delay + 1;
                        else begin
                            count_delay = 0;
                            state = START_R;
                        end
                    end
                START_R : begin
                        siod_o_en = 0;
                        count_index = 6;
                        state = IPADDR_R;
                    end
                IPADDR_R : begin
                        siod_o_en = ip_addr_saved[count_index];
                        if(count_index == 0) state = RW_READ;
                        else count_index = count_index - 1;
                    end
                RW_READ : begin
                        siod_o_en = 1; // RW = 1 (Read)
                        state = IPADDR_R_DC;
                    end
                IPADDR_R_DC : begin
                        siod_o_en = 1;
                        count_index = 7;
                        state = RDATA;
                    end
                RDATA : begin
                        data_out[count_index] = siod_i;
                        siod_o_en = 1;
                        if(count_index == 0) state = RDATA_NA;
                        else count_index = count_index - 1;
                    end
                RDATA_NA : begin
                        siod_o_en = 1'b1;
                        state = STOP_3W2R_L;
                    end
                STOP_3W2R_L : begin // stop for 3-phase write and 2-phase read
                        siod_o_en = 0;
                        state = STOP_3W2R_H;
                    end
                STOP_3W2R_H : begin // stop for 3-phase write and 2-phase read
                        siod_o_en = 1;
                        state = DONE;
                    end
                DONE : begin
                        siod_o_en = 1;
                        done = 1;
                        state = WAIT;
                    end
                default : begin
                        siod_o_en = 1;
                        state = WAIT;
                    end
            endcase
        end else begin            
            state = WAIT;
            siod_o_en = 1;
            count_index = 0;
            data_out = data_out;
            done = 0;
            ip_addr_saved = 0;
            sub_addr_saved = 0;
            data_in_saved = 0;
            rw_saved = 0;
        end
	end
end

endmodule