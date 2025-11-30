#version 150
// composite
// features: ["FAST_PATH", "TEXTURE_RECT", "YUV"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
uniform sampler2DRect sColor1;
uniform sampler2DRect sColor2;
flat in vec3 vYcbcrBias;
flat in mat3 vRgbFromDebiasedYcbcr;
flat in ivec2 vYuvFormat;
in vec2 vUV_y;
in vec2 vUV_u;
in vec2 vUV_v;
flat in vec4 vUVBounds_y;
flat in vec4 vUVBounds_u;
flat in vec4 vUVBounds_v;
void main ()
{
  vec3 ycbcr_sample_1;
  bool tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  tmpvar_2 = (3 == vYuvFormat.x);
  if (tmpvar_2) {
    ycbcr_sample_1.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    ycbcr_sample_1.y = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).x;
    ycbcr_sample_1.z = texture (sColor2, min (max (vUV_v, vUVBounds_v.xy), vUVBounds_v.zw)).x;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (0 == vYuvFormat.x));
  tmpvar_2 = (tmpvar_2 || (1 == vYuvFormat.x));
  tmpvar_2 = (tmpvar_2 || (2 == vYuvFormat.x));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    ycbcr_sample_1.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    ycbcr_sample_1.yz = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).xy;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = (tmpvar_2 || (4 == vYuvFormat.x));
  tmpvar_2 = (tmpvar_2 && !(tmpvar_3));
  if (tmpvar_2) {
    ycbcr_sample_1 = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).yzx;
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

