module ble_feedback_divider (clk_feedback,
    clk_prescaled,
    modulus_33,
    rst_n,
    cfg_divider);
 output clk_feedback;
 input clk_prescaled;
 output modulus_33;
 input rst_n;
 input [5:0] cfg_divider;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire _22_;
 wire _23_;
 wire _24_;
 wire _25_;
 wire _26_;
 wire _27_;
 wire _28_;
 wire _29_;
 wire _30_;
 wire _31_;
 wire clknet_0_clk_prescaled;
 wire \cycles_left[0] ;
 wire \cycles_left[1] ;
 wire \cycles_left[2] ;
 wire \cycles_left[3] ;
 wire \cycles_left[4] ;
 wire \cycles_left[5] ;
 wire reset_meta;
 wire reset_sync;
 wire net;
 wire clknet_1_0__leaf_clk_prescaled;
 wire clknet_1_1__leaf_clk_prescaled;

 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_0_36 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_48 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_0_52 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_0_68 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_0_76 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_0_80 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_10_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_10_32 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_10_40 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_10_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_10_52 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_10_54 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_10_67 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_10_75 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_10_79 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_10_81 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_11_10 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_11_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_11_29 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_11_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_11_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_11_52 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_11_66 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_1_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_1_4 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_1_45 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_1_81 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_10 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_14 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_2_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_64 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_66 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_2_71 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_2_79 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_2_81 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_4_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_4_34 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_4_52 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_4_69 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_4_77 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_4_81 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_5_10 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_5_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_5_41 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_5_49 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_5_74 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_6_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_16 FILLER_6_24 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_6_60 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_6_62 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_6_81 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_7_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_7_38 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_7_42 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_7_56 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_7_60 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_7_62 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_7_76 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_7_80 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_8_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_8_4 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_4 FILLER_8_76 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_8_80 ();
 gf180mcu_fd_sc_mcu7t5v0__fillcap_8 FILLER_9_2 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_2 FILLER_9_44 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_9_46 ();
 gf180mcu_fd_sc_mcu7t5v0__fill_1 FILLER_9_81 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Left_12 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_0_Right_0 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_10_Left_22 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_10_Right_10 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_11_Left_23 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_11_Right_11 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Left_13 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_1_Right_1 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Left_14 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_2_Right_2 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Left_15 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_3_Right_3 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Left_16 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_4_Right_4 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Left_17 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_5_Right_5 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_6_Left_18 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_6_Right_6 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_7_Left_19 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_7_Right_7 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_8_Left_20 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_8_Right_8 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_9_Left_21 ();
 gf180mcu_fd_sc_mcu7t5v0__endcap PHY_EDGE_ROW_9_Right_9 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_0_24 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_10_29 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_11_30 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_2_25 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_4_26 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_6_27 ();
 gf180mcu_fd_sc_mcu7t5v0__filltie TAP_TAPCELL_ROW_8_28 ();
 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _33_ (.I(\cycles_left[4] ),
    .ZN(_08_));
 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _34_ (.I(cfg_divider[0]),
    .ZN(_09_));
 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _35_ (.I(cfg_divider[4]),
    .ZN(_10_));
 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _36_ (.I(cfg_divider[5]),
    .ZN(_11_));
 gf180mcu_fd_sc_mcu7t5v0__clkinv_1 _37_ (.I(modulus_33),
    .ZN(_12_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _38_ (.A1(\cycles_left[0] ),
    .A2(\cycles_left[1] ),
    .ZN(_13_));
 gf180mcu_fd_sc_mcu7t5v0__or4_1 _39_ (.A1(\cycles_left[0] ),
    .A2(\cycles_left[1] ),
    .A3(\cycles_left[2] ),
    .A4(\cycles_left[3] ),
    .Z(_14_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _40_ (.A1(\cycles_left[4] ),
    .A2(_14_),
    .ZN(_15_));
 gf180mcu_fd_sc_mcu7t5v0__nor3_1 _41_ (.A1(\cycles_left[4] ),
    .A2(\cycles_left[5] ),
    .A3(_14_),
    .ZN(_16_));
 gf180mcu_fd_sc_mcu7t5v0__aoi21_1 _42_ (.A1(_11_),
    .A2(_16_),
    .B(\cycles_left[0] ),
    .ZN(_00_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _43_ (.A1(\cycles_left[0] ),
    .A2(\cycles_left[1] ),
    .Z(_17_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _44_ (.A1(_16_),
    .A2(_17_),
    .ZN(_01_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _45_ (.A1(\cycles_left[2] ),
    .A2(_13_),
    .Z(_02_));
 gf180mcu_fd_sc_mcu7t5v0__oai31_1 _46_ (.A1(\cycles_left[0] ),
    .A2(\cycles_left[1] ),
    .A3(\cycles_left[2] ),
    .B(\cycles_left[3] ),
    .ZN(_18_));
 gf180mcu_fd_sc_mcu7t5v0__aoi21_1 _47_ (.A1(_14_),
    .A2(_18_),
    .B(_16_),
    .ZN(_03_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _48_ (.A1(\cycles_left[4] ),
    .A2(_14_),
    .Z(_19_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _49_ (.A1(_16_),
    .A2(_19_),
    .ZN(_04_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _50_ (.A1(\cycles_left[5] ),
    .A2(_15_),
    .Z(_05_));
 gf180mcu_fd_sc_mcu7t5v0__or2_1 _51_ (.A1(_09_),
    .A2(\cycles_left[0] ),
    .Z(_20_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _52_ (.A1(cfg_divider[3]),
    .A2(\cycles_left[3] ),
    .Z(_21_));
 gf180mcu_fd_sc_mcu7t5v0__aoi211_1 _53_ (.A1(_08_),
    .A2(cfg_divider[4]),
    .B(_21_),
    .C(\cycles_left[5] ),
    .ZN(_22_));
 gf180mcu_fd_sc_mcu7t5v0__aoi22_1 _54_ (.A1(_09_),
    .A2(\cycles_left[0] ),
    .B1(_10_),
    .B2(\cycles_left[4] ),
    .ZN(_23_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _55_ (.A1(cfg_divider[2]),
    .A2(\cycles_left[2] ),
    .Z(_24_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _56_ (.A1(cfg_divider[1]),
    .A2(\cycles_left[1] ),
    .Z(_25_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _57_ (.A1(_24_),
    .A2(_25_),
    .ZN(_26_));
 gf180mcu_fd_sc_mcu7t5v0__nand4_1 _58_ (.A1(_20_),
    .A2(_22_),
    .A3(_23_),
    .A4(_26_),
    .ZN(_27_));
 gf180mcu_fd_sc_mcu7t5v0__aoi21_1 _59_ (.A1(_12_),
    .A2(_27_),
    .B(_16_),
    .ZN(_06_));
 gf180mcu_fd_sc_mcu7t5v0__xor2_1 _60_ (.A1(\cycles_left[0] ),
    .A2(cfg_divider[5]),
    .Z(_28_));
 gf180mcu_fd_sc_mcu7t5v0__or2_1 _61_ (.A1(\cycles_left[2] ),
    .A2(\cycles_left[3] ),
    .Z(_29_));
 gf180mcu_fd_sc_mcu7t5v0__nor4_1 _62_ (.A1(_08_),
    .A2(\cycles_left[5] ),
    .A3(_28_),
    .A4(_29_),
    .ZN(_30_));
 gf180mcu_fd_sc_mcu7t5v0__aoi21_1 _63_ (.A1(\cycles_left[1] ),
    .A2(_30_),
    .B(clk_feedback),
    .ZN(_31_));
 gf180mcu_fd_sc_mcu7t5v0__nor2_1 _64_ (.A1(_16_),
    .A2(_31_),
    .ZN(_07_));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _65_ (.D(_06_),
    .RN(reset_sync),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(modulus_33));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _66_ (.D(_07_),
    .RN(reset_sync),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(clk_feedback));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _67_ (.D(_00_),
    .RN(reset_sync),
    .CLK(clknet_1_1__leaf_clk_prescaled),
    .Q(\cycles_left[0] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _68_ (.D(_01_),
    .RN(reset_sync),
    .CLK(clknet_1_1__leaf_clk_prescaled),
    .Q(\cycles_left[1] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _69_ (.D(_02_),
    .RN(reset_sync),
    .CLK(clknet_1_1__leaf_clk_prescaled),
    .Q(\cycles_left[2] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _70_ (.D(_03_),
    .RN(reset_sync),
    .CLK(clknet_1_1__leaf_clk_prescaled),
    .Q(\cycles_left[3] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _71_ (.D(_04_),
    .RN(reset_sync),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(\cycles_left[4] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _72_ (.D(_05_),
    .RN(reset_sync),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(\cycles_left[5] ));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _73_ (.D(net),
    .RN(rst_n),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(reset_meta));
 gf180mcu_fd_sc_mcu7t5v0__tieh _73__1 (.Z(net));
 gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 _74_ (.D(reset_meta),
    .RN(rst_n),
    .CLK(clknet_1_0__leaf_clk_prescaled),
    .Q(reset_sync));
 gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 clkbuf_0_clk_prescaled (.I(clk_prescaled),
    .Z(clknet_0_clk_prescaled));
 gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 clkbuf_1_0__f_clk_prescaled (.I(clknet_0_clk_prescaled),
    .Z(clknet_1_0__leaf_clk_prescaled));
 gf180mcu_fd_sc_mcu7t5v0__clkbuf_4 clkbuf_1_1__f_clk_prescaled (.I(clknet_0_clk_prescaled),
    .Z(clknet_1_1__leaf_clk_prescaled));
 gf180mcu_fd_sc_mcu7t5v0__clkinv_2 clkload0 (.I(clknet_1_1__leaf_clk_prescaled));
endmodule
