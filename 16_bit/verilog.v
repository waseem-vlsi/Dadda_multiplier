
// FULL ADDER
module Full_Adder(
    input a, b, cin,
    output sum, carry
);
    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule


// HALF_ADDER
module Half_Adder(
    input a, b,
    output sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule


// PARAMETIRIZED RCA
module Parameterized_RCA #(parameter N = 12) (      
    input [N-1:0]A,B,            
    input Cin,          
    output [N-1:0]Sum,              
    output Cout);

    wire [N:0] carry;                 
    assign carry[0] = Cin;
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : full_adder
            Full_Adder FA (.a(A[i]), .b(B[i]), .cin (carry[i]), .sum (Sum[i]), .carry(carry[i+1])
            );
        end
    endgenerate
    assign Cout = carry[N];
endmodule


// PP GENERATION
module PP_gen #(
parameter N = 3 )
(
input [N:0]A,B,
output  [((N+1)*(N+1))-1:0]Y );

genvar i,j;
generate
for(i = 0; i<(N+1); i =  i+1)
begin
for(j = 0; j<(N+1); j =  j+1)
begin
 assign Y[(i*(N+1)) + j] = A[i] & B[j];
end
end
endgenerate
endmodule



// 4X4 DADDA MULTIPLIER

module dadda_4X4(
input [3:0]A,B,
output [7:0]out);
wire [15:0]Y;
wire a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30;
 PP_gen #(.N(3)) a9(.A(A), .B(B), .Y(Y));
 Half_Adder a1(.a(Y[3]), .b(Y[6]), .sum(a17), .carry(a18)); 
 Half_Adder a2(.a(Y[7]), .b(Y[10]), .sum(a19), .carry(a20));
 Half_Adder a3(.a(Y[1]), .b(Y[4]), .sum(a21), .carry(a23));
 Full_Adder a4(.a(Y[2]), .b(Y[5]), .cin(Y[8]), .sum(a22), .carry(a25));
 Full_Adder a5(.a(a17), .b(Y[9]), .cin(Y[12]), .sum(a24), .carry(a27));
 Full_Adder a6(.a(a19), .b(a18), .cin(Y[13]), .sum(a26), .carry(a29));
 Full_Adder a7(.a(Y[11]), .b(a20), .cin(Y[14]), .sum(a28), .carry(a30));
Parameterized_RCA #(.N(7)) a8(
   .A({a30,a28,a26,a24,a22,a21,Y[0]}),  
    .B({Y[15],a29,a27,a25,a23,2'b00}),
    .Cin(1'b0),          
    .Sum(out[6:0]),
    .Cout(out[7])         
 );
endmodule


//8X8 DADDA MULTIPLIER
module Dadda_8X8(
input [7:0]A,B,
output [15:0]product);
wire [3:0] A_H = A[7:4];
wire [3:0] A_L = A[3:0];
wire [3:0] B_H = B[7:4];
wire [3:0] B_L = B[3:0];
wire [7:0] M0, M1, M2, M3;

dadda_4X4 A1 (.A(A_L), .B(B_L), .out(M0));
dadda_4X4 A2 (.A(A_H), .B(B_L), .out(M1));
dadda_4X4 A3 (.A(A_L), .B(B_H), .out(M2));
dadda_4X4 A4 (.A(A_H), .B(B_H), .out(M3));

assign product = (M3 << 8) + ((M1 + M2) << 4) + M0;

endmodule

// MAIN MODULE_16X16_DADDA
module Dadda_16X16(
input [15:0]A,B,
input Cin,
output [31:0]result);

wire [7:0] A_H = A[15:8];
wire [7:0] A_L = A[7:0];
wire [7:0] B_H = B[15:8];
wire [7:0] B_L = B[7:0];
wire [15:0] M0, M1, M2, M3;

Dadda_8X8 A1 (.A(A_L), .B(B_L), .product(M0));
Dadda_8X8 A2 (.A(A_H), .B(B_L), .product(M1));
Dadda_8X8 A3 (.A(A_L), .B(B_H), .product(M2));
Dadda_8X8 A4 (.A(A_H), .B(B_H), .product(M3));
assign result = (M3 << 16) + ((M1 + M2) << 8) + M0;
endmodule
