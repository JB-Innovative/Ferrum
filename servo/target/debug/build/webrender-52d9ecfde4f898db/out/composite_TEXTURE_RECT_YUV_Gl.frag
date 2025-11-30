#version 150
// composite
// features: ["TEXTURE_RECT", "YUV"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
uniform sampler2DRect sColor1;
uniform sampler2DRect sColor2;
in vec2 vNormalizedWorldPos;
flat in vec2 vRoundedClipParams;
flat in vec4 vRoundedClipRadii;
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
  vec4 color_1;
  vec3 ycbcr_sample_2;
  bool tmpvar_3;
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  tmpvar_3 = (3 == vYuvFormat.x);
  if (tmpvar_3) {
    ycbcr_sample_2.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    ycbcr_sample_2.y = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).x;
    ycbcr_sample_2.z = texture (sColor2, min (max (vUV_v, vUVBounds_v.xy), vUVBounds_v.zw)).x;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (0 == vYuvFormat.x));
  tmpvar_3 = (tmpvar_3 || (1 == vYuvFormat.x));
  tmpvar_3 = (tmpvar_3 || (2 == vYuvFormat.x));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    ycbcr_sample_2.x = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).x;
    ycbcr_sample_2.yz = texture (sColor1, min (max (vUV_u, vUVBounds_u.xy), vUVBounds_u.zw)).xy;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (4 == vYuvFormat.x));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    ycbcr_sample_2 = texture (sColor0, min (max (vUV_y, vUVBounds_y.xy), vUVBounds_y.zw)).yzx;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = !(tmpvar_4);
  if (tmpvar_3) {
    ycbcr_sample_2 = vec3(0.0, 0.0, 0.0);
    tmpvar_4 = bool(1);
  };
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (vRgbFromDebiasedYcbcr * (ycbcr_sample_2 - vYcbcrBias));
  color_1 = tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_6 = (abs(dFdx(vNormalizedWorldPos)) + abs(dFdy(vNormalizedWorldPos)));
  float tmpvar_7;
  tmpvar_7 = inversesqrt((0.5 * dot (tmpvar_6, tmpvar_6)));
  vec4 tmpvar_8;
  tmpvar_8 = vRoundedClipRadii;
  vec2 tmpvar_9;
  if ((0.0 < vNormalizedWorldPos.x)) {
    tmpvar_9 = vRoundedClipRadii.xy;
  } else {
    tmpvar_9 = vRoundedClipRadii.zw;
  };
  tmpvar_8.xy = tmpvar_9;
  float tmpvar_10;
  if ((0.0 < vNormalizedWorldPos.y)) {
    tmpvar_10 = tmpvar_8.x;
  } else {
    tmpvar_10 = tmpvar_8.y;
  };
  tmpvar_8.x = tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_11 = ((abs(vNormalizedWorldPos) - vRoundedClipParams) + tmpvar_10);
  vec2 tmpvar_12;
  tmpvar_12 = max (tmpvar_11, 0.0);
  color_1 = (tmpvar_5 * min (max (
    (0.5 - (((
      min (max (tmpvar_11.x, tmpvar_11.y), 0.0)
     + 
      sqrt(dot (tmpvar_12, tmpvar_12))
    ) - tmpvar_10) * tmpvar_7))
  , 0.0), 1.0));
  oFragColor = color_1;
}

