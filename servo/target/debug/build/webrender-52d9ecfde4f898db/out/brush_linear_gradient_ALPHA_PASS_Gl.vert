#version 150
// brush_linear_gradient
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
flat out ivec2 v_gradient_address;
flat out vec2 v_gradient_repeat;
flat out vec2 v_repeated_size;
out vec2 v_pos;
flat out vec2 v_tile_repeat;
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
  vec4 segment_data_34;
  int tmpvar_35;
  tmpvar_35 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_36;
  tmpvar_36 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_32 = tmpvar_7;
    segment_rect_p1_33 = tmpvar_8;
    segment_data_34 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_37;
    tmpvar_37 = ((tmpvar_12.y + 2) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_38;
    tmpvar_38.x = int((uint(tmpvar_37) % 1024u));
    tmpvar_38.y = int((uint(tmpvar_37) / 1024u));
    vec4 tmpvar_39;
    tmpvar_39 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(0, 0));
    segment_rect_p0_32 = (tmpvar_39.xy + tmpvar_5.xy);
    segment_rect_p1_33 = (tmpvar_39.zw + tmpvar_5.xy);
    segment_data_34 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(1, 0));
  };
  adjusted_segment_rect_p0_30 = segment_rect_p0_32;
  adjusted_segment_rect_p1_31 = segment_rect_p1_33;
  if ((!(transform_is_axis_aligned_15) || ((tmpvar_36 & 1024) != 0))) {
    vec2 tmpvar_40;
    tmpvar_40 = min (max (segment_rect_p0_32, tmpvar_6.xy), tmpvar_6.zw);
    vec2 tmpvar_41;
    tmpvar_41 = min (max (segment_rect_p1_33, tmpvar_6.xy), tmpvar_6.zw);
    bvec4 tmpvar_42;
    tmpvar_42.x = bool((tmpvar_35 & 1));
    tmpvar_42.y = bool((tmpvar_35 & 2));
    tmpvar_42.z = bool((tmpvar_35 & 4));
    tmpvar_42.w = bool((tmpvar_35 & 8));
    vec4 tmpvar_43;
    tmpvar_43.xy = tmpvar_40;
    tmpvar_43.zw = tmpvar_41;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_43, bvec4(tmpvar_42));
    vec4 tmpvar_44;
    tmpvar_44 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_42));
    adjusted_segment_rect_p0_30 = (tmpvar_40 - tmpvar_44.xy);
    adjusted_segment_rect_p1_31 = (tmpvar_41 + tmpvar_44.zw);
    tmpvar_28 = vec2(-1e+16, -1e+16);
    tmpvar_29 = vec2(1e+16, 1e+16);
  } else {
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  };
  vec2 tmpvar_45;
  tmpvar_45 = min (max (mix (adjusted_segment_rect_p0_30, adjusted_segment_rect_p1_31, aPosition), tmpvar_28), tmpvar_29);
  vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 1.0);
  tmpvar_46.xy = tmpvar_45;
  vec4 tmpvar_47;
  tmpvar_47 = (transform_m_14 * tmpvar_46);
  vec4 tmpvar_48;
  tmpvar_48.xy = ((tmpvar_47.xy * tmpvar_20.x) + ((
    -(tmpvar_20.yz)
   + tmpvar_19.xy) * tmpvar_47.w));
  tmpvar_48.z = (ph_z_3 * tmpvar_47.w);
  tmpvar_48.w = tmpvar_47.w;
  gl_Position = (uTransform * tmpvar_48);
  vec4 tmpvar_49;
  tmpvar_49.xy = tmpvar_25.p0;
  tmpvar_49.zw = tmpvar_25.p1;
  vClipMaskUvBounds = tmpvar_49;
  vClipMaskUv = ((tmpvar_47.xy * tmpvar_26) + (tmpvar_47.w * (tmpvar_25.p0 - tmpvar_27)));
  ivec2 tmpvar_50;
  tmpvar_50.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_50.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_51;
  vec4 tmpvar_52;
  tmpvar_51 = texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(0, 0));
  tmpvar_52 = texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(1, 0));
  int tmpvar_53;
  tmpvar_53 = int(tmpvar_52.x);
  vec2 tmpvar_54;
  tmpvar_54 = tmpvar_52.yz;
  if (((tmpvar_36 & 2) != 0)) {
    v_pos = ((tmpvar_45 - segment_rect_p0_32) / (segment_rect_p1_33 - segment_rect_p0_32));
    v_pos = ((v_pos * (segment_data_34.zw - segment_data_34.xy)) + segment_data_34.xy);
    v_pos = (v_pos * (tmpvar_5.zw - tmpvar_5.xy));
  } else {
    v_pos = (tmpvar_45 - tmpvar_5.xy);
  };
  v_repeated_size = tmpvar_54;
  v_pos = (v_pos / tmpvar_52.yz);
  v_gradient_address.x = tmpvar_13.x;
  v_gradient_repeat.x = float((tmpvar_53 == 1));
  v_tile_repeat = ((tmpvar_5.zw - tmpvar_5.xy) / tmpvar_52.yz);
  vec2 tmpvar_55;
  tmpvar_55 = (tmpvar_51.zw - tmpvar_51.xy);
  v_scale_dir = (tmpvar_55 / dot (tmpvar_55, tmpvar_55));
  v_start_offset.x = dot (tmpvar_51.xy, v_scale_dir);
  v_scale_dir = (v_scale_dir * tmpvar_52.yz);
  v_local_pos = tmpvar_45;
}

