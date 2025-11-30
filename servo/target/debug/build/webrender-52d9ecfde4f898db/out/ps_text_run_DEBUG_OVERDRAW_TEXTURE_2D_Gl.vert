#version 150
// ps_text_run
// features: ["DEBUG_OVERDRAW", "TEXTURE_2D"]

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
void main ()
{
  vec2 glyph_offset_1;
  vec4 text_color_2;
  int color_mode_3;
  RectWithEndpoint clip_area_task_rect_4;
  float clip_area_device_pixel_scale_5;
  vec2 clip_area_screen_origin_6;
  float ph_z_7;
  ivec4 ph_user_data_8;
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
  ivec2 tmpvar_15;
  tmpvar_15.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_15.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_16;
  tmpvar_16 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_15, 0, ivec2(0, 0));
  ph_z_7 = float(tmpvar_16.x);
  ph_user_data_8 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_15, 0, ivec2(1, 0));
  mat4 transform_m_17;
  int tmpvar_18;
  tmpvar_18 = (tmpvar_16.z & 8388607);
  ivec2 tmpvar_19;
  tmpvar_19.x = int((8u * (
    uint(tmpvar_18)
   % 128u)));
  tmpvar_19.y = int((uint(tmpvar_18) / 128u));
  transform_m_17[0] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(0, 0));
  transform_m_17[1] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(1, 0));
  transform_m_17[2] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(2, 0));
  transform_m_17[3] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(3, 0));
  RenderTaskData task_data_20;
  if ((aData.y >= 2147483647)) {
    task_data_20 = RenderTaskData(RectWithEndpoint(vec2(0.0, 0.0), vec2(0.0, 0.0)), vec4(0.0, 0.0, 0.0, 0.0));
  } else {
    RectWithEndpoint task_rect_21;
    ivec2 tmpvar_22;
    tmpvar_22.x = int((2u * (
      uint(aData.y)
     % 512u)));
    tmpvar_22.y = int((uint(aData.y) / 512u));
    vec4 tmpvar_23;
    tmpvar_23 = texelFetchOffset (sRenderTasks, tmpvar_22, 0, ivec2(0, 0));
    task_rect_21.p0 = tmpvar_23.xy;
    task_rect_21.p1 = tmpvar_23.zw;
    task_data_20.task_rect = task_rect_21;
    task_data_20.user_data = texelFetchOffset (sRenderTasks, tmpvar_22, 0, ivec2(1, 0));
  };
  clip_area_task_rect_4 = task_data_20.task_rect;
  clip_area_device_pixel_scale_5 = task_data_20.user_data.x;
  clip_area_screen_origin_6 = task_data_20.user_data.yz;
  ivec2 tmpvar_24;
  tmpvar_24.x = int((2u * (
    uint(tmpvar_16.w)
   % 512u)));
  tmpvar_24.y = int((uint(tmpvar_16.w) / 512u));
  vec4 tmpvar_25;
  tmpvar_25 = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(0, 0));
  vec4 tmpvar_26;
  tmpvar_26 = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(1, 0));
  color_mode_3 = (instance_flags_10 & 255);
  ivec2 tmpvar_27;
  tmpvar_27.x = int((uint(tmpvar_16.y) % 1024u));
  tmpvar_27.y = int((uint(tmpvar_16.y) / 1024u));
  text_color_2 = texelFetch (sGpuCache, tmpvar_27, 0);
  int tmpvar_28;
  tmpvar_28 = ((tmpvar_16.y + 1) + int((
    uint(instance_segment_index_9)
   / 2u)));
  ivec2 tmpvar_29;
  tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
  tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
  vec4 tmpvar_30;
  tmpvar_30 = texelFetch (sGpuCache, tmpvar_29, 0);
  glyph_offset_1 = (mix(tmpvar_30.xy, tmpvar_30.zw, bvec2((
    (uint(instance_segment_index_9) % 2u)
   == 1u))) + tmpvar_13.xy);
  ivec2 tmpvar_31;
  tmpvar_31.x = int((uint(instance_resource_address_11) % 1024u));
  tmpvar_31.y = int((uint(instance_resource_address_11) / 1024u));
  vec4 tmpvar_32;
  vec4 tmpvar_33;
  tmpvar_32 = texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(0, 0));
  tmpvar_33 = texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(1, 0));
  int tmpvar_34;
  tmpvar_34 = ((instance_flags_10 >> 8) & 255);
  vec2 tmpvar_35;
  bool tmpvar_36;
  tmpvar_36 = (0 == tmpvar_34);
  tmpvar_36 = (tmpvar_36 || !((
    ((1 == tmpvar_34) || (2 == tmpvar_34))
   || 
    (3 == tmpvar_34)
  )));
  if (tmpvar_36) {
    tmpvar_35 = vec2(0.5, 0.5);
  } else {
    tmpvar_36 = (tmpvar_36 || (1 == tmpvar_34));
    if (tmpvar_36) {
      tmpvar_35 = vec2(0.125, 0.5);
    } else {
      tmpvar_36 = (tmpvar_36 || (2 == tmpvar_34));
      if (tmpvar_36) {
        tmpvar_35 = vec2(0.5, 0.125);
      } else {
        tmpvar_36 = (tmpvar_36 || (3 == tmpvar_34));
        if (tmpvar_36) {
          tmpvar_35 = vec2(0.125, 0.125);
        };
      };
    };
  };
  float tmpvar_37;
  tmpvar_37 = ((float(ph_user_data_8.x) / 65535.0) * tmpvar_26.x);
  float tmpvar_38;
  tmpvar_38 = (tmpvar_33.z / tmpvar_37);
  vec2 tmpvar_39;
  tmpvar_39 = ((tmpvar_38 * (tmpvar_33.xy + 
    (floor(((glyph_offset_1 * tmpvar_37) + tmpvar_35)) / tmpvar_33.z)
  )) + tmpvar_13.zw);
  vec2 tmpvar_40;
  tmpvar_40 = (tmpvar_39 + (tmpvar_38 * (tmpvar_32.zw - tmpvar_32.xy)));
  vec2 tmpvar_41;
  tmpvar_41 = min (max (mix (tmpvar_39, tmpvar_40, aPosition), tmpvar_14.xy), tmpvar_14.zw);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 1.0);
  tmpvar_42.xy = tmpvar_41;
  vec4 tmpvar_43;
  tmpvar_43 = (transform_m_17 * tmpvar_42);
  vec4 tmpvar_44;
  tmpvar_44.xy = ((tmpvar_43.xy * tmpvar_26.x) + ((
    -(tmpvar_26.yz)
   + tmpvar_25.xy) * tmpvar_43.w));
  tmpvar_44.z = (ph_z_7 * tmpvar_43.w);
  tmpvar_44.w = tmpvar_43.w;
  gl_Position = (uTransform * tmpvar_44);
  vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_41 - tmpvar_39) / (tmpvar_40 - tmpvar_39));
  vec4 tmpvar_46;
  tmpvar_46.xy = clip_area_task_rect_4.p0;
  tmpvar_46.zw = clip_area_task_rect_4.p1;
  vClipMaskUvBounds = tmpvar_46;
  vClipMaskUv = ((tmpvar_43.xy * clip_area_device_pixel_scale_5) + (tmpvar_43.w * (clip_area_task_rect_4.p0 - clip_area_screen_origin_6)));
  bool tmpvar_47;
  bool tmpvar_48;
  tmpvar_48 = bool(0);
  tmpvar_47 = (0 == color_mode_3);
  if (tmpvar_47) {
    v_mask_swizzle = vec3(0.0, 1.0, 1.0);
    v_color = text_color_2;
    tmpvar_48 = bool(1);
  };
  tmpvar_47 = (tmpvar_47 || (2 == color_mode_3));
  tmpvar_47 = (tmpvar_47 && !(tmpvar_48));
  if (tmpvar_47) {
    v_mask_swizzle = vec3(0.0, 1.0, 0.0);
    v_color = text_color_2;
    tmpvar_48 = bool(1);
  };
  tmpvar_47 = (tmpvar_47 || (3 == color_mode_3));
  tmpvar_47 = (tmpvar_47 && !(tmpvar_48));
  if (tmpvar_47) {
    v_mask_swizzle = vec3(1.0, 0.0, 0.0);
    v_color = text_color_2.wwww;
    tmpvar_48 = bool(1);
  };
  tmpvar_47 = (tmpvar_47 || (1 == color_mode_3));
  tmpvar_47 = (tmpvar_47 && !(tmpvar_48));
  if (tmpvar_47) {
    vec3 tmpvar_49;
    tmpvar_49.yz = vec2(0.0, 0.0);
    tmpvar_49.x = text_color_2.w;
    v_mask_swizzle = tmpvar_49;
    v_color = text_color_2;
    tmpvar_48 = bool(1);
  };
  tmpvar_47 = !(tmpvar_48);
  if (tmpvar_47) {
    v_mask_swizzle = vec3(0.0, 0.0, 0.0);
    v_color = vec4(1.0, 1.0, 1.0, 1.0);
  };
  vec2 tmpvar_50;
  tmpvar_50 = vec2(textureSize (sColor0, 0));
  v_uv = mix ((tmpvar_32.xy / tmpvar_50), (tmpvar_32.zw / tmpvar_50), tmpvar_45);
  v_uv_bounds = ((tmpvar_32 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_50.xyxy);
}

