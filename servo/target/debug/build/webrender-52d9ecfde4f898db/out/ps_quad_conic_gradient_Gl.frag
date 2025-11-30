#version 150
// ps_quad_conic_gradient
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
flat in vec3 v_start_offset_offset_scale_angle_vec;
in vec2 v_dir;
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
  vec2 tmpvar_6;
  tmpvar_6 = abs(v_dir);
  float tmpvar_7;
  tmpvar_7 = (min (tmpvar_6.x, tmpvar_6.y) / max (tmpvar_6.x, tmpvar_6.y));
  float tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = (((
    ((((-0.04649647 * tmpvar_8) + 0.1593142) * tmpvar_8) - 0.3276228)
   * tmpvar_8) * tmpvar_7) + tmpvar_7);
  float tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, (1.570796 - tmpvar_9), float((tmpvar_6.x < tmpvar_6.y)));
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, (3.141593 - tmpvar_10), float((v_dir.x < 0.0)));
  float tmpvar_12;
  if ((v_dir.y < 0.0)) {
    tmpvar_12 = -(tmpvar_11);
  } else {
    tmpvar_12 = tmpvar_11;
  };
  float tmpvar_13;
  tmpvar_13 = ((fract(
    ((tmpvar_12 + v_start_offset_offset_scale_angle_vec.z) / 6.283185)
  ) * v_start_offset_offset_scale_angle_vec.y) - v_start_offset_offset_scale_angle_vec.x);
  float tmpvar_14;
  tmpvar_14 = min (max ((1.0 + 
    ((tmpvar_13 - (floor(tmpvar_13) * v_gradient_repeat.x)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_15;
  tmpvar_15 = floor(tmpvar_14);
  int tmpvar_16;
  tmpvar_16 = (v_gradient_address.x + (2 * int(tmpvar_15)));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((uint(tmpvar_16) % 1024u));
  tmpvar_17.y = int((uint(tmpvar_16) / 1024u));
  tmpvar_5 = (base_color_2 * (texelFetchOffset (sGpuBufferF, tmpvar_17, 0, ivec2(0, 0)) + (texelFetchOffset (sGpuBufferF, tmpvar_17, 0, ivec2(1, 0)) * 
    (tmpvar_14 - tmpvar_15)
  )));
  output_color_1 = tmpvar_5;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_5.xxxx;
  };
  oFragColor = output_color_1;
}

