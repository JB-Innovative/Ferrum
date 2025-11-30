#version 150
// debug_color
// features: []

precision highp float;
out vec4 oFragColor;
in vec4 vColor;
void main ()
{
  oFragColor = vColor;
}

