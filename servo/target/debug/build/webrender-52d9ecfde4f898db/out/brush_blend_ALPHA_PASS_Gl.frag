#version 150
// brush_blend
// features: ["ALPHA_PASS"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sGpuCache;
flat in vec4 vTransformBounds;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_local_pos;
in vec2 v_uv;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_perspective_amount;
flat in ivec2 v_op_table_address_vec;
flat in mat4 v_color_mat;
flat in vec4 v_funcs;
flat in vec4 v_color_offset;
void main ()
{
  vec4 frag_color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture (sColor0, min (max ((v_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective_amount.x)
  ), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  vec3 tmpvar_3;
  float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  vec3 tmpvar_5;
  if ((tmpvar_2.w != 0.0)) {
    tmpvar_5 = (tmpvar_2.xyz / tmpvar_2.w);
  } else {
    tmpvar_5 = tmpvar_2.xyz;
  };
  tmpvar_3 = tmpvar_5;
  bool tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  tmpvar_6 = (0 == v_op_table_address_vec.x);
  if (tmpvar_6) {
    tmpvar_3 = min (max ((
      ((tmpvar_5 * v_perspective_amount.y) - (0.5 * v_perspective_amount.y))
     + 0.5), 0.0), 1.0);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (3 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix (tmpvar_3, (vec3(1.0, 1.0, 1.0) - tmpvar_3), v_perspective_amount.y);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (6 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = min (max ((tmpvar_3 * v_perspective_amount.y), 0.0), 1.0);
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (8 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix(pow ((
      (tmpvar_3 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (tmpvar_3 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), tmpvar_3)));
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (9 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (tmpvar_3, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (tmpvar_3 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), tmpvar_3)));
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (11 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    vec4 tmpvar_8;
    tmpvar_8.xyz = tmpvar_3;
    tmpvar_8.w = tmpvar_4;
    vec4 tmpvar_9;
    tmpvar_9 = tmpvar_8;
    int k_10;
    int offset_11;
    offset_11 = 0;
    int tmpvar_12;
    int tmpvar_13;
    int tmpvar_14;
    int tmpvar_15;
    tmpvar_12 = int(v_funcs.x);
    tmpvar_13 = int(v_funcs.y);
    tmpvar_14 = int(v_funcs.z);
    tmpvar_15 = int(v_funcs.w);
    bool tmpvar_16;
    bool tmpvar_17;
    tmpvar_17 = bool(0);
    tmpvar_16 = (0 == tmpvar_12);
    if (tmpvar_16) {
      tmpvar_17 = bool(1);
    };
    tmpvar_16 = (tmpvar_16 || (1 == tmpvar_12));
    tmpvar_16 = (tmpvar_16 || (2 == tmpvar_12));
    tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
    if (tmpvar_16) {
      k_10 = int(floor((
        (tmpvar_8[0] * 255.0)
       + 0.5)));
      int tmpvar_18;
      tmpvar_18 = (v_op_table_address_vec.y + (k_10 / 4));
      ivec2 tmpvar_19;
      tmpvar_19.x = int((uint(tmpvar_18) % 1024u));
      tmpvar_19.y = int((uint(tmpvar_18) / 1024u));
      vec4 tmpvar_20;
      tmpvar_20 = texelFetch (sGpuCache, tmpvar_19, 0);
      tmpvar_9[0] = min (max (tmpvar_20[(k_10 % 4)], 0.0), 1.0);
      offset_11 = 64;
      tmpvar_17 = bool(1);
    };
    tmpvar_16 = (tmpvar_16 || (3 == tmpvar_12));
    tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
    if (tmpvar_16) {
      int tmpvar_21;
      tmpvar_21 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_22;
      tmpvar_22.x = int((uint(tmpvar_21) % 1024u));
      tmpvar_22.y = int((uint(tmpvar_21) / 1024u));
      vec4 tmpvar_23;
      tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
      tmpvar_9[0] = min (max ((
        (tmpvar_23[0] * tmpvar_9[0])
       + tmpvar_23[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_17 = bool(1);
    };
    tmpvar_16 = (tmpvar_16 || (4 == tmpvar_12));
    tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
    if (tmpvar_16) {
      int tmpvar_24;
      tmpvar_24 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_25;
      tmpvar_25.x = int((uint(tmpvar_24) % 1024u));
      tmpvar_25.y = int((uint(tmpvar_24) / 1024u));
      vec4 tmpvar_26;
      tmpvar_26 = texelFetch (sGpuCache, tmpvar_25, 0);
      tmpvar_9[0] = min (max ((
        (tmpvar_26[0] * pow (tmpvar_9[0], tmpvar_26[1]))
       + tmpvar_26[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_17 = bool(1);
    };
    tmpvar_16 = !(tmpvar_17);
    if (tmpvar_16) {
      tmpvar_17 = bool(1);
    };
    bool tmpvar_27;
    bool tmpvar_28;
    tmpvar_28 = bool(0);
    tmpvar_27 = (0 == tmpvar_13);
    if (tmpvar_27) {
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = (tmpvar_27 || (1 == tmpvar_13));
    tmpvar_27 = (tmpvar_27 || (2 == tmpvar_13));
    tmpvar_27 = (tmpvar_27 && !(tmpvar_28));
    if (tmpvar_27) {
      k_10 = int(floor((
        (tmpvar_9[1] * 255.0)
       + 0.5)));
      int tmpvar_29;
      tmpvar_29 = ((v_op_table_address_vec.y + offset_11) + (k_10 / 4));
      ivec2 tmpvar_30;
      tmpvar_30.x = int((uint(tmpvar_29) % 1024u));
      tmpvar_30.y = int((uint(tmpvar_29) / 1024u));
      vec4 tmpvar_31;
      tmpvar_31 = texelFetch (sGpuCache, tmpvar_30, 0);
      tmpvar_9[1] = min (max (tmpvar_31[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = (tmpvar_27 || (3 == tmpvar_13));
    tmpvar_27 = (tmpvar_27 && !(tmpvar_28));
    if (tmpvar_27) {
      int tmpvar_32;
      tmpvar_32 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_33;
      tmpvar_33.x = int((uint(tmpvar_32) % 1024u));
      tmpvar_33.y = int((uint(tmpvar_32) / 1024u));
      vec4 tmpvar_34;
      tmpvar_34 = texelFetch (sGpuCache, tmpvar_33, 0);
      tmpvar_9[1] = min (max ((
        (tmpvar_34[0] * tmpvar_9[1])
       + tmpvar_34[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = (tmpvar_27 || (4 == tmpvar_13));
    tmpvar_27 = (tmpvar_27 && !(tmpvar_28));
    if (tmpvar_27) {
      int tmpvar_35;
      tmpvar_35 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_36;
      tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
      tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
      vec4 tmpvar_37;
      tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
      tmpvar_9[1] = min (max ((
        (tmpvar_37[0] * pow (tmpvar_9[1], tmpvar_37[1]))
       + tmpvar_37[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_28 = bool(1);
    };
    tmpvar_27 = !(tmpvar_28);
    if (tmpvar_27) {
      tmpvar_28 = bool(1);
    };
    bool tmpvar_38;
    bool tmpvar_39;
    tmpvar_39 = bool(0);
    tmpvar_38 = (0 == tmpvar_14);
    if (tmpvar_38) {
      tmpvar_39 = bool(1);
    };
    tmpvar_38 = (tmpvar_38 || (1 == tmpvar_14));
    tmpvar_38 = (tmpvar_38 || (2 == tmpvar_14));
    tmpvar_38 = (tmpvar_38 && !(tmpvar_39));
    if (tmpvar_38) {
      k_10 = int(floor((
        (tmpvar_9[2] * 255.0)
       + 0.5)));
      int tmpvar_40;
      tmpvar_40 = ((v_op_table_address_vec.y + offset_11) + (k_10 / 4));
      ivec2 tmpvar_41;
      tmpvar_41.x = int((uint(tmpvar_40) % 1024u));
      tmpvar_41.y = int((uint(tmpvar_40) / 1024u));
      vec4 tmpvar_42;
      tmpvar_42 = texelFetch (sGpuCache, tmpvar_41, 0);
      tmpvar_9[2] = min (max (tmpvar_42[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_39 = bool(1);
    };
    tmpvar_38 = (tmpvar_38 || (3 == tmpvar_14));
    tmpvar_38 = (tmpvar_38 && !(tmpvar_39));
    if (tmpvar_38) {
      int tmpvar_43;
      tmpvar_43 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_44;
      tmpvar_44.x = int((uint(tmpvar_43) % 1024u));
      tmpvar_44.y = int((uint(tmpvar_43) / 1024u));
      vec4 tmpvar_45;
      tmpvar_45 = texelFetch (sGpuCache, tmpvar_44, 0);
      tmpvar_9[2] = min (max ((
        (tmpvar_45[0] * tmpvar_9[2])
       + tmpvar_45[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_39 = bool(1);
    };
    tmpvar_38 = (tmpvar_38 || (4 == tmpvar_14));
    tmpvar_38 = (tmpvar_38 && !(tmpvar_39));
    if (tmpvar_38) {
      int tmpvar_46;
      tmpvar_46 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_47;
      tmpvar_47.x = int((uint(tmpvar_46) % 1024u));
      tmpvar_47.y = int((uint(tmpvar_46) / 1024u));
      vec4 tmpvar_48;
      tmpvar_48 = texelFetch (sGpuCache, tmpvar_47, 0);
      tmpvar_9[2] = min (max ((
        (tmpvar_48[0] * pow (tmpvar_9[2], tmpvar_48[1]))
       + tmpvar_48[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_39 = bool(1);
    };
    tmpvar_38 = !(tmpvar_39);
    if (tmpvar_38) {
      tmpvar_39 = bool(1);
    };
    bool tmpvar_49;
    bool tmpvar_50;
    tmpvar_50 = bool(0);
    tmpvar_49 = (0 == tmpvar_15);
    if (tmpvar_49) {
      tmpvar_50 = bool(1);
    };
    tmpvar_49 = (tmpvar_49 || (1 == tmpvar_15));
    tmpvar_49 = (tmpvar_49 || (2 == tmpvar_15));
    tmpvar_49 = (tmpvar_49 && !(tmpvar_50));
    if (tmpvar_49) {
      k_10 = int(floor((
        (tmpvar_9[3] * 255.0)
       + 0.5)));
      int tmpvar_51;
      tmpvar_51 = ((v_op_table_address_vec.y + offset_11) + (k_10 / 4));
      ivec2 tmpvar_52;
      tmpvar_52.x = int((uint(tmpvar_51) % 1024u));
      tmpvar_52.y = int((uint(tmpvar_51) / 1024u));
      vec4 tmpvar_53;
      tmpvar_53 = texelFetch (sGpuCache, tmpvar_52, 0);
      tmpvar_9[3] = min (max (tmpvar_53[(k_10 % 4)], 0.0), 1.0);
      offset_11 += 64;
      tmpvar_50 = bool(1);
    };
    tmpvar_49 = (tmpvar_49 || (3 == tmpvar_15));
    tmpvar_49 = (tmpvar_49 && !(tmpvar_50));
    if (tmpvar_49) {
      int tmpvar_54;
      tmpvar_54 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_55;
      tmpvar_55.x = int((uint(tmpvar_54) % 1024u));
      tmpvar_55.y = int((uint(tmpvar_54) / 1024u));
      vec4 tmpvar_56;
      tmpvar_56 = texelFetch (sGpuCache, tmpvar_55, 0);
      tmpvar_9[3] = min (max ((
        (tmpvar_56[0] * tmpvar_9[3])
       + tmpvar_56[1]), 0.0), 1.0);
      offset_11++;
      tmpvar_50 = bool(1);
    };
    tmpvar_49 = (tmpvar_49 || (4 == tmpvar_15));
    tmpvar_49 = (tmpvar_49 && !(tmpvar_50));
    if (tmpvar_49) {
      int tmpvar_57;
      tmpvar_57 = (v_op_table_address_vec.y + offset_11);
      ivec2 tmpvar_58;
      tmpvar_58.x = int((uint(tmpvar_57) % 1024u));
      tmpvar_58.y = int((uint(tmpvar_57) / 1024u));
      vec4 tmpvar_59;
      tmpvar_59 = texelFetch (sGpuCache, tmpvar_58, 0);
      tmpvar_9[3] = min (max ((
        (tmpvar_59[0] * pow (tmpvar_9[3], tmpvar_59[1]))
       + tmpvar_59[2]), 0.0), 1.0);
      offset_11++;
      tmpvar_50 = bool(1);
    };
    tmpvar_49 = !(tmpvar_50);
    if (tmpvar_49) {
      tmpvar_50 = bool(1);
    };
    tmpvar_3 = tmpvar_9.xyz;
    tmpvar_4 = tmpvar_9.w;
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = (tmpvar_6 || (10 == v_op_table_address_vec.x));
  tmpvar_6 = (tmpvar_6 && !(tmpvar_7));
  if (tmpvar_6) {
    tmpvar_3 = v_color_offset.xyz;
    tmpvar_4 = v_color_offset.w;
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = !(tmpvar_7);
  if (tmpvar_6) {
    vec4 tmpvar_60;
    tmpvar_60.xyz = tmpvar_3;
    tmpvar_60.w = tmpvar_4;
    vec4 tmpvar_61;
    tmpvar_61 = min (max ((
      (v_color_mat * tmpvar_60)
     + v_color_offset), 0.0), 1.0);
    tmpvar_3 = tmpvar_61.xyz;
    tmpvar_4 = tmpvar_61.w;
  };
  vec2 tmpvar_62;
  tmpvar_62 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  vec4 tmpvar_63;
  tmpvar_63.w = 1.0;
  tmpvar_63.xyz = tmpvar_3;
  frag_color_1 = ((tmpvar_4 * min (
    max ((0.5 - max (tmpvar_62.x, tmpvar_62.y)), 0.0)
  , 1.0)) * tmpvar_63);
  float tmpvar_64;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_64 = 1.0;
  } else {
    vec2 tmpvar_65;
    tmpvar_65 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_66;
    tmpvar_66.xy = greaterThanEqual (tmpvar_65, vClipMaskUvBounds.xy);
    tmpvar_66.zw = lessThan (tmpvar_65, vClipMaskUvBounds.zw);
    bool tmpvar_67;
    tmpvar_67 = (tmpvar_66 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_67)) {
      tmpvar_64 = 0.0;
    } else {
      tmpvar_64 = texelFetch (sClipMask, ivec2(tmpvar_65), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_64);
  oFragColor = frag_color_1;
}

