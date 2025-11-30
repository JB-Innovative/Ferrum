#version 150
// ps_quad_textured
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuBufferF;
uniform isampler2D sGpuBufferI;
flat out vec4 v_color;
flat out ivec4 v_flags;
out vec2 vLocalPos;
in ivec4 aData;
flat out vec4 v_uv0_sample_bounds;
out vec2 v_uv0;
void main ()
{
  float device_pixel_scale_1;
  vec2 local_coverage_rect_p0_2;
  vec2 local_coverage_rect_p1_3;
  vec2 seg_rect_p0_4;
  vec2 seg_rect_p1_5;
  vec2 seg_uv_rect_p0_6;
  vec2 seg_uv_rect_p1_7;
  int tmpvar_8;
  int tmpvar_9;
  int tmpvar_10;
  int tmpvar_11;
  tmpvar_8 = ((aData.z >> 24) & 255);
  tmpvar_9 = ((aData.z >> 16) & 255);
  tmpvar_10 = ((aData.z >> 8) & 255);
  tmpvar_11 = (aData.z & 255);
  ivec2 tmpvar_12;
  tmpvar_12.x = int((uint(aData.x) % 1024u));
  tmpvar_12.y = int((uint(aData.x) / 1024u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sGpuBufferI, tmpvar_12, 0);
  mat4 transform_m_14;
  mat4 transform_inv_m_15;
  int tmpvar_16;
  tmpvar_16 = (tmpvar_13.x & 8388607);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  transform_m_14[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(0, 0));
  transform_m_14[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(1, 0));
  transform_m_14[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(2, 0));
  transform_m_14[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(3, 0));
  transform_inv_m_15[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(4, 0));
  transform_inv_m_15[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(5, 0));
  transform_inv_m_15[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(6, 0));
  transform_inv_m_15[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(7, 0));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_18.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(0, 0));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(1, 0));
  float tmpvar_21;
  tmpvar_21 = tmpvar_20.x;
  ivec2 tmpvar_22;
  tmpvar_22.x = int((uint(aData.y) % 1024u));
  tmpvar_22.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_23;
  vec4 tmpvar_24;
  vec4 tmpvar_25;
  vec4 tmpvar_26;
  vec4 tmpvar_27;
  tmpvar_23 = texelFetchOffset (sGpuBufferF, tmpvar_22, 0, ivec2(0, 0));
  tmpvar_24 = texelFetchOffset (sGpuBufferF, tmpvar_22, 0, ivec2(1, 0));
  tmpvar_25 = texelFetchOffset (sGpuBufferF, tmpvar_22, 0, ivec2(2, 0));
  tmpvar_26 = texelFetchOffset (sGpuBufferF, tmpvar_22, 0, ivec2(3, 0));
  tmpvar_27 = texelFetchOffset (sGpuBufferF, tmpvar_22, 0, ivec2(4, 0));
  vec2 tmpvar_28;
  vec2 tmpvar_29;
  tmpvar_28 = tmpvar_23.xy;
  tmpvar_29 = tmpvar_23.zw;
  vec2 tmpvar_30;
  vec2 tmpvar_31;
  tmpvar_30 = tmpvar_25.xy;
  tmpvar_31 = tmpvar_25.zw;
  float tmpvar_32;
  tmpvar_32 = float(tmpvar_13.y);
  if ((tmpvar_11 == 255)) {
    seg_rect_p0_4 = tmpvar_28;
    seg_rect_p1_5 = tmpvar_29;
    seg_uv_rect_p0_6 = tmpvar_30;
    seg_uv_rect_p1_7 = tmpvar_31;
  } else {
    int tmpvar_33;
    tmpvar_33 = ((aData.y + 5) + (tmpvar_11 * 2));
    ivec2 tmpvar_34;
    tmpvar_34.x = int((uint(tmpvar_33) % 1024u));
    tmpvar_34.y = int((uint(tmpvar_33) / 1024u));
    vec4 tmpvar_35;
    vec4 tmpvar_36;
    tmpvar_35 = texelFetchOffset (sGpuBufferF, tmpvar_34, 0, ivec2(0, 0));
    tmpvar_36 = texelFetchOffset (sGpuBufferF, tmpvar_34, 0, ivec2(1, 0));
    seg_rect_p0_4 = tmpvar_35.xy;
    seg_rect_p1_5 = tmpvar_35.zw;
    seg_uv_rect_p0_6 = tmpvar_36.xy;
    seg_uv_rect_p1_7 = tmpvar_36.zw;
  };
  vec2 tmpvar_37;
  tmpvar_37 = max (seg_rect_p0_4, tmpvar_24.xy);
  local_coverage_rect_p0_2 = tmpvar_37;
  vec2 tmpvar_38;
  tmpvar_38 = max (tmpvar_37, min (seg_rect_p1_5, tmpvar_24.zw));
  local_coverage_rect_p1_3 = tmpvar_38;
  bool tmpvar_39;
  bool tmpvar_40;
  tmpvar_40 = bool(0);
  tmpvar_39 = (1 == tmpvar_10);
  if (tmpvar_39) {
    local_coverage_rect_p1_3.x = (tmpvar_37.x + 2.0);
    local_coverage_rect_p0_2 = (tmpvar_37 - vec2(2.0, 2.0));
    local_coverage_rect_p1_3.y = (tmpvar_38.y + 2.0);
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = (tmpvar_39 || (2 == tmpvar_10));
  tmpvar_39 = (tmpvar_39 && !(tmpvar_40));
  if (tmpvar_39) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p0_2.y + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = (tmpvar_39 || (3 == tmpvar_10));
  tmpvar_39 = (tmpvar_39 && !(tmpvar_40));
  if (tmpvar_39) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = (tmpvar_39 || (4 == tmpvar_10));
  tmpvar_39 = (tmpvar_39 && !(tmpvar_40));
  if (tmpvar_39) {
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + 2.0);
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - 2.0);
    local_coverage_rect_p0_2.y = (local_coverage_rect_p1_3.y - 2.0);
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + 2.0);
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = (tmpvar_39 || (0 == tmpvar_10));
  tmpvar_39 = (tmpvar_39 && !(tmpvar_40));
  if (tmpvar_39) {
    float tmpvar_41;
    if (((tmpvar_9 & 1) != 0)) {
      tmpvar_41 = 2.0;
    } else {
      tmpvar_41 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x + tmpvar_41);
    float tmpvar_42;
    if (((tmpvar_9 & 4) != 0)) {
      tmpvar_42 = 2.0;
    } else {
      tmpvar_42 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x - tmpvar_42);
    float tmpvar_43;
    if (((tmpvar_9 & 2) != 0)) {
      tmpvar_43 = 2.0;
    } else {
      tmpvar_43 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y + tmpvar_43);
    float tmpvar_44;
    if (((tmpvar_9 & 8) != 0)) {
      tmpvar_44 = 2.0;
    } else {
      tmpvar_44 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y - tmpvar_44);
    tmpvar_40 = bool(1);
  };
  tmpvar_39 = !(tmpvar_40);
  if (tmpvar_39) {
    float tmpvar_45;
    if (((tmpvar_9 & 1) != 0)) {
      tmpvar_45 = 2.0;
    } else {
      tmpvar_45 = 0.0;
    };
    local_coverage_rect_p0_2.x = (local_coverage_rect_p0_2.x - tmpvar_45);
    float tmpvar_46;
    if (((tmpvar_9 & 4) != 0)) {
      tmpvar_46 = 2.0;
    } else {
      tmpvar_46 = 0.0;
    };
    local_coverage_rect_p1_3.x = (local_coverage_rect_p1_3.x + tmpvar_46);
    float tmpvar_47;
    if (((tmpvar_9 & 2) != 0)) {
      tmpvar_47 = 2.0;
    } else {
      tmpvar_47 = 0.0;
    };
    local_coverage_rect_p0_2.y = (local_coverage_rect_p0_2.y - tmpvar_47);
    float tmpvar_48;
    if (((tmpvar_9 & 8) != 0)) {
      tmpvar_48 = 2.0;
    } else {
      tmpvar_48 = 0.0;
    };
    local_coverage_rect_p1_3.y = (local_coverage_rect_p1_3.y + tmpvar_48);
    tmpvar_40 = bool(1);
  };
  vec2 tmpvar_49;
  tmpvar_49 = mix (local_coverage_rect_p0_2, local_coverage_rect_p1_3, aPosition);
  device_pixel_scale_1 = tmpvar_21;
  if (((tmpvar_8 & 4) != 0)) {
    device_pixel_scale_1 = 1.0;
  };
  vec2 device_pos_50;
  vec2 vi_local_pos_51;
  vec4 tmpvar_52;
  tmpvar_52.zw = vec2(0.0, 1.0);
  tmpvar_52.xy = tmpvar_49;
  vec4 tmpvar_53;
  tmpvar_53 = (transform_m_14 * tmpvar_52);
  vec2 tmpvar_54;
  tmpvar_54 = (tmpvar_53.xy * device_pixel_scale_1);
  device_pos_50 = tmpvar_54;
  if (((tmpvar_8 & 2) != 0)) {
    vec2 tmpvar_55;
    tmpvar_55 = min (max (tmpvar_54, tmpvar_20.yz), ((tmpvar_20.yz + tmpvar_19.zw) - tmpvar_19.xy));
    device_pos_50 = tmpvar_55;
    vec4 tmpvar_56;
    tmpvar_56.zw = vec2(0.0, 1.0);
    tmpvar_56.xy = (tmpvar_55 / device_pixel_scale_1);
    vi_local_pos_51 = (transform_inv_m_15 * tmpvar_56).xy;
  } else {
    vi_local_pos_51 = tmpvar_49;
  };
  vec4 tmpvar_57;
  tmpvar_57.xy = (device_pos_50 + ((
    -(tmpvar_20.yz)
   + tmpvar_19.xy) * tmpvar_53.w));
  tmpvar_57.z = (tmpvar_32 * tmpvar_53.w);
  tmpvar_57.w = tmpvar_53.w;
  gl_Position = (uTransform * tmpvar_57);
  v_color = tmpvar_27;
  vec2 tmpvar_58;
  vec2 tmpvar_59;
  tmpvar_58 = ((seg_rect_p0_4 * tmpvar_26.xy) + tmpvar_26.zw);
  tmpvar_59 = ((seg_rect_p1_5 * tmpvar_26.xy) + tmpvar_26.zw);
  seg_rect_p0_4 = tmpvar_58;
  seg_rect_p1_5 = tmpvar_59;
  vec2 tmpvar_60;
  tmpvar_60 = ((vi_local_pos_51 * tmpvar_26.xy) + tmpvar_26.zw);
  vec2 tmpvar_61;
  vec2 tmpvar_62;
  tmpvar_61 = ((tmpvar_23.xy * tmpvar_26.xy) + tmpvar_26.zw);
  tmpvar_62 = ((tmpvar_23.zw * tmpvar_26.xy) + tmpvar_26.zw);
  vec2 tmpvar_63;
  vec2 tmpvar_64;
  tmpvar_63 = ((tmpvar_24.xy * tmpvar_26.xy) + tmpvar_26.zw);
  tmpvar_64 = ((tmpvar_24.zw * tmpvar_26.xy) + tmpvar_26.zw);
  if (((tmpvar_8 & 16) != 0)) {
    v_flags.z = 1;
  } else {
    v_flags.z = 0;
  };
  vec4 tmpvar_65;
  tmpvar_65.xy = max (tmpvar_61, tmpvar_63);
  tmpvar_65.zw = min (tmpvar_62, tmpvar_64);
  vTransformBounds = tmpvar_65;
  vLocalPos = tmpvar_60;
  if ((tmpvar_9 == 0)) {
    v_flags.w = 0;
  } else {
    v_flags.w = 1;
  };
  if ((seg_uv_rect_p0_6 != seg_uv_rect_p1_7)) {
    v_flags.x = 1;
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
    vec2 tmpvar_66;
    tmpvar_66 = vec2(textureSize (sColor0, 0));
    v_uv0 = (mix (seg_uv_rect_p0_6, seg_uv_rect_p1_7, (
      (tmpvar_60 - tmpvar_58)
     / 
      (tmpvar_59 - tmpvar_58)
    )) / tmpvar_66);
    vec4 tmpvar_67;
    tmpvar_67.xy = (seg_uv_rect_p0_6 + vec2(0.5, 0.5));
    tmpvar_67.zw = (seg_uv_rect_p1_7 - vec2(0.5, 0.5));
    v_uv0_sample_bounds = (tmpvar_67 / tmpvar_66.xyxy);
  } else {
    v_flags.x = 0;
  };
}

