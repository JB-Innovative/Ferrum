#version 150
// brush_yuv_image
// features: ["ALPHA_PASS", "TEXTURE_2D", "YUV"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
flat in vec4 vTransformBounds;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_local_pos;
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
  vec4 frag_color_1;
  vec3 ycbcr_sample_2;
  bool tmpvar_3;
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  tmpvar_3 = (3 == vFormat.x);
  if (tmpvar_3) {
    ycbcr_sample_2.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    ycbcr_sample_2.y = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).x;
    ycbcr_sample_2.z = texture (sColor2, min (max (vUv_V, vUvBounds_V.xy), vUvBounds_V.zw)).x;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (0 == vFormat.x));
  tmpvar_3 = (tmpvar_3 || (1 == vFormat.x));
  tmpvar_3 = (tmpvar_3 || (2 == vFormat.x));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    ycbcr_sample_2.x = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
    ycbcr_sample_2.yz = texture (sColor1, min (max (vUv_U, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
    tmpvar_4 = bool(1);
  };
  tmpvar_3 = (tmpvar_3 || (4 == vFormat.x));
  tmpvar_3 = (tmpvar_3 && !(tmpvar_4));
  if (tmpvar_3) {
    ycbcr_sample_2 = texture (sColor0, min (max (vUv_Y, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
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
  vec2 tmpvar_6;
  tmpvar_6 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  frag_color_1 = (tmpvar_5 * min (max (
    (0.5 - max (tmpvar_6.x, tmpvar_6.y))
  , 0.0), 1.0));
  float tmpvar_7;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_7 = 1.0;
  } else {
    vec2 tmpvar_8;
    tmpvar_8 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_9;
    tmpvar_9.xy = greaterThanEqual (tmpvar_8, vClipMaskUvBounds.xy);
    tmpvar_9.zw = lessThan (tmpvar_8, vClipMaskUvBounds.zw);
    bool tmpvar_10;
    tmpvar_10 = (tmpvar_9 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_10)) {
      tmpvar_7 = 0.0;
    } else {
      tmpvar_7 = texelFetch (sClipMask, ivec2(tmpvar_8), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_7);
  oFragColor = frag_color_1;
}

