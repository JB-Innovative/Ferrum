#version 150
// ps_quad_mask
// features: ["FAST_PATH"]

precision highp float;
out vec4 oFragColor;
flat in ivec4 v_flags;
in vec4 vClipLocalPos;
flat in vec4 v_clip_radii;
flat in vec2 v_clip_size;
flat in vec2 vClipMode;
void main ()
{
  vec4 output_color_1;
  vec2 tmpvar_2;
  tmpvar_2 = (vClipLocalPos.xy / vClipLocalPos.w);
  vec2 tmpvar_3;
  tmpvar_3 = (abs(dFdx(tmpvar_2)) + abs(dFdy(tmpvar_2)));
  float tmpvar_4;
  tmpvar_4 = inversesqrt((0.5 * dot (tmpvar_3, tmpvar_3)));
  vec4 tmpvar_5;
  tmpvar_5 = v_clip_radii;
  vec2 tmpvar_6;
  if ((0.0 < tmpvar_2.x)) {
    tmpvar_6 = v_clip_radii.xy;
  } else {
    tmpvar_6 = v_clip_radii.zw;
  };
  tmpvar_5.xy = tmpvar_6;
  float tmpvar_7;
  if ((0.0 < tmpvar_2.y)) {
    tmpvar_7 = tmpvar_5.x;
  } else {
    tmpvar_7 = tmpvar_5.y;
  };
  tmpvar_5.x = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = ((abs(tmpvar_2) - v_clip_size) + tmpvar_7);
  vec2 tmpvar_9;
  tmpvar_9 = max (tmpvar_8, 0.0);
  float tmpvar_10;
  tmpvar_10 = min (max ((0.5 - 
    (((min (
      max (tmpvar_8.x, tmpvar_8.y)
    , 0.0) + sqrt(
      dot (tmpvar_9, tmpvar_9)
    )) - tmpvar_7) * tmpvar_4)
  ), 0.0), 1.0);
  vec4 tmpvar_11;
  tmpvar_11 = vec4(mix (tmpvar_10, (1.0 - tmpvar_10), vClipMode.x));
  output_color_1 = tmpvar_11;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_11.xxxx;
  };
  oFragColor = output_color_1;
}

