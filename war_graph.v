module war_graph 
(
	input wire video_on, shoot,
	input wire [9:0] pix_x, pix_y,
	output reg [2:0] graph_rgb,count2,
	output reg [8:0] count1,x,y
);

// 60 Hz clock for positioning
wire refer_tick;
assign refer_tick = (pix_y==481)&&(pix_x==0);

initial count1=0;
always@(posedge refer_tick)
	if(~shoot || (count1>0 && count1 <460)) 
		count1 = count1+1;
	else count1=0;
	
// general screen size
localparam MAX_X= 640; 
localparam MAX_Y= 480; // top to down

// tank
localparam TANK_SIZE= 20;
localparam TANK_X_L= MAX_X/2-TANK_SIZE/2;
localparam TANK_X_R= MAX_X/2+TANK_SIZE/2-1;

localparam TANK_Y_T= 467;
localparam TANK_Y_B= 470;

// square ball
localparam BALL_SIZE = 8;	
localparam BALL_X_L = MAX_X/2-BALL_SIZE/2;
localparam BALL_X_R = BALL_X_L + BALL_SIZE - 1 ;

localparam BALL_Y_T = 463;
localparam BALL_Y_B = 466;

wire ball_y_t,ball_y_b;
assign ball_y_t= BALL_Y_T-count1;
assign ball_y_b= BALL_Y_B-count1;

// enemy
initial count2=0;
initial x=MAX_X/2;
initial y=200;
always@(posedge refer_tick)
	begin	
		count2=count2+1;
	case(count2)
		0 : begin x= MAX_X/2; y= 200; end
		1 : begin x= MAX_X/2+25; y= 225; end
		2 : begin x= MAX_X/2+50; y= 250; end
		3 : begin x= MAX_X/2+25; y= 275; end
		4 : begin x= MAX_X/2; y= 300; end
		5 : begin x= MAX_X/2-25; y= 275; end
		6 : begin x= MAX_X/2-50; y= 250; end
		7 : begin x= MAX_X/2-25; y= 225; end
	endcase
end


// output signals for objects
wire tank_on, enemy_on,  sq_ball_on;
wire [2:0] tank_rgb, enemy_rgb, ball_rgb;

//body

// TANK
assign tank_on = (TANK_X_L<=pix_x)&&(pix_x<=TANK_X_R)&&(TANK_Y_T<=pix_y)&&(pix_y<=TANK_Y_B);
assign tank_rgb = 3'b010; //green


//BALL
assign sq_ball_on = (BALL_X_L<=pix_x)&&(pix_x<=BALL_X_R)&&(ball_y_t<=pix_y)&&(pix_y<=ball_y_b);
assign ball_rgb = 3'b100; //red

//ENEMY
assign enemy_on = ((x-10)<=pix_x)&&(pix_x<=(x+10))&&((y-10)<=pix_y)&&(pix_y<=(y+10));
assign enemy_rgb = 3'b110; //yellow

// rgb  multiplex

always@*
	if(~video_on)
		graph_rgb = 3'b000;
	else 
		if(tank_on)
		graph_rgb= tank_rgb;
	else if (sq_ball_on)
		graph_rgb= ball_rgb;
	else if (enemy_on)
		graph_rgb= enemy_rgb;
	else
		graph_rgb= 3'b001; //blue

endmodule 