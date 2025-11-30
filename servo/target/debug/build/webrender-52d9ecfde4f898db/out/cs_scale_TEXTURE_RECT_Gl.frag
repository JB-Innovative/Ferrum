#version 150
// cs_scale
// features: ["TEXTURE_RECT"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
in vec2 vUv;
flat in vec4 vUvRect;
void main ()
{
  oFragColor = texture (sColor0, min (max (vUv, vUvRect.xy), vUvRect.zw));
}

