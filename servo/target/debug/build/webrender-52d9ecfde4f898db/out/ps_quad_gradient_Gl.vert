#version 150
// ps_quad_gradient
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuBufferF;
uniform isampler2D sGpuBufferI;
flat out vec4 v_color;
flat out ivec4 v_flags;
out vec2 vLocalPos;
in ivec4 aData;
flat out ivec4 v_gradient_header;
out vec4 v_interpolated_data;
flat out vec4 v_flat_data;
flat out vec4 v_stop_offsets;
flat out vec4 v_color0;
flat out vec4 v_color1;
void main ()
{
  float device_pixel_scale_1;
  vec2 local_coverage_rect_p0_2;
  vec2 local_coverage_rect_p1_3;
  vec2 seg_rect_p0_4;
  vec2 seg_rect_p1_5;
  int tmpvar_6;
  int tmpvar_7;
  int tmpvar_8;
  int tmpvar_9;
  tmpvar_6 = ((aData.z >> 24) & 255);
  tmpvar_7 = ((aData.z >> 16) & 255);
  tmpvar_8 = ((aData.z >> 8) & 255);
  tmpvar_9 = (aData.z & 255);
  ivec2 tmpvar_10;
  tmpvar_10.x = int((uint(aData.x) % 1024u));
  tmpvar_10.y = int((uint(aData.x) / 1024u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetch (sGpuBufferI, tmpvar_10, 0);
  mat4 transform_m_12;
  mat4 transform_inv_m_13;
  int tmpvar_14;
  tmpvar_14 = (tmpvar_11.x & 8388607);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_12[0] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(0, 0));
  transform_m_12[1] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(1, 0));
  transform_m_12[2] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(2, 0));
  transform_m_12[3] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(3, 0));
  transform_inv_m_13[0] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(4, 0));
  transform_inv_m_13[1] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(5, 0));
  transform_inv_m_13[2] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(6, 0));
  transform_inv_m_13[3] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(7, 0));
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_16.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(0, 0));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(1, 0));
  float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  ivec2 tmpvar_20;
  tmpvar_20.x = int((uint(aData.y) % 1024u));
  tmpvar_20.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_21;
  vec4 tmpvar_22;
  vec4 tmpvar_23;
  vec4 tmpvar_24;
  tmpvar_21 = texelFetchOffset (sGpuBufferF, tmpvar_20, 0, ivec2(0, 0));
  tmpvar_22 = texelFetchOffset (sGpuBufferF, tmpvar_20, 0, ivec2(1, 0));
  tmpvar_23 = texelFetchOffset (sGpuBufferF, tmpvar_20, 0, ivec2(3, 0));
  tmpvar_24 = texelFetchOffset (sGpuBufferF, tmpvar_20, 0, ivec2(4, 0));
  vec2 tmpvar_25;
  vec2 tmpvar_26;
  tmpvar_25 = tmpvar_21.xy;
  tmpvar_26 = tmpvar_21.zw;
  float tmpvar_27;
  tmpvar_27 = float(tmpvar_11.y);
  if ((tmpvar_9 == 255)) {
    seg_rect_p0_4 = tmpvar_25;
    seg_rect_p1_5 = tmpvar_26;
  } else {
    int tmpvar_28;
    tmpvar_28 = ((aData.y + 5) + (tmpvar_9 * 2));
    ivec2 tmpvar_29;
    tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
    tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
    vec4 tmpvar_30;
    tmpvar_30 = texelFetchOffset (sGpuBufferF, tmpvar_29, 0, ivec2(0, 0));
    seg_rect_p0_4 = tmpvar_30.xy;
    seg_rect_p1_5 = tmpvar_30.zw;
  };
  vec2 tmpvar_31;
  tmpvar_31 = max (seg_rect_p0_4, tmpvar_22.xy);
  local_coverage_rect_p0_2 = tmpvar_31;
  vec2 tmpvar_32;
  tmpvar_32 = max (tmpvar_31, min (seg_rect_p1_5, tmpvar_22.zw));
  local_coverage_rect_p1_3 = tmpvar_32;
  bool tmpvar_33;
  bool tmpvar_34;
  tmpvar_34 = bool(0);
  tmpvar_33 = (1 == tmpvar_8);
  if (tmpvar_33) {
    local_coverage_rect_p1_3.x = (tmpvar_31.x + 2.0);
    local_coverage_rect_p0_2 = (tmpvar_31 - vec2(2.0, 2.0));
    local_coverage_rect_p1_3.y = (tmpvar_32.y + 2.0);
    tmpvar_34 = bool(1);
  };
  tmpvar_33 = (tmpvar_33 || (2 == tmpvar_8));
  tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
  if (tmpvar_33) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p0_2.y + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    tmpvar_34 = bool(1);
  };
  tmpvar_33 = (tmpvar_33 || (3 == tmpvar_8));
  tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
  if (tmpvar_33) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_34 = bool(1);
  };
  tmpvar_33 = (tmpvar_33 || (4 == tmpvar_8));
  tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
  if (tmpvar_33) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p1_3.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_34 = bool(1);
  };
  tmpvar_33 = (tmpvar_33 || (0 == tmpvar_8));
  tmpvar_33 = (tmpvar_33 && !(tmpvar_34));
  if (tmpvar_33) {
    float tmpvar_35;
    if (((tmpvar_7 & 1) != 0)) {
      tmpvar_35 = 2.0;
    } else {
      tmpvar_35 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + tmpvar_35);
    float tmpvar_36;
    if (((tmpvar_7 & 4) != 0)) {
      tmpvar_36 = 2.0;
    } else {
      tmpvar_36 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - tmpvar_36);
    float tmpvar_37;
    if (((tmpvar_7 & 2) != 0)) {
      tmpvar_37 = 2.0;
    } else {
      tmpvar_37 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y + tmpvar_37);
    float tmpvar_38;
    if (((tmpvar_7 & 8) != 0)) {
      tmpvar_38 = 2.0;
    } else {
      tmpvar_38 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y - tmpvar_38);
    tmpvar_34 = bool(1);
  };
  tmpvar_33 = !(tmpvar_34);
  if (tmpvar_33) {
    float tmpvar_39;
    if (((tmpvar_7 & 1) != 0)) {
      tmpvar_39 = 2.0;
    } else {
      tmpvar_39 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x - tmpvar_39);
    float tmpvar_40;
    if (((tmpvar_7 & 4) != 0)) {
      tmpvar_40 = 2.0;
    } else {
      tmpvar_40 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + tmpvar_40);
    float tmpvar_41;
    if (((tmpvar_7 & 2) != 0)) {
      tmpvar_41 = 2.0;
    } else {
      tmpvar_41 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - tmpvar_41);
    float tmpvar_42;
    if (((tmpvar_7 & 8) != 0)) {
      tmpvar_42 = 2.0;
    } else {
      tmpvar_42 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + tmpvar_42);
    tmpvar_34 = bool(1);
  };
  vec2 tmpvar_43;
  tmpvar_43 = mix (local_coverage_rect_p0_2, local_coverage_rect_p1_3, aPosition);
  device_pixel_scale_1 = tmpvar_19;
  if (((tmpvar_6 & 4) != 0)) {
    device_pixel_scale_1 = 1.0;
  };
  vec2 device_pos_44;
  vec2 vi_local_pos_45;
  vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 1.0);
  tmpvar_46.xy = tmpvar_43;
  vec4 tmpvar_47;
  tmpvar_47 = (transform_m_12 * tmpvar_46);
  vec2 tmpvar_48;
  tmpvar_48 = (tmpvar_47.xy * device_pixel_scale_1);
  device_pos_44 = tmpvar_48;
  if (((tmpvar_6 & 2) != 0)) {
    vec2 tmpvar_49;
    tmpvar_49 = min (max (tmpvar_48, tmpvar_18.yz), ((tmpvar_18.yz + tmpvar_17.zw) - tmpvar_17.xy));
    device_pos_44 = tmpvar_49;
    vec4 tmpvar_50;
    tmpvar_50.zw = vec2(0.0, 1.0);
    tmpvar_50.xy = (tmpvar_49 / device_pixel_scale_1);
    vi_local_pos_45 = (transform_inv_m_13 * tmpvar_50).xy;
  } else {
    vi_local_pos_45 = tmpvar_43;
  };
  vec4 tmpvar_51;
  tmpvar_51.xy = (device_pos_44 + ((
    -(tmpvar_18.yz)
   + tmpvar_17.xy) * tmpvar_47.w));
  tmpvar_51.z = (tmpvar_27 * tmpvar_47.w);
  tmpvar_51.w = tmpvar_47.w;
  gl_Position = (uTransform * tmpvar_51);
  v_color = tmpvar_24;
  seg_rect_p0_4 = ((seg_rect_p0_4 * tmpvar_23.xy) + tmpvar_23.zw);
  seg_rect_p1_5 = ((seg_rect_p1_5 * tmpvar_23.xy) + tmpvar_23.zw);
  vec2 tmpvar_52;
  tmpvar_52 = ((vi_local_pos_45 * tmpvar_23.xy) + tmpvar_23.zw);
  vec2 tmpvar_53;
  vec2 tmpvar_54;
  tmpvar_53 = ((tmpvar_21.xy * tmpvar_23.xy) + tmpvar_23.zw);
  tmpvar_54 = ((tmpvar_21.zw * tmpvar_23.xy) + tmpvar_23.zw);
  vec2 tmpvar_55;
  vec2 tmpvar_56;
  tmpvar_55 = ((tmpvar_22.xy * tmpvar_23.xy) + tmpvar_23.zw);
  tmpvar_56 = ((tmpvar_22.zw * tmpvar_23.xy) + tmpvar_23.zw);
  if (((tmpvar_6 & 16) != 0)) {
    v_flags.z = 1;
  } else {
    v_flags.z = 0;
  };
  vec4 tmpvar_57;
  tmpvar_57.xy = max (tmpvar_53, tmpvar_55);
  tmpvar_57.zw = min (tmpvar_54, tmpvar_56);
  vTransformBounds = tmpvar_57;
  vLocalPos = tmpvar_52;
  if ((tmpvar_7 == 0)) {
    v_flags.w = 0;
  } else {
    v_flags.w = 1;
  };
  ivec2 tmpvar_58;
  tmpvar_58.x = int((uint(tmpvar_11.z) % 1024u));
  tmpvar_58.y = int((uint(tmpvar_11.z) / 1024u));
  vec4 tmpvar_59;
  vec4 tmpvar_60;
  tmpvar_59 = texelFetchOffset (sGpuBufferF, tmpvar_58, 0, ivec2(0, 0));
  tmpvar_60 = texelFetchOffset (sGpuBufferF, tmpvar_58, 0, ivec2(1, 0));
  ivec4 tmpvar_61;
  tmpvar_61.xyz = ivec3(texelFetchOffset (sGpuBufferF, tmpvar_58, 0, ivec2(2, 0)).xyz);
  tmpvar_61.w = (3 + tmpvar_11.z);
  vec2 tmpvar_62;
  tmpvar_62 = (tmpvar_52 - tmpvar_53);
  bool tmpvar_63;
  bool tmpvar_64;
  tmpvar_64 = bool(0);
  tmpvar_63 = (0 == tmpvar_61.x);
  if (tmpvar_63) {
    vec2 dir_65;
    vec2 tmpvar_66;
    tmpvar_66 = (tmpvar_59.zw - tmpvar_59.xy);
    dir_65 = (tmpvar_66 / dot (tmpvar_66, tmpvar_66));
    vec4 tmpvar_67;
    tmpvar_67.zw = vec2(0.0, 0.0);
    tmpvar_67.xy = tmpvar_62;
    v_interpolated_data = tmpvar_67;
    vec4 tmpvar_68;
    tmpvar_68.w = 0.0;
    tmpvar_68.xy = dir_65;
    tmpvar_68.z = dot (tmpvar_59.xy, dir_65);
    v_flat_data = tmpvar_68;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (1 == tmpvar_61.x));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    vec2 normalized_pos_69;
    float start_radius_70;
    start_radius_70 = tmpvar_60.x;
    float tmpvar_71;
    tmpvar_71 = (tmpvar_60.y - tmpvar_60.x);
    float tmpvar_72;
    if ((tmpvar_71 != 0.0)) {
      tmpvar_72 = (1.0/(tmpvar_71));
    } else {
      tmpvar_72 = 0.0;
    };
    start_radius_70 = (tmpvar_60.x * tmpvar_72);
    vec2 tmpvar_73;
    tmpvar_73 = (((tmpvar_62 * tmpvar_59.zw) - tmpvar_59.xy) * tmpvar_72);
    normalized_pos_69.x = tmpvar_73.x;
    normalized_pos_69.y = (tmpvar_73.y * tmpvar_60.z);
    vec4 tmpvar_74;
    tmpvar_74.zw = vec2(0.0, 0.0);
    tmpvar_74.xy = normalized_pos_69;
    v_interpolated_data = tmpvar_74;
    vec4 tmpvar_75;
    tmpvar_75.yzw = vec3(0.0, 0.0, 0.0);
    tmpvar_75.x = start_radius_70;
    v_flat_data = tmpvar_75;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = (tmpvar_63 || (2 == tmpvar_61.x));
  tmpvar_63 = (tmpvar_63 && !(tmpvar_64));
  if (tmpvar_63) {
    float start_offset_76;
    start_offset_76 = tmpvar_60.x;
    float tmpvar_77;
    tmpvar_77 = (1.570796 - tmpvar_60.z);
    float tmpvar_78;
    tmpvar_78 = (tmpvar_60.y - tmpvar_60.x);
    float tmpvar_79;
    if ((tmpvar_78 != 0.0)) {
      tmpvar_79 = (1.0/(tmpvar_78));
    } else {
      tmpvar_79 = 0.0;
    };
    start_offset_76 = (tmpvar_60.x * tmpvar_79);
    vec4 tmpvar_80;
    tmpvar_80.xy = ((tmpvar_62 * tmpvar_59.zw) - tmpvar_59.xy);
    tmpvar_80.z = start_offset_76;
    tmpvar_80.w = tmpvar_79;
    v_interpolated_data = tmpvar_80;
    vec4 tmpvar_81;
    tmpvar_81.yzw = vec3(0.0, 0.0, 0.0);
    tmpvar_81.x = tmpvar_77;
    v_flat_data = tmpvar_81;
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = !(tmpvar_64);
  if (tmpvar_63) {
    v_interpolated_data = vec4(0.0, 0.0, 0.0, 0.0);
    v_flat_data = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_64 = bool(1);
  };
  int tmpvar_82;
  tmpvar_82 = (tmpvar_61.w + tmpvar_61.y);
  ivec2 tmpvar_83;
  tmpvar_83.x = int((uint(tmpvar_82) % 1024u));
  tmpvar_83.y = int((uint(tmpvar_82) / 1024u));
  v_stop_offsets = texelFetch (sGpuBufferF, tmpvar_83, 0);
  v_gradient_header = tmpvar_61;
  if ((tmpvar_61.y == 2)) {
    ivec2 tmpvar_84;
    tmpvar_84.x = int((uint(tmpvar_61.w) % 1024u));
    tmpvar_84.y = int((uint(tmpvar_61.w) / 1024u));
    v_color0 = texelFetchOffset (sGpuBufferF, tmpvar_84, 0, ivec2(0, 0));
    v_color1 = texelFetchOffset (sGpuBufferF, tmpvar_84, 0, ivec2(1, 0));
  };
}

