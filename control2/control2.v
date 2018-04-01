module control2(go, restn, clock,ld_pos1, ld_pos2, ld_pos3, ld_pos4, ld_pos5, ld_pos6, ld_pos7, ld_pos8, ld_pos9) ;
    input go, restn;
	 input clock;
    output reg ld_pos1, ld_pos2, ld_pos3, ld_pos4, ld_pos5, ld_pos6, ld_pos7, ld_pos8, ld_pos9;

    reg[4:0] current_state, next_state;

    localparam  load_pos1 = 5'd0,
    			load_pos1_wait = 5'd1,
    			load_pos2 = 5'd2,
    			load_pos2_wait = 5'd3,
    			load_pos3 = 5'd4,
    			load_pos3_wait = 5'd5,
    			load_pos4 = 5'd6,
    			load_pos4_wait = 5'd7,
    			load_pos5 = 5'd8,
    			load_pos5_wait = 5'd9,
    			load_pos6 = 5'd10,
    			load_pos6_wait  = 5'd11,
    			load_pos7 = 5'd12,
    			load_pos7_wait = 5'd13,
    			load_pos8 = 5'd14,
    			load_pos8_wait = 5'd15,
    			load_pos9 = 5'd16,
    			load_pos9_wait = 5'd17;
				
		rate_counter1 m1(clock,reset_n,1'b1,q);
		assign clock_1 = (q==  5'b00000) ? 1 : 0;

    always @(*)
    begin: state_table
        case (current_state)
            // state 1, position 1
            load_pos1: next_state = go ? load_pos1_wait : load_pos1;
            load_pos1_wait: next_state = go ? load_pos1_wait : load_pos2;

            //state2, pos2
            load_pos2: next_state = go ? load_pos2_wait : load_pos2;
            load_pos2_wait: next_state = go ? load_pos2_wait : load_pos3;

			   // state3, pos3 
            load_pos3: next_state = go ? load_pos3_wait : load_pos3;
            load_pos3_wait: next_state = go? load_pos3_wait: load_pos4;

            //state4, pos4
            load_pos4: next_state = go ? load_pos4_wait : load_pos4;
            load_pos4_wait: next_state = go ? load_pos4_wait : load_pos5;

            //state5, pos5
            load_pos5: next_state = go ? load_pos5_wait : load_pos5;
            load_pos5_wait : next_state = go ? load_pos5_wait : load_pos6;

            // state6, pos6
            load_pos6: next_state = go ? load_pos6_wait : load_pos6;
            load_pos6_wait: next_state = go ? load_pos6_wait : load_pos7;

            // state7, pos7
            load_pos7: next_state = go ? load_pos7_wait : load_pos7;
            load_pos7_wait: next_state = go ? load_pos7_wait : load_pos8;

            // state8, pos8
            load_pos8: next_state = go ? load_pos8_wait : load_pos8;
            load_pos8_wait: next_state = go ? load_pos8_wait : load_pos9;

            // state9, pos9

            load_pos9: next_state = go ? load_pos9_wait : load_pos9;
            load_pos9_wait: next_state = go ? load_pos9_wait : load_pos1;

        default: next_state = load_pos1;

        endcase
     end



     always @(*)
     begin: enable_signals
        // by default given all signal 0 
        ld_pos1 = 1'b0;
		  ld_pos2 = 1'b0;
		  ld_pos3 = 1'b0;
		  ld_pos4 = 1'b0;
		  ld_pos5 = 1'b0;
		  ld_pos6 = 1'b0;
		  ld_pos7 = 1'b0;
		  ld_pos8 = 1'b0;
		  ld_pos9 = 1'b0;

		  

        case(current_state)
        	load_pos1:begin
			    ld_pos1 = 1'b1;
			    end
			load_pos2:begin
				ld_pos2 = 1'b1;
				end
			load_pos3:begin
				ld_pos3 = 1'b1;
				end
			load_pos4:begin
				ld_pos4 = 1'b1;
				end
			load_pos5:begin
				ld_pos5 = 1'b1;
				end
			load_pos6:begin
				ld_pos6 = 1'b1;
				end
			load_pos7:begin
				ld_pos7 = 1'b1;
				end
			load_pos8:begin
				ld_pos8 = 1'b1;
				end
			load_pos9:begin
				ld_pos9 = 1'b1;
				end

        endcase 
     end
	
	 always@(posedge clock_1)
    begin: state_FFs
    	if(!reset_n)
            current_state <= load_pos1;
        else
            current_state <= next_state;
      end 
		
 endmodule
 
 
 module rate_counter1(clock,reset_n,enable,q);
		input clock;
		input reset_n;
		input enable;
		output reg [4:0] q;
		
		always @(posedge clock)
		begin
			if(reset_n == 1'b0)
				q <= 5'b10000;
			else if(enable ==1'b1)
			begin
			   if ( q == 5'b00000 )
					q <= 5'b10000;
				else
					q <= q - 1'b1;
			end
		end
endmodule


module datapath2(x1,x2,x3,x4,x5,x6,x7,x8,x9, 
					y1,y2,y3,y4,y5,y6,y7,y8,y9,
					c1,c2,c3,c4,c5,c6,c7,c8,c9,
					ld_pos1, ld_pos2, ld_pos3, ld_pos4, ld_pos5, ld_pos6, ld_pos7, ld_pos8, ld_pos9,
					clock, reset_n, enable,
					X, Y, Colour);
	input 			reset_n, enable, clock;
	input 			ld_pos1, ld_pos2, ld_pos3, ld_pos4, ld_pos5, ld_pos6, ld_pos7, ld_pos8, ld_pos9;
	
	input 	[8:0]x1,x2,x3,x4,x5,x6,x7,x8,x9;
	input   	[7:0]y1,y2,y3,y4,y5,y6,y7,y8,y9;
	input   	[2:0]c1,c2,c3,c4,c5,c6,c7,c8,c9;
	output 	[7:0] 	X;
	output 	[6:0] 	Y;
	output 	[2:0]	Colour;
	reg 		[7:0] X_temp;
	reg 		[6:0] Y_temp;
	reg		[2:0] Colour_temp;
	
//	wire [3:0] c1;
//	wire temp;
//	wire [3:0] Z;
//	
	always @ (posedge clock) 
	begin
        if (!reset_n) begin
            X_temp <= 8'd0; 
            Y_temp <= 7'd0;
				Colour_temp <= 3'd0;
        end
        else begin
            if (ld_pos1) begin
					 X_temp <= x1;
					 Y_temp <= y1;
					 Colour_temp <=c1;
				end
				if (ld_pos2) begin
					 X_temp <= x2;
					 Y_temp <= y2;
					 Colour_temp <=c2;
				end
				if (ld_pos3) begin
					 X_temp <= x3;
					 Y_temp <= y3;
					 Colour_temp <= c3;
				end
				if (ld_pos4) begin
					 X_temp <= x4;
					 Y_temp <=y4;
					 Colour_temp <= c4;
				end
				if (ld_pos5) begin
					 X_temp <=x5;
					 Y_temp <= y5;
					 Colour_temp <= c5;
				end
				if (ld_pos6) begin
					 X_temp <= x6;
					 Y_temp <= y6;
					 Colour_temp <= c6;
				end
				if (ld_pos7) begin
					 X_temp <= x7;
					 Y_temp <= y7;
					 Colour_temp <=c7;
				end
				if (ld_pos8) begin
					 X_temp <= x8;
					 Y_temp <= y8;
					 Colour_temp <= c8;
				end
				if (ld_pos9) begin
					 X_temp <= x9;
					 Y_temp <= y9;
					 Colour_temp <= c9;
				end	
		end		
				
    end
	 
	 assign X = X_temp;
	 assign Y = Y_temp;
	 assign Colour = Colour_temp;

endmodule
