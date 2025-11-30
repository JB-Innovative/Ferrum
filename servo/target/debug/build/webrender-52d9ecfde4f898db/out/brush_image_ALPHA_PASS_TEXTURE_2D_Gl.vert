#version 150
// brush_image
// features: ["ALPHA_PASS", "TEXTURE_2D"]

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
out vec2 v_uv;
flat out vec4 v_color;
flat out vec2 v_mask_swizzle;
flat out vec2 v_tile_repeat_bounds;
flat out vec4 v_uv_bounds;
flat out vec4 v_uv_sample_bounds;
flat out vec2 v_perspective;
void main ()
{
  int instance_segment_index_1;
  int instance_flags_2;
  int instance_resource_address_3;
  instance_segment_index_1 = (aData.z & 65535);
  instance_flags_2 = (aData.z >> 16);
  instance_resource_address_3 = (aData.w & 16777215);
  float ph_z_4;
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(0, 0));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(1, 0));
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  vec2 tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_10 = tmpvar_7.xy;
  tmpvar_11 = tmpvar_7.zw;
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_12.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(0, 0));
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(1, 0));
  ph_z_4 = float(tmpvar_13.x);
  mat4 transform_m_15;
  bool transform_is_axis_aligned_16;
  transform_is_axis_aligned_16 = ((tmpvar_13.z >> 23) == 0);
  int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 8388607);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  transform_m_15[0] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(0, 0));
  transform_m_15[1] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(1, 0));
  transform_m_15[2] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(2, 0));
  transform_m_15[3] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(3, 0));
  ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(tmpvar_13.w)
   % 512u)));
  tmpvar_19.y = int((uint(tmpvar_13.w) / 512u));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(0, 0));
  vec4 tmpvar_21;
  tmpvar_21 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(1, 0));
  RenderTaskData task_data_22;
  if ((aData.y >= 2147483647)) {
    task_data_22 = RenderTaskData(RectWithEndpoint(vec2(0.0, 0.0), vec2(0.0, 0.0)), vec4(0.0, 0.0, 0.0, 0.0));
  } else {
    RectWithEndpoint task_rect_23;
    ivec2 tmpvar_24;
    tmpvar_24.x = int((2u * (
      uint(aData.y)
     % 512u)));
    tmpvar_24.y = int((uint(aData.y) / 512u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(0, 0));
    task_rect_23.p0 = tmpvar_25.xy;
    task_rect_23.p1 = tmpvar_25.zw;
    task_data_22.task_rect = task_rect_23;
    task_data_22.user_data = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(1, 0));
  };
  RectWithEndpoint tmpvar_26;
  float tmpvar_27;
  vec2 tmpvar_28;
  tmpvar_26 = task_data_22.task_rect;
  tmpvar_27 = task_data_22.user_data.x;
  tmpvar_28 = task_data_22.user_data.yz;
  vec2 tmpvar_29;
  vec2 tmpvar_30;
  tmpvar_29 = tmpvar_10;
  tmpvar_30 = tmpvar_11;
  vec2 adjusted_segment_rect_p0_31;
  vec2 adjusted_segment_rect_p1_32;
  vec2 segment_rect_p0_33;
  vec2 segment_rect_p1_34;
  vec4 segment_data_35;
  int tmpvar_36;
  tmpvar_36 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_37;
  tmpvar_37 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_33 = tmpvar_8;
    segment_rect_p1_34 = tmpvar_9;
    segment_data_35 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_38;
    tmpvar_38 = ((tmpvar_13.y + 3) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_39;
    tmpvar_39.x = int((uint(tmpvar_38) % 1024u));
    tmpvar_39.y = int((uint(tmpvar_38) / 1024u));
    vec4 tmpvar_40;
    tmpvar_40 = texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(0, 0));
    segment_rect_p0_33 = (tmpvar_40.xy + tmpvar_6.xy);
    segment_rect_p1_34 = (tmpvar_40.zw + tmpvar_6.xy);
    segment_data_35 = texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(1, 0));
  };
  adjusted_segment_rect_p0_31 = segment_rect_p0_33;
  adjusted_segment_rect_p1_32 = segment_rect_p1_34;
  if ((!(transform_is_axis_aligned_16) || ((tmpvar_37 & 1024) != 0))) {
    vec2 tmpvar_41;
    tmpvar_41 = min (max (segment_rect_p0_33, tmpvar_7.xy), tmpvar_7.zw);
    vec2 tmpvar_42;
    tmpvar_42 = min (max (segment_rect_p1_34, tmpvar_7.xy), tmpvar_7.zw);
    bvec4 tmpvar_43;
    tmpvar_43.x = bool((tmpvar_36 & 1));
    tmpvar_43.y = bool((tmpvar_36 & 2));
    tmpvar_43.z = bool((tmpvar_36 & 4));
    tmpvar_43.w = bool((tmpvar_36 & 8));
    vec4 tmpvar_44;
    tmpvar_44.xy = tmpvar_41;
    tmpvar_44.zw = tmpvar_42;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_44, bvec4(tmpvar_43));
    vec4 tmpvar_45;
    tmpvar_45 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_43));
    adjusted_segment_rect_p0_31 = (tmpvar_41 - tmpvar_45.xy);
    adjusted_segment_rect_p1_32 = (tmpvar_42 + tmpvar_45.zw);
    tmpvar_29 = vec2(-1e+16, -1e+16);
    tmpvar_30 = vec2(1e+16, 1e+16);
  } else {
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  };
  vec2 tmpvar_46;
  tmpvar_46 = min (max (mix (adjusted_segment_rect_p0_31, adjusted_segment_rect_p1_32, aPosition), tmpvar_29), tmpvar_30);
  vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 1.0);
  tmpvar_47.xy = tmpvar_46;
  vec4 tmpvar_48;
  tmpvar_48 = (transform_m_15 * tmpvar_47);
  vec4 tmpvar_49;
  tmpvar_49.xy = ((tmpvar_48.xy * tmpvar_21.x) + ((
    -(tmpvar_21.yz)
   + tmpvar_20.xy) * tmpvar_48.w));
  tmpvar_49.z = (ph_z_4 * tmpvar_48.w);
  tmpvar_49.w = tmpvar_48.w;
  gl_Position = (uTransform * tmpvar_49);
  vec4 tmpvar_50;
  tmpvar_50.xy = tmpvar_26.p0;
  tmpvar_50.zw = tmpvar_26.p1;
  vClipMaskUvBounds = tmpvar_50;
  vClipMaskUv = ((tmpvar_48.xy * tmpvar_27) + (tmpvar_48.w * (tmpvar_26.p0 - tmpvar_28)));
  vec2 f_51;
  vec2 stretch_size_52;
  vec2 local_rect_p0_53;
  vec2 local_rect_p1_54;
  vec2 uv1_55;
  vec2 uv0_56;
  vec4 image_data_color_57;
  ivec2 tmpvar_58;
  tmpvar_58.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_58.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_59;
  vec4 tmpvar_60;
  tmpvar_59 = texelFetchOffset (sGpuCache, tmpvar_58, 0, ivec2(0, 0));
  tmpvar_60 = texelFetchOffset (sGpuCache, tmpvar_58, 0, ivec2(2, 0));
  image_data_color_57 = tmpvar_59;
  vec2 tmpvar_61;
  tmpvar_61 = vec2(textureSize (sColor0, 0));
  ivec2 tmpvar_62;
  tmpvar_62.x = int((uint(instance_resource_address_3) % 1024u));
  tmpvar_62.y = int((uint(instance_resource_address_3) / 1024u));
  vec4 tmpvar_63;
  tmpvar_63 = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0));
  uv0_56 = tmpvar_63.xy;
  uv1_55 = tmpvar_63.zw;
  local_rect_p0_53 = tmpvar_8;
  local_rect_p1_54 = tmpvar_9;
  stretch_size_52 = tmpvar_60.xy;
  if ((tmpvar_60.x < 0.0)) {
    stretch_size_52 = (tmpvar_6.zw - tmpvar_6.xy);
  };
  if (((tmpvar_37 & 2) != 0)) {
    local_rect_p0_53 = segment_rect_p0_33;
    local_rect_p1_54 = segment_rect_p1_34;
    stretch_size_52 = (segment_rect_p1_34 - segment_rect_p0_33);
    if (((tmpvar_37 & 512) != 0)) {
      vec2 tmpvar_64;
      tmpvar_64 = (tmpvar_63.zw - tmpvar_63.xy);
      uv0_56 = (tmpvar_63.xy + (segment_data_35.xy * tmpvar_64));
      uv1_55 = (tmpvar_63.xy + (segment_data_35.zw * tmpvar_64));
    };
  };
  float tmpvar_65;
  if (((tmpvar_37 & 1) != 0)) {
    tmpvar_65 = 1.0;
  } else {
    tmpvar_65 = 0.0;
  };
  v_perspective.x = tmpvar_65;
  vec2 tmpvar_66;
  tmpvar_66 = mix(vec2(1.0, 1.0), tmpvar_61, bvec2(((tmpvar_37 & 2048) != 0)));
  uv0_56 = (uv0_56 * tmpvar_66);
  uv1_55 = (uv1_55 * tmpvar_66);
  vec2 tmpvar_67;
  tmpvar_67 = min (uv0_56, uv1_55);
  vec2 tmpvar_68;
  tmpvar_68 = max (uv0_56, uv1_55);
  vec4 tmpvar_69;
  tmpvar_69.xy = (tmpvar_67 + vec2(0.5, 0.5));
  tmpvar_69.zw = (tmpvar_68 - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_69 / tmpvar_61.xyxy);
  vec2 tmpvar_70;
  tmpvar_70 = ((tmpvar_46 - local_rect_p0_53) / (local_rect_p1_54 - local_rect_p0_53));
  f_51 = tmpvar_70;
  int tmpvar_71;
  tmpvar_71 = (tmpvar_14.x & 65535);
  int tmpvar_72;
  tmpvar_72 = (tmpvar_14.x >> 16);
  if ((tmpvar_14.y == 1)) {
    int tmpvar_73;
    tmpvar_73 = (instance_resource_address_3 + 2);
    ivec2 tmpvar_74;
    tmpvar_74.x = int((uint(tmpvar_73) % 1024u));
    tmpvar_74.y = int((uint(tmpvar_73) / 1024u));
    vec4 tmpvar_75;
    tmpvar_75 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(1, 0)), tmpvar_70.x), mix (texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(3, 0)), tmpvar_70.x), tmpvar_70.y);
    f_51 = (tmpvar_75.xy / tmpvar_75.w);
  };
  vec2 tmpvar_76;
  tmpvar_76 = ((local_rect_p1_54 - local_rect_p0_53) / stretch_size_52);
  v_uv = (mix (uv0_56, uv1_55, f_51) - tmpvar_67);
  v_uv = (v_uv * tmpvar_76);
  v_uv = (v_uv / tmpvar_61);
  if ((tmpvar_65 == 0.0)) {
    v_uv = (v_uv * tmpvar_48.w);
  };
  vec4 tmpvar_77;
  tmpvar_77.xy = tmpvar_67;
  tmpvar_77.zw = tmpvar_68;
  v_uv_bounds = (tmpvar_77 / tmpvar_61.xyxy);
  v_tile_repeat_bounds = tmpvar_76;
  float tmpvar_78;
  tmpvar_78 = (float(tmpvar_14.z) / 65535.0);
  bool tmpvar_79;
  bool tmpvar_80;
  tmpvar_80 = bool(0);
  tmpvar_79 = (0 == tmpvar_72);
  if (tmpvar_79) {
    image_data_color_57.w = (tmpvar_59.w * tmpvar_78);
    tmpvar_80 = bool(1);
  };
  tmpvar_79 = !(tmpvar_80);
  if (tmpvar_79) {
    image_data_color_57 = (image_data_color_57 * tmpvar_78);
    tmpvar_80 = bool(1);
  };
  bool tmpvar_81;
  bool tmpvar_82;
  tmpvar_82 = bool(0);
  tmpvar_81 = (0 == tmpvar_71);
  tmpvar_81 = (tmpvar_81 || (2 == tmpvar_71));
  if (tmpvar_81) {
    v_mask_swizzle = vec2(0.0, 1.0);
    v_color = image_data_color_57;
    tmpvar_82 = bool(1);
  };
  tmpvar_81 = (tmpvar_81 || (4 == tmpvar_71));
  tmpvar_81 = (tmpvar_81 && !(tmpvar_82));
  if (tmpvar_81) {
    v_mask_swizzle = vec2(1.0, 0.0);
    v_color = image_data_color_57;
    tmpvar_82 = bool(1);
  };
  tmpvar_81 = (tmpvar_81 || (3 == tmpvar_71));
  tmpvar_81 = (tmpvar_81 && !(tmpvar_82));
  if (tmpvar_81) {
    v_mask_swizzle = vec2(1.0, 0.0);
    v_color = image_data_color_57.wwww;
    tmpvar_82 = bool(1);
  };
  tmpvar_81 = (tmpvar_81 || (1 == tmpvar_71));
  tmpvar_81 = (tmpvar_81 && !(tmpvar_82));
  if (tmpvar_81) {
    vec2 tmpvar_83;
    tmpvar_83.y = 0.0;
    tmpvar_83.x = image_data_color_57.w;
    v_mask_swizzle = tmpvar_83;
    v_color = image_data_color_57;
    tmpvar_82 = bool(1);
  };
  tmpvar_81 = (tmpvar_81 || (5 == tmpvar_71));
  tmpvar_81 = (tmpvar_81 && !(tmpvar_82));
  if (tmpvar_81) {
    vec2 tmpvar_84;
    tmpvar_84.x = -(image_data_color_57.w);
    tmpvar_84.y = image_data_color_57.w;
    v_mask_swizzle = tmpvar_84;
    v_color = image_data_color_57;
    tmpvar_82 = bool(1);
  };
  tmpvar_81 = !(tmpvar_82);
  if (tmpvar_81) {
    v_mask_swizzle = vec2(0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  v_local_pos = tmpvar_46;
}

