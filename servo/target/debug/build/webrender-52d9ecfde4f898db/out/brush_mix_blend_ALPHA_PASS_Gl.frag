#version 150
// brush_mix_blend
// features: ["ALPHA_PASS"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_src_uv;
flat in vec4 v_src_uv_sample_bounds;
in vec2 v_backdrop_uv;
flat in vec4 v_backdrop_uv_sample_bounds;
flat in vec2 v_perspective;
flat in ivec2 v_op;
void main ()
{
  vec4 frag_color_1;
  vec4 result_2;
  vec4 Cs_3;
  vec4 Cb_4;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, min (max (v_backdrop_uv, v_backdrop_uv_sample_bounds.xy), v_backdrop_uv_sample_bounds.zw));
  Cb_4 = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture (sColor1, min (max ((v_src_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective.x)
  ), v_src_uv_sample_bounds.xy), v_src_uv_sample_bounds.zw));
  Cs_3 = tmpvar_6;
  if ((tmpvar_5.w != 0.0)) {
    Cb_4.xyz = (tmpvar_5.xyz / tmpvar_5.w);
  };
  if ((tmpvar_6.w != 0.0)) {
    Cs_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  };
  result_2 = vec4(1.0, 1.0, 0.0, 1.0);
  bool tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  int tmpvar_9;
  tmpvar_9 = (v_op.x & 255);
  tmpvar_7 = (1 == tmpvar_9);
  if (tmpvar_7) {
    result_2.xyz = (Cb_4.xyz * Cs_3.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (3 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_10;
    tmpvar_10 = ((2.0 * Cb_4.xyz) - 1.0);
    result_2.xyz = mix ((Cs_3.xyz * (2.0 * Cb_4.xyz)), ((Cs_3.xyz + tmpvar_10) - (Cs_3.xyz * tmpvar_10)), vec3(greaterThanEqual (Cb_4.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (4 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = min (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (5 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = max (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (6 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_11;
    if ((Cb_4.x == 0.0)) {
      tmpvar_11 = 0.0;
    } else {
      if ((Cs_3.x == 1.0)) {
        tmpvar_11 = 1.0;
      } else {
        tmpvar_11 = min (1.0, (Cb_4.x / (1.0 - Cs_3.x)));
      };
    };
    result_2.x = tmpvar_11;
    float tmpvar_12;
    if ((Cb_4.y == 0.0)) {
      tmpvar_12 = 0.0;
    } else {
      if ((Cs_3.y == 1.0)) {
        tmpvar_12 = 1.0;
      } else {
        tmpvar_12 = min (1.0, (Cb_4.y / (1.0 - Cs_3.y)));
      };
    };
    result_2.y = tmpvar_12;
    float tmpvar_13;
    if ((Cb_4.z == 0.0)) {
      tmpvar_13 = 0.0;
    } else {
      if ((Cs_3.z == 1.0)) {
        tmpvar_13 = 1.0;
      } else {
        tmpvar_13 = min (1.0, (Cb_4.z / (1.0 - Cs_3.z)));
      };
    };
    result_2.z = tmpvar_13;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (7 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_14;
    if ((Cb_4.x == 1.0)) {
      tmpvar_14 = 1.0;
    } else {
      if ((Cs_3.x == 0.0)) {
        tmpvar_14 = 0.0;
      } else {
        tmpvar_14 = (1.0 - min (1.0, (
          (1.0 - Cb_4.x)
         / Cs_3.x)));
      };
    };
    result_2.x = tmpvar_14;
    float tmpvar_15;
    if ((Cb_4.y == 1.0)) {
      tmpvar_15 = 1.0;
    } else {
      if ((Cs_3.y == 0.0)) {
        tmpvar_15 = 0.0;
      } else {
        tmpvar_15 = (1.0 - min (1.0, (
          (1.0 - Cb_4.y)
         / Cs_3.y)));
      };
    };
    result_2.y = tmpvar_15;
    float tmpvar_16;
    if ((Cb_4.z == 1.0)) {
      tmpvar_16 = 1.0;
    } else {
      if ((Cs_3.z == 0.0)) {
        tmpvar_16 = 0.0;
      } else {
        tmpvar_16 = (1.0 - min (1.0, (
          (1.0 - Cb_4.z)
         / Cs_3.z)));
      };
    };
    result_2.z = tmpvar_16;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (8 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_17;
    tmpvar_17 = ((2.0 * Cs_3.xyz) - 1.0);
    result_2.xyz = mix ((Cb_4.xyz * (2.0 * Cs_3.xyz)), ((Cb_4.xyz + tmpvar_17) - (Cb_4.xyz * tmpvar_17)), vec3(greaterThanEqual (Cs_3.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (9 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    float tmpvar_18;
    if ((0.5 >= Cs_3.x)) {
      tmpvar_18 = (Cb_4.x - ((
        (1.0 - (2.0 * Cs_3.x))
       * Cb_4.x) * (1.0 - Cb_4.x)));
    } else {
      float D_19;
      if ((0.25 >= Cb_4.x)) {
        D_19 = (((
          ((16.0 * Cb_4.x) - 12.0)
         * Cb_4.x) + 4.0) * Cb_4.x);
      } else {
        D_19 = sqrt(Cb_4.x);
      };
      tmpvar_18 = (Cb_4.x + ((
        (2.0 * Cs_3.x)
       - 1.0) * (D_19 - Cb_4.x)));
    };
    result_2.x = tmpvar_18;
    float tmpvar_20;
    if ((0.5 >= Cs_3.y)) {
      tmpvar_20 = (Cb_4.y - ((
        (1.0 - (2.0 * Cs_3.y))
       * Cb_4.y) * (1.0 - Cb_4.y)));
    } else {
      float D_21;
      if ((0.25 >= Cb_4.y)) {
        D_21 = (((
          ((16.0 * Cb_4.y) - 12.0)
         * Cb_4.y) + 4.0) * Cb_4.y);
      } else {
        D_21 = sqrt(Cb_4.y);
      };
      tmpvar_20 = (Cb_4.y + ((
        (2.0 * Cs_3.y)
       - 1.0) * (D_21 - Cb_4.y)));
    };
    result_2.y = tmpvar_20;
    float tmpvar_22;
    if ((0.5 >= Cs_3.z)) {
      tmpvar_22 = (Cb_4.z - ((
        (1.0 - (2.0 * Cs_3.z))
       * Cb_4.z) * (1.0 - Cb_4.z)));
    } else {
      float D_23;
      if ((0.25 >= Cb_4.z)) {
        D_23 = (((
          ((16.0 * Cb_4.z) - 12.0)
         * Cb_4.z) + 4.0) * Cb_4.z);
      } else {
        D_23 = sqrt(Cb_4.z);
      };
      tmpvar_22 = (Cb_4.z + ((
        (2.0 * Cs_3.z)
       - 1.0) * (D_23 - Cb_4.z)));
    };
    result_2.z = tmpvar_22;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (10 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    result_2.xyz = abs((Cb_4.xyz - Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (12 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_24;
    tmpvar_24 = Cs_3.xyz;
    float tmpvar_25;
    tmpvar_25 = (max (Cb_4.x, max (Cb_4.y, Cb_4.z)) - min (Cb_4.x, min (Cb_4.y, Cb_4.z)));
    vec3 tmpvar_26;
    tmpvar_26 = tmpvar_24;
    if ((Cs_3.y >= Cs_3.x)) {
      if ((Cs_3.z >= Cs_3.y)) {
        float tmpvar_27;
        tmpvar_27 = tmpvar_24.x;
        float tmpvar_28;
        tmpvar_28 = tmpvar_24.y;
        float tmpvar_29;
        tmpvar_29 = tmpvar_24.z;
        float tmpvar_30;
        tmpvar_30 = tmpvar_27;
        float tmpvar_31;
        tmpvar_31 = tmpvar_28;
        float tmpvar_32;
        tmpvar_32 = tmpvar_29;
        if ((Cs_3.x < Cs_3.z)) {
          tmpvar_31 = (((Cs_3.y - Cs_3.x) * tmpvar_25) / (Cs_3.z - Cs_3.x));
          tmpvar_32 = tmpvar_25;
        } else {
          tmpvar_31 = 0.0;
          tmpvar_32 = 0.0;
        };
        tmpvar_30 = 0.0;
        tmpvar_27 = tmpvar_30;
        tmpvar_28 = tmpvar_31;
        tmpvar_29 = tmpvar_32;
        tmpvar_26.x = 0.0;
        tmpvar_26.y = tmpvar_31;
        tmpvar_26.z = tmpvar_32;
      } else {
        if ((Cs_3.z >= Cs_3.x)) {
          float tmpvar_33;
          tmpvar_33 = tmpvar_24.x;
          float tmpvar_34;
          tmpvar_34 = tmpvar_24.z;
          float tmpvar_35;
          tmpvar_35 = tmpvar_24.y;
          float tmpvar_36;
          tmpvar_36 = tmpvar_33;
          float tmpvar_37;
          tmpvar_37 = tmpvar_34;
          float tmpvar_38;
          tmpvar_38 = tmpvar_35;
          if ((Cs_3.x < Cs_3.y)) {
            tmpvar_37 = (((Cs_3.z - Cs_3.x) * tmpvar_25) / (Cs_3.y - Cs_3.x));
            tmpvar_38 = tmpvar_25;
          } else {
            tmpvar_37 = 0.0;
            tmpvar_38 = 0.0;
          };
          tmpvar_36 = 0.0;
          tmpvar_33 = tmpvar_36;
          tmpvar_34 = tmpvar_37;
          tmpvar_35 = tmpvar_38;
          tmpvar_26.x = 0.0;
          tmpvar_26.z = tmpvar_37;
          tmpvar_26.y = tmpvar_38;
        } else {
          float tmpvar_39;
          tmpvar_39 = tmpvar_24.z;
          float tmpvar_40;
          tmpvar_40 = tmpvar_24.x;
          float tmpvar_41;
          tmpvar_41 = tmpvar_24.y;
          float tmpvar_42;
          tmpvar_42 = tmpvar_39;
          float tmpvar_43;
          tmpvar_43 = tmpvar_40;
          float tmpvar_44;
          tmpvar_44 = tmpvar_41;
          if ((Cs_3.z < Cs_3.y)) {
            tmpvar_43 = (((Cs_3.x - Cs_3.z) * tmpvar_25) / (Cs_3.y - Cs_3.z));
            tmpvar_44 = tmpvar_25;
          } else {
            tmpvar_43 = 0.0;
            tmpvar_44 = 0.0;
          };
          tmpvar_42 = 0.0;
          tmpvar_39 = tmpvar_42;
          tmpvar_40 = tmpvar_43;
          tmpvar_41 = tmpvar_44;
          tmpvar_26.z = 0.0;
          tmpvar_26.x = tmpvar_43;
          tmpvar_26.y = tmpvar_44;
        };
      };
    } else {
      if ((Cs_3.z >= Cs_3.x)) {
        float tmpvar_45;
        tmpvar_45 = tmpvar_24.y;
        float tmpvar_46;
        tmpvar_46 = tmpvar_24.x;
        float tmpvar_47;
        tmpvar_47 = tmpvar_24.z;
        float tmpvar_48;
        tmpvar_48 = tmpvar_45;
        float tmpvar_49;
        tmpvar_49 = tmpvar_46;
        float tmpvar_50;
        tmpvar_50 = tmpvar_47;
        if ((Cs_3.y < Cs_3.z)) {
          tmpvar_49 = (((Cs_3.x - Cs_3.y) * tmpvar_25) / (Cs_3.z - Cs_3.y));
          tmpvar_50 = tmpvar_25;
        } else {
          tmpvar_49 = 0.0;
          tmpvar_50 = 0.0;
        };
        tmpvar_48 = 0.0;
        tmpvar_45 = tmpvar_48;
        tmpvar_46 = tmpvar_49;
        tmpvar_47 = tmpvar_50;
        tmpvar_26.y = 0.0;
        tmpvar_26.x = tmpvar_49;
        tmpvar_26.z = tmpvar_50;
      } else {
        if ((Cs_3.z >= Cs_3.y)) {
          float tmpvar_51;
          tmpvar_51 = tmpvar_24.y;
          float tmpvar_52;
          tmpvar_52 = tmpvar_24.z;
          float tmpvar_53;
          tmpvar_53 = tmpvar_24.x;
          float tmpvar_54;
          tmpvar_54 = tmpvar_51;
          float tmpvar_55;
          tmpvar_55 = tmpvar_52;
          float tmpvar_56;
          tmpvar_56 = tmpvar_53;
          if ((Cs_3.y < Cs_3.x)) {
            tmpvar_55 = (((Cs_3.z - Cs_3.y) * tmpvar_25) / (Cs_3.x - Cs_3.y));
            tmpvar_56 = tmpvar_25;
          } else {
            tmpvar_55 = 0.0;
            tmpvar_56 = 0.0;
          };
          tmpvar_54 = 0.0;
          tmpvar_51 = tmpvar_54;
          tmpvar_52 = tmpvar_55;
          tmpvar_53 = tmpvar_56;
          tmpvar_26.y = 0.0;
          tmpvar_26.z = tmpvar_55;
          tmpvar_26.x = tmpvar_56;
        } else {
          float tmpvar_57;
          tmpvar_57 = tmpvar_24.z;
          float tmpvar_58;
          tmpvar_58 = tmpvar_24.y;
          float tmpvar_59;
          tmpvar_59 = tmpvar_24.x;
          float tmpvar_60;
          tmpvar_60 = tmpvar_57;
          float tmpvar_61;
          tmpvar_61 = tmpvar_58;
          float tmpvar_62;
          tmpvar_62 = tmpvar_59;
          if ((Cs_3.z < Cs_3.x)) {
            tmpvar_61 = (((Cs_3.y - Cs_3.z) * tmpvar_25) / (Cs_3.x - Cs_3.z));
            tmpvar_62 = tmpvar_25;
          } else {
            tmpvar_61 = 0.0;
            tmpvar_62 = 0.0;
          };
          tmpvar_60 = 0.0;
          tmpvar_57 = tmpvar_60;
          tmpvar_58 = tmpvar_61;
          tmpvar_59 = tmpvar_62;
          tmpvar_26.z = 0.0;
          tmpvar_26.y = tmpvar_61;
          tmpvar_26.x = tmpvar_62;
        };
      };
    };
    vec3 tmpvar_63;
    tmpvar_63 = (tmpvar_26 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_26, vec3(0.3, 0.59, 0.11))));
    float tmpvar_64;
    tmpvar_64 = dot (tmpvar_63, vec3(0.3, 0.59, 0.11));
    float tmpvar_65;
    tmpvar_65 = min (tmpvar_63.x, min (tmpvar_63.y, tmpvar_63.z));
    float tmpvar_66;
    tmpvar_66 = max (tmpvar_63.x, max (tmpvar_63.y, tmpvar_63.z));
    if ((tmpvar_65 < 0.0)) {
      tmpvar_63 = (tmpvar_64 + ((
        (tmpvar_63 - tmpvar_64)
       * tmpvar_64) / (tmpvar_64 - tmpvar_65)));
    };
    if ((1.0 < tmpvar_66)) {
      tmpvar_63 = (tmpvar_64 + ((
        (tmpvar_63 - tmpvar_64)
       * 
        (1.0 - tmpvar_64)
      ) / (tmpvar_66 - tmpvar_64)));
    };
    result_2.xyz = tmpvar_63;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (13 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_67;
    tmpvar_67 = Cb_4.xyz;
    float tmpvar_68;
    tmpvar_68 = (max (Cs_3.x, max (Cs_3.y, Cs_3.z)) - min (Cs_3.x, min (Cs_3.y, Cs_3.z)));
    vec3 tmpvar_69;
    tmpvar_69 = tmpvar_67;
    if ((Cb_4.y >= Cb_4.x)) {
      if ((Cb_4.z >= Cb_4.y)) {
        float tmpvar_70;
        tmpvar_70 = tmpvar_67.x;
        float tmpvar_71;
        tmpvar_71 = tmpvar_67.y;
        float tmpvar_72;
        tmpvar_72 = tmpvar_67.z;
        float tmpvar_73;
        tmpvar_73 = tmpvar_70;
        float tmpvar_74;
        tmpvar_74 = tmpvar_71;
        float tmpvar_75;
        tmpvar_75 = tmpvar_72;
        if ((Cb_4.x < Cb_4.z)) {
          tmpvar_74 = (((Cb_4.y - Cb_4.x) * tmpvar_68) / (Cb_4.z - Cb_4.x));
          tmpvar_75 = tmpvar_68;
        } else {
          tmpvar_74 = 0.0;
          tmpvar_75 = 0.0;
        };
        tmpvar_73 = 0.0;
        tmpvar_70 = tmpvar_73;
        tmpvar_71 = tmpvar_74;
        tmpvar_72 = tmpvar_75;
        tmpvar_69.x = 0.0;
        tmpvar_69.y = tmpvar_74;
        tmpvar_69.z = tmpvar_75;
      } else {
        if ((Cb_4.z >= Cb_4.x)) {
          float tmpvar_76;
          tmpvar_76 = tmpvar_67.x;
          float tmpvar_77;
          tmpvar_77 = tmpvar_67.z;
          float tmpvar_78;
          tmpvar_78 = tmpvar_67.y;
          float tmpvar_79;
          tmpvar_79 = tmpvar_76;
          float tmpvar_80;
          tmpvar_80 = tmpvar_77;
          float tmpvar_81;
          tmpvar_81 = tmpvar_78;
          if ((Cb_4.x < Cb_4.y)) {
            tmpvar_80 = (((Cb_4.z - Cb_4.x) * tmpvar_68) / (Cb_4.y - Cb_4.x));
            tmpvar_81 = tmpvar_68;
          } else {
            tmpvar_80 = 0.0;
            tmpvar_81 = 0.0;
          };
          tmpvar_79 = 0.0;
          tmpvar_76 = tmpvar_79;
          tmpvar_77 = tmpvar_80;
          tmpvar_78 = tmpvar_81;
          tmpvar_69.x = 0.0;
          tmpvar_69.z = tmpvar_80;
          tmpvar_69.y = tmpvar_81;
        } else {
          float tmpvar_82;
          tmpvar_82 = tmpvar_67.z;
          float tmpvar_83;
          tmpvar_83 = tmpvar_67.x;
          float tmpvar_84;
          tmpvar_84 = tmpvar_67.y;
          float tmpvar_85;
          tmpvar_85 = tmpvar_82;
          float tmpvar_86;
          tmpvar_86 = tmpvar_83;
          float tmpvar_87;
          tmpvar_87 = tmpvar_84;
          if ((Cb_4.z < Cb_4.y)) {
            tmpvar_86 = (((Cb_4.x - Cb_4.z) * tmpvar_68) / (Cb_4.y - Cb_4.z));
            tmpvar_87 = tmpvar_68;
          } else {
            tmpvar_86 = 0.0;
            tmpvar_87 = 0.0;
          };
          tmpvar_85 = 0.0;
          tmpvar_82 = tmpvar_85;
          tmpvar_83 = tmpvar_86;
          tmpvar_84 = tmpvar_87;
          tmpvar_69.z = 0.0;
          tmpvar_69.x = tmpvar_86;
          tmpvar_69.y = tmpvar_87;
        };
      };
    } else {
      if ((Cb_4.z >= Cb_4.x)) {
        float tmpvar_88;
        tmpvar_88 = tmpvar_67.y;
        float tmpvar_89;
        tmpvar_89 = tmpvar_67.x;
        float tmpvar_90;
        tmpvar_90 = tmpvar_67.z;
        float tmpvar_91;
        tmpvar_91 = tmpvar_88;
        float tmpvar_92;
        tmpvar_92 = tmpvar_89;
        float tmpvar_93;
        tmpvar_93 = tmpvar_90;
        if ((Cb_4.y < Cb_4.z)) {
          tmpvar_92 = (((Cb_4.x - Cb_4.y) * tmpvar_68) / (Cb_4.z - Cb_4.y));
          tmpvar_93 = tmpvar_68;
        } else {
          tmpvar_92 = 0.0;
          tmpvar_93 = 0.0;
        };
        tmpvar_91 = 0.0;
        tmpvar_88 = tmpvar_91;
        tmpvar_89 = tmpvar_92;
        tmpvar_90 = tmpvar_93;
        tmpvar_69.y = 0.0;
        tmpvar_69.x = tmpvar_92;
        tmpvar_69.z = tmpvar_93;
      } else {
        if ((Cb_4.z >= Cb_4.y)) {
          float tmpvar_94;
          tmpvar_94 = tmpvar_67.y;
          float tmpvar_95;
          tmpvar_95 = tmpvar_67.z;
          float tmpvar_96;
          tmpvar_96 = tmpvar_67.x;
          float tmpvar_97;
          tmpvar_97 = tmpvar_94;
          float tmpvar_98;
          tmpvar_98 = tmpvar_95;
          float tmpvar_99;
          tmpvar_99 = tmpvar_96;
          if ((Cb_4.y < Cb_4.x)) {
            tmpvar_98 = (((Cb_4.z - Cb_4.y) * tmpvar_68) / (Cb_4.x - Cb_4.y));
            tmpvar_99 = tmpvar_68;
          } else {
            tmpvar_98 = 0.0;
            tmpvar_99 = 0.0;
          };
          tmpvar_97 = 0.0;
          tmpvar_94 = tmpvar_97;
          tmpvar_95 = tmpvar_98;
          tmpvar_96 = tmpvar_99;
          tmpvar_69.y = 0.0;
          tmpvar_69.z = tmpvar_98;
          tmpvar_69.x = tmpvar_99;
        } else {
          float tmpvar_100;
          tmpvar_100 = tmpvar_67.z;
          float tmpvar_101;
          tmpvar_101 = tmpvar_67.y;
          float tmpvar_102;
          tmpvar_102 = tmpvar_67.x;
          float tmpvar_103;
          tmpvar_103 = tmpvar_100;
          float tmpvar_104;
          tmpvar_104 = tmpvar_101;
          float tmpvar_105;
          tmpvar_105 = tmpvar_102;
          if ((Cb_4.z < Cb_4.x)) {
            tmpvar_104 = (((Cb_4.y - Cb_4.z) * tmpvar_68) / (Cb_4.x - Cb_4.z));
            tmpvar_105 = tmpvar_68;
          } else {
            tmpvar_104 = 0.0;
            tmpvar_105 = 0.0;
          };
          tmpvar_103 = 0.0;
          tmpvar_100 = tmpvar_103;
          tmpvar_101 = tmpvar_104;
          tmpvar_102 = tmpvar_105;
          tmpvar_69.z = 0.0;
          tmpvar_69.y = tmpvar_104;
          tmpvar_69.x = tmpvar_105;
        };
      };
    };
    vec3 tmpvar_106;
    tmpvar_106 = (tmpvar_69 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_69, vec3(0.3, 0.59, 0.11))));
    float tmpvar_107;
    tmpvar_107 = dot (tmpvar_106, vec3(0.3, 0.59, 0.11));
    float tmpvar_108;
    tmpvar_108 = min (tmpvar_106.x, min (tmpvar_106.y, tmpvar_106.z));
    float tmpvar_109;
    tmpvar_109 = max (tmpvar_106.x, max (tmpvar_106.y, tmpvar_106.z));
    if ((tmpvar_108 < 0.0)) {
      tmpvar_106 = (tmpvar_107 + ((
        (tmpvar_106 - tmpvar_107)
       * tmpvar_107) / (tmpvar_107 - tmpvar_108)));
    };
    if ((1.0 < tmpvar_109)) {
      tmpvar_106 = (tmpvar_107 + ((
        (tmpvar_106 - tmpvar_107)
       * 
        (1.0 - tmpvar_107)
      ) / (tmpvar_109 - tmpvar_107)));
    };
    result_2.xyz = tmpvar_106;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (14 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_110;
    tmpvar_110 = (Cs_3.xyz + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_111;
    tmpvar_111 = dot (tmpvar_110, vec3(0.3, 0.59, 0.11));
    float tmpvar_112;
    tmpvar_112 = min (tmpvar_110.x, min (tmpvar_110.y, tmpvar_110.z));
    float tmpvar_113;
    tmpvar_113 = max (tmpvar_110.x, max (tmpvar_110.y, tmpvar_110.z));
    if ((tmpvar_112 < 0.0)) {
      tmpvar_110 = (tmpvar_111 + ((
        (tmpvar_110 - tmpvar_111)
       * tmpvar_111) / (tmpvar_111 - tmpvar_112)));
    };
    if ((1.0 < tmpvar_113)) {
      tmpvar_110 = (tmpvar_111 + ((
        (tmpvar_110 - tmpvar_111)
       * 
        (1.0 - tmpvar_111)
      ) / (tmpvar_113 - tmpvar_111)));
    };
    result_2.xyz = tmpvar_110;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (15 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec3 tmpvar_114;
    tmpvar_114 = (Cb_4.xyz + (dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_115;
    tmpvar_115 = dot (tmpvar_114, vec3(0.3, 0.59, 0.11));
    float tmpvar_116;
    tmpvar_116 = min (tmpvar_114.x, min (tmpvar_114.y, tmpvar_114.z));
    float tmpvar_117;
    tmpvar_117 = max (tmpvar_114.x, max (tmpvar_114.y, tmpvar_114.z));
    if ((tmpvar_116 < 0.0)) {
      tmpvar_114 = (tmpvar_115 + ((
        (tmpvar_114 - tmpvar_115)
       * tmpvar_115) / (tmpvar_115 - tmpvar_116)));
    };
    if ((1.0 < tmpvar_117)) {
      tmpvar_114 = (tmpvar_115 + ((
        (tmpvar_114 - tmpvar_115)
       * 
        (1.0 - tmpvar_115)
      ) / (tmpvar_117 - tmpvar_115)));
    };
    result_2.xyz = tmpvar_114;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (2 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 || (11 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 || (16 == tmpvar_9));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = !(tmpvar_8);
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  result_2.xyz = (((1.0 - tmpvar_5.w) * Cs_3.xyz) + (tmpvar_5.w * result_2.xyz));
  result_2.w = Cs_3.w;
  result_2.xyz = (result_2.xyz * tmpvar_6.w);
  frag_color_1 = result_2;
  float tmpvar_118;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_118 = 1.0;
  } else {
    vec2 tmpvar_119;
    tmpvar_119 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_120;
    tmpvar_120.xy = greaterThanEqual (tmpvar_119, vClipMaskUvBounds.xy);
    tmpvar_120.zw = lessThan (tmpvar_119, vClipMaskUvBounds.zw);
    bool tmpvar_121;
    tmpvar_121 = (tmpvar_120 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_121)) {
      tmpvar_118 = 0.0;
    } else {
      tmpvar_118 = texelFetch (sClipMask, ivec2(tmpvar_119), 0).x;
    };
  };
  frag_color_1 = (result_2 * tmpvar_118);
  oFragColor = frag_color_1;
}

