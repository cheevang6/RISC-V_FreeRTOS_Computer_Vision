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
	//output ready,
	output reg done,
	input mid_pulse,
	output reg siod_o_en
	//input sccb_clk
);

localparam	ST_INIT			= 7'd0;
localparam	ST_START_W		= 7'd1;
localparam	ST_IPADDR_W		= 7'd2;
localparam	ST_RW_WRITE		= 7'd3;
localparam	ST_IPADDR_W_DC	= 7'd4;
localparam	ST_SUBADDR		= 7'd5;
localparam	ST_SUBADDR_DC	= 7'd6;
localparam	ST_WDATA		= 7'd7;
localparam	ST_WDATA_DC 	= 7'd8;
localparam	ST_STOP_2W_L	= 7'd9;
localparam	ST_STOP_2W_H	= 7'd10;
localparam	ST_START_R		= 7'd11;
localparam	ST_IPADDR_R		= 7'd12;
localparam	ST_RW_READ		= 7'd13;
localparam	ST_IPADDR_R_DC	= 7'd14;
localparam	ST_RDATA		= 7'd15;
localparam	ST_RDATA_NA		= 7'd16;
localparam	ST_STOP_3W2R_L	= 7'd17;
localparam	ST_STOP_3W2R_H	= 7'd18;
localparam	ST_DONE			= 7'd19;
			
reg [7:0] state;
reg [4:0] count;
reg sioc_en = 0;

reg [6:0] ip_addr_saved;
reg [7:0] sub_addr_saved;
reg [7:0] data_in_saved;
reg rw_saved;

assign pwdn = 0;
assign sioc = (sioc_en)? ~clk : 1;
//assign ready = (resetn && (state == ST_INIT))? 1 : 0;

// sioc block
always @(negedge clk) begin
	if(!resetn) begin
		sioc_en <= 0;
	end else begin
		if((state > ST_START_W && state <= ST_STOP_2W_L) ||
           (state > ST_START_R && state <= ST_STOP_3W2R_L)) begin
			sioc_en <= 1;
		end else begin
			sioc_en <= 0;
		end
	end
end

// siod_o block
always @(posedge mid_pulse) begin
	if(!resetn) begin
		state = ST_INIT;
		siod_o = 1;
		count = 0;
		data_out = 0;
		done = 0;
        ip_addr_saved = 0;
        sub_addr_saved = 0;
        data_in_saved = 0;
        rw_saved = 0;
	end else begin
        siod_o_en = (state == ST_IPADDR_W_DC || state == ST_SUBADDR_DC ||
					state == ST_WDATA_DC || state == ST_IPADDR_R_DC ||
					state == ST_RDATA)? 0 : 1;
        if(start && !done) begin
            case(state)
                ST_INIT : begin
                        siod_o = 1;
                        state = ST_START_W;
                        ip_addr_saved = ip_addr;
                        sub_addr_saved = sub_addr;
                        data_in_saved = data_in;
                        rw_saved = rw;
                    end
                ST_START_W : begin
                        siod_o = 0;
                        count = 6;
                        state = ST_IPADDR_W;
                    end
                ST_IPADDR_W : begin
                        siod_o = ip_addr_saved[count];
                        if(count == 0) state = ST_RW_WRITE;
                        else count = count - 1;
                    end
                ST_RW_WRITE : begin
                        siod_o = 0; // RW = 1 (RWrite)
                        state = ST_IPADDR_W_DC;
                    end
                ST_IPADDR_W_DC : begin
                        siod_o = 1'bz;
                        count = 7;
                        state = ST_SUBADDR;
                    end
                ST_SUBADDR : begin
                        siod_o = sub_addr_saved[count];
                        if(count == 0) state = ST_SUBADDR_DC;
                        else count = count - 1;
                    end
                ST_SUBADDR_DC : begin
                        siod_o = 1'bz;
                        count = 7;
                        if(!rw_saved) state = ST_WDATA;
                        else state = ST_STOP_2W_L;
                    end
                ST_WDATA : begin
                        siod_o = data_in_saved[count];
                        if(count == 0) state = ST_WDATA_DC;
                        else count = count - 1;
                    end
                ST_WDATA_DC : begin
                        siod_o = 1'bz;
                        state = ST_STOP_3W2R_L;
                    end
                ST_STOP_2W_L : begin // stop for 2-phase write
                        siod_o = 0;
                        state = ST_STOP_2W_H;
                    end
                ST_STOP_2W_H : begin // stop for 2-phase write
                        siod_o = 1;
                        state = ST_START_R;
                    end
                ST_START_R : begin
                        siod_o = 0;
                        count = 6;
                        state = ST_IPADDR_R;
                    end
                ST_IPADDR_R : begin
                        siod_o = ip_addr_saved[count];
                        if(count == 0) state = ST_RW_READ;
                        else count = count - 1;
                    end
                ST_RW_READ : begin
                        siod_o = 1; // RW = 1 (Read)
                        state = ST_IPADDR_R_DC;
                    end
                ST_IPADDR_R_DC : begin
                        siod_o = 1'bz;
                        count = 7;
                        state = ST_RDATA;
                    end
                ST_RDATA : begin
                        data_out[count] = siod_i;
                        if(count == 0) state = ST_RDATA_NA;
                        else count = count - 1;
                    end
                ST_RDATA_NA : begin
                        siod_o = 1'b1;
                        state = ST_STOP_3W2R_L;
                    end
                ST_STOP_3W2R_L : begin // stop for 3-phase write and 2-phase read
                        siod_o = 0;
                        state = ST_STOP_3W2R_H;
                    end
                ST_STOP_3W2R_H : begin // stop for 3-phase write and 2-phase read
                        siod_o = 1;
                        state = ST_DONE;
                    end
                ST_DONE : begin
                        siod_o = 1;
                        done = 1;
                        //if(!start) state <= ST_INIT;
                        //else state <= ST_DONE;
                        state = ST_INIT;
                    end
                default : begin
                        siod_o = 1;
                        state = ST_INIT;
                    end
            endcase
        end else begin            
            state = ST_INIT;
            siod_o = 1;
            count = 0;
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