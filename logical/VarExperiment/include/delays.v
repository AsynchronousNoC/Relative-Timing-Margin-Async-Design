logic [69:0] intermediate_req;
`LOGIC_BUFFER u_dl_req[69 -1:0 ] (.Z(intermediate_req[69:1]), .A(intermediate_req[69-1:0]) );
`LOGIC_MUX4  u_mux (.Z(l2_req), 
        .D0(intermediate_req[7]), .D1(intermediate_req[27]), .D2(intermediate_req[47]), .D3(intermediate_req[69]), 
        .S0(delay_ctrl[0]), .S1(delay_ctrl[1]) 
    );

// delayline 0 Target: 266.6666667   num_buffers 10 - > 275.6
wire [10:1] delayElement0;
`LOGIC_BUFFER  u_delay0[10:1] (.Z({delayed_data[0],delayElement0[9 :1]}),   .A({delayElement0[9:1],intermediate_data[0]}));

// delayline 1 Target: 275.862069   num_buffers 11 - > 294.6
wire [11:1] delayElement1;
`LOGIC_BUFFER  u_delay1[11:1] (.Z({delayed_data[1],delayElement1[10 :1]}),   .A({delayElement1[10:1],intermediate_data[1]}));

// delayline 2 Target: 285.7142857   num_buffers 11 - > 294.6
wire [11:1] delayElement2;
`LOGIC_BUFFER  u_delay2[11:1] (.Z({delayed_data[2],delayElement2[10 :1]}),   .A({delayElement2[10:1],intermediate_data[2]}));

// delayline 3 Target: 296.2962963   num_buffers 12 - > 313.3
wire [12:1] delayElement3;
`LOGIC_BUFFER  u_delay3[12:1] (.Z({delayed_data[3],delayElement3[11 :1]}),   .A({delayElement3[11:1],intermediate_data[3]}));

// delayline 4 Target: 307.6923077   num_buffers 12 - > 313.3
wire [12:1] delayElement4;
`LOGIC_BUFFER  u_delay4[12:1] (.Z({delayed_data[4],delayElement4[11 :1]}),   .A({delayElement4[11:1],intermediate_data[4]}));

// delayline 5 Target: 320   num_buffers 13 - > 332.0
wire [13:1] delayElement5;
`LOGIC_BUFFER  u_delay5[13:1] (.Z({delayed_data[5],delayElement5[12 :1]}),   .A({delayElement5[12:1],intermediate_data[5]}));

// delayline 6 Target: 333.3333333   num_buffers 14 - > 350.8
wire [14:1] delayElement6;
`LOGIC_BUFFER  u_delay6[14:1] (.Z({delayed_data[6],delayElement6[13 :1]}),   .A({delayElement6[13:1],intermediate_data[6]}));

// delayline 7 Target: 347.826087   num_buffers 14 - > 350.8
wire [14:1] delayElement7;
`LOGIC_BUFFER  u_delay7[14:1] (.Z({delayed_data[7],delayElement7[13 :1]}),   .A({delayElement7[13:1],intermediate_data[7]}));

// delayline 8 Target: 363.6363636   num_buffers 15 - > 369.5
wire [15:1] delayElement8;
`LOGIC_BUFFER  u_delay8[15:1] (.Z({delayed_data[8],delayElement8[14 :1]}),   .A({delayElement8[14:1],intermediate_data[8]}));

// delayline 9 Target: 380.952381   num_buffers 16 - > 388.6
wire [16:1] delayElement9;
`LOGIC_BUFFER  u_delay9[16:1] (.Z({delayed_data[9],delayElement9[15 :1]}),   .A({delayElement9[15:1],intermediate_data[9]}));

// delayline 10 Target: 400   num_buffers 17 - > 407.7
wire [17:1] delayElement10;
`LOGIC_BUFFER  u_delay10[17:1] (.Z({delayed_data[10],delayElement10[16 :1]}),   .A({delayElement10[16:1],intermediate_data[10]}));

// delayline 11 Target: 421.0526316   num_buffers 18 - > 426.4
wire [18:1] delayElement11;
`LOGIC_BUFFER  u_delay11[18:1] (.Z({delayed_data[11],delayElement11[17 :1]}),   .A({delayElement11[17:1],intermediate_data[11]}));

