#version 150
// ps_quad_radial_gradient
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
uniform sampler2D sGpuBufferF;
flat in vec4 v_color;
flat in ivec4 v_flags;
in vec2 vLocalPos;
flat in ivec2 v_gradient_address;
flat in vec2 v_gradient_repeat;
flat in vec2 v_start_radius;
in vec2 v_pos;
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
  float tmpvar_6;
  tmpvar_6 = (sqrt(dot (v_pos, v_pos)) - v_start_radius.x);
  float tmpvar_7;
  tmpvar_7 = min (max ((1.0 + 
    ((tmpvar_6 - (floor(tmpvar_6) * v_gradient_repeat.x)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_8;
  tmpvar_8 = floor(tmpvar_7);
  int tmpvar_9;
  tmpvar_9 = (v_gradient_address.x + (2 * int(tmpvar_8)));
  ivec2 tmpvar_10;
  tmpvar_10.x = int((uint(tmpvar_9) % 1024u));
  tmpvar_10.y = int((uint(tmpvar_9) / 1024u));
  tmpvar_5 = (base_color_2 * (texelFetchOffset (sGpuBufferF, tmpvar_10, 0, ivec2(0, 0)) + (texelFetchOffset (sGpuBufferF, tmpvar_10, 0, ivec2(1, 0)) * 
    (tmpvar_7 - tmpvar_8)
  )));
  output_color_1 = tmpvar_5;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_5.xxxx;
  };
  oFragColor = output_color_1;
}

