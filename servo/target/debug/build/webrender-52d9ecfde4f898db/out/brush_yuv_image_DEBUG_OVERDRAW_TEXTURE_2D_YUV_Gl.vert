#version 150
// brush_yuv_image
// features: ["DEBUG_OVERDRAW", "TEXTURE_2D", "YUV"]

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 vUv_Y;
flat out vec4 vUvBounds_Y;
out vec2 vUv_U;
flat out vec4 vUvBounds_U;
out vec2 vUv_V;
flat out vec4 vUvBounds_V;
flat out vec3 vYcbcrBias;
flat out mat3 vRgbFromDebiasedYcbcr;
flat out ivec2 vFormat;
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
    tmpvar_27 = ((tmpvar_10.y + 1) + (instance_segment_index_1 * 2));
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
  vec2 f_39;
  f_39 = ((tmpvar_35 - tmpvar_5.xy) / (tmpvar_5.zw - tmpvar_5.xy));
  ivec2 tmpvar_40;
  tmpvar_40.x = int((uint(tmpvar_10.y) % 1024u));
  tmpvar_40.y = int((uint(tmpvar_10.y) / 1024u));
  vec4 tmpvar_41;
  tmpvar_41 = texelFetch (sGpuCache, tmpvar_40, 0);
  int tmpvar_42;
  tmpvar_42 = int(tmpvar_41.z);
  int tmpvar_43;
  int tmpvar_44;
  tmpvar_43 = int(tmpvar_41.x);
  tmpvar_44 = int(tmpvar_41.y);
  mat3 tmpvar_45;
  vec4 tmpvar_46;
  float channel_max_47;
  channel_max_47 = 255.0;
  if ((8 < tmpvar_43)) {
    if ((tmpvar_42 == 1)) {
      channel_max_47 = float(((1 << tmpvar_43) - 1));
    } else {
      channel_max_47 = 65535.0;
    };
  };
  if ((tmpvar_44 == 0)) {
    tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
    tmpvar_46 = (vec4((ivec4(16, 128, 235, 240) << 
      (tmpvar_43 - 8)
    )) / channel_max_47);
  } else {
    if ((tmpvar_44 == 1)) {
      float tmpvar_48;
      tmpvar_48 = (float((
        (1 << tmpvar_43)
       - 1)) / channel_max_47);
      vec4 tmpvar_49;
      tmpvar_49.xy = vec2(0.0, 0.0);
      tmpvar_49.z = tmpvar_48;
      tmpvar_49.w = tmpvar_48;
      vec4 tmpvar_50;
      tmpvar_50.x = 0.0;
      tmpvar_50.y = (vec4((ivec4(16, 128, 235, 240) << 
        (tmpvar_43 - 8)
      )) / channel_max_47).y;
      tmpvar_50.zw = tmpvar_49.zw;
      tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
      tmpvar_46 = tmpvar_50;
    } else {
      if ((tmpvar_44 == 2)) {
        tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
        tmpvar_46 = (vec4((ivec4(16, 128, 235, 240) << 
          (tmpvar_43 - 8)
        )) / channel_max_47);
      } else {
        if ((tmpvar_44 == 3)) {
          float tmpvar_51;
          tmpvar_51 = (float((
            (1 << tmpvar_43)
           - 1)) / channel_max_47);
          vec4 tmpvar_52;
          tmpvar_52.xy = vec2(0.0, 0.0);
          tmpvar_52.z = tmpvar_51;
          tmpvar_52.w = tmpvar_51;
          vec4 tmpvar_53;
          tmpvar_53.x = 0.0;
          tmpvar_53.y = (vec4((ivec4(16, 128, 235, 240) << 
            (tmpvar_43 - 8)
          )) / channel_max_47).y;
          tmpvar_53.zw = tmpvar_52.zw;
          tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
          tmpvar_46 = tmpvar_53;
        } else {
          if ((tmpvar_44 == 4)) {
            tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
            tmpvar_46 = (vec4((ivec4(16, 128, 235, 240) << 
              (tmpvar_43 - 8)
            )) / channel_max_47);
          } else {
            if ((tmpvar_44 == 5)) {
              float tmpvar_54;
              tmpvar_54 = (float((
                (1 << tmpvar_43)
               - 1)) / channel_max_47);
              vec4 tmpvar_55;
              tmpvar_55.xy = vec2(0.0, 0.0);
              tmpvar_55.z = tmpvar_54;
              tmpvar_55.w = tmpvar_54;
              vec4 tmpvar_56;
              tmpvar_56.x = 0.0;
              tmpvar_56.y = (vec4((ivec4(16, 128, 235, 240) << 
                (tmpvar_43 - 8)
              )) / channel_max_47).y;
              tmpvar_56.zw = tmpvar_55.zw;
              tmpvar_45 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
              tmpvar_46 = tmpvar_56;
            } else {
              float tmpvar_57;
              tmpvar_57 = (float((
                (1 << tmpvar_43)
               - 1)) / channel_max_47);
              vec4 tmpvar_58;
              tmpvar_58.xy = vec2(0.0, 0.0);
              tmpvar_58.z = tmpvar_57;
              tmpvar_58.w = tmpvar_57;
              tmpvar_45 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
              tmpvar_46 = tmpvar_58;
            };
          };
        };
      };
    };
  };
  vec2 tmpvar_59;
  tmpvar_59 = (1.0/((tmpvar_46.zw - tmpvar_46.xy)));
  mat3 tmpvar_60;
  tmpvar_60[uint(0)].x = tmpvar_59.x;
  tmpvar_60[uint(0)].y = 0.0;
  tmpvar_60[uint(0)].z = 0.0;
  tmpvar_60[1u].x = 0.0;
  tmpvar_60[1u].y = tmpvar_59.y;
  tmpvar_60[1u].z = 0.0;
  tmpvar_60[2u].x = 0.0;
  tmpvar_60[2u].y = 0.0;
  tmpvar_60[2u].z = tmpvar_59.y;
  vYcbcrBias = tmpvar_46.xyy;
  vRgbFromDebiasedYcbcr = (tmpvar_45 * tmpvar_60);
  vFormat.x = tmpvar_42;
  if (((tmpvar_42 == 3) || (tmpvar_42 == 99))) {
    ivec2 tmpvar_61;
    tmpvar_61.x = int((uint(tmpvar_11.x) % 1024u));
    tmpvar_61.y = int((uint(tmpvar_11.x) / 1024u));
    vec4 tmpvar_62;
    tmpvar_62 = texelFetchOffset (sGpuCache, tmpvar_61, 0, ivec2(0, 0));
    ivec2 tmpvar_63;
    tmpvar_63.x = int((uint(tmpvar_11.y) % 1024u));
    tmpvar_63.y = int((uint(tmpvar_11.y) / 1024u));
    vec4 tmpvar_64;
    tmpvar_64 = texelFetchOffset (sGpuCache, tmpvar_63, 0, ivec2(0, 0));
    ivec2 tmpvar_65;
    tmpvar_65.x = int((uint(tmpvar_11.z) % 1024u));
    tmpvar_65.y = int((uint(tmpvar_11.z) / 1024u));
    vec4 tmpvar_66;
    tmpvar_66 = texelFetchOffset (sGpuCache, tmpvar_65, 0, ivec2(0, 0));
    vec2 tmpvar_67;
    tmpvar_67 = vec2(textureSize (sColor0, 0));
    vec4 tmpvar_68;
    tmpvar_68.xy = (tmpvar_62.xy + vec2(0.5, 0.5));
    tmpvar_68.zw = (tmpvar_62.zw - vec2(0.5, 0.5));
    vUv_Y = (mix (tmpvar_62.xy, tmpvar_62.zw, f_39) / tmpvar_67);
    vUvBounds_Y = (tmpvar_68 / tmpvar_67.xyxy);
    vec2 tmpvar_69;
    tmpvar_69 = vec2(textureSize (sColor1, 0));
    vec4 tmpvar_70;
    tmpvar_70.xy = (tmpvar_64.xy + vec2(0.5, 0.5));
    tmpvar_70.zw = (tmpvar_64.zw - vec2(0.5, 0.5));
    vUv_U = (mix (tmpvar_64.xy, tmpvar_64.zw, f_39) / tmpvar_69);
    vUvBounds_U = (tmpvar_70 / tmpvar_69.xyxy);
    vec2 tmpvar_71;
    tmpvar_71 = vec2(textureSize (sColor2, 0));
    vec4 tmpvar_72;
    tmpvar_72.xy = (tmpvar_66.xy + vec2(0.5, 0.5));
    tmpvar_72.zw = (tmpvar_66.zw - vec2(0.5, 0.5));
    vUv_V = (mix (tmpvar_66.xy, tmpvar_66.zw, f_39) / tmpvar_71);
    vUvBounds_V = (tmpvar_72 / tmpvar_71.xyxy);
  } else {
    if (((tmpvar_42 == 0) || (tmpvar_42 == 1))) {
      ivec2 tmpvar_73;
      tmpvar_73.x = int((uint(tmpvar_11.x) % 1024u));
      tmpvar_73.y = int((uint(tmpvar_11.x) / 1024u));
      vec4 tmpvar_74;
      tmpvar_74 = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(0, 0));
      ivec2 tmpvar_75;
      tmpvar_75.x = int((uint(tmpvar_11.y) % 1024u));
      tmpvar_75.y = int((uint(tmpvar_11.y) / 1024u));
      vec4 tmpvar_76;
      tmpvar_76 = texelFetchOffset (sGpuCache, tmpvar_75, 0, ivec2(0, 0));
      vec2 tmpvar_77;
      tmpvar_77 = vec2(textureSize (sColor0, 0));
      vec4 tmpvar_78;
      tmpvar_78.xy = (tmpvar_74.xy + vec2(0.5, 0.5));
      tmpvar_78.zw = (tmpvar_74.zw - vec2(0.5, 0.5));
      vUv_Y = (mix (tmpvar_74.xy, tmpvar_74.zw, f_39) / tmpvar_77);
      vUvBounds_Y = (tmpvar_78 / tmpvar_77.xyxy);
      vec2 tmpvar_79;
      tmpvar_79 = vec2(textureSize (sColor1, 0));
      vec4 tmpvar_80;
      tmpvar_80.xy = (tmpvar_76.xy + vec2(0.5, 0.5));
      tmpvar_80.zw = (tmpvar_76.zw - vec2(0.5, 0.5));
      vUv_U = (mix (tmpvar_76.xy, tmpvar_76.zw, f_39) / tmpvar_79);
      vUvBounds_U = (tmpvar_80 / tmpvar_79.xyxy);
    } else {
      if ((tmpvar_42 == 4)) {
        ivec2 tmpvar_81;
        tmpvar_81.x = int((uint(tmpvar_11.x) % 1024u));
        tmpvar_81.y = int((uint(tmpvar_11.x) / 1024u));
        vec4 tmpvar_82;
        tmpvar_82 = texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(0, 0));
        vec2 tmpvar_83;
        tmpvar_83 = vec2(textureSize (sColor0, 0));
        vec4 tmpvar_84;
        tmpvar_84.xy = (tmpvar_82.xy + vec2(0.5, 0.5));
        tmpvar_84.zw = (tmpvar_82.zw - vec2(0.5, 0.5));
        vUv_Y = (mix (tmpvar_82.xy, tmpvar_82.zw, f_39) / tmpvar_83);
        vUvBounds_Y = (tmpvar_84 / tmpvar_83.xyxy);
      };
    };
  };
}

