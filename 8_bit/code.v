


module dadda_8bit_structural(input [7:0] A,B,output [15:0] P_sum,output [15:0] P_carry,output [15:0]product,output carry);
wire [7:0] pp_row [7:0];
wire [11:0]temp,x,y;
assign x=P_sum[15:4];
assign y=P_carry[15:4];
CSA_12bit dut1(x,y,1'b0,temp,carry);
assign product={temp,P_sum[3:0]};
//assign product=P_sum+P_carry;
genvar i,j;
generate
for(i=0;i<8;i=i+1)begin:gen_pp_row
for(j=0;j<8;j=j+1)begin:gen_pp_col
assign pp_row[i][j]=A[i]&B[j];
end
end
endgenerate

wire s1_s1[15:0],c1_s[15:0],s2_s1[15:0],c2_s[15:0],s3_s1[15:0],c3_s[15:0];
wire [8:0] col_in[15:0];
wire [15:0]temp1_2,temp1_1,temp1_3,temp1_4,temp2_1,temp2_2,temp2_3,temp3;

assign col_in[0]={7'b0,pp_row[0][0]};
assign col_in[1]={6'b0,pp_row[1][0],pp_row[0][1]};
assign col_in[2]={5'b0,pp_row[2][0],pp_row[1][1],pp_row[0][2]};
assign col_in[3]={4'b0,pp_row[3][0],pp_row[2][1],pp_row[1][2],pp_row[0][3]};
assign col_in[4]={3'b0,pp_row[4][0],pp_row[3][1],pp_row[2][2],pp_row[1][3],pp_row[0][4]};
assign col_in[5]={2'b0,pp_row[5][0],pp_row[4][1],pp_row[3][2],pp_row[2][3],pp_row[1][4],pp_row[0][5]};
assign col_in[6]={1'b0,pp_row[6][0],pp_row[5][1],pp_row[4][2],pp_row[3][3],pp_row[2][4],pp_row[1][5],pp_row[0][6]};
assign col_in[7]={pp_row[7][0],pp_row[6][1],pp_row[5][2],pp_row[4][3],pp_row[3][4],pp_row[2][5],pp_row[1][6],pp_row[0][7]};
assign col_in[8]={1'b0,pp_row[7][1],pp_row[6][2],pp_row[5][3],pp_row[4][4],pp_row[3][5],pp_row[2][6],pp_row[1][7]};
assign col_in[9]={2'b0,pp_row[7][2],pp_row[6][3],pp_row[5][4],pp_row[4][5],pp_row[3][6],pp_row[2][7]};
assign col_in[10]={3'b0,pp_row[7][3],pp_row[6][4],pp_row[5][5],pp_row[4][6],pp_row[3][7]};
assign col_in[11]={4'b0,pp_row[7][4],pp_row[6][5],pp_row[5][6],pp_row[4][7]};
assign col_in[12]={5'b0,pp_row[7][5],pp_row[6][6],pp_row[5][7]};
assign col_in[13]={6'b0,pp_row[7][6],pp_row[6][7]};
assign col_in[14]={7'b0,pp_row[7][7]};
assign col_in[15]={8'b0};


//stage 1
ha ha_s1_c11(col_in[1][1],col_in[1][0],s1_s1[1],c1_s[2]);
fa fa_s1_c12(col_in[2][2],col_in[2][1],col_in[2][0],s1_s1[2],c1_s[3]);
fa fa_s1_c13_1(col_in[3][3],col_in[3][2],col_in[3][1],s1_s1[3],c1_s[4]);
fa fa_s1_c14_1(col_in[4][4],col_in[4][3],col_in[4][2],s1_s1[4],c1_s[5]);
fa fa_s1_c15_1(col_in[5][5],col_in[5][4],col_in[5][3],s1_s1[5],c1_s[6]);
fa fa_s1_c16_1(col_in[6][6],col_in[6][5],col_in[6][4],s1_s1[6],c1_s[7]);
fa fa_s1_c17_1(col_in[7][7],col_in[7][6],col_in[7][5],s1_s1[7],c1_s[8]);
fa fa_s1_c18_1(col_in[8][6],col_in[8][5],col_in[8][4],s1_s1[8],c1_s[9]);
fa fa_s1_c19(col_in[9][5],col_in[9][4],col_in[9][3],s1_s1[9],c1_s[10]);
fa s1_c14_10(col_in[10][4],col_in[10][3],col_in[10][2],s1_s1[10],c1_s[11]);
fa s1_c14_11(col_in[11][3],col_in[11][2],col_in[11][1],s1_s1[11],c1_s[12]);
fa s1_c14_12(col_in[12][2],col_in[12][1],col_in[12][0],s1_s1[12],c1_s[13]);

ha s1_c14_13(col_in[13][1],col_in[13][0],s1_s1[13],c1_s[14]);
ha s1_c44(col_in[4][1],col_in[4][0],temp1_1[4],temp1_2[5]);
fa fa_s1_c55(col_in[5][2],col_in[5][1],col_in[5][0],temp1_1[5],temp1_2[6]);
fa s1_c66(col_in[6][3],col_in[6][2],col_in[6][1],temp1_1[6],temp1_2[7]);
fa s1_c77(col_in[7][4],col_in[7][3],col_in[7][2],temp1_1[7],temp1_2[8]);
fa s1_c88(col_in[8][3],col_in[8][2],col_in[8][1],temp1_1[8],temp1_2[9]);
fa s1_c99(col_in[9][2],col_in[9][1],col_in[9][0],temp1_1[9],temp1_2[10]);
ha s1_c1010(col_in[10][1],col_in[10][0],temp1_1[10],temp1_2[11]);
ha s1_c777(col_in[7][1],col_in[7][0],temp1_3[7],temp1_3[8]);

assign s1_s1[0]=col_in[0][0];
assign s1_s1[14]=col_in[14][0];
assign temp1_4[3]=col_in[3][0];
assign temp1_4[6]=col_in[6][0];
assign temp1_4[8]=col_in[8][0];
assign temp1_4[11]=col_in[11][0];

//stage 2

ha ha_s2_c2(s1_s1[2],c1_s[2],s2_s1[2],c2_s[3]);
fa fa_s2_c3(s1_s1[3],c1_s[3],temp1_4[3],s2_s1[3],c2_s[4]);
fa fa_s2_c4(s1_s1[4],c1_s[4],temp1_1[4],s2_s1[4],c2_s[5]);
fa fa_s2_c5(c1_s[5],temp1_1[5],temp1_2[5],s2_s1[5],c2_s[6]);
fa fa_s2_c6(temp1_1[6],temp1_2[6],temp1_4[6],s2_s1[6],c2_s[7]);
fa fa_s2_c7(temp1_1[7],temp1_3[7],temp1_2[7],s2_s1[7],c2_s[8]);
fa fa_s2_c8(temp1_2[8],temp1_3[8],temp1_4[8],s2_s1[8],c2_s[9]);
fa fa_s2_c9(c1_s[9],temp1_1[9],temp1_2[9],s2_s1[9],c2_s[10]);
fa fa_s2_c10(c1_s[10],temp1_1[10],temp1_2[10],s2_s1[10],c2_s[11]);
fa fa_s2_c11(c1_s[11],temp1_2[11],temp1_4[11],s2_s1[11],c2_s[12]);
ha ha_s2_c12(s1_s1[12],c1_s[12],s2_s1[12],c2_s[13]);
ha ha_s2_c13(s1_s1[13],c1_s[13],s2_s1[13],c2_s[14]);
ha ha_s2_c14(s1_s1[14],c1_s[14],s2_s1[14],c2_s[15]);

ha ha_s2_c66(s1_s1[6],c1_s[6],temp2_1[6],temp2_2[7]);
ha ha_s2_c77(s1_s1[7],c1_s[7],temp2_1[7],temp2_2[8]);
fa fa_s2_c88(s1_s1[8],c1_s[8],temp1_1[8],temp2_1[8],temp2_2[9]);

assign s2_s1[0]=s1_s1[0];
assign s2_s1[1]=s1_s1[1];
assign temp2_3[5]=s1_s1[5];
assign temp2_3[9]=s1_s1[9];
assign temp2_3[10]=s1_s1[10];
assign temp2_3[11]=s1_s1[11];

//stage 3
ha s3_c13(s2_s1[3],c2_s[3],s3_s1[3],c3_s[4]);
ha s3_c14(s2_s1[4],c2_s[4],s3_s1[4],c3_s[5]);
fa fa_s3_c15(s2_s1[5],c2_s[5],temp2_3[5],s3_s1[5],c3_s[6]);
fa fa_s3_c16(s2_s1[6],c2_s[6],temp2_1[6],s3_s1[6],c3_s[7]);
fa fa_s3_c17(c2_s[7],temp2_1[7],temp2_2[7],s3_s1[7],c3_s[8]);
fa fa_s3_c8(c2_s[8],temp2_1[8],temp2_2[8],s3_s1[8],c3_s[9]);
fa fa_s3_c9(c2_s[9],temp2_2[9],temp2_3[9],s3_s1[9],c3_s[10]);
fa fa_s3_c10(s2_s1[10],c2_s[10],temp2_3[10],s3_s1[10],c3_s[11]);
fa fa_s3_c11(s2_s1[11],c2_s[11],temp2_3[11],s3_s1[11],temp3[12]);

//ha s3_c12(s2_s1[12],c2_s[12],s3_s1[12],c3_s[13]);
//ha s3_c133(s2_s1[13],c2_s[13],s3_s1[13],c3_s[14]);
//ha s3_c144(s2_s1[14],c2_s[14],s3_s1[14],c3_s[15]);

assign s3_s1[0]=s2_s1[0];
assign s3_s1[1]=s2_s1[1];
assign s3_s1[2]=s2_s1[2];

//assign s3_s1[15]=c2_s[15];

assign temp3[7]=s2_s1[7];
assign temp3[8]=s2_s1[8];
assign temp3[9]=s2_s1[9];

assign s3_s1[12]=s2_s1[12];
assign s3_s1[13]=s2_s1[13];
assign s3_s1[14]=s2_s1[14];
assign c3_s[12]=c2_s[12];
assign c3_s[13]=c2_s[13];
assign c3_s[14]=c2_s[14];
assign c3_s[15]=c2_s[15];

//stage4

wire s4_s1[15:0],c4_s[15:0];
ha s4_c4(s3_s1[4],c3_s[4],s4_s1[4],c4_s[5]);
ha s4_c5(s3_s1[5],c3_s[5],s4_s1[5],c4_s[6]);
ha s4_c6(s3_s1[6],c3_s[6],s4_s1[6],c4_s[7]);
fa s4_c7(s3_s1[7],c3_s[7],temp3[7],s4_s1[7],c4_s[8]);
fa s4_c8(s3_s1[8],c3_s[8],temp3[8],s4_s1[8],c4_s[9]);
fa s4_c9(s3_s1[9],c3_s[9],temp3[9],s4_s1[9],c4_s[10]);
ha s4_c10(s3_s1[10],c3_s[10],s4_s1[10],c4_s[11]);

ha s4_c11(s3_s1[11],c3_s[11],s4_s1[11],c4_s[12]);

fa s4_c12(s3_s1[12],c3_s[12],temp3[12],s4_s1[12],c4_s[13]);
ha s4_c13(s3_s1[13],c3_s[13],s4_s1[13],c4_s[14]);
ha s4_c14(s3_s1[14],c3_s[14],s4_s1[14],s4_s1[15]);
//ha s4_c15(s3_s1[15],c3_s[15],s4_s1[15],c4_s[16]);


assign s4_s1[0]=s3_s1[0];
assign s4_s1[1]=s3_s1[1];
assign s4_s1[2]=s3_s1[2];
assign s4_s1[3]=s3_s1[3];
assign c4_s[15]=c3_s[15];

assign P_sum[0]=s4_s1[0];
assign P_sum[1]=s4_s1[1];
assign P_sum[2]=s4_s1[2];
assign P_sum[3]=s4_s1[3];
assign P_sum[4]=s4_s1[4];
assign P_sum[5]=s4_s1[5];
assign P_sum[6]=s4_s1[6];
assign P_sum[7]=s4_s1[7];
assign P_sum[8]=s4_s1[8];
assign P_sum[9]=s4_s1[9];
assign P_sum[10]=s4_s1[10];
assign P_sum[11]=s4_s1[11];
assign P_sum[12]=s4_s1[12];
assign P_sum[13]=s4_s1[13];
assign P_sum[14]=s4_s1[14];
assign P_sum[15]=s4_s1[15];

assign P_carry[0]=1'b0;
assign P_carry[1]=1'b0;
assign P_carry[2]=1'b0;
assign P_carry[3]=1'b0;
assign P_carry[4]=1'b0;
assign P_carry[5]=c4_s[5];
assign P_carry[6]=c4_s[6];
assign P_carry[7]=c4_s[7];
assign P_carry[8]=c4_s[8];
assign P_carry[9]=c4_s[9];
assign P_carry[10]=c4_s[10];
assign P_carry[11]=c4_s[11];
assign P_carry[12]=c4_s[12];
assign P_carry[13]=c4_s[13];
assign P_carry[14]=c4_s[14];
assign P_carry[15]=c4_s[15];

endmodule

module fa(input a,b,cin,output sum,cout);
assign sum=a^b^cin;
assign cout=(a&b)|(b&cin)|(a&cin);
endmodule

module ha(input a,b,output sum,cout);
assign sum=a^b;
assign cout=a&b;
endmodule



module CC(input a,b,output sum0,cout0,sum1,cout1);
fa f1(a,b,1'b1,sum1,cout1);
ha h1(a,b,sum0,cout0);
endmodule

module CSA_12bit(input [11:0] a,b,input cin,output [11:0] sum,output cout);
wire [11:0] sum0,sum1;
wire c0_33,c1_33;
wire sum1_3,sum0_3;
wire c0,c1,c2,c3,c4,c5,c6,c7,c11;
wire[11:0]c0_0;
wire [11:0]c1_1;
wire [11:0]s0,s1,s00,s11,s000,s111,carry0,carry1,carry00,carry11,carry000,carry111;

fa fa1_0(a[0],b[0],cin,sum[0],c1_1[0]);


CC cc1(a[1],b[1],sum0[1],c0_0[1],sum1[1],c1_1[1]);
CC cc2(a[2],b[2],sum0[2],c0_0[2],sum1[2],c1_1[2]);
CC cc3(a[3],b[3],sum0[3],c0_0[3],sum1[3],c1_1[3]);

CC cc4(a[4],b[4],sum0[4],c0_0[4],sum1[4],c1_1[4]);
CC cc5(a[5],b[5],sum0[5],c0_0[5],sum1[5],c1_1[5]);
CC cc6(a[6],b[6],sum0[6],c0_0[6],sum1[6],c1_1[6]);
CC cc7(a[7],b[7],sum0[7],c0_0[7],sum1[7],c1_1[7]);

CC cc8(a[8],b[8],sum0[8],c0_0[8],sum1[8],c1_1[8]);
CC cc9(a[9],b[9],sum0[9],c0_0[9],sum1[9],c1_1[9]);
CC cc10(a[10],b[10],sum0[10],c0_0[10],sum1[10],c1_1[10]);
CC cc11(a[11],b[11],sum0[11],c0_0[11],sum1[11],c1_1[11]);

assign {c2,sum[1]}=(c1_1[0])?{c1_1[1],sum1[1]}:{c0_0[1],sum0[1]};
assign {sum1_3,c1_33}=(c1_1[2])?{sum1[3],c1_1[3]}:{sum0[3],c0_0[3]};
assign {c0_33, sum0_3}=(c0_0[2])?{c1_1[3],sum1[3]}:{c0_0[3],sum0[3]};
assign {c3,sum[3],sum[2]}=c2?{c1_33,sum1_3,sum1[2]}:{c0_33,sum0_3,sum0[2]};

assign {carry0[5],s0[5]}=c0_0[4]?{c1_1[5],sum1[5]}:{c0_0[5],sum0[5]};
assign {carry1[5],s1[5]}=c1_1[4]?{c1_1[5],sum1[5]}:{c0_0[5],sum0[5]};
assign {carry0[7],s0[7]}=c0_0[6]?{c1_1[7],sum1[7]}:{c0_0[7],sum0[7]};
assign {carry1[7],s1[7]}=c1_1[6]?{c1_1[7],sum1[7]}:{c0_0[7],sum0[7]};

assign {carry00[7],s00[7],s00[6]}=carry0[5]?{carry1[7],s1[7],sum1[6]}:{carry0[7],s0[7],sum0[6]};
assign {carry11[7],s11[7],s11[6]}=carry1[5]?{carry1[7],s1[7],sum1[6]}:{carry0[7],s0[7],sum0[6]};

assign {c7,sum[7],sum[6],sum[5],sum[4]}=c3?{carry11[7],s11[7],s11[6],s1[5],sum1[4]}:{carry00[7],s00[7],s00[6],s0[5],sum0[4]};

assign {carry0[9],s0[9]}=c0_0[8]?{c1_1[9],sum1[9]}:{c0_0[9],sum0[9]};
assign {carry1[9],s1[9]}=c1_1[8]?{c1_1[9],sum1[9]}:{c0_0[9],sum0[9]};
assign {carry0[11],s0[11]}=c0_0[10]?{c1_1[11],sum1[11]}:{c0_0[11],sum0[11]};
assign {carry1[11],s1[11]}=c1_1[10]?{c1_1[11],sum1[11]}:{c0_0[11],sum0[11]};

assign {carry00[11],s00[11],s00[10]}=carry0[9]?{carry1[11],s1[11],sum1[10]}:{carry0[11],s0[11],sum0[10]};
assign {carry11[11],s11[11],s11[10]}=carry1[9]?{carry1[11],s1[11],sum1[10]}:{carry0[11],s0[11],sum0[10]};

assign {cout,sum[11],sum[10],sum[9],sum[8]}=c7?{carry11[11],s11[11],s11[10],s1[9],sum1[8]}:{carry00[11],s00[11],s00[10],s0[9],sum0[8]};
endmodule
