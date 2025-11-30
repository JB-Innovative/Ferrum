#version 150
// brush_image
// features: ["ANTIALIASING", "DEBUG_OVERDRAW", "REPETITION", "TEXTURE_RECT"]

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DRect sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 v_local_pos;
out vec2 v_uv;
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
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_10.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(0, 0));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(1, 0));
  ph_z_4 = float(tmpvar_11.x);
  mat4 transform_m_13;
  bool transform_is_axis_aligned_14;
  transform_is_axis_aligned_14 = ((tmpvar_11.z >> 23) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 8388607);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  transform_m_13[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  transform_m_13[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  transform_m_13[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  transform_m_13[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_11.w)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_11.w) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  vec2 tmpvar_20;
  vec2 tmpvar_21;
  tmpvar_20 = tmpvar_7.xy;
  tmpvar_21 = tmpvar_7.zw;
  vec2 adjusted_segment_rect_p0_22;
  vec2 adjusted_segment_rect_p1_23;
  vec2 segment_rect_p0_24;
  vec2 segment_rect_p1_25;
  vec4 segment_data_26;
  int tmpvar_27;
  tmpvar_27 = ((instance_flags_2 >> 12) & 15);
  int tmpvar_28;
  tmpvar_28 = (instance_flags_2 & 4095);
  if ((instance_segment_index_1 == 65535)) {
    segment_rect_p0_24 = tmpvar_8;
    segment_rect_p1_25 = tmpvar_9;
    segment_data_26 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_29;
    tmpvar_29 = ((tmpvar_11.y + 3) + (instance_segment_index_1 * 2));
    ivec2 tmpvar_30;
    tmpvar_30.x = int((uint(tmpvar_29) % 1024u));
    tmpvar_30.y = int((uint(tmpvar_29) / 1024u));
    vec4 tmpvar_31;
    tmpvar_31 = texelFetchOffset (sGpuCache, tmpvar_30, 0, ivec2(0, 0));
    segment_rect_p0_24 = (tmpvar_31.xy + tmpvar_6.xy);
    segment_rect_p1_25 = (tmpvar_31.zw + tmpvar_6.xy);
    segment_data_26 = texelFetchOffset (sGpuCache, tmpvar_30, 0, ivec2(1, 0));
  };
  adjusted_segment_rect_p0_22 = segment_rect_p0_24;
  adjusted_segment_rect_p1_23 = segment_rect_p1_25;
  if ((!(transform_is_axis_aligned_14) || ((tmpvar_28 & 1024) != 0))) {
    vec2 tmpvar_32;
    tmpvar_32 = min (max (segment_rect_p0_24, tmpvar_7.xy), tmpvar_7.zw);
    vec2 tmpvar_33;
    tmpvar_33 = min (max (segment_rect_p1_25, tmpvar_7.xy), tmpvar_7.zw);
    bvec4 tmpvar_34;
    tmpvar_34.x = bool((tmpvar_27 & 1));
    tmpvar_34.y = bool((tmpvar_27 & 2));
    tmpvar_34.z = bool((tmpvar_27 & 4));
    tmpvar_34.w = bool((tmpvar_27 & 8));
    vec4 tmpvar_35;
    tmpvar_35.xy = tmpvar_32;
    tmpvar_35.zw = tmpvar_33;
    vTransformBounds = mix(vec4(-1e+16, -1e+16, 1e+16, 1e+16), tmpvar_35, bvec4(tmpvar_34));
    vec4 tmpvar_36;
    tmpvar_36 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(2.0, 2.0, 2.0, 2.0), bvec4(tmpvar_34));
    adjusted_segment_rect_p0_22 = (tmpvar_32 - tmpvar_36.xy);
    adjusted_segment_rect_p1_23 = (tmpvar_33 + tmpvar_36.zw);
    tmpvar_20 = vec2(-1e+16, -1e+16);
    tmpvar_21 = vec2(1e+16, 1e+16);
  };
  vec2 tmpvar_37;
  tmpvar_37 = min (max (mix (adjusted_segment_rect_p0_22, adjusted_segment_rect_p1_23, aPosition), tmpvar_20), tmpvar_21);
  vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 1.0);
  tmpvar_38.xy = tmpvar_37;
  vec4 tmpvar_39;
  tmpvar_39 = (transform_m_13 * tmpvar_38);
  vec4 tmpvar_40;
  tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_19.x) + ((
    -(tmpvar_19.yz)
   + tmpvar_18.xy) * tmpvar_39.w));
  tmpvar_40.z = (ph_z_4 * tmpvar_39.w);
  tmpvar_40.w = tmpvar_39.w;
  gl_Position = (uTransform * tmpvar_40);
  vec2 f_41;
  vec2 stretch_size_42;
  vec2 local_rect_p0_43;
  vec2 local_rect_p1_44;
  vec2 uv1_45;
  vec2 uv0_46;
  ivec2 tmpvar_47;
  tmpvar_47.x = int((uint(tmpvar_11.y) % 1024u));
  tmpvar_47.y = int((uint(tmpvar_11.y) / 1024u));
  vec4 tmpvar_48;
  tmpvar_48 = texelFetchOffset (sGpuCache, tmpvar_47, 0, ivec2(2, 0));
  ivec2 tmpvar_49;
  tmpvar_49.x = int((uint(instance_resource_address_3) % 1024u));
  tmpvar_49.y = int((uint(instance_resource_address_3) / 1024u));
  vec4 tmpvar_50;
  tmpvar_50 = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(0, 0));
  uv0_46 = tmpvar_50.xy;
  uv1_45 = tmpvar_50.zw;
  local_rect_p0_43 = tmpvar_8;
  local_rect_p1_44 = tmpvar_9;
  stretch_size_42 = tmpvar_48.xy;
  if ((tmpvar_48.x < 0.0)) {
    stretch_size_42 = (tmpvar_6.zw - tmpvar_6.xy);
  };
  if (((tmpvar_28 & 2) != 0)) {
    local_rect_p0_43 = segment_rect_p0_24;
    local_rect_p1_44 = segment_rect_p1_25;
    vec2 tmpvar_51;
    tmpvar_51 = (segment_rect_p1_25 - segment_rect_p0_24);
    stretch_size_42 = tmpvar_51;
    if (((tmpvar_28 & 512) != 0)) {
      vec2 tmpvar_52;
      tmpvar_52 = (tmpvar_50.zw - tmpvar_50.xy);
      uv0_46 = (tmpvar_50.xy + (segment_data_26.xy * tmpvar_52));
      uv1_45 = (tmpvar_50.xy + (segment_data_26.zw * tmpvar_52));
    };
    if (((tmpvar_28 & 512) != 0)) {
      vec2 vertical_uv_size_53;
      vec2 horizontal_uv_size_54;
      vec2 repeated_stretch_size_55;
      repeated_stretch_size_55 = tmpvar_51;
      vec2 tmpvar_56;
      tmpvar_56 = (uv1_45 - uv0_46);
      horizontal_uv_size_54 = tmpvar_56;
      vec2 tmpvar_57;
      tmpvar_57 = (uv1_45 - uv0_46);
      vertical_uv_size_53 = tmpvar_57;
      if (((tmpvar_28 & 256) != 0)) {
        repeated_stretch_size_55 = (segment_rect_p0_24 - tmpvar_6.xy);
        vertical_uv_size_53.x = (uv0_46.x - tmpvar_50.x);
        if (((vertical_uv_size_53.x < 0.001) || (repeated_stretch_size_55.x < 0.001))) {
          vertical_uv_size_53.x = (tmpvar_50.z - uv1_45.x);
          repeated_stretch_size_55.x = (tmpvar_6.z - segment_rect_p1_25.x);
        };
        horizontal_uv_size_54.y = (uv0_46.y - tmpvar_50.y);
        if (((horizontal_uv_size_54.y < 0.001) || (repeated_stretch_size_55.y < 0.001))) {
          horizontal_uv_size_54.y = (tmpvar_50.w - uv1_45.y);
          repeated_stretch_size_55.y = (tmpvar_6.w - segment_rect_p1_25.y);
        };
      };
      if (((tmpvar_28 & 4) != 0)) {
        stretch_size_42.x = (repeated_stretch_size_55.y * (tmpvar_56.x / horizontal_uv_size_54.y));
      };
      if (((tmpvar_28 & 8) != 0)) {
        stretch_size_42.y = (repeated_stretch_size_55.x * (tmpvar_57.y / vertical_uv_size_53.x));
      };
    } else {
      if (((tmpvar_28 & 4) != 0)) {
        stretch_size_42.x = (segment_data_26.z - segment_data_26.x);
      };
      if (((tmpvar_28 & 8) != 0)) {
        stretch_size_42.y = (segment_data_26.w - segment_data_26.y);
      };
    };
    if (((tmpvar_28 & 16) != 0)) {
      float tmpvar_58;
      tmpvar_58 = (segment_rect_p1_25.x - segment_rect_p0_24.x);
      stretch_size_42.x = (tmpvar_58 / max (1.0, roundEven(
        (tmpvar_58 / stretch_size_42.x)
      )));
    };
    if (((tmpvar_28 & 32) != 0)) {
      float tmpvar_59;
      tmpvar_59 = (segment_rect_p1_25.y - segment_rect_p0_24.y);
      stretch_size_42.y = (tmpvar_59 / max (1.0, roundEven(
        (tmpvar_59 / stretch_size_42.y)
      )));
    };
  };
  float tmpvar_60;
  if (((tmpvar_28 & 1) != 0)) {
    tmpvar_60 = 1.0;
  } else {
    tmpvar_60 = 0.0;
  };
  v_perspective.x = tmpvar_60;
  vec2 tmpvar_61;
  tmpvar_61 = min (uv0_46, uv1_45);
  vec2 tmpvar_62;
  tmpvar_62 = max (uv0_46, uv1_45);
  vec4 tmpvar_63;
  tmpvar_63.xy = (tmpvar_61 + vec2(0.5, 0.5));
  tmpvar_63.zw = (tmpvar_62 - vec2(0.5, 0.5));
  v_uv_sample_bounds = tmpvar_63;
  vec2 tmpvar_64;
  tmpvar_64 = ((tmpvar_37 - local_rect_p0_43) / (local_rect_p1_44 - local_rect_p0_43));
  f_41 = tmpvar_64;
  if ((tmpvar_12.y == 1)) {
    int tmpvar_65;
    tmpvar_65 = (instance_resource_address_3 + 2);
    ivec2 tmpvar_66;
    tmpvar_66.x = int((uint(tmpvar_65) % 1024u));
    tmpvar_66.y = int((uint(tmpvar_65) / 1024u));
    vec4 tmpvar_67;
    tmpvar_67 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_66, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_66, 0, ivec2(1, 0)), tmpvar_64.x), mix (texelFetchOffset (sGpuCache, tmpvar_66, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_66, 0, ivec2(3, 0)), tmpvar_64.x), tmpvar_64.y);
    f_41 = (tmpvar_67.xy / tmpvar_67.w);
  };
  vec2 tmpvar_68;
  tmpvar_68 = ((local_rect_p1_44 - local_rect_p0_43) / stretch_size_42);
  v_uv = (mix (uv0_46, uv1_45, f_41) - tmpvar_61);
  v_uv = (v_uv * tmpvar_68);
  bvec2 tmpvar_69;
  tmpvar_69.x = bool((tmpvar_28 & 64));
  tmpvar_69.y = bool((tmpvar_28 & 128));
  v_uv = (v_uv + (mix(vec2(0.0, 0.0), 
    (1.0 - fract(((tmpvar_68 * 0.5) + 0.5)))
  , bvec2(tmpvar_69)) * (tmpvar_62 - tmpvar_61)));
  if ((tmpvar_60 == 0.0)) {
    v_uv = (v_uv * tmpvar_39.w);
  };
  vec2 tmpvar_70;
  tmpvar_70 = vec2(textureSize (sColor0));
  vec4 tmpvar_71;
  tmpvar_71.xy = vec2(0.0, 0.0);
  tmpvar_71.zw = tmpvar_70;
  v_uv_bounds = tmpvar_71;
  v_uv = (v_uv / tmpvar_70);
  v_local_pos = tmpvar_37;
}