// delayline 12 Target: 444.4444444   num_buffers 19 - > 445.0
wire [19:1] delayElement12;
`LOGIC_BUFFER  u_delay12[19:1] (.Z({delayed_data[12],delayElement12[18 :1]}),   .A({delayElement12[18:1],intermediate_data[12]}));

// delayline 13 Target: 470.5882353   num_buffers 21 - > 484.0
wire [21:1] delayElement13;
`LOGIC_BUFFER  u_delay13[21:1] (.Z({delayed_data[13],delayElement13[20 :1]}),   .A({delayElement13[20:1],intermediate_data[13]}));

// delayline 14 Target: 500   num_buffers 22 - > 502.9
wire [22:1] delayElement14;
`LOGIC_BUFFER  u_delay14[22:1] (.Z({delayed_data[14],delayElement14[21 :1]}),   .A({delayElement14[21:1],intermediate_data[14]}));

// delayline 15 Target: 533.3333333   num_buffers 24 - > 539.9
wire [24:1] delayElement15;
`LOGIC_BUFFER  u_delay15[24:1] (.Z({delayed_data[15],delayElement15[23 :1]}),   .A({delayElement15[23:1],intermediate_data[15]}));

// delayline 16 Target: 551.7241379   num_buffers 25 - > 558.4
wire [25:1] delayElement16;
`LOGIC_BUFFER  u_delay16[25:1] (.Z({delayed_data[16],delayElement16[24 :1]}),   .A({delayElement16[24:1],intermediate_data[16]}));

// delayline 17 Target: 571.4285714   num_buffers 26 - > 577.0
wire [26:1] delayElement17;
`LOGIC_BUFFER  u_delay17[26:1] (.Z({delayed_data[17],delayElement17[25 :1]}),   .A({delayElement17[25:1],intermediate_data[17]}));

// delayline 18 Target: 592.5925926   num_buffers 27 - > 595.3
wire [27:1] delayElement18;
`LOGIC_BUFFER  u_delay18[27:1] (.Z({delayed_data[18],delayElement18[26 :1]}),   .A({delayElement18[26:1],intermediate_data[18]}));

// delayline 19 Target: 615.3846154   num_buffers 29 - > 633.4
wire [29:1] delayElement19;
`LOGIC_BUFFER  u_delay19[29:1] (.Z({delayed_data[19],delayElement19[28 :1]}),   .A({delayElement19[28:1],intermediate_data[19]}));

// delayline 20 Target: 640   num_buffers 30 - > 652.1
wire [30:1] delayElement20;
`LOGIC_BUFFER  u_delay20[30:1] (.Z({delayed_data[20],delayElement20[29 :1]}),   .A({delayElement20[29:1],intermediate_data[20]}));

// delayline 21 Target: 666.6666667   num_buffers 31 - > 670.8
wire [31:1] delayElement21;
`LOGIC_BUFFER  u_delay21[31:1] (.Z({delayed_data[21],delayElement21[30 :1]}),   .A({delayElement21[30:1],intermediate_data[21]}));

// delayline 22 Target: 695.6521739   num_buffers 33 - > 708.1
wire [33:1] delayElement22;
`LOGIC_BUFFER  u_delay22[33:1] (.Z({delayed_data[22],delayElement22[32 :1]}),   .A({delayElement22[32:1],intermediate_data[22]}));

// delayline 23 Target: 727.2727273   num_buffers 35 - > 745.4
wire [35:1] delayElement23;
`LOGIC_BUFFER  u_delay23[35:1] (.Z({delayed_data[23],delayElement23[34 :1]}),   .A({delayElement23[34:1],intermediate_data[23]}));

