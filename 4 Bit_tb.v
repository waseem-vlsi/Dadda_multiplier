module Dadda_4X4_tb( );
reg [3:0]A,B;
wire [7:0]out;
 dadda_4X4 dut(.A(A), .B(B), .out(out));
 initial 
 begin 
 A = 4'b1010; B = 4'b1111;
 #20 A = 4'b1101; B = 4'b1010;
 #20 A = 4'b1111; B = 4'b1111;
 #20 $finish;
 end  
 initial 
 begin 
 $monitor("time = %0t A = %b B = %b out = %b", $time, A,B,out);
 end 
endmodule
