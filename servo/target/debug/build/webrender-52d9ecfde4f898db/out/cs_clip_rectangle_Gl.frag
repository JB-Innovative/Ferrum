#version 150
// cs_clip_rectangle
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
in vec4 vLocalPos;
flat in vec4 vClipCenter_Radius_TL;
flat in vec4 vClipCenter_Radius_TR;
flat in vec4 vClipCenter_Radius_BL;
flat in vec4 vClipCenter_Radius_BR;
flat in vec3 vClipPlane_TL;
flat in vec3 vClipPlane_TR;
flat in vec3 vClipPlane_BL;
flat in vec3 vClipPlane_BR;
flat in vec2 vClipMode;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (vLocalPos.xy / vLocalPos.w);
  vec2 tmpvar_2;
  tmpvar_2 = (abs(dFdx(tmpvar_1)) + abs(dFdy(tmpvar_1)));
  float tmpvar_3;
  tmpvar_3 = inversesqrt((0.5 * dot (tmpvar_2, tmpvar_2)));
  vec4 tmpvar_4;
  tmpvar_4.zw = vClipCenter_Radius_TL.zw;
  vec4 tmpvar_5;
  tmpvar_5.zw = vClipCenter_Radius_TR.zw;
  vec4 tmpvar_6;
  tmpvar_6.zw = vClipCenter_Radius_BR.zw;
  vec4 tmpvar_7;
  tmpvar_7.zw = vClipCenter_Radius_BL.zw;
  vec4 corner_8;
  corner_8 = vec4(1e-06, 1e-06, 1.0, 1.0);
  tmpvar_4.xy = (vClipCenter_Radius_TL.xy - tmpvar_1);
  tmpvar_5.xy = ((vClipCenter_Radius_TR.xy - tmpvar_1) * vec2(-1.0, 1.0));
  tmpvar_6.xy = (tmpvar_1 - vClipCenter_Radius_BR.xy);
  tmpvar_7.xy = ((vClipCenter_Radius_BL.xy - tmpvar_1) * vec2(1.0, -1.0));
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_1, vClipPlane_TL.xy);
  if ((vClipPlane_TL.z < tmpvar_9)) {
    corner_8 = tmpvar_4;
  };
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_1, vClipPlane_TR.xy);
  if ((vClipPlane_TR.z < tmpvar_10)) {
    corner_8 = tmpvar_5;
  };
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_1, vClipPlane_BR.xy);
  if ((vClipPlane_BR.z < tmpvar_11)) {
    corner_8 = tmpvar_6;
  };
  float tmpvar_12;
  tmpvar_12 = dot (tmpvar_1, vClipPlane_BL.xy);
  if ((vClipPlane_BL.z < tmpvar_12)) {
    corner_8 = tmpvar_7;
  };
  vec2 tmpvar_13;
  tmpvar_13 = (corner_8.xy * corner_8.zw);
  vec2 tmpvar_14;
  tmpvar_14 = (2.0 * tmpvar_13);
  vec2 tmpvar_15;
  tmpvar_15 = max ((vTransformBounds.xy - tmpvar_1), (tmpvar_1 - vTransformBounds.zw));
  float tmpvar_16;
  tmpvar_16 = min (max ((0.5 - 
    (max (((
      dot (corner_8.xy, tmpvar_13)
     - 1.0) * inversesqrt(
      dot (tmpvar_14, tmpvar_14)
    )), max (tmpvar_15.x, tmpvar_15.y)) * tmpvar_3)
  ), 0.0), 1.0);
  float tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, (1.0 - tmpvar_16), vClipMode.x);
  float tmpvar_18;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_18 = tmpvar_17;
  } else {
    tmpvar_18 = 0.0;
  };
  vec4 tmpvar_19;
  tmpvar_19.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_19.x = tmpvar_18;
  oFragColor = tmpvar_19;
}

