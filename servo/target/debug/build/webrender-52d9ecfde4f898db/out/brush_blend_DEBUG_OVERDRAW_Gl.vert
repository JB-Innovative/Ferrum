#version 150
// brush_blend
// features: ["DEBUG_OVERDRAW"]

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
flat out vec2 v_perspective_amount;
flat out ivec2 v_op_table_address_vec;
flat out mat4 v_color_mat;
flat out vec4 v_funcs;
flat out vec4 v_color_offset;
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
  tmpvar_41 = (1.0/(vec2(textureSize (sColor0, 0))));
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
  v_uv = ((tmpvar_46 * tmpvar_41) * mix (tmpvar_37.w, 1.0, tmpvar_47));
  v_perspective_amount.x = tmpvar_47;
  vec4 tmpvar_48;
  tmpvar_48.xy = (tmpvar_40.xy + vec2(0.5, 0.5));
  tmpvar_48.zw = (tmpvar_40.zw - vec2(0.5, 0.5));
  v_uv_sample_bounds = (tmpvar_48 * tmpvar_41.xyxy);
  float tmpvar_49;
  tmpvar_49 = (float(tmpvar_11.z) / 65536.0);
  v_op_table_address_vec.x = (tmpvar_11.y & 65535);
  v_perspective_amount.y = tmpvar_49;
  v_funcs.x = float(((tmpvar_11.y >> 28) & 15));
  v_funcs.y = float(((tmpvar_11.y >> 24) & 15));
  v_funcs.z = float(((tmpvar_11.y >> 20) & 15));
  v_funcs.w = float(((tmpvar_11.y >> 16) & 15));
  int tmpvar_50;
  tmpvar_50 = tmpvar_11.z;
  vec4 tmpvar_51;
  mat4 tmpvar_52;
  int tmpvar_53;
  float tmpvar_54;
  tmpvar_54 = (1.0 - tmpvar_49);
  if ((v_op_table_address_vec.x == 1)) {
    vec4 tmpvar_55;
    tmpvar_55.w = 0.0;
    tmpvar_55.x = (0.2126 + (0.7874 * tmpvar_54));
    tmpvar_55.y = (0.2126 - (0.2126 * tmpvar_54));
    tmpvar_55.z = (0.2126 - (0.2126 * tmpvar_54));
    vec4 tmpvar_56;
    tmpvar_56.w = 0.0;
    tmpvar_56.x = (0.7152 - (0.7152 * tmpvar_54));
    tmpvar_56.y = (0.7152 + (0.2848 * tmpvar_54));
    tmpvar_56.z = (0.7152 - (0.7152 * tmpvar_54));
    vec4 tmpvar_57;
    tmpvar_57.w = 0.0;
    tmpvar_57.x = (0.0722 - (0.0722 * tmpvar_54));
    tmpvar_57.y = (0.0722 - (0.0722 * tmpvar_54));
    tmpvar_57.z = (0.0722 + (0.9278 * tmpvar_54));
    mat4 tmpvar_58;
    tmpvar_58[uint(0)] = tmpvar_55;
    tmpvar_58[1u] = tmpvar_56;
    tmpvar_58[2u] = tmpvar_57;
    tmpvar_58[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    tmpvar_52 = tmpvar_58;
    tmpvar_51 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    if ((v_op_table_address_vec.x == 2)) {
      float tmpvar_59;
      tmpvar_59 = cos(tmpvar_49);
      float tmpvar_60;
      tmpvar_60 = sin(tmpvar_49);
      vec4 tmpvar_61;
      tmpvar_61.w = 0.0;
      tmpvar_61.x = ((0.2126 + (0.7874 * tmpvar_59)) - (0.2126 * tmpvar_60));
      tmpvar_61.y = ((0.2126 - (0.2126 * tmpvar_59)) + (0.143 * tmpvar_60));
      tmpvar_61.z = ((0.2126 - (0.2126 * tmpvar_59)) - (0.7874 * tmpvar_60));
      vec4 tmpvar_62;
      tmpvar_62.w = 0.0;
      tmpvar_62.x = ((0.7152 - (0.7152 * tmpvar_59)) - (0.7152 * tmpvar_60));
      tmpvar_62.y = ((0.7152 + (0.2848 * tmpvar_59)) + (0.14 * tmpvar_60));
      tmpvar_62.z = ((0.7152 - (0.7152 * tmpvar_59)) + (0.7152 * tmpvar_60));
      vec4 tmpvar_63;
      tmpvar_63.w = 0.0;
      tmpvar_63.x = ((0.0722 - (0.0722 * tmpvar_59)) + (0.9278 * tmpvar_60));
      tmpvar_63.y = ((0.0722 - (0.0722 * tmpvar_59)) - (0.283 * tmpvar_60));
      tmpvar_63.z = ((0.0722 + (0.9278 * tmpvar_59)) + (0.0722 * tmpvar_60));
      mat4 tmpvar_64;
      tmpvar_64[uint(0)] = tmpvar_61;
      tmpvar_64[1u] = tmpvar_62;
      tmpvar_64[2u] = tmpvar_63;
      tmpvar_64[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      tmpvar_52 = tmpvar_64;
      tmpvar_51 = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
      if ((v_op_table_address_vec.x == 4)) {
        vec4 tmpvar_65;
        tmpvar_65.w = 0.0;
        tmpvar_65.x = ((tmpvar_54 * 0.2126) + tmpvar_49);
        tmpvar_65.y = (tmpvar_54 * 0.2126);
        tmpvar_65.z = (tmpvar_54 * 0.2126);
        vec4 tmpvar_66;
        tmpvar_66.w = 0.0;
        tmpvar_66.x = (tmpvar_54 * 0.7152);
        tmpvar_66.y = ((tmpvar_54 * 0.7152) + tmpvar_49);
        tmpvar_66.z = (tmpvar_54 * 0.7152);
        vec4 tmpvar_67;
        tmpvar_67.w = 0.0;
        tmpvar_67.x = (tmpvar_54 * 0.0722);
        tmpvar_67.y = (tmpvar_54 * 0.0722);
        tmpvar_67.z = ((tmpvar_54 * 0.0722) + tmpvar_49);
        mat4 tmpvar_68;
        tmpvar_68[uint(0)] = tmpvar_65;
        tmpvar_68[1u] = tmpvar_66;
        tmpvar_68[2u] = tmpvar_67;
        tmpvar_68[3u] = vec4(0.0, 0.0, 0.0, 1.0);
        tmpvar_52 = tmpvar_68;
        tmpvar_51 = vec4(0.0, 0.0, 0.0, 0.0);
      } else {
        if ((v_op_table_address_vec.x == 5)) {
          vec4 tmpvar_69;
          tmpvar_69.w = 0.0;
          tmpvar_69.x = (0.393 + (0.607 * tmpvar_54));
          tmpvar_69.y = (0.349 - (0.349 * tmpvar_54));
          tmpvar_69.z = (0.272 - (0.272 * tmpvar_54));
          vec4 tmpvar_70;
          tmpvar_70.w = 0.0;
          tmpvar_70.x = (0.769 - (0.769 * tmpvar_54));
          tmpvar_70.y = (0.686 + (0.314 * tmpvar_54));
          tmpvar_70.z = (0.534 - (0.534 * tmpvar_54));
          vec4 tmpvar_71;
          tmpvar_71.w = 0.0;
          tmpvar_71.x = (0.189 - (0.189 * tmpvar_54));
          tmpvar_71.y = (0.168 - (0.168 * tmpvar_54));
          tmpvar_71.z = (0.131 + (0.869 * tmpvar_54));
          mat4 tmpvar_72;
          tmpvar_72[uint(0)] = tmpvar_69;
          tmpvar_72[1u] = tmpvar_70;
          tmpvar_72[2u] = tmpvar_71;
          tmpvar_72[3u] = vec4(0.0, 0.0, 0.0, 1.0);
          tmpvar_52 = tmpvar_72;
          tmpvar_51 = vec4(0.0, 0.0, 0.0, 0.0);
        } else {
          if ((v_op_table_address_vec.x == 7)) {
            ivec2 tmpvar_73;
            tmpvar_73.x = int((uint(tmpvar_11.z) % 1024u));
            tmpvar_73.y = int((uint(tmpvar_11.z) / 1024u));
            int tmpvar_74;
            tmpvar_74 = (tmpvar_11.z + 4);
            ivec2 tmpvar_75;
            tmpvar_75.x = int((uint(tmpvar_74) % 1024u));
            tmpvar_75.y = int((uint(tmpvar_74) / 1024u));
            mat4 tmpvar_76;
            tmpvar_76[uint(0)] = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(0, 0));
            tmpvar_76[1u] = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(1, 0));
            tmpvar_76[2u] = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(2, 0));
            tmpvar_76[3u] = texelFetchOffset (sGpuCache, tmpvar_73, 0, ivec2(3, 0));
            tmpvar_52 = tmpvar_76;
            tmpvar_51 = texelFetch (sGpuCache, tmpvar_75, 0);
          } else {
            if ((v_op_table_address_vec.x == 11)) {
              tmpvar_53 = tmpvar_50;
            } else {
              if ((v_op_table_address_vec.x == 10)) {
                ivec2 tmpvar_77;
                tmpvar_77.x = int((uint(tmpvar_11.z) % 1024u));
                tmpvar_77.y = int((uint(tmpvar_11.z) / 1024u));
                tmpvar_51 = texelFetch (sGpuCache, tmpvar_77, 0);
              };
            };
          };
        };
      };
    };
  };
  v_color_offset = tmpvar_51;
  v_color_mat = tmpvar_52;
  v_op_table_address_vec.y = tmpvar_53;
}