// delayline 24 Target: 761.9047619   num_buffers 36 - > 764.1
wire [36:1] delayElement24;
`LOGIC_BUFFER  u_delay24[36:1] (.Z({delayed_data[24],delayElement24[35 :1]}),   .A({delayElement24[35:1],intermediate_data[24]}));

// delayline 25 Target: 800   num_buffers 38 - > 800.9
wire [38:1] delayElement25;
`LOGIC_BUFFER  u_delay25[38:1] (.Z({delayed_data[25],delayElement25[37 :1]}),   .A({delayElement25[37:1],intermediate_data[25]}));

// delayline 26 Target: 827.5862069   num_buffers 40 - > 838.2
wire [40:1] delayElement26;
`LOGIC_BUFFER  u_delay26[40:1] (.Z({delayed_data[26],delayElement26[39 :1]}),   .A({delayElement26[39:1],intermediate_data[26]}));

// delayline 27 Target: 842.1052632   num_buffers 41 - > 856.8
wire [41:1] delayElement27;
`LOGIC_BUFFER  u_delay27[41:1] (.Z({delayed_data[27],delayElement27[40 :1]}),   .A({delayElement27[40:1],intermediate_data[27]}));

// delayline 28 Target: 857.1428571   num_buffers 42 - > 875.0
wire [42:1] delayElement28;
`LOGIC_BUFFER  u_delay28[42:1] (.Z({delayed_data[28],delayElement28[41 :1]}),   .A({delayElement28[41:1],intermediate_data[28]}));

// delayline 29 Target: 888.8888889   num_buffers 43 - > 893.7
wire [43:1] delayElement29;
`LOGIC_BUFFER  u_delay29[43:1] (.Z({delayed_data[29],delayElement29[42 :1]}),   .A({delayElement29[42:1],intermediate_data[29]}));

// delayline 30 Target: 923.0769231   num_buffers 45 - > 931.1
wire [45:1] delayElement30;
`LOGIC_BUFFER  u_delay30[45:1] (.Z({delayed_data[30],delayElement30[44 :1]}),   .A({delayElement30[44:1],intermediate_data[30]}));

// delayline 31 Target: 941.1764706   num_buffers 46 - > 949.9
wire [46:1] delayElement31;
`LOGIC_BUFFER  u_delay31[46:1] (.Z({delayed_data[31],delayElement31[45 :1]}),   .A({delayElement31[45:1],intermediate_data[31]}));

// delayline 32 Target: 960   num_buffers 47 - > 968.6
wire [47:1] delayElement32;
`LOGIC_BUFFER  u_delay32[47:1] (.Z({delayed_data[32],delayElement32[46 :1]}),   .A({delayElement32[46:1],intermediate_data[32]}));

// delayline 33 Target: 1000   num_buffers 49 - > 1005.5
wire [49:1] delayElement33;
`LOGIC_BUFFER  u_delay33[49:1] (.Z({delayed_data[33],delayElement33[48 :1]}),   .A({delayElement33[48:1],intermediate_data[33]}));

// delayline 34 Target: 1043.478261   num_buffers 52 - > 1061.3
wire [52:1] delayElement34;
`LOGIC_BUFFER  u_delay34[52:1] (.Z({delayed_data[34],delayElement34[51 :1]}),   .A({delayElement34[51:1],intermediate_data[34]}));

// delayline 35 Target: 1066.666667   num_buffers 53 - > 1079.5
wire [53:1] delayElement35;
`LOGIC_BUFFER  u_delay35[53:1] (.Z({delayed_data[35],delayElement35[52 :1]}),   .A({delayElement35[52:1],intermediate_data[35]}));

// delayline 36 Target: 1090.909091   num_buffers 54 - > 1097.9
wire [54:1] delayElement36;
`LOGIC_BUFFER  u_delay36[54:1] (.Z({delayed_data[36],delayElement36[53 :1]}),   .A({delayElement36[53:1],intermediate_data[36]}));

// delayline 37 Target: 1103.448276   num_buffers 55 - > 1116.5
wire [55:1] delayElement37;
`LOGIC_BUFFER  u_delay37[55:1] (.Z({delayed_data[37],delayElement37[54 :1]}),   .A({delayElement37[54:1],intermediate_data[37]}));

