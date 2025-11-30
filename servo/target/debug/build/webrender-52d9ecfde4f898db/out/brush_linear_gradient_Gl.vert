#version 150
// brush_linear_gradient
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out ivec2 v_gradient_address;
flat out vec2 v_gradient_repeat;
flat out vec2 v_repeated_size;
out vec2 v_pos;
flat out vec2 v_start_offset;
flat out vec2 v_scale_dir;
void main ()
{
  int instance_segment_index_1;
  int instance_flags_2;
  instance_segment_index_1 = (aData.z & 65535);
  instance_flags_2 = (aData.z >> 16);
  float ph_z_3;
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_4.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(0, 0));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(1, 0));
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_7 = tmpvar_5.xy;
  tmpvar_8 = tmpvar_5.zw;
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_9.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(0, 0));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(1, 0));
  ph_z_3 = float(tmpvar_10.x);
  mat4 transform_m_12;
  bool transform_is_axis_aligned_13;
  transform_is_axis_aligned_13 = ((tmpvar_10.z >> 23) == 0);
  int tmpvar_14;
  tmpvar_14 = (tmpvar_10.z & 8388607);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_12[0] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(0, 0));
  transform_m_12[1] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(1, 0));
  transform_m_12[2] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(2, 0));
  transform_m_12[3] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(3, 0));
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(tmpvar_10.w)
   % 512u)));
  tmpvar_16.y = int((uint(tmpvar_10.w) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(0, 0));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(1, 0));
  vec2 tmpvar_19;
  vec2 tmpvar_20;
  tmpvar_19 = tmpvar_6.xy;
  tmpvar_20 = tmpvar_6.zw;
  vec2 adjusted_segment_rect_p0_21;
  vec2 adjusted_segment_rect_p1_22;
  vec2 segment_rect_p0_23;
  vec2 segment_rect_p1_24;
  vec4 segment_data_25;
  int tmpvar_26;
  tmpvar_26 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_27;
  tmpvar_27 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_23 = tmpvar_7;
    segment_rect_p1_24 = tmpvar_8;
    segment_data_25 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_28;
    tmpvar_28 = ((tmpvar_10.y + 2) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_29;
    tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
    tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
    vec4 tmpvar_30;
    tmpvar_30 = texelFetchOffset (sGpuCache, tmpvar_29, 0, ivec2(0, 0));
    segment_rect_p0_23 = (tmpvar_30.xy + tmpvar_5.xy);
    segment_rect_p1_24 = (tmpvar_30.zw + tmpvar_5.xy);
    segment_data_25 = texelFetchOffset (sGpuCache, tmpvar_29, 0, ivec2(1, 0));
  };
  adjusted_segment_rect_p0_21 = segment_rect_p0_23;
  adjusted_segment_rect_p1_22 = segment_rect_p1_24;
  if ((!(transform_is_axis_aligned_13) || ((tmpvar_27 & 1024) != 0))) {
    vec2 tmpvar_31;
    tmpvar_31 = min (max (segment_rect_p0_23, tmpvar_6.xy), tmpvar_6.zw);
    vec2 tmpvar_32;
    tmpvar_32 = min (max (segment_rect_p1_24, tmpvar_6.xy), tmpvar_6.zw);
    bvec4 tmpvar_33;
    tmpvar_33.x = bool((tmpvar_26 & 1));
    tmpvar_33.y = bool((tmpvar_26 & 2));
    tmpvar_33.z = bool((tmpvar_26 & 4));
    tmpvar_33.w = bool((tmpvar_26 & 8));
    vec4 tmpvar_34;
    tmpvar_34.xy = tmpvar_31;
    tmpvar_34.zw = tmpvar_32;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_34, bvec4(tmpvar_33));
    vec4 tmpvar_35;
    tmpvar_35 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_33));
    adjusted_segment_rect_p0_21 = (tmpvar_31 - tmpvar_35.xy);
    adjusted_segment_rect_p1_22 = (tmpvar_32 + tmpvar_35.zw);
    tmpvar_19 = vec2(-1e+16, -1e+16);
    tmpvar_20 = vec2(1e+16, 1e+16);
  };
  vec2 tmpvar_36;
  tmpvar_36 = min (max (mix (adjusted_segment_rect_p0_21, adjusted_segment_rect_p1_22, aPosition), tmpvar_19), tmpvar_20);
  vec4 tmpvar_37;
  tmpvar_37.zw = vec2(0.0, 1.0);
  tmpvar_37.xy = tmpvar_36;
  vec4 tmpvar_38;
  tmpvar_38 = (transform_m_12 * tmpvar_37);
  vec4 tmpvar_39;
  tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_18.x) + ((
    -(tmpvar_18.yz)
   + tmpvar_17.xy) * tmpvar_38.w));
  tmpvar_39.z = (ph_z_3 * tmpvar_38.w);
  tmpvar_39.w = tmpvar_38.w;
  gl_Position = (uTransform * tmpvar_39);
  ivec2 tmpvar_40;
  tmpvar_40.x = int((uint(tmpvar_10.y) % 1024u));
  tmpvar_40.y = int((uint(tmpvar_10.y) / 1024u));
  vec4 tmpvar_41;
  vec4 tmpvar_42;
  tmpvar_41 = texelFetchOffset (sGpuCache, tmpvar_40, 0, ivec2(0, 0));
  tmpvar_42 = texelFetchOffset (sGpuCache, tmpvar_40, 0, ivec2(1, 0));
  int tmpvar_43;
  tmpvar_43 = int(tmpvar_42.x);
  vec2 tmpvar_44;
  tmpvar_44 = tmpvar_42.yz;
  if (((tmpvar_27 & 2) != 0)) {
    v_pos = ((tmpvar_36 - segment_rect_p0_23) / (segment_rect_p1_24 - segment_rect_p0_23));
    v_pos = ((v_pos * (segment_data_25.zw - segment_data_25.xy)) + segment_data_25.xy);
    v_pos = (v_pos * (tmpvar_5.zw - tmpvar_5.xy));
  } else {
    v_pos = (tmpvar_36 - tmpvar_5.xy);
  };
  v_repeated_size = tmpvar_44;
  v_pos = (v_pos / tmpvar_42.yz);
  v_gradient_address.x = tmpvar_11.x;
  v_gradient_repeat.x = float((tmpvar_43 == 1));
  vec2 tmpvar_45;
  tmpvar_45 = (tmpvar_41.zw - tmpvar_41.xy);
  v_scale_dir = (tmpvar_45 / dot (tmpvar_45, tmpvar_45));
  v_start_offset.x = dot (tmpvar_41.xy, v_scale_dir);
  v_scale_dir = (v_scale_dir * tmpvar_42.yz);
}

