#version 150
// brush_opacity
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 v_uv;
flat out vec4 v_uv_sample_bounds;
flat out vec2 v_opacity_perspective_vec;
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
  int tmpvar_25;
  tmpvar_25 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_26;
  tmpvar_26 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_23 = tmpvar_7;
    segment_rect_p1_24 = tmpvar_8;
  } else {
    int tmpvar_27;
    tmpvar_27 = ((tmpvar_10.y + 3) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_28;
    tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
    tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
    vec4 tmpvar_29;
    tmpvar_29 = texelFetchOffset (sGpuCache, tmpvar_28, 0, ivec2(0, 0));
    segment_rect_p0_23 = (tmpvar_29.xy + tmpvar_5.xy);
    segment_rect_p1_24 = (tmpvar_29.zw + tmpvar_5.xy);
  };
  adjusted_segment_rect_p0_21 = segment_rect_p0_23;
  adjusted_segment_rect_p1_22 = segment_rect_p1_24;
  if ((!(transform_is_axis_aligned_13) || ((tmpvar_26 & 1024) != 0))) {
    vec2 tmpvar_30;
    tmpvar_30 = min (max (segment_rect_p0_23, tmpvar_6.xy), tmpvar_6.zw);
    vec2 tmpvar_31;
    tmpvar_31 = min (max (segment_rect_p1_24, tmpvar_6.xy), tmpvar_6.zw);
    bvec4 tmpvar_32;
    tmpvar_32.x = bool((tmpvar_25 & 1));
    tmpvar_32.y = bool((tmpvar_25 & 2));
    tmpvar_32.z = bool((tmpvar_25 & 4));
    tmpvar_32.w = bool((tmpvar_25 & 8));
    vec4 tmpvar_33;
    tmpvar_33.xy = tmpvar_30;
    tmpvar_33.zw = tmpvar_31;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_33, bvec4(tmpvar_32));
    vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_32));
    adjusted_segment_rect_p0_21 = (tmpvar_30 - tmpvar_34.xy);
    adjusted_segment_rect_p1_22 = (tmpvar_31 + tmpvar_34.zw);
    tmpvar_19 = vec2(-1e+16, -1e+16);
    tmpvar_20 = vec2(1e+16, 1e+16);
  };
  vec2 tmpvar_35;
  tmpvar_35 = min (max (mix (adjusted_segment_rect_p0_21, adjusted_segment_rect_p1_22, aPosition), tmpvar_19), tmpvar_20);
  vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 1.0);
  tmpvar_36.xy = tmpvar_35;
  vec4 tmpvar_37;
  tmpvar_37 = (transform_m_12 * tmpvar_36);
  vec4 tmpvar_38;
  tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_18.x) + ((
    -(tmpvar_18.yz)
   + tmpvar_17.xy) * tmpvar_37.w));
  tmpvar_38.z = (ph_z_3 * tmpvar_37.w);
  tmpvar_38.w = tmpvar_37.w;
  gl_Position = (uTransform * tmpvar_38);
  ivec2 tmpvar_39;
  tmpvar_39.x = int((uint(tmpvar_11.x) % 1024u));
  tmpvar_39.y = int((uint(tmpvar_11.x) / 1024u));
  vec4 tmpvar_40;
  tmpvar_40 = texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(0, 0));
  vec2 tmpvar_41;
  tmpvar_41 = vec2(textureSize (sColor0, 0));
  vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_35 - tmpvar_5.xy) / (tmpvar_5.zw - tmpvar_5.xy));
  int tmpvar_43;
  tmpvar_43 = (tmpvar_11.x + 2);
  ivec2 tmpvar_44;
  tmpvar_44.x = int((uint(tmpvar_43) % 1024u));
  tmpvar_44.y = int((uint(tmpvar_43) / 1024u));
  vec4 tmpvar_45;
  tmpvar_45 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(1, 0)), tmpvar_42.x), mix (texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(3, 0)), tmpvar_42.x), tmpvar_42.y);
  vec2 tmpvar_46;
  tmpvar_46 = mix (tmpvar_40.xy, tmpvar_40.zw, (tmpvar_45.xy / tmpvar_45.w));
  float tmpvar_47;
  if (((tmpvar_26 & 1) != 0)) {
    tmpvar_47 = 1.0;
  } else {
    tmpvar_47 = 0.0;
  };
  v_uv = ((tmpvar_46 / tmpvar_41) * mix (tmpvar_37.w, 1.0, tmpvar_47));
  v_opacity_perspective_vec.y = tmpvar_47;
  vec4 tmpvar_48;
  tmpvar_48.xy = (tmpvar_40.xy + vec2(0.5, 0.5));
  tmpvar_48.zw = (tmpvar_40.zw - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_48 / tmpvar_41.xyxy);
  v_opacity_perspective_vec.x = min (max ((
    float(tmpvar_11.y)
   / 65536.0), 0.0), 1.0);
}

