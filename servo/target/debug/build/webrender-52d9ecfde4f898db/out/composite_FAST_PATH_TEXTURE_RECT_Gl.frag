#version 150
// composite
// features: ["FAST_PATH", "TEXTURE_RECT"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
in vec2 vUv;
void main ()
{
  oFragColor = texture (sColor0, vUv);
}

