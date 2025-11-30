#version 150
// brush_mix_blend
// features: ["ALPHA_PASS"]

struct RectWithEndpoint {
  vec2 p0;
  vec2 p1;
};
struct RenderTaskData {
  RectWithEndpoint task_rect;
  vec4 user_data;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec2 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 v_local_pos;
out vec2 v_src_uv;
flat out vec4 v_src_uv_sample_bounds;
out vec2 v_backdrop_uv;
flat out vec4 v_backdrop_uv_sample_bounds;
flat out vec2 v_perspective;
flat out ivec2 v_op;
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
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  tmpvar_9 = tmpvar_6.xy;
  tmpvar_10 = tmpvar_6.zw;
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_11.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(0, 0));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(1, 0));
  ph_z_3 = float(tmpvar_12.x);
  mat4 transform_m_14;
  bool transform_is_axis_aligned_15;
  transform_is_axis_aligned_15 = ((tmpvar_12.z >> 23) == 0);
  int tmpvar_16;
  tmpvar_16 = (tmpvar_12.z & 8388607);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  transform_m_14[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(0, 0));
  transform_m_14[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(1, 0));
  transform_m_14[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(2, 0));
  transform_m_14[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(3, 0));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(tmpvar_12.w)
   % 512u)));
  tmpvar_18.y = int((uint(tmpvar_12.w) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(0, 0));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(1, 0));
  RenderTaskData task_data_21;
  if ((aData.y >= 2147483647)) {
    task_data_21 = RenderTaskData(RectWithEndpoint(vec2(0.0, 0.0), vec2(0.0, 0.0)), vec4(0.0, 0.0, 0.0, 0.0));
  } else {
    RectWithEndpoint task_rect_22;
    ivec2 tmpvar_23;
    tmpvar_23.x = int((2u * (
      uint(aData.y)
     % 512u)));
    tmpvar_23.y = int((uint(aData.y) / 512u));
    vec4 tmpvar_24;
    tmpvar_24 = texelFetchOffset (sRenderTasks, tmpvar_23, 0, ivec2(0, 0));
    task_rect_22.p0 = tmpvar_24.xy;
    task_rect_22.p1 = tmpvar_24.zw;
    task_data_21.task_rect = task_rect_22;
    task_data_21.user_data = texelFetchOffset (sRenderTasks, tmpvar_23, 0, ivec2(1, 0));
  };
  RectWithEndpoint tmpvar_25;
  float tmpvar_26;
  vec2 tmpvar_27;
  tmpvar_25 = task_data_21.task_rect;
  tmpvar_26 = task_data_21.user_data.x;
  tmpvar_27 = task_data_21.user_data.yz;
  vec2 tmpvar_28;
  vec2 tmpvar_29;
  tmpvar_28 = tmpvar_9;
  tmpvar_29 = tmpvar_10;
  vec2 adjusted_segment_rect_p0_30;
  vec2 adjusted_segment_rect_p1_31;
  vec2 segment_rect_p0_32;
  vec2 segment_rect_p1_33;
  int tmpvar_34;
  tmpvar_34 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_35;
  tmpvar_35 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_32 = tmpvar_7;
    segment_rect_p1_33 = tmpvar_8;
  } else {
    int tmpvar_36;
    tmpvar_36 = ((tmpvar_12.y + 3) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_37;
    tmpvar_37.x = int((uint(tmpvar_36) % 1024u));
    tmpvar_37.y = int((uint(tmpvar_36) / 1024u));
    vec4 tmpvar_38;
    tmpvar_38 = texelFetchOffset (sGpuCache, tmpvar_37, 0, ivec2(0, 0));
    segment_rect_p0_32 = (tmpvar_38.xy + tmpvar_5.xy);
    segment_rect_p1_33 = (tmpvar_38.zw + tmpvar_5.xy);
  };
  adjusted_segment_rect_p0_30 = segment_rect_p0_32;
  adjusted_segment_rect_p1_31 = segment_rect_p1_33;
  if ((!(transform_is_axis_aligned_15) || ((tmpvar_35 & 1024) != 0))) {
    vec2 tmpvar_39;
    tmpvar_39 = min (max (segment_rect_p0_32, tmpvar_6.xy), tmpvar_6.zw);
    vec2 tmpvar_40;
    tmpvar_40 = min (max (segment_rect_p1_33, tmpvar_6.xy), tmpvar_6.zw);
    bvec4 tmpvar_41;
    tmpvar_41.x = bool((tmpvar_34 & 1));
    tmpvar_41.y = bool((tmpvar_34 & 2));
    tmpvar_41.z = bool((tmpvar_34 & 4));
    tmpvar_41.w = bool((tmpvar_34 & 8));
    vec4 tmpvar_42;
    tmpvar_42.xy = tmpvar_39;
    tmpvar_42.zw = tmpvar_40;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_42, bvec4(tmpvar_41));
    vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_41));
    adjusted_segment_rect_p0_30 = (tmpvar_39 - tmpvar_43.xy);
    adjusted_segment_rect_p1_31 = (tmpvar_40 + tmpvar_43.zw);
    tmpvar_28 = vec2(-1e+16, -1e+16);
    tmpvar_29 = vec2(1e+16, 1e+16);
  } else {
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  };
  vec2 tmpvar_44;
  tmpvar_44 = min (max (mix (adjusted_segment_rect_p0_30, adjusted_segment_rect_p1_31, aPosition), tmpvar_28), tmpvar_29);
  vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 1.0);
  tmpvar_45.xy = tmpvar_44;
  vec4 tmpvar_46;
  tmpvar_46 = (transform_m_14 * tmpvar_45);
  vec4 tmpvar_47;
  tmpvar_47.xy = ((tmpvar_46.xy * tmpvar_20.x) + ((
    -(tmpvar_20.yz)
   + tmpvar_19.xy) * tmpvar_46.w));
  tmpvar_47.z = (ph_z_3 * tmpvar_46.w);
  tmpvar_47.w = tmpvar_46.w;
  gl_Position = (uTransform * tmpvar_47);
  vec4 tmpvar_48;
  tmpvar_48.xy = tmpvar_25.p0;
  tmpvar_48.zw = tmpvar_25.p1;
  vClipMaskUvBounds = tmpvar_48;
  vClipMaskUv = ((tmpvar_46.xy * tmpvar_26) + (tmpvar_46.w * (tmpvar_25.p0 - tmpvar_27)));
  vec2 tmpvar_49;
  tmpvar_49 = ((tmpvar_44 - tmpvar_5.xy) / (tmpvar_5.zw - tmpvar_5.xy));
  float tmpvar_50;
  if (((tmpvar_35 & 1) != 0)) {
    tmpvar_50 = 1.0;
  } else {
    tmpvar_50 = 0.0;
  };
  v_perspective.x = tmpvar_50;
  v_op.x = tmpvar_13.x;
  vec2 inv_texture_size_51;
  ivec2 tmpvar_52;
  tmpvar_52.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_52.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_53;
  tmpvar_53 = texelFetchOffset (sGpuCache, tmpvar_52, 0, ivec2(0, 0));
  inv_texture_size_51 = (1.0/(vec2(textureSize (sColor0, 0))));
  int tmpvar_54;
  tmpvar_54 = (tmpvar_13.y + 2);
  ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(tmpvar_54) % 1024u));
  tmpvar_55.y = int((uint(tmpvar_54) / 1024u));
  vec4 tmpvar_56;
  tmpvar_56 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(1, 0)), tmpvar_49.x), mix (texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(3, 0)), tmpvar_49.x), tmpvar_49.y);
  vec4 tmpvar_57;
  tmpvar_57.xy = (tmpvar_53.xy + vec2(0.5, 0.5));
  tmpvar_57.zw = (tmpvar_53.zw - vec2(0.5, 0.5));
  v_backdrop_uv = (mix (tmpvar_53.xy, tmpvar_53.zw, (tmpvar_56.xy / tmpvar_56.w)) * inv_texture_size_51);
  v_backdrop_uv_sample_bounds = (tmpvar_57 * inv_texture_size_51.xyxy);
  vec2 inv_texture_size_58;
  ivec2 tmpvar_59;
  tmpvar_59.x = int((uint(tmpvar_13.z) % 1024u));
  tmpvar_59.y = int((uint(tmpvar_13.z) / 1024u));
  vec4 tmpvar_60;
  tmpvar_60 = texelFetchOffset (sGpuCache, tmpvar_59, 0, ivec2(0, 0));
  inv_texture_size_58 = (1.0/(vec2(textureSize (sColor1, 0))));
  int tmpvar_61;
  tmpvar_61 = (tmpvar_13.z + 2);
  ivec2 tmpvar_62;
  tmpvar_62.x = int((uint(tmpvar_61) % 1024u));
  tmpvar_62.y = int((uint(tmpvar_61) / 1024u));
  vec4 tmpvar_63;
  tmpvar_63 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)), tmpvar_49.x), mix (texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(3, 0)), tmpvar_49.x), tmpvar_49.y);
  vec4 tmpvar_64;
  tmpvar_64.xy = (tmpvar_60.xy + vec2(0.5, 0.5));
  tmpvar_64.zw = (tmpvar_60.zw - vec2(0.5, 0.5));
  v_src_uv = ((mix (tmpvar_60.xy, tmpvar_60.zw, 
    (tmpvar_63.xy / tmpvar_63.w)
  ) * inv_texture_size_58) * mix (tmpvar_46.w, 1.0, tmpvar_50));
  v_src_uv_sample_bounds = (tmpvar_64 * inv_texture_size_58.xyxy);
  v_local_pos = tmpvar_44;
}

