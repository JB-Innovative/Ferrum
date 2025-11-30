#version 150
// debug_font
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
in vec2 vColorTexCoord;
in vec4 vColor;
void main ()
{
  oFragColor = (vColor * texture (sColor0, vColorTexCoord).x);
}

