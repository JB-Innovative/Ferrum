#version 150
// brush_linear_gradient
// features: ["ALPHA_PASS"]

precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_local_pos;
uniform sampler2D sGpuBufferF;
flat in ivec2 v_gradient_address;
flat in vec2 v_gradient_repeat;
in vec2 v_pos;
flat in vec2 v_tile_repeat;
flat in vec2 v_start_offset;
flat in vec2 v_scale_dir;
void main ()
{
  vec4 frag_color_1;
  vec2 pos_2;
  vec2 tmpvar_3;
  tmpvar_3 = max (v_pos, vec2(0.0, 0.0));
  pos_2 = fract(tmpvar_3);
  if ((tmpvar_3.x >= v_tile_repeat.x)) {
    pos_2.x = 1.0;
  };
  if ((tmpvar_3.y >= v_tile_repeat.y)) {
    pos_2.y = 1.0;
  };
  float tmpvar_4;
  tmpvar_4 = (dot (pos_2, v_scale_dir) - v_start_offset.x);
  float tmpvar_5;
  tmpvar_5 = min (max ((1.0 + 
    ((tmpvar_4 - (floor(tmpvar_4) * v_gradient_repeat.x)) * 128.0)
  ), 0.0), 129.0);
  float tmpvar_6;
  tmpvar_6 = floor(tmpvar_5);
  int tmpvar_7;
  tmpvar_7 = (v_gradient_address.x + (2 * int(tmpvar_6)));
  ivec2 tmpvar_8;
  tmpvar_8.x = int((uint(tmpvar_7) % 1024u));
  tmpvar_8.y = int((uint(tmpvar_7) / 1024u));
  vec2 tmpvar_9;
  tmpvar_9 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  frag_color_1 = ((texelFetchOffset (sGpuBufferF, tmpvar_8, 0, ivec2(0, 0)) + (texelFetchOffset (sGpuBufferF, tmpvar_8, 0, ivec2(1, 0)) * 
    (tmpvar_5 - tmpvar_6)
  )) * min (max (
    (0.5 - max (tmpvar_9.x, tmpvar_9.y))
  , 0.0), 1.0));
  float tmpvar_10;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_10 = 1.0;
  } else {
    vec2 tmpvar_11;
    tmpvar_11 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_12;
    tmpvar_12.xy = greaterThanEqual (tmpvar_11, vClipMaskUvBounds.xy);
    tmpvar_12.zw = lessThan (tmpvar_11, vClipMaskUvBounds.zw);
    bool tmpvar_13;
    tmpvar_13 = (tmpvar_12 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_13)) {
      tmpvar_10 = 0.0;
    } else {
      tmpvar_10 = texelFetch (sClipMask, ivec2(tmpvar_11), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_10);
  oFragColor = frag_color_1;
}

