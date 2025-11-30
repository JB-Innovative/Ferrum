#version 150
// ps_quad_radial_gradient
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
flat out ivec2 v_gradient_address;
flat out vec2 v_gradient_repeat;
flat out vec2 v_start_radius;
out vec2 v_pos;
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
  ivec2 tmpvar_12;
  tmpvar_12 = tmpvar_11.zw;
  mat4 transform_m_13;
  mat4 transform_inv_m_14;
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.x & 8388607);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  transform_m_13[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  transform_m_13[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  transform_m_13[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  transform_m_13[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  transform_inv_m_14[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(4, 0));
  transform_inv_m_14[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(5, 0));
  transform_inv_m_14[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(6, 0));
  transform_inv_m_14[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(7, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_17.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  float tmpvar_20;
  tmpvar_20 = tmpvar_19.x;
  ivec2 tmpvar_21;
  tmpvar_21.x = int((uint(aData.y) % 1024u));
  tmpvar_21.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_22;
  vec4 tmpvar_23;
  vec4 tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_22 = texelFetchOffset (sGpuBufferF, tmpvar_21, 0, ivec2(0, 0));
  tmpvar_23 = texelFetchOffset (sGpuBufferF, tmpvar_21, 0, ivec2(1, 0));
  tmpvar_24 = texelFetchOffset (sGpuBufferF, tmpvar_21, 0, ivec2(3, 0));
  tmpvar_25 = texelFetchOffset (sGpuBufferF, tmpvar_21, 0, ivec2(4, 0));
  vec2 tmpvar_26;
  vec2 tmpvar_27;
  tmpvar_26 = tmpvar_22.xy;
  tmpvar_27 = tmpvar_22.zw;
  float tmpvar_28;
  tmpvar_28 = float(tmpvar_11.y);
  if ((tmpvar_9 == 255)) {
    seg_rect_p0_4 = tmpvar_26;
    seg_rect_p1_5 = tmpvar_27;
  } else {
    int tmpvar_29;
    tmpvar_29 = ((aData.y + 5) + (tmpvar_9 * 2));
    ivec2 tmpvar_30;
    tmpvar_30.x = int((uint(tmpvar_29) % 1024u));
    tmpvar_30.y = int((uint(tmpvar_29) / 1024u));
    vec4 tmpvar_31;
    tmpvar_31 = texelFetchOffset (sGpuBufferF, tmpvar_30, 0, ivec2(0, 0));
    seg_rect_p0_4 = tmpvar_31.xy;
    seg_rect_p1_5 = tmpvar_31.zw;
  };
  vec2 tmpvar_32;
  tmpvar_32 = max (seg_rect_p0_4, tmpvar_23.xy);
  local_coverage_rect_p0_2 = tmpvar_32;
  vec2 tmpvar_33;
  tmpvar_33 = max (tmpvar_32, min (seg_rect_p1_5, tmpvar_23.zw));
  local_coverage_rect_p1_3 = tmpvar_33;
  bool tmpvar_34;
  bool tmpvar_35;
  tmpvar_35 = bool(0);
  tmpvar_34 = (1 == tmpvar_8);
  if (tmpvar_34) {
    local_coverage_rect_p1_3.x = (tmpvar_32.x + 2.0);
    local_coverage_rect_p0_2 = (tmpvar_32 - vec2(2.0, 2.0));
    local_coverage_rect_p1_3.y = (tmpvar_33.y + 2.0);
    tmpvar_35 = bool(1);
  };
  tmpvar_34 = (tmpvar_34 || (2 == tmpvar_8));
  tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
  if (tmpvar_34) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p0_2.y + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    tmpvar_35 = bool(1);
  };
  tmpvar_34 = (tmpvar_34 || (3 == tmpvar_8));
  tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
  if (tmpvar_34) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_35 = bool(1);
  };
  tmpvar_34 = (tmpvar_34 || (4 == tmpvar_8));
  tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
  if (tmpvar_34) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p1_3.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_35 = bool(1);
  };
  tmpvar_34 = (tmpvar_34 || (0 == tmpvar_8));
  tmpvar_34 = (tmpvar_34 && !(tmpvar_35));
  if (tmpvar_34) {
    float tmpvar_36;
    if (((tmpvar_7 & 1) != 0)) {
      tmpvar_36 = 2.0;
    } else {
      tmpvar_36 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + tmpvar_36);
    float tmpvar_37;
    if (((tmpvar_7 & 4) != 0)) {
      tmpvar_37 = 2.0;
    } else {
      tmpvar_37 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - tmpvar_37);
    float tmpvar_38;
    if (((tmpvar_7 & 2) != 0)) {
      tmpvar_38 = 2.0;
    } else {
      tmpvar_38 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y + tmpvar_38);
    float tmpvar_39;
    if (((tmpvar_7 & 8) != 0)) {
      tmpvar_39 = 2.0;
    } else {
      tmpvar_39 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y - tmpvar_39);
    tmpvar_35 = bool(1);
  };
  tmpvar_34 = !(tmpvar_35);
  if (tmpvar_34) {
    float tmpvar_40;
    if (((tmpvar_7 & 1) != 0)) {
      tmpvar_40 = 2.0;
    } else {
      tmpvar_40 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x - tmpvar_40);
    float tmpvar_41;
    if (((tmpvar_7 & 4) != 0)) {
      tmpvar_41 = 2.0;
    } else {
      tmpvar_41 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + tmpvar_41);
    float tmpvar_42;
    if (((tmpvar_7 & 2) != 0)) {
      tmpvar_42 = 2.0;
    } else {
      tmpvar_42 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - tmpvar_42);
    float tmpvar_43;
    if (((tmpvar_7 & 8) != 0)) {
      tmpvar_43 = 2.0;
    } else {
      tmpvar_43 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + tmpvar_43);
    tmpvar_35 = bool(1);
  };
  vec2 tmpvar_44;
  tmpvar_44 = mix (local_coverage_rect_p0_2, local_coverage_rect_p1_3, aPosition);
  device_pixel_scale_1 = tmpvar_20;
  if (((tmpvar_6 & 4) != 0)) {
    device_pixel_scale_1 = 1.0;
  };
  vec2 device_pos_45;
  vec2 vi_local_pos_46;
  vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 1.0);
  tmpvar_47.xy = tmpvar_44;
  vec4 tmpvar_48;
  tmpvar_48 = (transform_m_13 * tmpvar_47);
  vec2 tmpvar_49;
  tmpvar_49 = (tmpvar_48.xy * device_pixel_scale_1);
  device_pos_45 = tmpvar_49;
  if (((tmpvar_6 & 2) != 0)) {
    vec2 tmpvar_50;
    tmpvar_50 = min (max (tmpvar_49, tmpvar_19.yz), ((tmpvar_19.yz + tmpvar_18.zw) - tmpvar_18.xy));
    device_pos_45 = tmpvar_50;
    vec4 tmpvar_51;
    tmpvar_51.zw = vec2(0.0, 1.0);
    tmpvar_51.xy = (tmpvar_50 / device_pixel_scale_1);
    vi_local_pos_46 = (transform_inv_m_14 * tmpvar_51).xy;
  } else {
    vi_local_pos_46 = tmpvar_44;
  };
  vec4 tmpvar_52;
  tmpvar_52.xy = (device_pos_45 + ((
    -(tmpvar_19.yz)
   + tmpvar_18.xy) * tmpvar_48.w));
  tmpvar_52.z = (tmpvar_28 * tmpvar_48.w);
  tmpvar_52.w = tmpvar_48.w;
  gl_Position = (uTransform * tmpvar_52);
  v_color = tmpvar_25;
  seg_rect_p0_4 = ((seg_rect_p0_4 * tmpvar_24.xy) + tmpvar_24.zw);
  seg_rect_p1_5 = ((seg_rect_p1_5 * tmpvar_24.xy) + tmpvar_24.zw);
  vec2 tmpvar_53;
  tmpvar_53 = ((vi_local_pos_46 * tmpvar_24.xy) + tmpvar_24.zw);
  vec2 tmpvar_54;
  vec2 tmpvar_55;
  tmpvar_54 = ((tmpvar_22.xy * tmpvar_24.xy) + tmpvar_24.zw);
  tmpvar_55 = ((tmpvar_22.zw * tmpvar_24.xy) + tmpvar_24.zw);
  vec2 tmpvar_56;
  vec2 tmpvar_57;
  tmpvar_56 = ((tmpvar_23.xy * tmpvar_24.xy) + tmpvar_24.zw);
  tmpvar_57 = ((tmpvar_23.zw * tmpvar_24.xy) + tmpvar_24.zw);
  if (((tmpvar_6 & 16) != 0)) {
    v_flags.z = 1;
  } else {
    v_flags.z = 0;
  };
  vec4 tmpvar_58;
  tmpvar_58.xy = max (tmpvar_54, tmpvar_56);
  tmpvar_58.zw = min (tmpvar_55, tmpvar_57);
  vTransformBounds = tmpvar_58;
  vLocalPos = tmpvar_53;
  if ((tmpvar_7 == 0)) {
    v_flags.w = 0;
  } else {
    v_flags.w = 1;
  };
  ivec2 tmpvar_59;
  tmpvar_59.x = int((uint(tmpvar_11.z) % 1024u));
  tmpvar_59.y = int((uint(tmpvar_11.z) / 1024u));
  vec4 tmpvar_60;
  vec4 tmpvar_61;
  tmpvar_60 = texelFetchOffset (sGpuBufferF, tmpvar_59, 0, ivec2(0, 0));
  tmpvar_61 = texelFetchOffset (sGpuBufferF, tmpvar_59, 0, ivec2(1, 0));
  float tmpvar_62;
  tmpvar_62 = tmpvar_61.w;
  v_gradient_address.x = tmpvar_12.y;
  float tmpvar_63;
  tmpvar_63 = (tmpvar_61.y - tmpvar_61.x);
  float tmpvar_64;
  if ((tmpvar_63 != 0.0)) {
    tmpvar_64 = (1.0/(tmpvar_63));
  } else {
    tmpvar_64 = 0.0;
  };
  v_start_radius.x = (tmpvar_61.x * tmpvar_64);
  v_pos = (((
    (tmpvar_53 - tmpvar_54)
   * tmpvar_60.zw) - tmpvar_60.xy) * tmpvar_64);
  v_pos.y = (v_pos.y * tmpvar_61.z);
  v_gradient_repeat.x = tmpvar_62;
}

