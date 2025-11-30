#version 150
// composite
// features: ["TEXTURE_RECT", "YUV"]

uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vNormalizedWorldPos;
flat out vec2 vRoundedClipParams;
flat out vec4 vRoundedClipRadii;
flat out vec3 vYcbcrBias;
flat out mat3 vRgbFromDebiasedYcbcr;
flat out ivec2 vYuvFormat;
out vec2 vUV_y;
out vec2 vUV_u;
out vec2 vUV_v;
flat out vec4 vUVBounds_y;
flat out vec4 vUVBounds_u;
flat out vec4 vUVBounds_v;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec4 aParams;
in vec2 aFlip;
in vec4 aDeviceRoundedClipRect;
in vec4 aDeviceRoundedClipRadii;
in vec4 aUvRect0;
in vec4 aUvRect1;
in vec4 aUvRect2;
void main ()
{
  vec2 uv_1;
  vec4 tmpvar_2;
  tmpvar_2 = mix (aDeviceRect, aDeviceRect.zwxy, aFlip.xyxy);
  vec2 tmpvar_3;
  tmpvar_3 = min (max (mix (tmpvar_2.xy, tmpvar_2.zw, aPosition), aDeviceClipRect.xy), aDeviceClipRect.zw);
  vec2 tmpvar_4;
  tmpvar_4 = (0.5 * (aDeviceRoundedClipRect.zw - aDeviceRoundedClipRect.xy));
  vNormalizedWorldPos = ((aDeviceRoundedClipRect.xy + tmpvar_4) - tmpvar_3);
  vRoundedClipParams = tmpvar_4;
  vRoundedClipRadii = aDeviceRoundedClipRadii;
  uv_1 = ((tmpvar_3 - tmpvar_2.xy) / (tmpvar_2.zw - tmpvar_2.xy));
  int tmpvar_5;
  tmpvar_5 = int(aParams.z);
  int tmpvar_6;
  int tmpvar_7;
  tmpvar_6 = int(aParams.w);
  tmpvar_7 = int(aParams.y);
  mat3 tmpvar_8;
  vec4 tmpvar_9;
  float channel_max_10;
  channel_max_10 = 255.0;
  if ((8 < tmpvar_6)) {
    if ((tmpvar_5 == 1)) {
      channel_max_10 = float(((1 << tmpvar_6) - 1));
    } else {
      channel_max_10 = 65535.0;
    };
  };
  if ((tmpvar_7 == 0)) {
    tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
    tmpvar_9 = (vec4((ivec4(16, 128, 235, 240) << 
      (tmpvar_6 - 8)
    )) / channel_max_10);
  } else {
    if ((tmpvar_7 == 1)) {
      float tmpvar_11;
      tmpvar_11 = (float((
        (1 << tmpvar_6)
       - 1)) / channel_max_10);
      vec4 tmpvar_12;
      tmpvar_12.xy = vec2(0.0, 0.0);
      tmpvar_12.z = tmpvar_11;
      tmpvar_12.w = tmpvar_11;
      vec4 tmpvar_13;
      tmpvar_13.x = 0.0;
      tmpvar_13.y = (vec4((ivec4(16, 128, 235, 240) << 
        (tmpvar_6 - 8)
      )) / channel_max_10).y;
      tmpvar_13.zw = tmpvar_12.zw;
      tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
      tmpvar_9 = tmpvar_13;
    } else {
      if ((tmpvar_7 == 2)) {
        tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
        tmpvar_9 = (vec4((ivec4(16, 128, 235, 240) << 
          (tmpvar_6 - 8)
        )) / channel_max_10);
      } else {
        if ((tmpvar_7 == 3)) {
          float tmpvar_14;
          tmpvar_14 = (float((
            (1 << tmpvar_6)
           - 1)) / channel_max_10);
          vec4 tmpvar_15;
          tmpvar_15.xy = vec2(0.0, 0.0);
          tmpvar_15.z = tmpvar_14;
          tmpvar_15.w = tmpvar_14;
          vec4 tmpvar_16;
          tmpvar_16.x = 0.0;
          tmpvar_16.y = (vec4((ivec4(16, 128, 235, 240) << 
            (tmpvar_6 - 8)
          )) / channel_max_10).y;
          tmpvar_16.zw = tmpvar_15.zw;
          tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
          tmpvar_9 = tmpvar_16;
        } else {
          if ((tmpvar_7 == 4)) {
            tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
            tmpvar_9 = (vec4((ivec4(16, 128, 235, 240) << 
              (tmpvar_6 - 8)
            )) / channel_max_10);
          } else {
            if ((tmpvar_7 == 5)) {
              float tmpvar_17;
              tmpvar_17 = (float((
                (1 << tmpvar_6)
               - 1)) / channel_max_10);
              vec4 tmpvar_18;
              tmpvar_18.xy = vec2(0.0, 0.0);
              tmpvar_18.z = tmpvar_17;
              tmpvar_18.w = tmpvar_17;
              vec4 tmpvar_19;
              tmpvar_19.x = 0.0;
              tmpvar_19.y = (vec4((ivec4(16, 128, 235, 240) << 
                (tmpvar_6 - 8)
              )) / channel_max_10).y;
              tmpvar_19.zw = tmpvar_18.zw;
              tmpvar_8 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
              tmpvar_9 = tmpvar_19;
            } else {
              float tmpvar_20;
              tmpvar_20 = (float((
                (1 << tmpvar_6)
               - 1)) / channel_max_10);
              vec4 tmpvar_21;
              tmpvar_21.xy = vec2(0.0, 0.0);
              tmpvar_21.z = tmpvar_20;
              tmpvar_21.w = tmpvar_20;
              tmpvar_8 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
              tmpvar_9 = tmpvar_21;
            };
          };
        };
      };
    };
  };
  vec2 tmpvar_22;
  tmpvar_22 = (1.0/((tmpvar_9.zw - tmpvar_9.xy)));
  mat3 tmpvar_23;
  tmpvar_23[uint(0)].x = tmpvar_22.x;
  tmpvar_23[uint(0)].y = 0.0;
  tmpvar_23[uint(0)].z = 0.0;
  tmpvar_23[1u].x = 0.0;
  tmpvar_23[1u].y = tmpvar_22.y;
  tmpvar_23[1u].z = 0.0;
  tmpvar_23[2u].x = 0.0;
  tmpvar_23[2u].y = 0.0;
  tmpvar_23[2u].z = tmpvar_22.y;
  vYcbcrBias = tmpvar_9.xyy;
  vRgbFromDebiasedYcbcr = (tmpvar_8 * tmpvar_23);
  vYuvFormat.x = tmpvar_5;
  vec4 tmpvar_24;
  tmpvar_24.xy = (aUvRect0.xy + vec2(0.5, 0.5));
  tmpvar_24.zw = (aUvRect0.zw - vec2(0.5, 0.5));
  vUV_y = mix (aUvRect0.xy, aUvRect0.zw, uv_1);
  vUVBounds_y = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25.xy = (aUvRect1.xy + vec2(0.5, 0.5));
  tmpvar_25.zw = (aUvRect1.zw - vec2(0.5, 0.5));
  vUV_u = mix (aUvRect1.xy, aUvRect1.zw, uv_1);
  vUVBounds_u = tmpvar_25;
  vec4 tmpvar_26;
  tmpvar_26.xy = (aUvRect2.xy + vec2(0.5, 0.5));
  tmpvar_26.zw = (aUvRect2.zw - vec2(0.5, 0.5));
  vUV_v = mix (aUvRect2.xy, aUvRect2.zw, uv_1);
  vUVBounds_v = tmpvar_26;
  vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 1.0);
  tmpvar_27.xy = tmpvar_3;
  gl_Position = (uTransform * tmpvar_27);
}

