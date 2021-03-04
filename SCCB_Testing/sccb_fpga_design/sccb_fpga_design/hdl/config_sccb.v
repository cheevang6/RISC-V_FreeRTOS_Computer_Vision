// config_sccb.v

module config_sccb(
    input PCLK,
    input PRESETN,
    output sioc,
    output siod,
    output cam_rstn,
    output cam_pwdn
);

reg         start;
reg         rw;
reg  [7:0]  data_in;
reg  [6:0]  id_addr;
reg  [7:0]  sub_addr;
wire [7:0]  data_out;
wire        done;
//wire        ready;

wire sccb_clk;
wire mid_pulse;

clock_divider #(.CLK_FREQ(10_000_000),.SCCB_CLK_FREQ(300_000)) sccb_clk_0(
	.clk(PCLK),
	.resetn(PRESETN),
	.sccb_clk(sccb_clk),
	.mid_pulse(mid_pulse)
);

CoreSCCB coresccb_0(
	.clk(sccb_clk),
	.resetn(PRESETN),
	.pwdn(pwdn),
	.start(start),
	.rw(rw),
	.id_addr(id_addr),
	.sub_addr(sub_addr),
	.data_in(data_in),
	.data_out(data_out),
	.sioc(sioc),
	.siod(siod),
	//.ready(ready),
	.done(done),
	.mid_pulse(mid_pulse),
    .cam_rstn(cam_rstn)
);

assign pwdn = 1'b0;
typedef enum {
    INIT_W,
    WRITE,
    INIT_R,
    READ,
    IDLE
} state_t;

state_t state;

always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin // RST is acitve-low
		id_addr <= 8'h00; // write for ov2640
        sub_addr <= 8'h00; // register bank select (default: 0x00)
        data_in <= 8'h00;
        start <= 1'b0;
        state <= INIT_W; //init_w;
	end else if(mid_pulse) begin
        //state <= idle;
        case(state)
        INIT_W : begin
                // SCCB IP address for ov7670 = 0x21
                id_addr <= 7'h21; // write for ov7670
                sub_addr <= 8'h12; // COMCTRL7 - SCCB Register Reset
                data_in <= 8'h80;
                rw <= 0;
                start <= 1'b0;
                //if(ready) 
                state <= WRITE;
            end
        WRITE : begin
                start <= 1'b1;
                if(done) begin
                    state <= INIT_R;
                end else begin
                    state <= WRITE;
                end
            end
        INIT_R : begin
                id_addr <= 7'h21; // read for ov7670
                sub_addr <= 8'h0a; // Product ID Number MSB (default 0x76)
                rw <= 1;
                start <= 1'b0;
                //if(ready) 
                state <= READ;
            end
        READ : begin
                start <= 1'b1;
                if(done) begin
                    start <= 1'b0;
                    state <= IDLE;
                end else begin
                    state <= READ;
                end
            end
        IDLE : begin
                start <= 1'b0;
            end
        default : begin
                start <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule