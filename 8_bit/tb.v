module dadda_8bit_structural_tb();
reg [7:0] A,B;
wire [15:0] P_sum;
wire [15:0] P_carry;
wire [15:0]product;
wire carry;
dadda_8bit_structural dut(.A(A), .B(B), .product(product), .P_sum(P_sum), .P_carry(P_carry), .carry(carry));
initial 
begin 
A = 8'd10; B = 8'd10;
#10 $finish;
end
endmodule
