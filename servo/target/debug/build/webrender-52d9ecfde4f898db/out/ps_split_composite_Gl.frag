#version 150
// ps_split_composite
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 vUv;
flat in vec2 vPerspective;
flat in vec4 vUvSampleBounds;
void main ()
{
  float tmpvar_1;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_1 = 1.0;
  } else {
    vec2 tmpvar_2;
    tmpvar_2 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_3;
    tmpvar_3.xy = greaterThanEqual (tmpvar_2, vClipMaskUvBounds.xy);
    tmpvar_3.zw = lessThan (tmpvar_2, vClipMaskUvBounds.zw);
    bool tmpvar_4;
    tmpvar_4 = (tmpvar_3 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_4)) {
      tmpvar_1 = 0.0;
    } else {
      tmpvar_1 = texelFetch (sClipMask, ivec2(tmpvar_2), 0).x;
    };
  };
  oFragColor = (tmpvar_1 * texture (sColor0, min (max (
    (vUv * mix (gl_FragCoord.w, 1.0, vPerspective.x))
  , vUvSampleBounds.xy), vUvSampleBounds.zw)));
}

