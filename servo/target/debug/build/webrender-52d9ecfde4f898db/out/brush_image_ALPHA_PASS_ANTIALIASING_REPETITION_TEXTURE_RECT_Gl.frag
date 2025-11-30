#version 150
// brush_image
// features: ["ALPHA_PASS", "ANTIALIASING", "REPETITION", "TEXTURE_RECT"]

precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
flat in vec4 vTransformBounds;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
in vec2 v_local_pos;
in vec2 v_uv;
flat in vec4 v_color;
flat in vec2 v_mask_swizzle;
flat in vec2 v_tile_repeat_bounds;
flat in vec4 v_uv_bounds;
flat in vec4 v_uv_sample_bounds;
flat in vec2 v_perspective;
void main ()
{
  vec4 frag_color_1;
  vec4 texel_2;
  vec2 repeated_uv_3;
  vec2 tmpvar_4;
  tmpvar_4 = max ((v_uv * mix (gl_FragCoord.w, 1.0, v_perspective.x)), vec2(0.0, 0.0));
  repeated_uv_3 = ((fract(tmpvar_4) * (v_uv_bounds.zw - v_uv_bounds.xy)) + v_uv_bounds.xy);
  if ((tmpvar_4.x >= v_tile_repeat_bounds.x)) {
    repeated_uv_3.x = v_uv_bounds.z;
  };
  if ((tmpvar_4.y >= v_tile_repeat_bounds.y)) {
    repeated_uv_3.y = v_uv_bounds.w;
  };
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, min (max (repeated_uv_3, v_uv_sample_bounds.xy), v_uv_sample_bounds.zw));
  texel_2.w = tmpvar_5.w;
  vec2 tmpvar_6;
  tmpvar_6 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  texel_2.xyz = ((tmpvar_5.xyz * v_mask_swizzle.x) + (tmpvar_5.www * v_mask_swizzle.y));
  frag_color_1 = (v_color * (texel_2 * min (
    max ((0.5 - max (tmpvar_6.x, tmpvar_6.y)), 0.0)
  , 1.0)));
  float tmpvar_7;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_7 = 1.0;
  } else {
    vec2 tmpvar_8;
    tmpvar_8 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_9;
    tmpvar_9.xy = greaterThanEqual (tmpvar_8, vClipMaskUvBounds.xy);
    tmpvar_9.zw = lessThan (tmpvar_8, vClipMaskUvBounds.zw);
    bool tmpvar_10;
    tmpvar_10 = (tmpvar_9 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_10)) {
      tmpvar_7 = 0.0;
    } else {
      tmpvar_7 = texelFetch (sClipMask, ivec2(tmpvar_8), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_7);
  oFragColor = frag_color_1;
}

