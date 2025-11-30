#version 150
// cs_clip_box_shadow
// features: ["TEXTURE_2D"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
flat in vec4 vTransformBounds;
in vec4 vLocalPos;
in vec2 vUv;
flat in vec4 vUvBounds;
flat in vec4 vEdge;
flat in vec4 vUvBounds_NoClamp;
flat in vec2 vClipMode;
void main ()
{
  vec2 uv_1;
  vec2 tmpvar_2;
  tmpvar_2 = (vUv / vLocalPos.w);
  uv_1 = (min (max (tmpvar_2, vec2(0.0, 0.0)), vEdge.xy) + max (vec2(0.0, 0.0), (tmpvar_2 - vEdge.zw)));
  vec2 tmpvar_3;
  tmpvar_3 = min (max (mix (vUvBounds_NoClamp.xy, vUvBounds_NoClamp.zw, uv_1), vUvBounds.xy), vUvBounds.zw);
  uv_1 = tmpvar_3;
  vec2 tmpvar_4;
  tmpvar_4 = (vLocalPos.xy / vLocalPos.w);
  float tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_6.x = float((tmpvar_4.x >= vTransformBounds.z));
  tmpvar_6.y = float((tmpvar_4.y >= vTransformBounds.w));
  vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (tmpvar_4, vTransformBounds.xy)) - tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  vec4 tmpvar_8;
  tmpvar_8 = texture (sColor0, tmpvar_3);
  float tmpvar_9;
  tmpvar_9 = mix (tmpvar_8.x, (1.0 - tmpvar_8.x), vClipMode.x);
  float tmpvar_10;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_10 = mix (vClipMode.x, tmpvar_9, tmpvar_5);
  } else {
    tmpvar_10 = 0.0;
  };
  oFragColor = vec4(tmpvar_10);
}

