module PP_gen #(
parameter N = 3 )
(
input [N:0]A,B,
output  [((N+1)*(N+1))-1:0]Y );

genvar i,j;
generate
for(i = 0; i<4; i =  i+1)
begin
for(j = 0; j<4; j =  j+1)
begin
assign Y[4*i + j] = A[i] & B[j];
end
end
endgenerate
endmodule


module Half_Adder(
    input a, b,
    output sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule

// Full Adder
module Full_Adder(
    input a, b, cin,
    output sum, carry
);
    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule


module RCA_6bit(
    input  [6:0] A, B,
    input  cin,
    output [6:0] SUM,
    output cout
);
    wire [5:0] c;  

    Full_Adder fa0 (.a(A[0]), .b(B[0]), .cin(cin),    .sum(SUM[0]), .carry(c[0]));
    Full_Adder fa1 (.a(A[1]), .b(B[1]), .cin(c[0]),   .sum(SUM[1]), .carry(c[1]));
    Full_Adder fa2 (.a(A[2]), .b(B[2]), .cin(c[1]),   .sum(SUM[2]), .carry(c[2]));
    Full_Adder fa3 (.a(A[3]), .b(B[3]), .cin(c[2]),   .sum(SUM[3]), .carry(c[3]));
    Full_Adder fa4 (.a(A[4]), .b(B[4]), .cin(c[3]),   .sum(SUM[4]), .carry(c[4]));
    Full_Adder fa5 (.a(A[5]), .b(B[5]), .cin(c[4]),   .sum(SUM[5]), .carry(c[5]));
    Full_Adder fa6 (.a(A[6]), .b(B[6]), .cin(c[5]),   .sum(SUM[6]), .carry(cout));
endmodule


// MAIN MODULE
module dadda_4X4(
input [3:0]A,B,
output [7:0]out);
wire [15:0]Y;
wire a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30;
PP_gen a9(.A(A), .B(B), .Y(Y));
 Half_Adder a1(.a(Y[3]), .b(Y[6]), .sum(a17), .carry(a18)); 
 Half_Adder a2(.a(Y[7]), .b(Y[10]), .sum(a19), .carry(a20));
 Half_Adder a3(.a(Y[1]), .b(Y[4]), .sum(a21), .carry(a23));
 Full_Adder a4(.a(Y[2]), .b(Y[5]), .cin(Y[8]), .sum(a22), .carry(a25));
 Full_Adder a5(.a(a17), .b(Y[9]), .cin(Y[12]), .sum(a24), .carry(a27));
 Full_Adder a6(.a(a19), .b(a18), .cin(Y[13]), .sum(a26), .carry(a29));
 Full_Adder a7(.a(Y[11]), .b(a20), .cin(Y[14]), .sum(a28), .carry(a30));
 RCA_6bit a8(
   .A({a30,a28,a26,a24,a22,a21,Y[0]}),  
    .B({Y[15],a29,a27,a25,a23,2'b00}),
    .cin(1'b0),          
    .SUM(out[6:0]),
    .cout(out[7])         
 );
endmodule

