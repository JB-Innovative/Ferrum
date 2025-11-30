#version 150
// composite
// features: ["TEXTURE_RECT"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
in vec2 vNormalizedWorldPos;
flat in vec2 vRoundedClipParams;
flat in vec4 vRoundedClipRadii;
in vec2 vUv;
flat in vec4 vColor;
flat in vec4 vUVBounds;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (vColor * texture (sColor0, min (max (vUv, vUVBounds.xy), vUVBounds.zw)));
  color_1 = tmpvar_2;
  vec2 tmpvar_3;
  tmpvar_3 = (abs(dFdx(vNormalizedWorldPos)) + abs(dFdy(vNormalizedWorldPos)));
  float tmpvar_4;
  tmpvar_4 = inversesqrt((0.5 * dot (tmpvar_3, tmpvar_3)));
  vec4 tmpvar_5;
  tmpvar_5 = vRoundedClipRadii;
  vec2 tmpvar_6;
  if ((0.0 < vNormalizedWorldPos.x)) {
    tmpvar_6 = vRoundedClipRadii.xy;
  } else {
    tmpvar_6 = vRoundedClipRadii.zw;
  };
  tmpvar_5.xy = tmpvar_6;
  float tmpvar_7;
  if ((0.0 < vNormalizedWorldPos.y)) {
    tmpvar_7 = tmpvar_5.x;
  } else {
    tmpvar_7 = tmpvar_5.y;
  };
  tmpvar_5.x = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = ((abs(vNormalizedWorldPos) - vRoundedClipParams) + tmpvar_7);
  vec2 tmpvar_9;
  tmpvar_9 = max (tmpvar_8, 0.0);
  color_1 = (tmpvar_2 * min (max (
    (0.5 - (((
      min (max (tmpvar_8.x, tmpvar_8.y), 0.0)
     + 
      sqrt(dot (tmpvar_9, tmpvar_9))
    ) - tmpvar_7) * tmpvar_4))
  , 0.0), 1.0));
  oFragColor = color_1;
}

