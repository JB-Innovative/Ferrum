#version 150
// brush_opacity
// features: []

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
in vec2 v_uv;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_opacity_perspective_vec;
void main ()
{
  oFragColor = (v_opacity_perspective_vec.x * texture (sColor0, min (max (
    (v_uv * mix (gl_FragCoord.w, 1.0, v_opacity_perspective_vec.y))
  , v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)));
}

