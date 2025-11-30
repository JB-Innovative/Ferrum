#version 150
// ps_copy
// features: []

in vec2 aPosition;
in vec4 a_src_rect;
in vec4 a_dst_rect;
in vec2 a_dst_texture_size;
out vec2 v_uv;
void main ()
{
  v_uv = mix (a_src_rect.xy, a_src_rect.zw, aPosition);
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = ((mix (a_dst_rect.xy, a_dst_rect.zw, aPosition) / (a_dst_texture_size * 0.5)) - vec2(1.0, 1.0));
  gl_Position = tmpvar_1;
}

