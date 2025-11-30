#version 150
// cs_border_segment
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 vColor00;
flat in vec4 vColor01;
flat in vec4 vColor10;
flat in vec4 vColor11;
flat in vec4 vColorLine;
flat in vec2 vSegmentClipMode;
flat in vec4 vStyleEdgeAxis;
flat in vec4 vClipCenter_Sign;
flat in vec4 vClipRadii;
flat in vec4 vEdgeReference;
flat in vec4 vPartialWidths;
flat in vec4 vClipParams1;
flat in vec4 vClipParams2;
in vec2 vPos;
void main ()
{
  float d_1;
  float mix_factor_2;
  vec4 color1_3;
  vec4 color0_4;
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  float tmpvar_6;
  tmpvar_6 = inversesqrt((0.5 * dot (tmpvar_5, tmpvar_5)));
  int tmpvar_7;
  tmpvar_7 = int(vSegmentClipMode.x);
  int tmpvar_8;
  tmpvar_8 = int(vSegmentClipMode.y);
  ivec2 tmpvar_9;
  tmpvar_9 = ivec2(vStyleEdgeAxis.xy);
  ivec2 tmpvar_10;
  tmpvar_10.x = int(vStyleEdgeAxis.z);
  tmpvar_10.y = int(vStyleEdgeAxis.w);
  mix_factor_2 = 0.0;
  if ((tmpvar_10.x != tmpvar_10.y)) {
    mix_factor_2 = min (max ((0.5 - 
      (-(dot ((vColorLine.zw * 
        inversesqrt(dot (vColorLine.zw, vColorLine.zw))
      ), (vColorLine.xy - vPos))) * tmpvar_6)
    ), 0.0), 1.0);
  };
  vec2 tmpvar_11;
  tmpvar_11 = (vPos - vClipCenter_Sign.xy);
  bool tmpvar_12;
  tmpvar_12 = (lessThan ((vClipCenter_Sign.zw * tmpvar_11), vec2(0.0, 0.0)) == bvec2(1, 1));
  d_1 = -1.0;
  bool tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = bool(0);
  tmpvar_13 = (3 == tmpvar_8);
  if (tmpvar_13) {
    vec2 tmpvar_15;
    tmpvar_15 = (vClipParams1.xy - vPos);
    d_1 = (sqrt(dot (tmpvar_15, tmpvar_15)) - vClipParams1.z);
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (2 == tmpvar_8));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    bool tmpvar_16;
    tmpvar_16 = (vClipParams1.x == 0.0);
    float tmpvar_17;
    if (tmpvar_16) {
      tmpvar_17 = vClipParams1.y;
    } else {
      tmpvar_17 = vClipParams1.x;
    };
    float tmpvar_18;
    if (tmpvar_16) {
      tmpvar_18 = vPos.y;
    } else {
      tmpvar_18 = vPos.x;
    };
    bool tmpvar_19;
    tmpvar_19 = ((tmpvar_18 < tmpvar_17) || ((3.0 * tmpvar_17) < tmpvar_18));
    if (!(tmpvar_19)) {
      d_1 = 1.0;
    };
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (1 == tmpvar_8));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    d_1 = max (dot ((vClipParams1.zw * 
      inversesqrt(dot (vClipParams1.zw, vClipParams1.zw))
    ), (vClipParams1.xy - vPos)), -(dot (
      (vClipParams2.zw * inversesqrt(dot (vClipParams2.zw, vClipParams2.zw)))
    , 
      (vClipParams2.xy - vPos)
    )));
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = !(tmpvar_14);
  if (tmpvar_13) {
    tmpvar_14 = bool(1);
  };
  if (tmpvar_12) {
    float tmpvar_20;
    tmpvar_20 = float((lessThan (vec2(0.0, 0.0), vClipRadii.xy) == bvec2(1, 1)));
    vec2 tmpvar_21;
    tmpvar_21 = (tmpvar_11 * (1.0/(max (
      (vClipRadii.xy * vClipRadii.xy)
    , 1e-06))));
    vec2 tmpvar_22;
    tmpvar_22 = ((1.0 + tmpvar_20) * tmpvar_21);
    float tmpvar_23;
    tmpvar_23 = float((lessThan (vec2(0.0, 0.0), vClipRadii.zw) == bvec2(1, 1)));
    vec2 tmpvar_24;
    tmpvar_24 = (tmpvar_11 * (1.0/(max (
      (vClipRadii.zw * vClipRadii.zw)
    , 1e-06))));
    vec2 tmpvar_25;
    tmpvar_25 = ((1.0 + tmpvar_23) * tmpvar_24);
    d_1 = max (d_1, max ((
      (dot (tmpvar_11, tmpvar_21) - tmpvar_20)
     * 
      inversesqrt(dot (tmpvar_22, tmpvar_22))
    ), -(
      ((dot (tmpvar_11, tmpvar_24) - tmpvar_23) * inversesqrt(dot (tmpvar_25, tmpvar_25)))
    )));
    vec4 tmpvar_26;
    tmpvar_26 = vColor00;
    bool tmpvar_27;
    bool tmpvar_28;
    tmpvar_28 = bool(0);
    tmpvar_27 = (2 == tmpvar_9.x);
    if (tmpvar_27) {
      vec2 tmpvar_29;
      tmpvar_29 = (vClipRadii.xy - vPartialWidths.xy);
      float tmpvar_30;
      tmpvar_30 = float((lessThan (vec2(0.0, 0.0), tmpvar_29) == bvec2(1, 1)));
      vec2 tmpvar_31;
      tmpvar_31 = (tmpvar_11 * (1.0/(max (
        (tmpvar_29 * tmpvar_29)
      , 1e-06))));
      vec2 tmpvar_32;
      tmpvar_32 = ((1.0 + tmpvar_30) * tmpvar_31);
      vec2 tmpvar_33;
      tmpvar_33 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      float tmpvar_34;
      tmpvar_34 = float((lessThan (vec2(0.0, 0.0), tmpvar_33) == bvec2(1, 1)));
      vec2 tmpvar_35;
      tmpvar_35 = (tmpvar_11 * (1.0/(max (
        (tmpvar_33 * tmpvar_33)
      , 1e-06))));
      vec2 tmpvar_36;
      tmpvar_36 = ((1.0 + tmpvar_34) * tmpvar_35);
      tmpvar_26 = (vColor00 * min (max (
        (0.5 - (min (-(
          ((dot (tmpvar_11, tmpvar_31) - tmpvar_30) * inversesqrt(dot (tmpvar_32, tmpvar_32)))
        ), (
          (dot (tmpvar_11, tmpvar_35) - tmpvar_34)
         * 
          inversesqrt(dot (tmpvar_36, tmpvar_36))
        )) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = (tmpvar_27 || (6 == tmpvar_9.x));
    tmpvar_27 = (tmpvar_27 || (7 == tmpvar_9.x));
    tmpvar_27 = (tmpvar_27 && !(tmpvar_28));
    if (tmpvar_27) {
      float swizzled_factor_37;
      vec2 tmpvar_38;
      tmpvar_38 = (vClipRadii.xy - vPartialWidths.zw);
      float tmpvar_39;
      tmpvar_39 = float((lessThan (vec2(0.0, 0.0), tmpvar_38) == bvec2(1, 1)));
      vec2 tmpvar_40;
      tmpvar_40 = (tmpvar_11 * (1.0/(max (
        (tmpvar_38 * tmpvar_38)
      , 1e-06))));
      vec2 tmpvar_41;
      tmpvar_41 = ((1.0 + tmpvar_39) * tmpvar_40);
      float tmpvar_42;
      tmpvar_42 = min (max ((0.5 - 
        (((dot (tmpvar_11, tmpvar_40) - tmpvar_39) * inversesqrt(dot (tmpvar_41, tmpvar_41))) * tmpvar_6)
      ), 0.0), 1.0);
      bool tmpvar_43;
      bool tmpvar_44;
      tmpvar_44 = bool(0);
      tmpvar_43 = (0 == tmpvar_7);
      if (tmpvar_43) {
        swizzled_factor_37 = 0.0;
        tmpvar_44 = bool(1);
      };
      tmpvar_43 = (tmpvar_43 || (1 == tmpvar_7));
      tmpvar_43 = (tmpvar_43 && !(tmpvar_44));
      if (tmpvar_43) {
        swizzled_factor_37 = mix_factor_2;
        tmpvar_44 = bool(1);
      };
      tmpvar_43 = (tmpvar_43 || (2 == tmpvar_7));
      tmpvar_43 = (tmpvar_43 && !(tmpvar_44));
      if (tmpvar_43) {
        swizzled_factor_37 = 1.0;
        tmpvar_44 = bool(1);
      };
      tmpvar_43 = (tmpvar_43 || (3 == tmpvar_7));
      tmpvar_43 = (tmpvar_43 && !(tmpvar_44));
      if (tmpvar_43) {
        swizzled_factor_37 = (1.0 - mix_factor_2);
        tmpvar_44 = bool(1);
      };
      tmpvar_43 = !(tmpvar_44);
      if (tmpvar_43) {
        swizzled_factor_37 = 0.0;
        tmpvar_44 = bool(1);
      };
      tmpvar_26 = mix (mix (vColor01, tmpvar_26, swizzled_factor_37), mix (tmpvar_26, vColor01, swizzled_factor_37), tmpvar_42);
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = !(tmpvar_28);
    if (tmpvar_27) {
      tmpvar_28 = bool(1);
    };
    color0_4 = tmpvar_26;
    vec4 tmpvar_45;
    tmpvar_45 = vColor10;
    bool tmpvar_46;
    bool tmpvar_47;
    tmpvar_47 = bool(0);
    tmpvar_46 = (2 == tmpvar_9.y);
    if (tmpvar_46) {
      vec2 tmpvar_48;
      tmpvar_48 = (vClipRadii.xy - vPartialWidths.xy);
      float tmpvar_49;
      tmpvar_49 = float((lessThan (vec2(0.0, 0.0), tmpvar_48) == bvec2(1, 1)));
      vec2 tmpvar_50;
      tmpvar_50 = (tmpvar_11 * (1.0/(max (
        (tmpvar_48 * tmpvar_48)
      , 1e-06))));
      vec2 tmpvar_51;
      tmpvar_51 = ((1.0 + tmpvar_49) * tmpvar_50);
      vec2 tmpvar_52;
      tmpvar_52 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      float tmpvar_53;
      tmpvar_53 = float((lessThan (vec2(0.0, 0.0), tmpvar_52) == bvec2(1, 1)));
      vec2 tmpvar_54;
      tmpvar_54 = (tmpvar_11 * (1.0/(max (
        (tmpvar_52 * tmpvar_52)
      , 1e-06))));
      vec2 tmpvar_55;
      tmpvar_55 = ((1.0 + tmpvar_53) * tmpvar_54);
      tmpvar_45 = (vColor10 * min (max (
        (0.5 - (min (-(
          ((dot (tmpvar_11, tmpvar_50) - tmpvar_49) * inversesqrt(dot (tmpvar_51, tmpvar_51)))
        ), (
          (dot (tmpvar_11, tmpvar_54) - tmpvar_53)
         * 
          inversesqrt(dot (tmpvar_55, tmpvar_55))
        )) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_47 = bool(1);
    };
    tmpvar_46 = (tmpvar_46 || (6 == tmpvar_9.y));
    tmpvar_46 = (tmpvar_46 || (7 == tmpvar_9.y));
    tmpvar_46 = (tmpvar_46 && !(tmpvar_47));
    if (tmpvar_46) {
      float swizzled_factor_56;
      vec2 tmpvar_57;
      tmpvar_57 = (vClipRadii.xy - vPartialWidths.zw);
      float tmpvar_58;
      tmpvar_58 = float((lessThan (vec2(0.0, 0.0), tmpvar_57) == bvec2(1, 1)));
      vec2 tmpvar_59;
      tmpvar_59 = (tmpvar_11 * (1.0/(max (
        (tmpvar_57 * tmpvar_57)
      , 1e-06))));
      vec2 tmpvar_60;
      tmpvar_60 = ((1.0 + tmpvar_58) * tmpvar_59);
      float tmpvar_61;
      tmpvar_61 = min (max ((0.5 - 
        (((dot (tmpvar_11, tmpvar_59) - tmpvar_58) * inversesqrt(dot (tmpvar_60, tmpvar_60))) * tmpvar_6)
      ), 0.0), 1.0);
      bool tmpvar_62;
      bool tmpvar_63;
      tmpvar_63 = bool(0);
      tmpvar_62 = (0 == tmpvar_7);
      if (tmpvar_62) {
        swizzled_factor_56 = 0.0;
        tmpvar_63 = bool(1);
      };
      tmpvar_62 = (tmpvar_62 || (1 == tmpvar_7));
      tmpvar_62 = (tmpvar_62 && !(tmpvar_63));
      if (tmpvar_62) {
        swizzled_factor_56 = mix_factor_2;
        tmpvar_63 = bool(1);
      };
      tmpvar_62 = (tmpvar_62 || (2 == tmpvar_7));
      tmpvar_62 = (tmpvar_62 && !(tmpvar_63));
      if (tmpvar_62) {
        swizzled_factor_56 = 1.0;
        tmpvar_63 = bool(1);
      };
      tmpvar_62 = (tmpvar_62 || (3 == tmpvar_7));
      tmpvar_62 = (tmpvar_62 && !(tmpvar_63));
      if (tmpvar_62) {
        swizzled_factor_56 = (1.0 - mix_factor_2);
        tmpvar_63 = bool(1);
      };
      tmpvar_62 = !(tmpvar_63);
      if (tmpvar_62) {
        swizzled_factor_56 = 0.0;
        tmpvar_63 = bool(1);
      };
      tmpvar_45 = mix (mix (vColor11, tmpvar_45, swizzled_factor_56), mix (tmpvar_45, vColor11, swizzled_factor_56), tmpvar_61);
      tmpvar_47 = bool(1);
    };
    tmpvar_46 = !(tmpvar_47);
    if (tmpvar_46) {
      tmpvar_47 = bool(1);
    };
    color1_3 = tmpvar_45;
  } else {
    vec4 tmpvar_64;
    tmpvar_64 = vColor00;
    vec2 tmpvar_65;
    if ((tmpvar_10.x != 0)) {
      tmpvar_65 = vec2(0.0, 1.0);
    } else {
      tmpvar_65 = vec2(1.0, 0.0);
    };
    float tmpvar_66;
    tmpvar_66 = dot (vPos, tmpvar_65);
    bool tmpvar_67;
    bool tmpvar_68;
    tmpvar_68 = bool(0);
    tmpvar_67 = (2 == tmpvar_9.x);
    if (tmpvar_67) {
      float d_69;
      d_69 = -1.0;
      float tmpvar_70;
      tmpvar_70 = dot (vPartialWidths.xy, tmpvar_65);
      if ((tmpvar_70 >= 1.0)) {
        vec2 tmpvar_71;
        tmpvar_71.x = (dot (vEdgeReference.xy, tmpvar_65) + tmpvar_70);
        tmpvar_71.y = (dot (vEdgeReference.zw, tmpvar_65) - tmpvar_70);
        d_69 = min ((tmpvar_66 - tmpvar_71.x), (tmpvar_71.y - tmpvar_66));
      };
      tmpvar_64 = (vColor00 * min (max (
        (0.5 - (d_69 * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_68 = bool(1);
    };
    tmpvar_67 = (tmpvar_67 || (6 == tmpvar_9.x));
    tmpvar_67 = (tmpvar_67 || (7 == tmpvar_9.x));
    tmpvar_67 = (tmpvar_67 && !(tmpvar_68));
    if (tmpvar_67) {
      tmpvar_64 = mix (tmpvar_64, vColor01, min (max (
        (0.5 - ((tmpvar_66 - dot (
          (vEdgeReference.xy + vPartialWidths.zw)
        , tmpvar_65)) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_68 = bool(1);
    };
    tmpvar_67 = !(tmpvar_68);
    if (tmpvar_67) {
      tmpvar_68 = bool(1);
    };
    color0_4 = tmpvar_64;
    vec4 tmpvar_72;
    tmpvar_72 = vColor10;
    vec2 tmpvar_73;
    if ((tmpvar_10.y != 0)) {
      tmpvar_73 = vec2(0.0, 1.0);
    } else {
      tmpvar_73 = vec2(1.0, 0.0);
    };
    float tmpvar_74;
    tmpvar_74 = dot (vPos, tmpvar_73);
    bool tmpvar_75;
    bool tmpvar_76;
    tmpvar_76 = bool(0);
    tmpvar_75 = (2 == tmpvar_9.y);
    if (tmpvar_75) {
      float d_77;
      d_77 = -1.0;
      float tmpvar_78;
      tmpvar_78 = dot (vPartialWidths.xy, tmpvar_73);
      if ((tmpvar_78 >= 1.0)) {
        vec2 tmpvar_79;
        tmpvar_79.x = (dot (vEdgeReference.xy, tmpvar_73) + tmpvar_78);
        tmpvar_79.y = (dot (vEdgeReference.zw, tmpvar_73) - tmpvar_78);
        d_77 = min ((tmpvar_74 - tmpvar_79.x), (tmpvar_79.y - tmpvar_74));
      };
      tmpvar_72 = (vColor10 * min (max (
        (0.5 - (d_77 * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_76 = bool(1);
    };
    tmpvar_75 = (tmpvar_75 || (6 == tmpvar_9.y));
    tmpvar_75 = (tmpvar_75 || (7 == tmpvar_9.y));
    tmpvar_75 = (tmpvar_75 && !(tmpvar_76));
    if (tmpvar_75) {
      tmpvar_72 = mix (tmpvar_72, vColor11, min (max (
        (0.5 - ((tmpvar_74 - dot (
          (vEdgeReference.xy + vPartialWidths.zw)
        , tmpvar_73)) * tmpvar_6))
      , 0.0), 1.0));
      tmpvar_76 = bool(1);
    };
    tmpvar_75 = !(tmpvar_76);
    if (tmpvar_75) {
      tmpvar_76 = bool(1);
    };
    color1_3 = tmpvar_72;
  };
  oFragColor = (mix (color0_4, color1_3, mix_factor_2) * min (max (
    (0.5 - (d_1 * tmpvar_6))
  , 0.0), 1.0));
}

