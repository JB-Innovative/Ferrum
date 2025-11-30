#version 150
// ps_quad_textured
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
flat in vec4 vTransformBounds;
flat in vec4 v_color;
flat in ivec4 v_flags;
in vec2 vLocalPos;
flat in vec4 v_uv0_sample_bounds;
in vec2 v_uv0;
void main ()
{
  vec4 output_color_1;
  vec4 base_color_2;
  base_color_2 = v_color;
  float alpha_3;
  alpha_3 = 1.0;
  if ((v_flags.w != 0)) {
    vec2 tmpvar_4;
    tmpvar_4 = (max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw)) / (abs(
      dFdx(vLocalPos)
    ) + abs(
      dFdy(vLocalPos)
    )));
    alpha_3 = min (max ((0.5 - 
      max (tmpvar_4.x, tmpvar_4.y)
    ), 0.0), 1.0);
  };
  base_color_2 = (v_color * alpha_3);
  vec4 tmpvar_5;
  tmpvar_5 = base_color_2;
  if ((v_flags.x != 0)) {
    tmpvar_5 = (base_color_2 * texture (sColor0, min (max (v_uv0, v_uv0_sample_bounds.xy), v_uv0_sample_bounds.zw)));
  };
  output_color_1 = tmpvar_5;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_5.xxxx;
  };
  oFragColor = output_color_1;
}

