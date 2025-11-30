#version 150
// cs_fast_linear_gradient
// features: []

precision highp float;
out vec4 oFragColor;
in float vPos;
flat in vec4 vColor0;
flat in vec4 vColor1;
void main ()
{
  oFragColor = mix (vColor0, vColor1, vPos);
}

