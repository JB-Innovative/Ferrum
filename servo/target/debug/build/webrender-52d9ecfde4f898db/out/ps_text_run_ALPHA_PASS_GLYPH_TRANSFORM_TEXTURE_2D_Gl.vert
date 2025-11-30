#version 150
// ps_text_run
// features: ["ALPHA_PASS", "GLYPH_TRANSFORM", "TEXTURE_2D"]

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
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec2 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 v_color;
flat out vec3 v_mask_swizzle;
flat out vec4 v_uv_bounds;
out vec2 v_uv;
out vec4 v_uv_clip;
void main ()
{
  vec2 local_pos_1;
  vec2 glyph_offset_2;
  vec4 text_color_3;
  int color_mode_4;
  RectWithEndpoint clip_area_task_rect_5;
  float clip_area_device_pixel_scale_6;
  vec2 clip_area_screen_origin_7;
  float ph_z_8;
  int instance_segment_index_9;
  int instance_flags_10;
  int instance_resource_address_11;
  instance_segment_index_9 = (aData.z & 65535);
  instance_flags_10 = (aData.z >> 16);
  instance_resource_address_11 = (aData.w & 16777215);
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_12.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_12, 0, ivec2(0, 0));
  vec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_12, 0, ivec2(1, 0));
  vec2 tmpvar_15;
  vec2 tmpvar_16;
  tmpvar_15 = tmpvar_14.xy;
  tmpvar_16 = tmpvar_14.zw;
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_17.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_17, 0, ivec2(0, 0));
  ph_z_8 = float(tmpvar_18.x);
  mat4 transform_m_19;
  int tmpvar_20;
  tmpvar_20 = (tmpvar_18.z & 8388607);
  ivec2 tmpvar_21;
  tmpvar_21.x = int((8u * (
    uint(tmpvar_20)
   % 128u)));
  tmpvar_21.y = int((uint(tmpvar_20) / 128u));
  transform_m_19[0] = texelFetchOffset (sTransformPalette, tmpvar_21, 0, ivec2(0, 0));
  transform_m_19[1] = texelFetchOffset (sTransformPalette, tmpvar_21, 0, ivec2(1, 0));
  transform_m_19[2] = texelFetchOffset (sTransformPalette, tmpvar_21, 0, ivec2(2, 0));
  transform_m_19[3] = texelFetchOffset (sTransformPalette, tmpvar_21, 0, ivec2(3, 0));
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
  clip_area_task_rect_5 = task_data_22.task_rect;
  clip_area_device_pixel_scale_6 = task_data_22.user_data.x;
  clip_area_screen_origin_7 = task_data_22.user_data.yz;
  ivec2 tmpvar_26;
  tmpvar_26.x = int((2u * (
    uint(tmpvar_18.w)
   % 512u)));
  tmpvar_26.y = int((uint(tmpvar_18.w) / 512u));
  vec4 tmpvar_27;
  tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(0, 0));
  vec4 tmpvar_28;
  tmpvar_28 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(1, 0));
  color_mode_4 = (instance_flags_10 & 255);
  ivec2 tmpvar_29;
  tmpvar_29.x = int((uint(tmpvar_18.y) % 1024u));
  tmpvar_29.y = int((uint(tmpvar_18.y) / 1024u));
  text_color_3 = texelFetch (sGpuCache, tmpvar_29, 0);
  int tmpvar_30;
  tmpvar_30 = ((tmpvar_18.y + 1) + int((
    uint(instance_segment_index_9)
   / 2u)));
  ivec2 tmpvar_31;
  tmpvar_31.x = int((uint(tmpvar_30) % 1024u));
  tmpvar_31.y = int((uint(tmpvar_30) / 1024u));
  vec4 tmpvar_32;
  tmpvar_32 = texelFetch (sGpuCache, tmpvar_31, 0);
  glyph_offset_2 = (mix(tmpvar_32.xy, tmpvar_32.zw, bvec2((
    (uint(instance_segment_index_9) % 2u)
   == 1u))) + tmpvar_13.xy);
  ivec2 tmpvar_33;
  tmpvar_33.x = int((uint(instance_resource_address_11) % 1024u));
  tmpvar_33.y = int((uint(instance_resource_address_11) / 1024u));
  vec4 tmpvar_34;
  vec4 tmpvar_35;
  tmpvar_34 = texelFetchOffset (sGpuCache, tmpvar_33, 0, ivec2(0, 0));
  tmpvar_35 = texelFetchOffset (sGpuCache, tmpvar_33, 0, ivec2(1, 0));
  int tmpvar_36;
  tmpvar_36 = ((instance_flags_10 >> 8) & 255);
  vec2 tmpvar_37;
  bool tmpvar_38;
  tmpvar_38 = (0 == tmpvar_36);
  tmpvar_38 = (tmpvar_38 || !((
    ((1 == tmpvar_36) || (2 == tmpvar_36))
   || 
    (3 == tmpvar_36)
  )));
  if (tmpvar_38) {
    tmpvar_37 = vec2(0.5, 0.5);
  } else {
    tmpvar_38 = (tmpvar_38 || (1 == tmpvar_36));
    if (tmpvar_38) {
      tmpvar_37 = vec2(0.125, 0.5);
    } else {
      tmpvar_38 = (tmpvar_38 || (2 == tmpvar_36));
      if (tmpvar_38) {
        tmpvar_37 = vec2(0.5, 0.125);
      } else {
        tmpvar_38 = (tmpvar_38 || (3 == tmpvar_36));
        if (tmpvar_38) {
          tmpvar_37 = vec2(0.125, 0.125);
        };
      };
    };
  };
  mat2 tmpvar_39;
  tmpvar_39[uint(0)] = transform_m_19[uint(0)].xy;
  tmpvar_39[1u] = transform_m_19[1u].xy;
  mat2 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * tmpvar_28.x);
  vec2 tmpvar_41;
  tmpvar_41 = (transform_m_19[3].xy * tmpvar_28.x);
  mat2 tmpvar_42;
  mat2 tmpvar_43;
  tmpvar_43[0].x = tmpvar_40[1].y;
  tmpvar_43[0].y = -(tmpvar_40[0].y);
  tmpvar_43[1].x = -(tmpvar_40[1].x);
  tmpvar_43[1].y = tmpvar_40[0].x;
  tmpvar_42 = (tmpvar_43 / ((tmpvar_40[0].x * tmpvar_40[1].y) - (tmpvar_40[1].x * tmpvar_40[0].y)));
  vec2 tmpvar_44;
  tmpvar_44 = ((tmpvar_35.xy + floor(
    ((tmpvar_40 * glyph_offset_2) + tmpvar_37)
  )) + (floor(
    (((tmpvar_40 * tmpvar_13.zw) + tmpvar_41) + 0.5)
  ) - tmpvar_41));
  vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_44 + tmpvar_34.zw) - tmpvar_34.xy);
  vec2 tmpvar_46;
  tmpvar_46 = (tmpvar_45 - tmpvar_44);
  vec2 tmpvar_47;
  tmpvar_47 = (tmpvar_42 * (tmpvar_44 + (tmpvar_46 * 0.5)));
  mat2 tmpvar_48;
  tmpvar_48[uint(0)] = abs(tmpvar_42[0]);
  tmpvar_48[1u] = abs(tmpvar_42[1]);
  vec2 tmpvar_49;
  tmpvar_49 = (tmpvar_48 * (tmpvar_46 * 0.5));
  vec2 tmpvar_50;
  vec2 tmpvar_51;
  tmpvar_50 = (tmpvar_47 - tmpvar_49);
  tmpvar_51 = (tmpvar_47 + tmpvar_49);
  local_pos_1 = mix (tmpvar_50, tmpvar_51, aPosition);
  vec4 tmpvar_52;
  tmpvar_52.xy = tmpvar_15;
  tmpvar_52.zw = tmpvar_51;
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_50;
  tmpvar_53.zw = tmpvar_16;
  if ((greaterThanEqual (tmpvar_53, tmpvar_52) == bvec4(1, 1, 1, 1))) {
    local_pos_1 = (tmpvar_42 * mix (tmpvar_44, tmpvar_45, aPosition));
  };
  vec2 tmpvar_54;
  tmpvar_54 = min (max (local_pos_1, tmpvar_14.xy), tmpvar_14.zw);
  vec4 tmpvar_55;
  tmpvar_55.zw = vec2(0.0, 1.0);
  tmpvar_55.xy = tmpvar_54;
  vec4 tmpvar_56;
  tmpvar_56 = (transform_m_19 * tmpvar_55);
  vec4 tmpvar_57;
  tmpvar_57.xy = ((tmpvar_56.xy * tmpvar_28.x) + ((
    -(tmpvar_28.yz)
   + tmpvar_27.xy) * tmpvar_56.w));
  tmpvar_57.z = (ph_z_8 * tmpvar_56.w);
  tmpvar_57.w = tmpvar_56.w;
  gl_Position = (uTransform * tmpvar_57);
  vec2 tmpvar_58;
  tmpvar_58 = (((tmpvar_40 * tmpvar_54) - tmpvar_44) / (tmpvar_45 - tmpvar_44));
  vec4 tmpvar_59;
  tmpvar_59.xy = tmpvar_58;
  tmpvar_59.zw = (1.0 - tmpvar_58);
  v_uv_clip = tmpvar_59;
  vec4 tmpvar_60;
  tmpvar_60.xy = clip_area_task_rect_5.p0;
  tmpvar_60.zw = clip_area_task_rect_5.p1;
  vClipMaskUvBounds = tmpvar_60;
  vClipMaskUv = ((tmpvar_56.xy * clip_area_device_pixel_scale_6) + (tmpvar_56.w * (clip_area_task_rect_5.p0 - clip_area_screen_origin_7)));
  bool tmpvar_61;
  bool tmpvar_62;
  tmpvar_62 = bool(0);
  tmpvar_61 = (0 == color_mode_4);
  if (tmpvar_61) {
    v_mask_swizzle = vec3(0.0, 1.0, 1.0);
    v_color = text_color_3;
    tmpvar_62 = bool(1);
  };
  tmpvar_61 = (tmpvar_61 || (2 == color_mode_4));
  tmpvar_61 = (tmpvar_61 && !(tmpvar_62));
  if (tmpvar_61) {
    v_mask_swizzle = vec3(0.0, 1.0, 0.0);
    v_color = text_color_3;
    tmpvar_62 = bool(1);
  };
  tmpvar_61 = (tmpvar_61 || (3 == color_mode_4));
  tmpvar_61 = (tmpvar_61 && !(tmpvar_62));
  if (tmpvar_61) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = text_color_3.wwww;
    tmpvar_62 = bool(1);
  };
  tmpvar_61 = (tmpvar_61 || (1 == color_mode_4));
  tmpvar_61 = (tmpvar_61 && !(tmpvar_62));
  if (tmpvar_61) {
    vec3 tmpvar_63;
    tmpvar_63.yz = vec2(0.0, 0.0);
    tmpvar_63.x = text_color_3.w;
    v_mask_swizzle = tmpvar_63;
    v_color = text_color_3;
    tmpvar_62 = bool(1);
  };
  tmpvar_61 = !(tmpvar_62);
  if (tmpvar_61) {
    v_mask_swizzle = vec3(0.0, 0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  vec2 tmpvar_64;
  tmpvar_64 = vec2(textureSize (sColor0, 0));
  v_uv = mix ((tmpvar_34.xy / tmpvar_64), (tmpvar_34.zw / tmpvar_64), tmpvar_58);
  v_uv_bounds = ((tmpvar_34 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_64.xyxy);
}

