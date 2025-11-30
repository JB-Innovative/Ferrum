#version 150
// brush_image
// features: ["ALPHA_PASS", "ANTIALIASING", "DUAL_SOURCE_BLENDING", "REPETITION", "TEXTURE_RECT"]

#extension GL_ARB_explicit_attrib_location : enable
precision highp float;
layout(location=0, index=0) out vec4 oFragColor;
layout(location=0, index=1) out vec4 oFragBlend;
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
  vec4 frag_blend_2;
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
  vec2 tmpvar_5;
  tmpvar_5 = (max ((vTransformBounds.xy - v_local_pos), (v_local_pos - vTransformBounds.zw)) / (abs(
    dFdx(v_local_pos)
  ) + abs(
    dFdy(v_local_pos)
  )));
  vec4 tmpvar_6;
  tmpvar_6 = (texture (sColor0, min (max (repeated_uv_3, v_uv_sample_bounds.xy), v_uv_sample_bounds.zw)) * min (max (
    (0.5 - max (tmpvar_5.x, tmpvar_5.y))
  , 0.0), 1.0));
  frag_color_1 = (v_color * tmpvar_6);
  frag_blend_2 = ((tmpvar_6 * v_mask_swizzle.x) + (tmpvar_6.wwww * v_mask_swizzle.y));
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
  oFragBlend = (frag_blend_2 * tmpvar_7);
  oFragColor = frag_color_1;
}

