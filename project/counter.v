module counter (clk, resetn, enable, erase, color, x, y, plot, done);
input clk, resetn, enable, erase;
output reg plot;
output reg [7:0]x;
output reg [6:0]y;
wire [7:0] addr;
wire [2:0] color_out;
output reg [2:0] color;
output reg done;

parameter width = 10, height = 10;

always @ (posedge clk or negedge resetn)
begin
	if (!resetn)
	begin
		x <= 0;
		y <= 0;
		plot <= 0;
		color <= 3'b000;
		done <= 0;
	end
	else if (!enable)
	begin
		x <= x;
		y <= y;
		plot <= 0;
		color <= 3'b000;
		done <= 0;
	end
	else
	begin
		if (erase)
		begin
			if (y < height)
			begin
				if (x < width)
				begin
					x <= x + 1;
					y <= y;
					plot <= 1;
					done <= 0;
					color <= 3'b000;
				end
				else
				begin
					x <= 0;
					y <= y + 1;
					plot <= 1;
					done <= 0;
					color <= 3'b000;
				end
			end
			else
			begin
				x <= 0;
				y <= 0;
				plot <= 0;
				color <= color;
				done <= 1;
			end
		end
		else
		begin
			if (y < height)
			begin
				if (x < width)
				begin
					x <= x + 1;
					y <= y;
					plot <= 1;
					done <=0;
					color <= 3'b011;
				end
				else
				begin
					x <= 0;
					y <= y + 1;
					plot <= 1;
					done <= 0;
					color <= 3'b011;
				end
			end
			else
			begin
				x <= 0;
				y <= 0;
				plot <= 0;
				color <= color;
				done <= 1;
			end
		end
	end
end
	/*assign addr = y * 16 + x;
	
	lpm_ram_dq1	lpm_ram_dq1_inst (
	.address ( addr ),
	.clock ( clk ),
	.data ( 3'b000 ),
	.wren ( 0 ),
	.q ( color_out ));*/

	
endmodule

