module war_top 
(
	input wire clk,reset, shoot,
	input wire hsync, vsync,
	output wire [2:0] rgb
);

// signal declaration
wire[9:0] pixel_x, pixel_y;
wire video_on, pixel_tick;
reg [2:0] rgb_reg;
wire [2:0] rgb_next;

// INSTANTIATE

vga_sync vsync_unit
		(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), 
	.video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));
	
// graphics generator

war_graph war_grf_unit 
	( .video_on(video_on), .shoot(shoot), .pix_x(pix_x), .pix_y(pix_y), .graph_rgb(rgb_next),
		.count2(), .count1(), .x(), .y());
	
// rgb buffer

always@(posedge clk)
	if (pixel_tick)
		rgb_reg <= rgb_next;
		
assign rgb= rgb_reg;

endmodule
