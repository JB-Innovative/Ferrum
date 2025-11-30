#version 150
// composite
// features: ["FAST_PATH", "TEXTURE_RECT", "YUV"]

uniform mat4 uTransform;
in vec2 aPosition;
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
  uv_1 = ((tmpvar_3 - tmpvar_2.xy) / (tmpvar_2.zw - tmpvar_2.xy));
  int tmpvar_4;
  tmpvar_4 = int(aParams.z);
  int tmpvar_5;
  int tmpvar_6;
  tmpvar_5 = int(aParams.w);
  tmpvar_6 = int(aParams.y);
  mat3 tmpvar_7;
  vec4 tmpvar_8;
  float channel_max_9;
  channel_max_9 = 255.0;
  if ((8 < tmpvar_5)) {
    if ((tmpvar_4 == 1)) {
      channel_max_9 = float(((1 << tmpvar_5) - 1));
    } else {
      channel_max_9 = 65535.0;
    };
  };
  if ((tmpvar_6 == 0)) {
    tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
    tmpvar_8 = (vec4((ivec4(16, 128, 235, 240) << 
      (tmpvar_5 - 8)
    )) / channel_max_9);
  } else {
    if ((tmpvar_6 == 1)) {
      float tmpvar_10;
      tmpvar_10 = (float((
        (1 << tmpvar_5)
       - 1)) / channel_max_9);
      vec4 tmpvar_11;
      tmpvar_11.xy = vec2(0.0, 0.0);
      tmpvar_11.z = tmpvar_10;
      tmpvar_11.w = tmpvar_10;
      vec4 tmpvar_12;
      tmpvar_12.x = 0.0;
      tmpvar_12.y = (vec4((ivec4(16, 128, 235, 240) << 
        (tmpvar_5 - 8)
      )) / channel_max_9).y;
      tmpvar_12.zw = tmpvar_11.zw;
      tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.17207, 0.886, 0.701, -0.35707, 0.0);
      tmpvar_8 = tmpvar_12;
    } else {
      if ((tmpvar_6 == 2)) {
        tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
        tmpvar_8 = (vec4((ivec4(16, 128, 235, 240) << 
          (tmpvar_5 - 8)
        )) / channel_max_9);
      } else {
        if ((tmpvar_6 == 3)) {
          float tmpvar_13;
          tmpvar_13 = (float((
            (1 << tmpvar_5)
           - 1)) / channel_max_9);
          vec4 tmpvar_14;
          tmpvar_14.xy = vec2(0.0, 0.0);
          tmpvar_14.z = tmpvar_13;
          tmpvar_14.w = tmpvar_13;
          vec4 tmpvar_15;
          tmpvar_15.x = 0.0;
          tmpvar_15.y = (vec4((ivec4(16, 128, 235, 240) << 
            (tmpvar_5 - 8)
          )) / channel_max_9).y;
          tmpvar_15.zw = tmpvar_14.zw;
          tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.09366, 0.9278, 0.7874, -0.23406, 0.0);
          tmpvar_8 = tmpvar_15;
        } else {
          if ((tmpvar_6 == 4)) {
            tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
            tmpvar_8 = (vec4((ivec4(16, 128, 235, 240) << 
              (tmpvar_5 - 8)
            )) / channel_max_9);
          } else {
            if ((tmpvar_6 == 5)) {
              float tmpvar_16;
              tmpvar_16 = (float((
                (1 << tmpvar_5)
               - 1)) / channel_max_9);
              vec4 tmpvar_17;
              tmpvar_17.xy = vec2(0.0, 0.0);
              tmpvar_17.z = tmpvar_16;
              tmpvar_17.w = tmpvar_16;
              vec4 tmpvar_18;
              tmpvar_18.x = 0.0;
              tmpvar_18.y = (vec4((ivec4(16, 128, 235, 240) << 
                (tmpvar_5 - 8)
              )) / channel_max_9).y;
              tmpvar_18.zw = tmpvar_17.zw;
              tmpvar_7 = mat3(1.0, 1.0, 1.0, 0.0, -0.08228, 0.9407, 0.7373, -0.28568, 0.0);
              tmpvar_8 = tmpvar_18;
            } else {
              float tmpvar_19;
              tmpvar_19 = (float((
                (1 << tmpvar_5)
               - 1)) / channel_max_9);
              vec4 tmpvar_20;
              tmpvar_20.xy = vec2(0.0, 0.0);
              tmpvar_20.z = tmpvar_19;
              tmpvar_20.w = tmpvar_19;
              tmpvar_7 = mat3(0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0);
              tmpvar_8 = tmpvar_20;
            };
          };
        };
      };
    };
  };
  vec2 tmpvar_21;
  tmpvar_21 = (1.0/((tmpvar_8.zw - tmpvar_8.xy)));
  mat3 tmpvar_22;
  tmpvar_22[uint(0)].x = tmpvar_21.x;
  tmpvar_22[uint(0)].y = 0.0;
  tmpvar_22[uint(0)].z = 0.0;
  tmpvar_22[1u].x = 0.0;
  tmpvar_22[1u].y = tmpvar_21.y;
  tmpvar_22[1u].z = 0.0;
  tmpvar_22[2u].x = 0.0;
  tmpvar_22[2u].y = 0.0;
  tmpvar_22[2u].z = tmpvar_21.y;
  vYcbcrBias = tmpvar_8.xyy;
  vRgbFromDebiasedYcbcr = (tmpvar_7 * tmpvar_22);
  vYuvFormat.x = tmpvar_4;
  vec4 tmpvar_23;
  tmpvar_23.xy = (aUvRect0.xy + vec2(0.5, 0.5));
  tmpvar_23.zw = (aUvRect0.zw - vec2(0.5, 0.5));
  vUV_y = mix (aUvRect0.xy, aUvRect0.zw, uv_1);
  vUVBounds_y = tmpvar_23;
  vec4 tmpvar_24;
  tmpvar_24.xy = (aUvRect1.xy + vec2(0.5, 0.5));
  tmpvar_24.zw = (aUvRect1.zw - vec2(0.5, 0.5));
  vUV_u = mix (aUvRect1.xy, aUvRect1.zw, uv_1);
  vUVBounds_u = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25.xy = (aUvRect2.xy + vec2(0.5, 0.5));
  tmpvar_25.zw = (aUvRect2.zw - vec2(0.5, 0.5));
  vUV_v = mix (aUvRect2.xy, aUvRect2.zw, uv_1);
  vUVBounds_v = tmpvar_25;
  vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 1.0);
  tmpvar_26.xy = tmpvar_3;
  gl_Position = (uTransform * tmpvar_26);
}

