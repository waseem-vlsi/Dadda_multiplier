
module Dadda_16X16_tb();
reg [15:0]A,B;
reg Cin;
wire [31:0]result;
Dadda_16X16 dut(.A(A), .B(B), .Cin(Cin), .result(result));
initial 
begin 
A = 16'd55; B = 16'd10; Cin = 1'b0;
#10 A = 16'b1111111111111111; B = 16'b1111111111111111; Cin = 1'b0;
#10 $finish;
end
initial
begin 
$display("$time = %0t, A = %d, B = %d", $time, A,B);
 end
endmodule
