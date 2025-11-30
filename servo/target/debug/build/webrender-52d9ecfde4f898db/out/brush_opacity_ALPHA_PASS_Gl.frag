#version 150
// brush_opacity
// features: ["ALPHA_PASS"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
flat in vec4 vTransformBounds;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_local_pos;
in vec2 v_uv;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_opacity_perspective_vec;
void main ()
{
  vec4 frag_color_1;
  vec2 tmpvar_2;
  tmpvar_2 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  frag_color_1 = ((v_opacity_perspective_vec.x * min (
    max ((0.5 - max (tmpvar_2.x, tmpvar_2.y)), 0.0)
  , 1.0)) * texture (sColor0, min (max (
    (v_uv * mix (gl_FragCoord.w, 1.0, v_opacity_perspective_vec.y))
  , v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)));
  float tmpvar_3;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_3 = 1.0;
  } else {
    vec2 tmpvar_4;
    tmpvar_4 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_5;
    tmpvar_5.xy = greaterThanEqual (tmpvar_4, vClipMaskUvBounds.xy);
    tmpvar_5.zw = lessThan (tmpvar_4, vClipMaskUvBounds.zw);
    bool tmpvar_6;
    tmpvar_6 = (tmpvar_5 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_6)) {
      tmpvar_3 = 0.0;
    } else {
      tmpvar_3 = texelFetch (sClipMask, ivec2(tmpvar_4), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_3);
  oFragColor = frag_color_1;
}

