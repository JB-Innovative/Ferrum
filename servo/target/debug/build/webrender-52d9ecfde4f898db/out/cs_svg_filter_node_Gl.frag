#version 150
// cs_svg_filter_node
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sGpuCache;
in vec2 vInput1Uv;
in vec2 vInput2Uv;
flat in vec4 vInput1UvRect;
flat in vec4 vInput2UvRect;
flat in ivec4 vData;
flat in vec4 vFilterData0;
flat in ivec2 vFilterInputCountFilterKindVec;
flat in vec2 vFloat0;
flat in mat4 vColorMat;
void main ()
{
  vec4 result_1;
  vec4 Nb_2;
  vec4 Ns_3;
  vec4 Rb_4;
  vec4 Rs_5;
  Rs_5 = vec4(0.0, 0.0, 0.0, 0.0);
  Rb_4 = vec4(0.0, 0.0, 0.0, 0.0);
  Ns_3 = vec4(0.0, 0.0, 0.0, 0.0);
  Nb_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((0 < vFilterInputCountFilterKindVec.x)) {
    vec4 tmpvar_6;
    tmpvar_6 = texture (sColor0, min (max (vInput1Uv, vInput1UvRect.xy), vInput1UvRect.zw));
    Rs_5 = tmpvar_6;
    Ns_3.xyz = (tmpvar_6.xyz * (1.0/(max (1e-06, tmpvar_6.w))));
    Ns_3.w = tmpvar_6.w;
    if (((vFilterInputCountFilterKindVec.y & 1) != 0)) {
      Ns_3.xyz = mix(pow ((
        (Ns_3.xyz / 1.055)
       + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (Ns_3.xyz / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), Ns_3.xyz)));
      Rs_5.xyz = (Ns_3.xyz * tmpvar_6.w);
    };
  };
  if ((1 < vFilterInputCountFilterKindVec.x)) {
    vec4 tmpvar_7;
    tmpvar_7 = texture (sColor1, min (max (vInput2Uv, vInput2UvRect.xy), vInput2UvRect.zw));
    Rb_4 = tmpvar_7;
    Nb_2.xyz = (tmpvar_7.xyz * (1.0/(max (1e-06, tmpvar_7.w))));
    Nb_2.w = tmpvar_7.w;
    if (((vFilterInputCountFilterKindVec.y & 1) != 0)) {
      Nb_2.xyz = mix(pow ((
        (Nb_2.xyz / 1.055)
       + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (Nb_2.xyz / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), Nb_2.xyz)));
      Rb_4.xyz = (Nb_2.xyz * tmpvar_7.w);
    };
  };
  result_1 = vec4(1.0, 0.0, 0.0, 1.0);
  if (((vFilterInputCountFilterKindVec.y == 0) || (vFilterInputCountFilterKindVec.y == 1))) {
    result_1 = Rs_5;
  } else {
    if (((vFilterInputCountFilterKindVec.y == 2) || (vFilterInputCountFilterKindVec.y == 3))) {
      result_1 = (Rs_5 * vFloat0.x);
    } else {
      if (((vFilterInputCountFilterKindVec.y == 4) || (vFilterInputCountFilterKindVec.y == 5))) {
        vec4 tmpvar_8;
        tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
        tmpvar_8.w = Rs_5.w;
        oFragColor = tmpvar_8;
        return;
      } else {
        if (((vFilterInputCountFilterKindVec.y == 6) || (vFilterInputCountFilterKindVec.y == 7))) {
          vec3 tmpvar_9;
          tmpvar_9 = (Ns_3.xyz + (dot (Nb_2.xyz, vec3(0.3, 0.59, 0.11)) - dot (Ns_3.xyz, vec3(0.3, 0.59, 0.11))));
          float tmpvar_10;
          tmpvar_10 = dot (tmpvar_9, vec3(0.3, 0.59, 0.11));
          float tmpvar_11;
          tmpvar_11 = min (tmpvar_9.x, min (tmpvar_9.y, tmpvar_9.z));
          float tmpvar_12;
          tmpvar_12 = max (tmpvar_9.x, max (tmpvar_9.y, tmpvar_9.z));
          if ((tmpvar_11 < 0.0)) {
            tmpvar_9 = (tmpvar_10 + ((
              (tmpvar_9 - tmpvar_10)
             * tmpvar_10) / (tmpvar_10 - tmpvar_11)));
          };
          if ((1.0 < tmpvar_12)) {
            tmpvar_9 = (tmpvar_10 + ((
              (tmpvar_9 - tmpvar_10)
             * 
              (1.0 - tmpvar_10)
            ) / (tmpvar_12 - tmpvar_10)));
          };
          result_1.xyz = (((
            (1.0 - Rb_4.w)
           * Rs_5.xyz) + (
            (1.0 - Rs_5.w)
           * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_9));
          result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
        } else {
          if (((vFilterInputCountFilterKindVec.y == 8) || (vFilterInputCountFilterKindVec.y == 9))) {
            float tmpvar_13;
            if ((Nb_2.x == 1.0)) {
              tmpvar_13 = 1.0;
            } else {
              if ((Ns_3.x == 0.0)) {
                tmpvar_13 = 0.0;
              } else {
                tmpvar_13 = (1.0 - min (1.0, (
                  (1.0 - Nb_2.x)
                 / Ns_3.x)));
              };
            };
            float tmpvar_14;
            if ((Nb_2.y == 1.0)) {
              tmpvar_14 = 1.0;
            } else {
              if ((Ns_3.y == 0.0)) {
                tmpvar_14 = 0.0;
              } else {
                tmpvar_14 = (1.0 - min (1.0, (
                  (1.0 - Nb_2.y)
                 / Ns_3.y)));
              };
            };
            float tmpvar_15;
            if ((Nb_2.z == 1.0)) {
              tmpvar_15 = 1.0;
            } else {
              if ((Ns_3.z == 0.0)) {
                tmpvar_15 = 0.0;
              } else {
                tmpvar_15 = (1.0 - min (1.0, (
                  (1.0 - Nb_2.z)
                 / Ns_3.z)));
              };
            };
            vec3 tmpvar_16;
            tmpvar_16.x = tmpvar_13;
            tmpvar_16.y = tmpvar_14;
            tmpvar_16.z = tmpvar_15;
            result_1.xyz = (((
              (1.0 - Rb_4.w)
             * Rs_5.xyz) + (
              (1.0 - Rs_5.w)
             * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_16));
            result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
          } else {
            if (((vFilterInputCountFilterKindVec.y == 10) || (vFilterInputCountFilterKindVec.y == 11))) {
              float tmpvar_17;
              if ((Nb_2.x == 0.0)) {
                tmpvar_17 = 0.0;
              } else {
                if ((Ns_3.x == 1.0)) {
                  tmpvar_17 = 1.0;
                } else {
                  tmpvar_17 = min (1.0, (Nb_2.x / (1.0 - Ns_3.x)));
                };
              };
              float tmpvar_18;
              if ((Nb_2.y == 0.0)) {
                tmpvar_18 = 0.0;
              } else {
                if ((Ns_3.y == 1.0)) {
                  tmpvar_18 = 1.0;
                } else {
                  tmpvar_18 = min (1.0, (Nb_2.y / (1.0 - Ns_3.y)));
                };
              };
              float tmpvar_19;
              if ((Nb_2.z == 0.0)) {
                tmpvar_19 = 0.0;
              } else {
                if ((Ns_3.z == 1.0)) {
                  tmpvar_19 = 1.0;
                } else {
                  tmpvar_19 = min (1.0, (Nb_2.z / (1.0 - Ns_3.z)));
                };
              };
              vec3 tmpvar_20;
              tmpvar_20.x = tmpvar_17;
              tmpvar_20.y = tmpvar_18;
              tmpvar_20.z = tmpvar_19;
              result_1.xyz = (((
                (1.0 - Rb_4.w)
               * Rs_5.xyz) + (
                (1.0 - Rs_5.w)
               * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_20));
              result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
            } else {
              if (((vFilterInputCountFilterKindVec.y == 12) || (vFilterInputCountFilterKindVec.y == 13))) {
                result_1.xyz = ((Rs_5.xyz + Rb_4.xyz) - max ((Rs_5.xyz * Rb_4.w), (Rb_4.xyz * Rs_5.w)));
                result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
              } else {
                if (((vFilterInputCountFilterKindVec.y == 14) || (vFilterInputCountFilterKindVec.y == 15))) {
                  result_1.xyz = ((Rs_5.xyz + Rb_4.xyz) - (2.0 * min (
                    (Rs_5.xyz * Rb_4.w)
                  , 
                    (Rb_4.xyz * Rs_5.w)
                  )));
                  result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                } else {
                  if (((vFilterInputCountFilterKindVec.y == 16) || (vFilterInputCountFilterKindVec.y == 17))) {
                    result_1.xyz = ((Rs_5.xyz + Rb_4.xyz) - (2.0 * (Rs_5.xyz * Rb_4.xyz)));
                    result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                  } else {
                    if (((vFilterInputCountFilterKindVec.y == 18) || (vFilterInputCountFilterKindVec.y == 19))) {
                      vec3 tmpvar_21;
                      tmpvar_21 = ((2.0 * Ns_3.xyz) - 1.0);
                      result_1.xyz = mix ((Nb_2.xyz * (2.0 * Ns_3.xyz)), ((Nb_2.xyz + tmpvar_21) - (Nb_2.xyz * tmpvar_21)), vec3(greaterThanEqual (Ns_3.xyz, vec3(0.5, 0.5, 0.5))));
                      result_1.xyz = (((
                        (1.0 - Rb_4.w)
                       * Rs_5.xyz) + (
                        (1.0 - Rs_5.w)
                       * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * result_1.xyz));
                      result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                    } else {
                      if (((vFilterInputCountFilterKindVec.y == 20) || (vFilterInputCountFilterKindVec.y == 21))) {
                        vec3 tmpvar_22;
                        tmpvar_22 = Ns_3.xyz;
                        float tmpvar_23;
                        tmpvar_23 = (max (Nb_2.x, max (Nb_2.y, Nb_2.z)) - min (Nb_2.x, min (Nb_2.y, Nb_2.z)));
                        vec3 tmpvar_24;
                        tmpvar_24 = tmpvar_22;
                        if ((Ns_3.y >= Ns_3.x)) {
                          if ((Ns_3.z >= Ns_3.y)) {
                            float tmpvar_25;
                            tmpvar_25 = tmpvar_22.x;
                            float tmpvar_26;
                            tmpvar_26 = tmpvar_22.y;
                            float tmpvar_27;
                            tmpvar_27 = tmpvar_22.z;
                            float tmpvar_28;
                            tmpvar_28 = tmpvar_25;
                            float tmpvar_29;
                            tmpvar_29 = tmpvar_26;
                            float tmpvar_30;
                            tmpvar_30 = tmpvar_27;
                            if ((Ns_3.x < Ns_3.z)) {
                              tmpvar_29 = (((Ns_3.y - Ns_3.x) * tmpvar_23) / (Ns_3.z - Ns_3.x));
                              tmpvar_30 = tmpvar_23;
                            } else {
                              tmpvar_29 = 0.0;
                              tmpvar_30 = 0.0;
                            };
                            tmpvar_28 = 0.0;
                            tmpvar_25 = tmpvar_28;
                            tmpvar_26 = tmpvar_29;
                            tmpvar_27 = tmpvar_30;
                            tmpvar_24.x = 0.0;
                            tmpvar_24.y = tmpvar_29;
                            tmpvar_24.z = tmpvar_30;
                          } else {
                            if ((Ns_3.z >= Ns_3.x)) {
                              float tmpvar_31;
                              tmpvar_31 = tmpvar_22.x;
                              float tmpvar_32;
                              tmpvar_32 = tmpvar_22.z;
                              float tmpvar_33;
                              tmpvar_33 = tmpvar_22.y;
                              float tmpvar_34;
                              tmpvar_34 = tmpvar_31;
                              float tmpvar_35;
                              tmpvar_35 = tmpvar_32;
                              float tmpvar_36;
                              tmpvar_36 = tmpvar_33;
                              if ((Ns_3.x < Ns_3.y)) {
                                tmpvar_35 = (((Ns_3.z - Ns_3.x) * tmpvar_23) / (Ns_3.y - Ns_3.x));
                                tmpvar_36 = tmpvar_23;
                              } else {
                                tmpvar_35 = 0.0;
                                tmpvar_36 = 0.0;
                              };
                              tmpvar_34 = 0.0;
                              tmpvar_31 = tmpvar_34;
                              tmpvar_32 = tmpvar_35;
                              tmpvar_33 = tmpvar_36;
                              tmpvar_24.x = 0.0;
                              tmpvar_24.z = tmpvar_35;
                              tmpvar_24.y = tmpvar_36;
                            } else {
                              float tmpvar_37;
                              tmpvar_37 = tmpvar_22.z;
                              float tmpvar_38;
                              tmpvar_38 = tmpvar_22.x;
                              float tmpvar_39;
                              tmpvar_39 = tmpvar_22.y;
                              float tmpvar_40;
                              tmpvar_40 = tmpvar_37;
                              float tmpvar_41;
                              tmpvar_41 = tmpvar_38;
                              float tmpvar_42;
                              tmpvar_42 = tmpvar_39;
                              if ((Ns_3.z < Ns_3.y)) {
                                tmpvar_41 = (((Ns_3.x - Ns_3.z) * tmpvar_23) / (Ns_3.y - Ns_3.z));
                                tmpvar_42 = tmpvar_23;
                              } else {
                                tmpvar_41 = 0.0;
                                tmpvar_42 = 0.0;
                              };
                              tmpvar_40 = 0.0;
                              tmpvar_37 = tmpvar_40;
                              tmpvar_38 = tmpvar_41;
                              tmpvar_39 = tmpvar_42;
                              tmpvar_24.z = 0.0;
                              tmpvar_24.x = tmpvar_41;
                              tmpvar_24.y = tmpvar_42;
                            };
                          };
                        } else {
                          if ((Ns_3.z >= Ns_3.x)) {
                            float tmpvar_43;
                            tmpvar_43 = tmpvar_22.y;
                            float tmpvar_44;
                            tmpvar_44 = tmpvar_22.x;
                            float tmpvar_45;
                            tmpvar_45 = tmpvar_22.z;
                            float tmpvar_46;
                            tmpvar_46 = tmpvar_43;
                            float tmpvar_47;
                            tmpvar_47 = tmpvar_44;
                            float tmpvar_48;
                            tmpvar_48 = tmpvar_45;
                            if ((Ns_3.y < Ns_3.z)) {
                              tmpvar_47 = (((Ns_3.x - Ns_3.y) * tmpvar_23) / (Ns_3.z - Ns_3.y));
                              tmpvar_48 = tmpvar_23;
                            } else {
                              tmpvar_47 = 0.0;
                              tmpvar_48 = 0.0;
                            };
                            tmpvar_46 = 0.0;
                            tmpvar_43 = tmpvar_46;
                            tmpvar_44 = tmpvar_47;
                            tmpvar_45 = tmpvar_48;
                            tmpvar_24.y = 0.0;
                            tmpvar_24.x = tmpvar_47;
                            tmpvar_24.z = tmpvar_48;
                          } else {
                            if ((Ns_3.z >= Ns_3.y)) {
                              float tmpvar_49;
                              tmpvar_49 = tmpvar_22.y;
                              float tmpvar_50;
                              tmpvar_50 = tmpvar_22.z;
                              float tmpvar_51;
                              tmpvar_51 = tmpvar_22.x;
                              float tmpvar_52;
                              tmpvar_52 = tmpvar_49;
                              float tmpvar_53;
                              tmpvar_53 = tmpvar_50;
                              float tmpvar_54;
                              tmpvar_54 = tmpvar_51;
                              if ((Ns_3.y < Ns_3.x)) {
                                tmpvar_53 = (((Ns_3.z - Ns_3.y) * tmpvar_23) / (Ns_3.x - Ns_3.y));
                                tmpvar_54 = tmpvar_23;
                              } else {
                                tmpvar_53 = 0.0;
                                tmpvar_54 = 0.0;
                              };
                              tmpvar_52 = 0.0;
                              tmpvar_49 = tmpvar_52;
                              tmpvar_50 = tmpvar_53;
                              tmpvar_51 = tmpvar_54;
                              tmpvar_24.y = 0.0;
                              tmpvar_24.z = tmpvar_53;
                              tmpvar_24.x = tmpvar_54;
                            } else {
                              float tmpvar_55;
                              tmpvar_55 = tmpvar_22.z;
                              float tmpvar_56;
                              tmpvar_56 = tmpvar_22.y;
                              float tmpvar_57;
                              tmpvar_57 = tmpvar_22.x;
                              float tmpvar_58;
                              tmpvar_58 = tmpvar_55;
                              float tmpvar_59;
                              tmpvar_59 = tmpvar_56;
                              float tmpvar_60;
                              tmpvar_60 = tmpvar_57;
                              if ((Ns_3.z < Ns_3.x)) {
                                tmpvar_59 = (((Ns_3.y - Ns_3.z) * tmpvar_23) / (Ns_3.x - Ns_3.z));
                                tmpvar_60 = tmpvar_23;
                              } else {
                                tmpvar_59 = 0.0;
                                tmpvar_60 = 0.0;
                              };
                              tmpvar_58 = 0.0;
                              tmpvar_55 = tmpvar_58;
                              tmpvar_56 = tmpvar_59;
                              tmpvar_57 = tmpvar_60;
                              tmpvar_24.z = 0.0;
                              tmpvar_24.y = tmpvar_59;
                              tmpvar_24.x = tmpvar_60;
                            };
                          };
                        };
                        vec3 tmpvar_61;
                        tmpvar_61 = (tmpvar_24 + (dot (Nb_2.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_24, vec3(0.3, 0.59, 0.11))));
                        float tmpvar_62;
                        tmpvar_62 = dot (tmpvar_61, vec3(0.3, 0.59, 0.11));
                        float tmpvar_63;
                        tmpvar_63 = min (tmpvar_61.x, min (tmpvar_61.y, tmpvar_61.z));
                        float tmpvar_64;
                        tmpvar_64 = max (tmpvar_61.x, max (tmpvar_61.y, tmpvar_61.z));
                        if ((tmpvar_63 < 0.0)) {
                          tmpvar_61 = (tmpvar_62 + ((
                            (tmpvar_61 - tmpvar_62)
                           * tmpvar_62) / (tmpvar_62 - tmpvar_63)));
                        };
                        if ((1.0 < tmpvar_64)) {
                          tmpvar_61 = (tmpvar_62 + ((
                            (tmpvar_61 - tmpvar_62)
                           * 
                            (1.0 - tmpvar_62)
                          ) / (tmpvar_64 - tmpvar_62)));
                        };
                        result_1.xyz = (((
                          (1.0 - Rb_4.w)
                         * Rs_5.xyz) + (
                          (1.0 - Rs_5.w)
                         * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_61));
                        result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                      } else {
                        if (((vFilterInputCountFilterKindVec.y == 22) || (vFilterInputCountFilterKindVec.y == 23))) {
                          result_1.xyz = ((Rs_5.xyz + Rb_4.xyz) - min ((Rs_5.xyz * Rb_4.w), (Rb_4.xyz * Rs_5.w)));
                          result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                        } else {
                          if (((vFilterInputCountFilterKindVec.y == 24) || (vFilterInputCountFilterKindVec.y == 25))) {
                            vec3 tmpvar_65;
                            tmpvar_65 = (Nb_2.xyz + (dot (Ns_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Nb_2.xyz, vec3(0.3, 0.59, 0.11))));
                            float tmpvar_66;
                            tmpvar_66 = dot (tmpvar_65, vec3(0.3, 0.59, 0.11));
                            float tmpvar_67;
                            tmpvar_67 = min (tmpvar_65.x, min (tmpvar_65.y, tmpvar_65.z));
                            float tmpvar_68;
                            tmpvar_68 = max (tmpvar_65.x, max (tmpvar_65.y, tmpvar_65.z));
                            if ((tmpvar_67 < 0.0)) {
                              tmpvar_65 = (tmpvar_66 + ((
                                (tmpvar_65 - tmpvar_66)
                               * tmpvar_66) / (tmpvar_66 - tmpvar_67)));
                            };
                            if ((1.0 < tmpvar_68)) {
                              tmpvar_65 = (tmpvar_66 + ((
                                (tmpvar_65 - tmpvar_66)
                               * 
                                (1.0 - tmpvar_66)
                              ) / (tmpvar_68 - tmpvar_66)));
                            };
                            result_1.xyz = (((
                              (1.0 - Rb_4.w)
                             * Rs_5.xyz) + (
                              (1.0 - Rs_5.w)
                             * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_65));
                            result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                          } else {
                            if (((vFilterInputCountFilterKindVec.y == 26) || (vFilterInputCountFilterKindVec.y == 27))) {
                              result_1.xyz = (((Rs_5.xyz * 
                                (1.0 - Rb_4.w)
                              ) + (Rb_4.xyz * 
                                (1.0 - Rs_5.w)
                              )) + (Rs_5.xyz * Rb_4.xyz));
                              result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                            } else {
                              if (((vFilterInputCountFilterKindVec.y == 28) || (vFilterInputCountFilterKindVec.y == 29))) {
                                result_1 = ((Rb_4 * (1.0 - Rs_5.w)) + Rs_5);
                              } else {
                                if (((vFilterInputCountFilterKindVec.y == 30) || (vFilterInputCountFilterKindVec.y == 31))) {
                                  vec3 tmpvar_69;
                                  tmpvar_69 = ((2.0 * Nb_2.xyz) - 1.0);
                                  result_1.xyz = mix ((Ns_3.xyz * (2.0 * Nb_2.xyz)), ((Ns_3.xyz + tmpvar_69) - (Ns_3.xyz * tmpvar_69)), vec3(greaterThanEqual (Nb_2.xyz, vec3(0.5, 0.5, 0.5))));
                                  result_1.xyz = (((
                                    (1.0 - Rb_4.w)
                                   * Rs_5.xyz) + (
                                    (1.0 - Rs_5.w)
                                   * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * result_1.xyz));
                                  result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                                } else {
                                  if (((vFilterInputCountFilterKindVec.y == 32) || (vFilterInputCountFilterKindVec.y == 33))) {
                                    vec3 tmpvar_70;
                                    tmpvar_70 = Nb_2.xyz;
                                    float tmpvar_71;
                                    tmpvar_71 = (max (Ns_3.x, max (Ns_3.y, Ns_3.z)) - min (Ns_3.x, min (Ns_3.y, Ns_3.z)));
                                    vec3 tmpvar_72;
                                    tmpvar_72 = tmpvar_70;
                                    if ((Nb_2.y >= Nb_2.x)) {
                                      if ((Nb_2.z >= Nb_2.y)) {
                                        float tmpvar_73;
                                        tmpvar_73 = tmpvar_70.x;
                                        float tmpvar_74;
                                        tmpvar_74 = tmpvar_70.y;
                                        float tmpvar_75;
                                        tmpvar_75 = tmpvar_70.z;
                                        float tmpvar_76;
                                        tmpvar_76 = tmpvar_73;
                                        float tmpvar_77;
                                        tmpvar_77 = tmpvar_74;
                                        float tmpvar_78;
                                        tmpvar_78 = tmpvar_75;
                                        if ((Nb_2.x < Nb_2.z)) {
                                          tmpvar_77 = (((Nb_2.y - Nb_2.x) * tmpvar_71) / (Nb_2.z - Nb_2.x));
                                          tmpvar_78 = tmpvar_71;
                                        } else {
                                          tmpvar_77 = 0.0;
                                          tmpvar_78 = 0.0;
                                        };
                                        tmpvar_76 = 0.0;
                                        tmpvar_73 = tmpvar_76;
                                        tmpvar_74 = tmpvar_77;
                                        tmpvar_75 = tmpvar_78;
                                        tmpvar_72.x = 0.0;
                                        tmpvar_72.y = tmpvar_77;
                                        tmpvar_72.z = tmpvar_78;
                                      } else {
                                        if ((Nb_2.z >= Nb_2.x)) {
                                          float tmpvar_79;
                                          tmpvar_79 = tmpvar_70.x;
                                          float tmpvar_80;
                                          tmpvar_80 = tmpvar_70.z;
                                          float tmpvar_81;
                                          tmpvar_81 = tmpvar_70.y;
                                          float tmpvar_82;
                                          tmpvar_82 = tmpvar_79;
                                          float tmpvar_83;
                                          tmpvar_83 = tmpvar_80;
                                          float tmpvar_84;
                                          tmpvar_84 = tmpvar_81;
                                          if ((Nb_2.x < Nb_2.y)) {
                                            tmpvar_83 = (((Nb_2.z - Nb_2.x) * tmpvar_71) / (Nb_2.y - Nb_2.x));
                                            tmpvar_84 = tmpvar_71;
                                          } else {
                                            tmpvar_83 = 0.0;
                                            tmpvar_84 = 0.0;
                                          };
                                          tmpvar_82 = 0.0;
                                          tmpvar_79 = tmpvar_82;
                                          tmpvar_80 = tmpvar_83;
                                          tmpvar_81 = tmpvar_84;
                                          tmpvar_72.x = 0.0;
                                          tmpvar_72.z = tmpvar_83;
                                          tmpvar_72.y = tmpvar_84;
                                        } else {
                                          float tmpvar_85;
                                          tmpvar_85 = tmpvar_70.z;
                                          float tmpvar_86;
                                          tmpvar_86 = tmpvar_70.x;
                                          float tmpvar_87;
                                          tmpvar_87 = tmpvar_70.y;
                                          float tmpvar_88;
                                          tmpvar_88 = tmpvar_85;
                                          float tmpvar_89;
                                          tmpvar_89 = tmpvar_86;
                                          float tmpvar_90;
                                          tmpvar_90 = tmpvar_87;
                                          if ((Nb_2.z < Nb_2.y)) {
                                            tmpvar_89 = (((Nb_2.x - Nb_2.z) * tmpvar_71) / (Nb_2.y - Nb_2.z));
                                            tmpvar_90 = tmpvar_71;
                                          } else {
                                            tmpvar_89 = 0.0;
                                            tmpvar_90 = 0.0;
                                          };
                                          tmpvar_88 = 0.0;
                                          tmpvar_85 = tmpvar_88;
                                          tmpvar_86 = tmpvar_89;
                                          tmpvar_87 = tmpvar_90;
                                          tmpvar_72.z = 0.0;
                                          tmpvar_72.x = tmpvar_89;
                                          tmpvar_72.y = tmpvar_90;
                                        };
                                      };
                                    } else {
                                      if ((Nb_2.z >= Nb_2.x)) {
                                        float tmpvar_91;
                                        tmpvar_91 = tmpvar_70.y;
                                        float tmpvar_92;
                                        tmpvar_92 = tmpvar_70.x;
                                        float tmpvar_93;
                                        tmpvar_93 = tmpvar_70.z;
                                        float tmpvar_94;
                                        tmpvar_94 = tmpvar_91;
                                        float tmpvar_95;
                                        tmpvar_95 = tmpvar_92;
                                        float tmpvar_96;
                                        tmpvar_96 = tmpvar_93;
                                        if ((Nb_2.y < Nb_2.z)) {
                                          tmpvar_95 = (((Nb_2.x - Nb_2.y) * tmpvar_71) / (Nb_2.z - Nb_2.y));
                                          tmpvar_96 = tmpvar_71;
                                        } else {
                                          tmpvar_95 = 0.0;
                                          tmpvar_96 = 0.0;
                                        };
                                        tmpvar_94 = 0.0;
                                        tmpvar_91 = tmpvar_94;
                                        tmpvar_92 = tmpvar_95;
                                        tmpvar_93 = tmpvar_96;
                                        tmpvar_72.y = 0.0;
                                        tmpvar_72.x = tmpvar_95;
                                        tmpvar_72.z = tmpvar_96;
                                      } else {
                                        if ((Nb_2.z >= Nb_2.y)) {
                                          float tmpvar_97;
                                          tmpvar_97 = tmpvar_70.y;
                                          float tmpvar_98;
                                          tmpvar_98 = tmpvar_70.z;
                                          float tmpvar_99;
                                          tmpvar_99 = tmpvar_70.x;
                                          float tmpvar_100;
                                          tmpvar_100 = tmpvar_97;
                                          float tmpvar_101;
                                          tmpvar_101 = tmpvar_98;
                                          float tmpvar_102;
                                          tmpvar_102 = tmpvar_99;
                                          if ((Nb_2.y < Nb_2.x)) {
                                            tmpvar_101 = (((Nb_2.z - Nb_2.y) * tmpvar_71) / (Nb_2.x - Nb_2.y));
                                            tmpvar_102 = tmpvar_71;
                                          } else {
                                            tmpvar_101 = 0.0;
                                            tmpvar_102 = 0.0;
                                          };
                                          tmpvar_100 = 0.0;
                                          tmpvar_97 = tmpvar_100;
                                          tmpvar_98 = tmpvar_101;
                                          tmpvar_99 = tmpvar_102;
                                          tmpvar_72.y = 0.0;
                                          tmpvar_72.z = tmpvar_101;
                                          tmpvar_72.x = tmpvar_102;
                                        } else {
                                          float tmpvar_103;
                                          tmpvar_103 = tmpvar_70.z;
                                          float tmpvar_104;
                                          tmpvar_104 = tmpvar_70.y;
                                          float tmpvar_105;
                                          tmpvar_105 = tmpvar_70.x;
                                          float tmpvar_106;
                                          tmpvar_106 = tmpvar_103;
                                          float tmpvar_107;
                                          tmpvar_107 = tmpvar_104;
                                          float tmpvar_108;
                                          tmpvar_108 = tmpvar_105;
                                          if ((Nb_2.z < Nb_2.x)) {
                                            tmpvar_107 = (((Nb_2.y - Nb_2.z) * tmpvar_71) / (Nb_2.x - Nb_2.z));
                                            tmpvar_108 = tmpvar_71;
                                          } else {
                                            tmpvar_107 = 0.0;
                                            tmpvar_108 = 0.0;
                                          };
                                          tmpvar_106 = 0.0;
                                          tmpvar_103 = tmpvar_106;
                                          tmpvar_104 = tmpvar_107;
                                          tmpvar_105 = tmpvar_108;
                                          tmpvar_72.z = 0.0;
                                          tmpvar_72.y = tmpvar_107;
                                          tmpvar_72.x = tmpvar_108;
                                        };
                                      };
                                    };
                                    vec3 tmpvar_109;
                                    tmpvar_109 = (tmpvar_72 + (dot (Nb_2.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_72, vec3(0.3, 0.59, 0.11))));
                                    float tmpvar_110;
                                    tmpvar_110 = dot (tmpvar_109, vec3(0.3, 0.59, 0.11));
                                    float tmpvar_111;
                                    tmpvar_111 = min (tmpvar_109.x, min (tmpvar_109.y, tmpvar_109.z));
                                    float tmpvar_112;
                                    tmpvar_112 = max (tmpvar_109.x, max (tmpvar_109.y, tmpvar_109.z));
                                    if ((tmpvar_111 < 0.0)) {
                                      tmpvar_109 = (tmpvar_110 + ((
                                        (tmpvar_109 - tmpvar_110)
                                       * tmpvar_110) / (tmpvar_110 - tmpvar_111)));
                                    };
                                    if ((1.0 < tmpvar_112)) {
                                      tmpvar_109 = (tmpvar_110 + ((
                                        (tmpvar_109 - tmpvar_110)
                                       * 
                                        (1.0 - tmpvar_110)
                                      ) / (tmpvar_112 - tmpvar_110)));
                                    };
                                    result_1.xyz = (((
                                      (1.0 - Rb_4.w)
                                     * Rs_5.xyz) + (
                                      (1.0 - Rs_5.w)
                                     * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_109));
                                    result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                                  } else {
                                    if (((vFilterInputCountFilterKindVec.y == 34) || (vFilterInputCountFilterKindVec.y == 35))) {
                                      result_1.xyz = ((Rs_5.xyz + Rb_4.xyz) - (Rs_5.xyz * Rb_4.xyz));
                                      result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                                    } else {
                                      if (((vFilterInputCountFilterKindVec.y == 36) || (vFilterInputCountFilterKindVec.y == 37))) {
                                        float tmpvar_113;
                                        if ((0.5 >= Ns_3.x)) {
                                          tmpvar_113 = (Nb_2.x - ((
                                            (1.0 - (2.0 * Ns_3.x))
                                           * Nb_2.x) * (1.0 - Nb_2.x)));
                                        } else {
                                          float D_114;
                                          if ((0.25 >= Nb_2.x)) {
                                            D_114 = (((
                                              ((16.0 * Nb_2.x) - 12.0)
                                             * Nb_2.x) + 4.0) * Nb_2.x);
                                          } else {
                                            D_114 = sqrt(Nb_2.x);
                                          };
                                          tmpvar_113 = (Nb_2.x + ((
                                            (2.0 * Ns_3.x)
                                           - 1.0) * (D_114 - Nb_2.x)));
                                        };
                                        float tmpvar_115;
                                        if ((0.5 >= Ns_3.y)) {
                                          tmpvar_115 = (Nb_2.y - ((
                                            (1.0 - (2.0 * Ns_3.y))
                                           * Nb_2.y) * (1.0 - Nb_2.y)));
                                        } else {
                                          float D_116;
                                          if ((0.25 >= Nb_2.y)) {
                                            D_116 = (((
                                              ((16.0 * Nb_2.y) - 12.0)
                                             * Nb_2.y) + 4.0) * Nb_2.y);
                                          } else {
                                            D_116 = sqrt(Nb_2.y);
                                          };
                                          tmpvar_115 = (Nb_2.y + ((
                                            (2.0 * Ns_3.y)
                                           - 1.0) * (D_116 - Nb_2.y)));
                                        };
                                        float tmpvar_117;
                                        if ((0.5 >= Ns_3.z)) {
                                          tmpvar_117 = (Nb_2.z - ((
                                            (1.0 - (2.0 * Ns_3.z))
                                           * Nb_2.z) * (1.0 - Nb_2.z)));
                                        } else {
                                          float D_118;
                                          if ((0.25 >= Nb_2.z)) {
                                            D_118 = (((
                                              ((16.0 * Nb_2.z) - 12.0)
                                             * Nb_2.z) + 4.0) * Nb_2.z);
                                          } else {
                                            D_118 = sqrt(Nb_2.z);
                                          };
                                          tmpvar_117 = (Nb_2.z + ((
                                            (2.0 * Ns_3.z)
                                           - 1.0) * (D_118 - Nb_2.z)));
                                        };
                                        vec3 tmpvar_119;
                                        tmpvar_119.x = tmpvar_113;
                                        tmpvar_119.y = tmpvar_115;
                                        tmpvar_119.z = tmpvar_117;
                                        result_1.xyz = (((
                                          (1.0 - Rb_4.w)
                                         * Rs_5.xyz) + (
                                          (1.0 - Rs_5.w)
                                         * Rb_4.xyz)) + ((Rs_5.w * Rb_4.w) * tmpvar_119));
                                        result_1.w = ((Rb_4.w * (1.0 - Rs_5.w)) + Rs_5.w);
                                      } else {
                                        if (((vFilterInputCountFilterKindVec.y == 38) || (vFilterInputCountFilterKindVec.y == 39))) {
                                          result_1 = ((vColorMat * Ns_3) + vFilterData0);
                                          vec4 tmpvar_120;
                                          tmpvar_120 = min (max (result_1, 0.0), 1.0);
                                          result_1.w = tmpvar_120.w;
                                          result_1.xyz = (tmpvar_120.xyz * tmpvar_120.w);
                                        } else {
                                          if (((vFilterInputCountFilterKindVec.y == 40) || (vFilterInputCountFilterKindVec.y == 41))) {
                                            ivec4 tmpvar_121;
                                            tmpvar_121 = ivec4(floor(min (
                                              max ((Ns_3 * 255.0), vec4(0.0, 0.0, 0.0, 0.0))
                                            , vec4(255.0, 255.0, 255.0, 255.0))));
                                            ivec2 tmpvar_122;
                                            tmpvar_122.y = 0;
                                            tmpvar_122.x = tmpvar_121.x;
                                            result_1.x = texelFetch (sGpuCache, (vData.xy + tmpvar_122), 0).x;
                                            ivec2 tmpvar_123;
                                            tmpvar_123.y = 0;
                                            tmpvar_123.x = tmpvar_121.y;
                                            result_1.y = texelFetch (sGpuCache, (vData.xy + tmpvar_123), 0).y;
                                            ivec2 tmpvar_124;
                                            tmpvar_124.y = 0;
                                            tmpvar_124.x = tmpvar_121.z;
                                            result_1.z = texelFetch (sGpuCache, (vData.xy + tmpvar_124), 0).z;
                                            ivec2 tmpvar_125;
                                            tmpvar_125.y = 0;
                                            tmpvar_125.x = tmpvar_121.w;
                                            result_1.w = texelFetch (sGpuCache, (vData.xy + tmpvar_125), 0).w;
                                            result_1.xyz = (result_1.xyz * result_1.w);
                                          } else {
                                            if (((vFilterInputCountFilterKindVec.y == 42) || (vFilterInputCountFilterKindVec.y == 43))) {
                                              result_1 = (((
                                                ((Rs_5 * Rb_4) * vFilterData0.x)
                                               + 
                                                (Rs_5 * vFilterData0.y)
                                              ) + (Rb_4 * vFilterData0.z)) + vFilterData0.wwww);
                                              result_1 = min (max (result_1, 0.0), 1.0);
                                            } else {
                                              if (((vFilterInputCountFilterKindVec.y == 44) || (vFilterInputCountFilterKindVec.y == 45))) {
                                                result_1 = ((Rs_5 * Rb_4.w) + (Rb_4 * (1.0 - Rs_5.w)));
                                              } else {
                                                if (((vFilterInputCountFilterKindVec.y == 46) || (vFilterInputCountFilterKindVec.y == 47))) {
                                                  result_1 = (Rs_5 * Rb_4.w);
                                                } else {
                                                  if (((vFilterInputCountFilterKindVec.y == 48) || (vFilterInputCountFilterKindVec.y == 49))) {
                                                    result_1 = (Rs_5 + Rb_4);
                                                    result_1 = min (max (result_1, 0.0), 1.0);
                                                  } else {
                                                    if (((vFilterInputCountFilterKindVec.y == 50) || (vFilterInputCountFilterKindVec.y == 51))) {
                                                      result_1 = (Rs_5 * (1.0 - Rb_4.w));
                                                    } else {
                                                      if (((vFilterInputCountFilterKindVec.y == 52) || (vFilterInputCountFilterKindVec.y == 53))) {
                                                        result_1 = (Rs_5 + (Rb_4 * (1.0 - Rs_5.w)));
                                                      } else {
                                                        if (((vFilterInputCountFilterKindVec.y == 54) || (vFilterInputCountFilterKindVec.y == 55))) {
                                                          result_1 = ((Rs_5 * (1.0 - Rb_4.w)) + (Rb_4 * (1.0 - Rs_5.w)));
                                                        } else {
                                                          if (!(((
                                                            (vFilterInputCountFilterKindVec.y == 56)
                                                           || 
                                                            (vFilterInputCountFilterKindVec.y == 57)
                                                          ) || (
                                                            ((vFilterInputCountFilterKindVec.y == 58) || (vFilterInputCountFilterKindVec.y == 59))
                                                           || 
                                                            (((vFilterInputCountFilterKindVec.y == 60) || (vFilterInputCountFilterKindVec.y == 61)) || (((vFilterInputCountFilterKindVec.y == 62) || (vFilterInputCountFilterKindVec.y == 63)) || ((
                                                              (vFilterInputCountFilterKindVec.y == 64)
                                                             || 
                                                              (vFilterInputCountFilterKindVec.y == 65)
                                                            ) || (
                                                              ((vFilterInputCountFilterKindVec.y == 66) || (vFilterInputCountFilterKindVec.y == 67))
                                                             || 
                                                              ((vFilterInputCountFilterKindVec.y == 68) || (vFilterInputCountFilterKindVec.y == 69))
                                                            ))))
                                                          )))) {
                                                            if (((vFilterInputCountFilterKindVec.y == 70) || (vFilterInputCountFilterKindVec.y == 71))) {
                                                              result_1 = (Rs_5 + (vFilterData0 * (Rb_4.w * 
                                                                (1.0 - Rs_5.w)
                                                              )));
                                                            } else {
                                                              if (((vFilterInputCountFilterKindVec.y == 72) || (vFilterInputCountFilterKindVec.y == 73))) {
                                                                result_1 = vFilterData0;
                                                              } else {
                                                                if ((!((
                                                                  (vFilterInputCountFilterKindVec.y == 74)
                                                                 || 
                                                                  (vFilterInputCountFilterKindVec.y == 75)
                                                                )) && (!(
                                                                  ((vFilterInputCountFilterKindVec.y == 76) || (vFilterInputCountFilterKindVec.y == 77))
                                                                ) && (
                                                                  !(((vFilterInputCountFilterKindVec.y == 80) || (vFilterInputCountFilterKindVec.y == 81)))
                                                                 && 
                                                                  (!(((vFilterInputCountFilterKindVec.y == 82) || (vFilterInputCountFilterKindVec.y == 83))) && (!((
                                                                    (vFilterInputCountFilterKindVec.y == 86)
                                                                   || 
                                                                    (vFilterInputCountFilterKindVec.y == 87)
                                                                  )) && (!(
                                                                    ((vFilterInputCountFilterKindVec.y == 88) || (vFilterInputCountFilterKindVec.y == 89))
                                                                  ) && (
                                                                    !(((vFilterInputCountFilterKindVec.y == 90) || (vFilterInputCountFilterKindVec.y == 91)))
                                                                   && 
                                                                    ((vFilterInputCountFilterKindVec.y == 92) || (vFilterInputCountFilterKindVec.y == 93))
                                                                  ))))
                                                                )))) {
                                                                  vec2 tmpvar_126;
                                                                  tmpvar_126 = (vInput1UvRect.zw - vInput1UvRect.xy);
                                                                  oFragColor = texture (sColor0, min (max ((vInput1UvRect.xy + 
                                                                    (tmpvar_126 * fract(((1.0/(
                                                                      max (tmpvar_126, vec2(1e-06, 1e-06))
                                                                    )) * (vInput1Uv - vInput1UvRect.xy))))
                                                                  ), vInput1UvRect.xy), vInput1UvRect.zw));
                                                                  return;
                                                                };
                                                              };
                                                            };
                                                          };
                                                        };
                                                      };
                                                    };
                                                  };
                                                };
                                              };
                                            };
                                          };
                                        };
                                      };
                                    };
                                  };
                                };
                              };
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  if (((vFilterInputCountFilterKindVec.y & 1) != 0)) {
    vec3 tmpvar_127;
    tmpvar_127 = (result_1.xyz * (1.0/(max (1e-06, result_1.w))));
    result_1.xyz = (mix((
      (vec3(1.055, 1.055, 1.055) * pow (tmpvar_127, vec3(0.4166667, 0.4166667, 0.4166667)))
     - vec3(0.055, 0.055, 0.055)), (tmpvar_127 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), tmpvar_127))) * result_1.w);
  };
  oFragColor = result_1;
}

