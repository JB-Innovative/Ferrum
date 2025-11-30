#version 150
// brush_yuv_image
// features: ["TEXTURE_2D", "YUV"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
in vec2 vUv_Y;
flat in vec4 vUvBounds_Y;
in vec2 vUv_U;
flat in vec4 vUvBounds_U;
in vec2 vUv_V;
flat in vec4 vUvBounds_V;
flat in vec3 vYcbcrBias;
flat in mat3 vRgbFromDebiasedYcbcr;
flat in ivec2 vFormat;
void main ()
{
  vec3 ycbcr_sample_1;
  bool tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  tmpvar_2 = (3 == vFormat.x);
  if (tmpvar_2) {
    ycbcr_sample_1.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    ycbcr_sample_1.y = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).x;
    ycbcr_sample_1.z = texture (sColor2, min (max (vUv_V, vUvBounds_V.xy), vUvBounds_V.zw)).x;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (0 == vFormat.x));
  tmpvar_2 = (tmpvar_2 || (1 == vFormat.x));
  tmpvar_2 = (tmpvar_2 || (2 == vFormat.x));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    ycbcr_sample_1.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    ycbcr_sample_1.yz = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (4 == vFormat.x));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    ycbcr_sample_1 = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = !(tmpvar_3);
  if (tmpvar_2) {
    ycbcr_sample_1 = vec3(0.0, 0.0, 0.0);
    tmpvar_3 = bool(1);
  };
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (vRgbFromDebiasedYcbcr * (ycbcr_sample_1 - vYcbcrBias));
  oFragColor = tmpvar_4;
}

