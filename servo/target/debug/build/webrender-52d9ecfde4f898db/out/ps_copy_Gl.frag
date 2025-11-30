#version 150
// ps_copy
// features: []

precision highp float;
out vec4 oFragColor;
in vec2 v_uv;
uniform sampler2D sColor0;
void main ()
{
  oFragColor = texelFetch (sColor0, ivec2(v_uv), 0);
}

