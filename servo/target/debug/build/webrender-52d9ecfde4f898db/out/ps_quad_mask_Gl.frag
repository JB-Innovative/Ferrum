#version 150
// ps_quad_mask
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
flat in ivec4 v_flags;
in vec4 vClipLocalPos;
flat in vec4 vClipCenter_Radius_TL;
flat in vec4 vClipCenter_Radius_TR;
flat in vec4 vClipCenter_Radius_BR;
flat in vec4 vClipCenter_Radius_BL;
flat in vec4 vClipPlane_A;
flat in vec4 vClipPlane_B;
flat in vec4 vClipPlane_C;
flat in vec2 vClipMode;
void main ()
{
  vec4 output_color_1;
  float aa_range_2;
  vec2 tmpvar_3;
  tmpvar_3 = (vClipLocalPos.xy / vClipLocalPos.w);
  vec2 tmpvar_4;
  tmpvar_4 = (abs(dFdx(tmpvar_3)) + abs(dFdy(tmpvar_3)));
  aa_range_2 = inversesqrt((0.5 * dot (tmpvar_4, tmpvar_4)));
  vec3 tmpvar_5;
  tmpvar_5.x = vClipPlane_A.w;
  tmpvar_5.y = vClipPlane_B.x;
  tmpvar_5.z = vClipPlane_B.y;
  vec4 tmpvar_6;
  tmpvar_6.zw = vClipCenter_Radius_TL.zw;
  vec4 tmpvar_7;
  tmpvar_7.zw = vClipCenter_Radius_TR.zw;
  vec4 tmpvar_8;
  tmpvar_8.zw = vClipCenter_Radius_BR.zw;
  vec4 tmpvar_9;
  tmpvar_9.zw = vClipCenter_Radius_BL.zw;
  vec4 corner_10;
  corner_10 = vec4(1e-06, 1e-06, 1.0, 1.0);
  tmpvar_6.xy = (vClipCenter_Radius_TL.xy - tmpvar_3);
  tmpvar_7.xy = ((vClipCenter_Radius_TR.xy - tmpvar_3) * vec2(-1.0, 1.0));
  tmpvar_8.xy = (tmpvar_3 - vClipCenter_Radius_BR.xy);
  tmpvar_9.xy = ((vClipCenter_Radius_BL.xy - tmpvar_3) * vec2(1.0, -1.0));
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_3, vClipPlane_A.xy);
  if ((vClipPlane_A.z < tmpvar_11)) {
    corner_10 = tmpvar_6;
  };
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_3, tmpvar_5.xy);
  if ((vClipPlane_B.y < tmpvar_12)) {
    corner_10 = tmpvar_7;
  };
  float tmpvar_13;
  tmpvar_13 = dot (tmpvar_3, vClipPlane_B.zw);
  if ((vClipPlane_C.x < tmpvar_13)) {
    corner_10 = tmpvar_8;
  };
  float tmpvar_14;
  tmpvar_14 = dot (tmpvar_3, vClipPlane_C.yz);
  if ((vClipPlane_C.w < tmpvar_14)) {
    corner_10 = tmpvar_9;
  };
  vec2 tmpvar_15;
  tmpvar_15 = (corner_10.xy * corner_10.zw);
  vec2 tmpvar_16;
  tmpvar_16 = (2.0 * tmpvar_15);
  vec2 tmpvar_17;
  tmpvar_17 = max ((vTransformBounds.xy - tmpvar_3), (tmpvar_3 - vTransformBounds.zw));
  float tmpvar_18;
  tmpvar_18 = min (max ((0.5 - 
    (max (((
      dot (corner_10.xy, tmpvar_15)
     - 1.0) * inversesqrt(
      dot (tmpvar_16, tmpvar_16)
    )), max (tmpvar_17.x, tmpvar_17.y)) * aa_range_2)
  ), 0.0), 1.0);
  vec4 tmpvar_19;
  tmpvar_19 = vec4(mix (tmpvar_18, (1.0 - tmpvar_18), vClipMode.x));
  output_color_1 = tmpvar_19;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_19.xxxx;
  };
  oFragColor = output_color_1;
}