// delayline 38 Target: 1142.857143   num_buffers 57 - > 1152.7
wire [57:1] delayElement38;
`LOGIC_BUFFER  u_delay38[57:1] (.Z({delayed_data[38],delayElement38[56 :1]}),   .A({delayElement38[56:1],intermediate_data[38]}));

// delayline 39 Target: 1185.185185   num_buffers 59 - > 1188.8
wire [59:1] delayElement39;
`LOGIC_BUFFER  u_delay39[59:1] (.Z({delayed_data[39],delayElement39[58 :1]}),   .A({delayElement39[58:1],intermediate_data[39]}));

// delayline 40 Target: 1200   num_buffers 60 - > 1206.8
wire [60:1] delayElement40;
`LOGIC_BUFFER  u_delay40[60:1] (.Z({delayed_data[40],delayElement40[59 :1]}),   .A({delayElement40[59:1],intermediate_data[40]}));

// delayline 41 Target: 1230.769231   num_buffers 62 - > 1243.6
wire [62:1] delayElement41;
`LOGIC_BUFFER  u_delay41[62:1] (.Z({delayed_data[41],delayElement41[61 :1]}),   .A({delayElement41[61:1],intermediate_data[41]}));

// delayline 42 Target: 1263.157895   num_buffers 64 - > 1280.3
wire [64:1] delayElement42;
`LOGIC_BUFFER  u_delay42[64:1] (.Z({delayed_data[42],delayElement42[63 :1]}),   .A({delayElement42[63:1],intermediate_data[42]}));

// delayline 43 Target: 1280   num_buffers 64 - > 1280.3
wire [64:1] delayElement43;
`LOGIC_BUFFER  u_delay43[64:1] (.Z({delayed_data[43],delayElement43[63 :1]}),   .A({delayElement43[63:1],intermediate_data[43]}));

// delayline 44 Target: 1333.333333   num_buffers 67 - > 1334.7
wire [67:1] delayElement44;
`LOGIC_BUFFER  u_delay44[67:1] (.Z({delayed_data[44],delayElement44[66 :1]}),   .A({delayElement44[66:1],intermediate_data[44]}));

// delayline 45 Target: 1391.304348   num_buffers 71 - > 1409.0
wire [71:1] delayElement45;
`LOGIC_BUFFER  u_delay45[71:1] (.Z({delayed_data[45],delayElement45[70 :1]}),   .A({delayElement45[70:1],intermediate_data[45]}));

// delayline 46 Target: 1411.764706   num_buffers 72 - > 1427.3
wire [72:1] delayElement46;
`LOGIC_BUFFER  u_delay46[72:1] (.Z({delayed_data[46],delayElement46[71 :1]}),   .A({delayElement46[71:1],intermediate_data[46]}));

// delayline 47 Target: 1454.545455   num_buffers 74 - > 1463.3
wire [74:1] delayElement47;
`LOGIC_BUFFER  u_delay47[74:1] (.Z({delayed_data[47],delayElement47[73 :1]}),   .A({delayElement47[73:1],intermediate_data[47]}));

// delayline 48 Target: 1500   num_buffers 77 - > 1517.4
wire [77:1] delayElement48;
`LOGIC_BUFFER  u_delay48[77:1] (.Z({delayed_data[48],delayElement48[76 :1]}),   .A({delayElement48[76:1],intermediate_data[48]}));

// delayline 49 Target: 1523.809524   num_buffers 78 - > 1535.6
wire [78:1] delayElement49;
`LOGIC_BUFFER  u_delay49[78:1] (.Z({delayed_data[49],delayElement49[77 :1]}),   .A({delayElement49[77:1],intermediate_data[49]}));

// delayline 50 Target: 1600   num_buffers 82 - > 1607.7
wire [82:1] delayElement50;
`LOGIC_BUFFER  u_delay50[82:1] (.Z({delayed_data[50],delayElement50[81 :1]}),   .A({delayElement50[81:1],intermediate_data[50]}));

// delayline 51 Target: 1684.210526   num_buffers 87 - > 1698.1
wire [87:1] delayElement51;
`LOGIC_BUFFER  u_delay51[87:1] (.Z({delayed_data[51],delayElement51[86 :1]}),   .A({delayElement51[86:1],intermediate_data[51]}));

