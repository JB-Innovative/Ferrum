#version 150
// cs_conic_gradient
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sGpuBufferF;
flat in ivec2 v_gradient_address;
flat in vec2 v_gradient_repeat;
in vec2 v_pos;
flat in vec2 v_center;
flat in vec3 v_start_offset_offset_scale_angle_vec;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (v_pos - v_center);
  float tmpvar_2;
  tmpvar_2 = ((fract(
    ((atan (tmpvar_1.y, tmpvar_1.x) + v_start_offset_offset_scale_angle_vec.z) / 6.283185)
  ) * v_start_offset_offset_scale_angle_vec.y) - v_start_offset_offset_scale_angle_vec.x);
  float tmpvar_3;
  tmpvar_3 = min (max ((1.0 + 
    ((tmpvar_2 - (floor(tmpvar_2) * v_gradient_repeat.x)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_4;
  tmpvar_4 = floor(tmpvar_3);
  int tmpvar_5;
  tmpvar_5 = (v_gradient_address.x + (2 * int(tmpvar_4)));
  ivec2 tmpvar_6;
  tmpvar_6.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_6.y = int((uint(tmpvar_5) / 1024u));
  oFragColor = (texelFetchOffset (sGpuBufferF, tmpvar_6, 0, ivec2(0, 0)) + (texelFetchOffset (sGpuBufferF, tmpvar_6, 0, ivec2(1, 0)) * (tmpvar_3 - tmpvar_4)));
}

