#version 150
// brush_yuv_image
// features: ["ALPHA_PASS", "TEXTURE_RECT", "YUV"]

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
    tmpvar_36 = ((tmpvar_12.y + 1) + (instance_segment_index_1 * 2));
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
  vec2 f_49;
  f_49 = ((tmpvar_44 - tmpvar_5.xy) / (tmpvar_5.zw - tmpvar_5.xy));
  ivec2 tmpvar_50;
  tmpvar_50.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_50.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_51;
  tmpvar_51 = texelFetch (sGpuCache, tmpvar_50, 0);
  int tmpvar_52;
  tmpvar_52 = int(tmpvar_51.z);
  int tmpvar_53;
  int tmpvar_54;
  tmpvar_53 = int(tmpvar_51.x);
  tmpvar_54 = int(tmpvar_51.y);
  mat3 tmpvar_55;
  vec4 tmpvar_56;
  float channel_max_57;
  channel_max_57 = 255.0;
  if ((8 < tmpvar_53)) {
    if ((tmpvar_52 == 1)) {
      channel_max_57 = float(((1 << tmpvar_53) - 1));
    } else {
      channel_max_57 = 65535.0;
    };
  };
  if ((tmpvar_54 == 0)) {
    tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
    tmpvar_56 = (vec4((ivec4(16, 128, 235, 240) << 
      (tmpvar_53 - 8)
    )) / channel_max_57);
  } else {
    if ((tmpvar_54 == 1)) {
      float tmpvar_58;
      tmpvar_58 = (float((
        (1 << tmpvar_53)
       - 1)) / channel_max_57);
      vec4 tmpvar_59;
      tmpvar_59.xy = vec2(0.0, 0.0);
      tmpvar_59.z = tmpvar_58;
      tmpvar_59.w = tmpvar_58;
      vec4 tmpvar_60;
      tmpvar_60.x = 0.0;
      tmpvar_60.y = (vec4((ivec4(16, 128, 235, 240) << 
        (tmpvar_53 - 8)
      )) / channel_max_57).y;
      tmpvar_60.zw = tmpvar_59.zw;
      tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
      tmpvar_56 = tmpvar_60;
    } else {
      if ((tmpvar_54 == 2)) {
        tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
        tmpvar_56 = (vec4((ivec4(16, 128, 235, 240) << 
          (tmpvar_53 - 8)
        )) / channel_max_57);
      } else {
        if ((tmpvar_54 == 3)) {
          float tmpvar_61;
          tmpvar_61 = (float((
            (1 << tmpvar_53)
           - 1)) / channel_max_57);
          vec4 tmpvar_62;
          tmpvar_62.xy = vec2(0.0, 0.0);
          tmpvar_62.z = tmpvar_61;
          tmpvar_62.w = tmpvar_61;
          vec4 tmpvar_63;
          tmpvar_63.x = 0.0;
          tmpvar_63.y = (vec4((ivec4(16, 128, 235, 240) << 
            (tmpvar_53 - 8)
          )) / channel_max_57).y;
          tmpvar_63.zw = tmpvar_62.zw;
          tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
          tmpvar_56 = tmpvar_63;
        } else {
          if ((tmpvar_54 == 4)) {
            tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
            tmpvar_56 = (vec4((ivec4(16, 128, 235, 240) << 
              (tmpvar_53 - 8)
            )) / channel_max_57);
          } else {
            if ((tmpvar_54 == 5)) {
              float tmpvar_64;
              tmpvar_64 = (float((
                (1 << tmpvar_53)
               - 1)) / channel_max_57);
              vec4 tmpvar_65;
              tmpvar_65.xy = vec2(0.0, 0.0);
              tmpvar_65.z = tmpvar_64;
              tmpvar_65.w = tmpvar_64;
              vec4 tmpvar_66;
              tmpvar_66.x = 0.0;
              tmpvar_66.y = (vec4((ivec4(16, 128, 235, 240) << 
                (tmpvar_53 - 8)
              )) / channel_max_57).y;
              tmpvar_66.zw = tmpvar_65.zw;
              tmpvar_55 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
              tmpvar_56 = tmpvar_66;
            } else {
              float tmpvar_67;
              tmpvar_67 = (float((
                (1 << tmpvar_53)
               - 1)) / channel_max_57);
              vec4 tmpvar_68;
              tmpvar_68.xy = vec2(0.0, 0.0);
              tmpvar_68.z = tmpvar_67;
              tmpvar_68.w = tmpvar_67;
              tmpvar_55 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
              tmpvar_56 = tmpvar_68;
            };
          };
        };
      };
    };
  };
  vec2 tmpvar_69;
  tmpvar_69 = (1.0/((tmpvar_56.zw - tmpvar_56.xy)));
  mat3 tmpvar_70;
  tmpvar_70[uint(0)].x = tmpvar_69.x;
  tmpvar_70[uint(0)].y = 0.0;
  tmpvar_70[uint(0)].z = 0.0;
  tmpvar_70[1u].x = 0.0;
  tmpvar_70[1u].y = tmpvar_69.y;
  tmpvar_70[1u].z = 0.0;
  tmpvar_70[2u].x = 0.0;
  tmpvar_70[2u].y = 0.0;
  tmpvar_70[2u].z = tmpvar_69.y;
  vYcbcrBias = tmpvar_56.xyy;
  vRgbFromDebiasedYcbcr = (tmpvar_55 * tmpvar_70);
  vFormat.x = tmpvar_52;
  if (((tmpvar_52 == 3) || (tmpvar_52 == 99))) {
    ivec2 tmpvar_71;
    tmpvar_71.x = int((uint(tmpvar_13.x) % 1024u));
    tmpvar_71.y = int((uint(tmpvar_13.x) / 1024u));
    vec4 tmpvar_72;
    tmpvar_72 = texelFetchOffset (sGpuCache, tmpvar_71, 0, ivec2(0, 0));
    ivec2 tmpvar_73;
    tmpvar_73.x = int((uint(tmpvar_13.y) % 1024u));
    tmpvar_73.y = int((uint(tmpvar_13.y) / 1024u));
    vec4 tmpvar_74;
    tmpvar_74 = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(0, 0));
    ivec2 tmpvar_75;
    tmpvar_75.x = int((uint(tmpvar_13.z) % 1024u));
    tmpvar_75.y = int((uint(tmpvar_13.z) / 1024u));
    vec4 tmpvar_76;
    tmpvar_76 = texelFetchOffset (sGpuCache, tmpvar_75, 0, ivec2(0, 0));
    vec4 tmpvar_77;
    tmpvar_77.xy = (tmpvar_72.xy + vec2(0.5, 0.5));
    tmpvar_77.zw = (tmpvar_72.zw - vec2(0.5, 0.5));
    vUv_Y = mix (tmpvar_72.xy, tmpvar_72.zw, f_49);
    vUvBounds_Y = tmpvar_77;
    vec4 tmpvar_78;
    tmpvar_78.xy = (tmpvar_74.xy + vec2(0.5, 0.5));
    tmpvar_78.zw = (tmpvar_74.zw - vec2(0.5, 0.5));
    vUv_U = mix (tmpvar_74.xy, tmpvar_74.zw, f_49);
    vUvBounds_U = tmpvar_78;
    vec4 tmpvar_79;
    tmpvar_79.xy = (tmpvar_76.xy + vec2(0.5, 0.5));
    tmpvar_79.zw = (tmpvar_76.zw - vec2(0.5, 0.5));
    vUv_V = mix (tmpvar_76.xy, tmpvar_76.zw, f_49);
    vUvBounds_V = tmpvar_79;
  } else {
    if (((tmpvar_52 == 0) || (tmpvar_52 == 1))) {
      ivec2 tmpvar_80;
      tmpvar_80.x = int((uint(tmpvar_13.x) % 1024u));
      tmpvar_80.y = int((uint(tmpvar_13.x) / 1024u));
      vec4 tmpvar_81;
      tmpvar_81 = texelFetchOffset (sGpuCache, tmpvar_80, 0, ivec2(0, 0));
      ivec2 tmpvar_82;
      tmpvar_82.x = int((uint(tmpvar_13.y) % 1024u));
      tmpvar_82.y = int((uint(tmpvar_13.y) / 1024u));
      vec4 tmpvar_83;
      tmpvar_83 = texelFetchOffset (sGpuCache, tmpvar_82, 0, ivec2(0, 0));
      vec4 tmpvar_84;
      tmpvar_84.xy = (tmpvar_81.xy + vec2(0.5, 0.5));
      tmpvar_84.zw = (tmpvar_81.zw - vec2(0.5, 0.5));
      vUv_Y = mix (tmpvar_81.xy, tmpvar_81.zw, f_49);
      vUvBounds_Y = tmpvar_84;
      vec4 tmpvar_85;
      tmpvar_85.xy = (tmpvar_83.xy + vec2(0.5, 0.5));
      tmpvar_85.zw = (tmpvar_83.zw - vec2(0.5, 0.5));
      vUv_U = mix (tmpvar_83.xy, tmpvar_83.zw, f_49);
      vUvBounds_U = tmpvar_85;
    } else {
      if ((tmpvar_52 == 4)) {
        ivec2 tmpvar_86;
        tmpvar_86.x = int((uint(tmpvar_13.x) % 1024u));
        tmpvar_86.y = int((uint(tmpvar_13.x) / 1024u));
        vec4 tmpvar_87;
        tmpvar_87 = texelFetchOffset (sGpuCache, tmpvar_86, 0, ivec2(0, 0));
        vec4 tmpvar_88;
        tmpvar_88.xy = (tmpvar_87.xy + vec2(0.5, 0.5));
        tmpvar_88.zw = (tmpvar_87.zw - vec2(0.5, 0.5));
        vUv_Y = mix (tmpvar_87.xy, tmpvar_87.zw, f_49);
        vUvBounds_Y = tmpvar_88;
      };
    };
  };
  v_local_pos = tmpvar_44;
}

