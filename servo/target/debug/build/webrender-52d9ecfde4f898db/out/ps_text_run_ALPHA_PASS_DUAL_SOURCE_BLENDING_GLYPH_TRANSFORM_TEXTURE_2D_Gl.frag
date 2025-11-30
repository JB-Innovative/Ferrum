#version 150
// ps_text_run
// features: ["ALPHA_PASS", "DUAL_SOURCE_BLENDING", "GLYPH_TRANSFORM", "TEXTURE_2D"]

#extension GL_ARB_explicit_attrib_location : enable
precision highp float;
layout(location=0, index=0) out vec4 oFragColor;
layout(location=0, index=1) out vec4 oFragBlend;
uniform sampler2D sColor0;
uniform sampler2D sClipMask;
flat in vec4 vClipMaskUvBounds;
in vec2 vClipMaskUv;
flat in vec4 v_color;
flat in vec3 v_mask_swizzle;
flat in vec4 v_uv_bounds;
in vec2 v_uv;
in vec4 v_uv_clip;
void main ()
{
  vec4 frag_color_1;
  vec4 frag_blend_2;
  vec4 mask_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, min (max (v_uv, v_uv_bounds.xy), v_uv_bounds.zw));
  mask_3 = (mix(tmpvar_4, tmpvar_4.xxxx, bvec4((v_mask_swizzle.z != 0.0))) * float((
    greaterThanEqual (v_uv_clip, vec4(0.0, 0.0, 0.0, 0.0))
   == bvec4(1, 1, 1, 1))));
  frag_color_1 = (v_color * mask_3);
  frag_blend_2 = ((mask_3 * v_mask_swizzle.x) + (mask_3.wwww * v_mask_swizzle.y));
  float tmpvar_5;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_5 = 1.0;
  } else {
    vec2 tmpvar_6;
    tmpvar_6 = (vClipMaskUv * gl_FragCoord.w);
    bvec4 tmpvar_7;
    tmpvar_7.xy = greaterThanEqual (tmpvar_6, vClipMaskUvBounds.xy);
    tmpvar_7.zw = lessThan (tmpvar_6, vClipMaskUvBounds.zw);
    bool tmpvar_8;
    tmpvar_8 = (tmpvar_7 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_8)) {
      tmpvar_5 = 0.0;
    } else {
      tmpvar_5 = texelFetch (sClipMask, ivec2(tmpvar_6), 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_5);
  oFragColor = frag_color_1;
  oFragBlend = (frag_blend_2 * tmpvar_5);
}

