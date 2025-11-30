#version 150
// ps_clear
// features: []

precision highp float;
out vec4 oFragColor;
in vec4 vColor;
void main ()
{
  oFragColor = vColor;
}

