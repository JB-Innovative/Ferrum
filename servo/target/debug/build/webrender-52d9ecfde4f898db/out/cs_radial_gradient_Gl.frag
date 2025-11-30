#version 150
// cs_radial_gradient
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sGpuBufferF;
flat in ivec2 v_gradient_address;
flat in vec2 v_gradient_repeat;
in vec2 v_pos;
flat in vec2 v_start_radius;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (sqrt(dot (v_pos, v_pos)) - v_start_radius.x);
  float tmpvar_2;
  tmpvar_2 = min (max ((1.0 + 
    ((tmpvar_1 - (floor(tmpvar_1) * v_gradient_repeat.x)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_3;
  tmpvar_3 = floor(tmpvar_2);
  int tmpvar_4;
  tmpvar_4 = (v_gradient_address.x + (2 * int(tmpvar_3)));
  ivec2 tmpvar_5;
  tmpvar_5.x = int((uint(tmpvar_4) % 1024u));
  tmpvar_5.y = int((uint(tmpvar_4) / 1024u));
  oFragColor = (texelFetchOffset (sGpuBufferF, tmpvar_5, 0, ivec2(0, 0)) + (texelFetchOffset (sGpuBufferF, tmpvar_5, 0, ivec2(1, 0)) * (tmpvar_2 - tmpvar_3)));
}

