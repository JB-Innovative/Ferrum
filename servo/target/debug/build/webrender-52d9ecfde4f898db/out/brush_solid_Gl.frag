#version 150
// brush_solid
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 v_color;
void main ()
{
  oFragColor = v_color;
}

