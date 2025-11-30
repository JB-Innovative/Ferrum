#version 150
// brush_image
// features: ["TEXTURE_RECT"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
in vec2 v_uv;
flat in vec4 v_uv_bounds;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_perspective;
void main ()
{
  oFragColor = texture (sColor0, min (max ((
    (v_uv * mix (gl_FragCoord.w, 1.0, v_perspective.x))
   + v_uv_bounds.xy), v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
}

