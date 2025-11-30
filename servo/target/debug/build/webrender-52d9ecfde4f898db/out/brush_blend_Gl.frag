#version 150
// brush_blend
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sGpuCache;
in vec2 v_uv;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_perspective_amount;
flat in ivec2 v_op_table_address_vec;
flat in mat4 v_color_mat;
flat in vec4 v_funcs;
flat in vec4 v_color_offset;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture (sColor0, min (max ((v_uv * 
    mix (gl_FragCoord.w, 1.0, v_perspective_amount.x)
  ), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  vec3 tmpvar_2;
  float tmpvar_3;
  tmpvar_3 = tmpvar_1.w;
  vec3 tmpvar_4;
  if ((tmpvar_1.w != 0.0)) {
    tmpvar_4 = (tmpvar_1.xyz / tmpvar_1.w);
  } else {
    tmpvar_4 = tmpvar_1.xyz;
  };
  tmpvar_2 = tmpvar_4;
  bool tmpvar_5;
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  tmpvar_5 = (0 == v_op_table_address_vec.x);
  if (tmpvar_5) {
    tmpvar_2 = min (max ((
      ((tmpvar_4 * v_perspective_amount.y) - (0.5 * v_perspective_amount.y))
     + 0.5), 0.0), 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (3 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix (tmpvar_2, (vec3(1.0, 1.0, 1.0) - tmpvar_2), v_perspective_amount.y);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (6 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = min (max ((tmpvar_2 * v_perspective_amount.y), 0.0), 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (8 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix(pow ((
      (tmpvar_2 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (tmpvar_2 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), tmpvar_2)));
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (9 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (tmpvar_2, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (tmpvar_2 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), tmpvar_2)));
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (11 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    vec4 tmpvar_7;
    tmpvar_7.xyz = tmpvar_2;
    tmpvar_7.w = tmpvar_3;
    vec4 tmpvar_8;
    tmpvar_8 = tmpvar_7;
    int k_9;
    int offset_10;
    offset_10 = 0;
    int tmpvar_11;
    int tmpvar_12;
    int tmpvar_13;
    int tmpvar_14;
    tmpvar_11 = int(v_funcs.x);
    tmpvar_12 = int(v_funcs.y);
    tmpvar_13 = int(v_funcs.z);
    tmpvar_14 = int(v_funcs.w);
    bool tmpvar_15;
    bool tmpvar_16;
    tmpvar_16 = bool(0);
    tmpvar_15 = (0 == tmpvar_11);
    if (tmpvar_15) {
      tmpvar_16 = bool(1);
    };
    tmpvar_15 = (tmpvar_15 || (1 == tmpvar_11));
    tmpvar_15 = (tmpvar_15 || (2 == tmpvar_11));
    tmpvar_15 = (tmpvar_15 && !(tmpvar_16));
    if (tmpvar_15) {
      k_9 = int(floor((
        (tmpvar_7[0] * 255.0)
       + 0.5)));
      int tmpvar_17;
      tmpvar_17 = (v_op_table_address_vec.y + (k_9 / 4));
      ivec2 tmpvar_18;
      tmpvar_18.x = int((uint(tmpvar_17) % 1024u));
      tmpvar_18.y = int((uint(tmpvar_17) / 1024u));
      vec4 tmpvar_19;
      tmpvar_19 = texelFetch (sGpuCache, tmpvar_18, 0);
      tmpvar_8[0] = min (max (tmpvar_19[(k_9 % 4)], 0.0), 1.0);
      offset_10 = 64;
      tmpvar_16 = bool(1);
    };
    tmpvar_15 = (tmpvar_15 || (3 == tmpvar_11));
    tmpvar_15 = (tmpvar_15 && !(tmpvar_16));
    if (tmpvar_15) {
      int tmpvar_20;
      tmpvar_20 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_21;
      tmpvar_21.x = int((uint(tmpvar_20) % 1024u));
      tmpvar_21.y = int((uint(tmpvar_20) / 1024u));
      vec4 tmpvar_22;
      tmpvar_22 = texelFetch (sGpuCache, tmpvar_21, 0);
      tmpvar_8[0] = min (max ((
        (tmpvar_22[0] * tmpvar_8[0])
       + tmpvar_22[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_16 = bool(1);
    };
    tmpvar_15 = (tmpvar_15 || (4 == tmpvar_11));
    tmpvar_15 = (tmpvar_15 && !(tmpvar_16));
    if (tmpvar_15) {
      int tmpvar_23;
      tmpvar_23 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_24;
      tmpvar_24.x = int((uint(tmpvar_23) % 1024u));
      tmpvar_24.y = int((uint(tmpvar_23) / 1024u));
      vec4 tmpvar_25;
      tmpvar_25 = texelFetch (sGpuCache, tmpvar_24, 0);
      tmpvar_8[0] = min (max ((
        (tmpvar_25[0] * pow (tmpvar_8[0], tmpvar_25[1]))
       + tmpvar_25[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_16 = bool(1);
    };
    tmpvar_15 = !(tmpvar_16);
    if (tmpvar_15) {
      tmpvar_16 = bool(1);
    };
    bool tmpvar_26;
    bool tmpvar_27;
    tmpvar_27 = bool(0);
    tmpvar_26 = (0 == tmpvar_12);
    if (tmpvar_26) {
      tmpvar_27 = bool(1);
    };
    tmpvar_26 = (tmpvar_26 || (1 == tmpvar_12));
    tmpvar_26 = (tmpvar_26 || (2 == tmpvar_12));
    tmpvar_26 = (tmpvar_26 && !(tmpvar_27));
    if (tmpvar_26) {
      k_9 = int(floor((
        (tmpvar_8[1] * 255.0)
       + 0.5)));
      int tmpvar_28;
      tmpvar_28 = ((v_op_table_address_vec.y + offset_10) + (k_9 / 4));
      ivec2 tmpvar_29;
      tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
      tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
      vec4 tmpvar_30;
      tmpvar_30 = texelFetch (sGpuCache, tmpvar_29, 0);
      tmpvar_8[1] = min (max (tmpvar_30[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_27 = bool(1);
    };
    tmpvar_26 = (tmpvar_26 || (3 == tmpvar_12));
    tmpvar_26 = (tmpvar_26 && !(tmpvar_27));
    if (tmpvar_26) {
      int tmpvar_31;
      tmpvar_31 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_32;
      tmpvar_32.x = int((uint(tmpvar_31) % 1024u));
      tmpvar_32.y = int((uint(tmpvar_31) / 1024u));
      vec4 tmpvar_33;
      tmpvar_33 = texelFetch (sGpuCache, tmpvar_32, 0);
      tmpvar_8[1] = min (max ((
        (tmpvar_33[0] * tmpvar_8[1])
       + tmpvar_33[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_27 = bool(1);
    };
    tmpvar_26 = (tmpvar_26 || (4 == tmpvar_12));
    tmpvar_26 = (tmpvar_26 && !(tmpvar_27));
    if (tmpvar_26) {
      int tmpvar_34;
      tmpvar_34 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_35;
      tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
      tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
      vec4 tmpvar_36;
      tmpvar_36 = texelFetch (sGpuCache, tmpvar_35, 0);
      tmpvar_8[1] = min (max ((
        (tmpvar_36[0] * pow (tmpvar_8[1], tmpvar_36[1]))
       + tmpvar_36[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_27 = bool(1);
    };
    tmpvar_26 = !(tmpvar_27);
    if (tmpvar_26) {
      tmpvar_27 = bool(1);
    };
    bool tmpvar_37;
    bool tmpvar_38;
    tmpvar_38 = bool(0);
    tmpvar_37 = (0 == tmpvar_13);
    if (tmpvar_37) {
      tmpvar_38 = bool(1);
    };
    tmpvar_37 = (tmpvar_37 || (1 == tmpvar_13));
    tmpvar_37 = (tmpvar_37 || (2 == tmpvar_13));
    tmpvar_37 = (tmpvar_37 && !(tmpvar_38));
    if (tmpvar_37) {
      k_9 = int(floor((
        (tmpvar_8[2] * 255.0)
       + 0.5)));
      int tmpvar_39;
      tmpvar_39 = ((v_op_table_address_vec.y + offset_10) + (k_9 / 4));
      ivec2 tmpvar_40;
      tmpvar_40.x = int((uint(tmpvar_39) % 1024u));
      tmpvar_40.y = int((uint(tmpvar_39) / 1024u));
      vec4 tmpvar_41;
      tmpvar_41 = texelFetch (sGpuCache, tmpvar_40, 0);
      tmpvar_8[2] = min (max (tmpvar_41[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_38 = bool(1);
    };
    tmpvar_37 = (tmpvar_37 || (3 == tmpvar_13));
    tmpvar_37 = (tmpvar_37 && !(tmpvar_38));
    if (tmpvar_37) {
      int tmpvar_42;
      tmpvar_42 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_43;
      tmpvar_43.x = int((uint(tmpvar_42) % 1024u));
      tmpvar_43.y = int((uint(tmpvar_42) / 1024u));
      vec4 tmpvar_44;
      tmpvar_44 = texelFetch (sGpuCache, tmpvar_43, 0);
      tmpvar_8[2] = min (max ((
        (tmpvar_44[0] * tmpvar_8[2])
       + tmpvar_44[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_38 = bool(1);
    };
    tmpvar_37 = (tmpvar_37 || (4 == tmpvar_13));
    tmpvar_37 = (tmpvar_37 && !(tmpvar_38));
    if (tmpvar_37) {
      int tmpvar_45;
      tmpvar_45 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_46;
      tmpvar_46.x = int((uint(tmpvar_45) % 1024u));
      tmpvar_46.y = int((uint(tmpvar_45) / 1024u));
      vec4 tmpvar_47;
      tmpvar_47 = texelFetch (sGpuCache, tmpvar_46, 0);
      tmpvar_8[2] = min (max ((
        (tmpvar_47[0] * pow (tmpvar_8[2], tmpvar_47[1]))
       + tmpvar_47[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_38 = bool(1);
    };
    tmpvar_37 = !(tmpvar_38);
    if (tmpvar_37) {
      tmpvar_38 = bool(1);
    };
    bool tmpvar_48;
    bool tmpvar_49;
    tmpvar_49 = bool(0);
    tmpvar_48 = (0 == tmpvar_14);
    if (tmpvar_48) {
      tmpvar_49 = bool(1);
    };
    tmpvar_48 = (tmpvar_48 || (1 == tmpvar_14));
    tmpvar_48 = (tmpvar_48 || (2 == tmpvar_14));
    tmpvar_48 = (tmpvar_48 && !(tmpvar_49));
    if (tmpvar_48) {
      k_9 = int(floor((
        (tmpvar_8[3] * 255.0)
       + 0.5)));
      int tmpvar_50;
      tmpvar_50 = ((v_op_table_address_vec.y + offset_10) + (k_9 / 4));
      ivec2 tmpvar_51;
      tmpvar_51.x = int((uint(tmpvar_50) % 1024u));
      tmpvar_51.y = int((uint(tmpvar_50) / 1024u));
      vec4 tmpvar_52;
      tmpvar_52 = texelFetch (sGpuCache, tmpvar_51, 0);
      tmpvar_8[3] = min (max (tmpvar_52[(k_9 % 4)], 0.0), 1.0);
      offset_10 += 64;
      tmpvar_49 = bool(1);
    };
    tmpvar_48 = (tmpvar_48 || (3 == tmpvar_14));
    tmpvar_48 = (tmpvar_48 && !(tmpvar_49));
    if (tmpvar_48) {
      int tmpvar_53;
      tmpvar_53 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_54;
      tmpvar_54.x = int((uint(tmpvar_53) % 1024u));
      tmpvar_54.y = int((uint(tmpvar_53) / 1024u));
      vec4 tmpvar_55;
      tmpvar_55 = texelFetch (sGpuCache, tmpvar_54, 0);
      tmpvar_8[3] = min (max ((
        (tmpvar_55[0] * tmpvar_8[3])
       + tmpvar_55[1]), 0.0), 1.0);
      offset_10++;
      tmpvar_49 = bool(1);
    };
    tmpvar_48 = (tmpvar_48 || (4 == tmpvar_14));
    tmpvar_48 = (tmpvar_48 && !(tmpvar_49));
    if (tmpvar_48) {
      int tmpvar_56;
      tmpvar_56 = (v_op_table_address_vec.y + offset_10);
      ivec2 tmpvar_57;
      tmpvar_57.x = int((uint(tmpvar_56) % 1024u));
      tmpvar_57.y = int((uint(tmpvar_56) / 1024u));
      vec4 tmpvar_58;
      tmpvar_58 = texelFetch (sGpuCache, tmpvar_57, 0);
      tmpvar_8[3] = min (max ((
        (tmpvar_58[0] * pow (tmpvar_8[3], tmpvar_58[1]))
       + tmpvar_58[2]), 0.0), 1.0);
      offset_10++;
      tmpvar_49 = bool(1);
    };
    tmpvar_48 = !(tmpvar_49);
    if (tmpvar_48) {
      tmpvar_49 = bool(1);
    };
    tmpvar_2 = tmpvar_8.xyz;
    tmpvar_3 = tmpvar_8.w;
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = (tmpvar_5 || (10 == v_op_table_address_vec.x));
  tmpvar_5 = (tmpvar_5 && !(tmpvar_6));
  if (tmpvar_5) {
    tmpvar_2 = v_color_offset.xyz;
    tmpvar_3 = v_color_offset.w;
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = !(tmpvar_6);
  if (tmpvar_5) {
    vec4 tmpvar_59;
    tmpvar_59.xyz = tmpvar_2;
    tmpvar_59.w = tmpvar_3;
    vec4 tmpvar_60;
    tmpvar_60 = min (max ((
      (v_color_mat * tmpvar_59)
     + v_color_offset), 0.0), 1.0);
    tmpvar_2 = tmpvar_60.xyz;
    tmpvar_3 = tmpvar_60.w;
  };
  vec4 tmpvar_61;
  tmpvar_61.w = 1.0;
  tmpvar_61.xyz = tmpvar_2;
  oFragColor = (tmpvar_3 * tmpvar_61);
}