// delayline 52 Target: 1714.285714   num_buffers 88 - > 1716.1
wire [88:1] delayElement52;
`LOGIC_BUFFER  u_delay52[88:1] (.Z({delayed_data[52],delayElement52[87 :1]}),   .A({delayElement52[87:1],intermediate_data[52]}));

// delayline 53 Target: 1777.777778   num_buffers 92 - > 1789.1
wire [92:1] delayElement53;
`LOGIC_BUFFER  u_delay53[92:1] (.Z({delayed_data[53],delayElement53[91 :1]}),   .A({delayElement53[91:1],intermediate_data[53]}));

// delayline 54 Target: 1846.153846   num_buffers 96 - > 1861.1
wire [96:1] delayElement54;
`LOGIC_BUFFER  u_delay54[96:1] (.Z({delayed_data[54],delayElement54[95 :1]}),   .A({delayElement54[95:1],intermediate_data[54]}));

// delayline 55 Target: 1882.352941   num_buffers 98 - > 1897.1
wire [98:1] delayElement55;
`LOGIC_BUFFER  u_delay55[98:1] (.Z({delayed_data[55],delayElement55[97 :1]}),   .A({delayElement55[97:1],intermediate_data[55]}));

// delayline 56 Target: 2000   num_buffers 104 - > 2005.5
wire [104:1] delayElement56;
`LOGIC_BUFFER  u_delay56[104:1] (.Z({delayed_data[56],delayElement56[103 :1]}),   .A({delayElement56[103:1],intermediate_data[56]}));

// delayline 57 Target: 2133.333333   num_buffers 112 - > 2150.7
wire [112:1] delayElement57;
`LOGIC_BUFFER  u_delay57[112:1] (.Z({delayed_data[57],delayElement57[111 :1]}),   .A({delayElement57[111:1],intermediate_data[57]}));

// delayline 58 Target: 2181.818182   num_buffers 114 - > 2186.7
wire [114:1] delayElement58;
`LOGIC_BUFFER  u_delay58[114:1] (.Z({delayed_data[58],delayElement58[113 :1]}),   .A({delayElement58[113:1],intermediate_data[58]}));

// delayline 59 Target: 2285.714286   num_buffers 120 - > 2295.0
wire [120:1] delayElement59;
`LOGIC_BUFFER  u_delay59[120:1] (.Z({delayed_data[59],delayElement59[119 :1]}),   .A({delayElement59[119:1],intermediate_data[59]}));

// delayline 60 Target: 2400   num_buffers 126 - > 2406.6
wire [126:1] delayElement60;
`LOGIC_BUFFER  u_delay60[126:1] (.Z({delayed_data[60],delayElement60[125 :1]}),   .A({delayElement60[125:1],intermediate_data[60]}));

// delayline 61 Target: 2461.538462   num_buffers 130 - > 2478.9
wire [130:1] delayElement61;
`LOGIC_BUFFER  u_delay61[130:1] (.Z({delayed_data[61],delayElement61[129 :1]}),   .A({delayElement61[129:1],intermediate_data[61]}));

// delayline 62 Target: 2666.666667   num_buffers 141 - > 2682.9
wire [141:1] delayElement62;
`LOGIC_BUFFER  u_delay62[141:1] (.Z({delayed_data[62],delayElement62[140 :1]}),   .A({delayElement62[140:1],intermediate_data[62]}));

// delayline 63 Target: 2909.090909   num_buffers 154 - > 2924.6
wire [154:1] delayElement63;
`LOGIC_BUFFER  u_delay63[154:1] (.Z({delayed_data[63],delayElement63[153 :1]}),   .A({delayElement63[153:1],intermediate_data[63]}));

// delayline 64 Target: 3200   num_buffers 169 - > 3210.0
wire [169:1] delayElement64;
`LOGIC_BUFFER  u_delay64[169:1] (.Z({delayed_data[64],delayElement64[168 :1]}),   .A({delayElement64[168:1],intermediate_data[64]}));
