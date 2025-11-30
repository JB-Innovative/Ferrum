#version 150
// cs_clip_rectangle
// features: ["FAST_PATH"]

precision highp float;
out vec4 oFragColor;
in vec4 vLocalPos;
flat in vec4 v_clip_radii;
flat in vec2 v_clip_size;
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
  tmpvar_4 = v_clip_radii;
  vec2 tmpvar_5;
  if ((0.0 < tmpvar_1.x)) {
    tmpvar_5 = v_clip_radii.xy;
  } else {
    tmpvar_5 = v_clip_radii.zw;
  };
  tmpvar_4.xy = tmpvar_5;
  float tmpvar_6;
  if ((0.0 < tmpvar_1.y)) {
    tmpvar_6 = tmpvar_4.x;
  } else {
    tmpvar_6 = tmpvar_4.y;
  };
  tmpvar_4.x = tmpvar_6;
  vec2 tmpvar_7;
  tmpvar_7 = ((abs(tmpvar_1) - v_clip_size) + tmpvar_6);
  vec2 tmpvar_8;
  tmpvar_8 = max (tmpvar_7, 0.0);
  float tmpvar_9;
  tmpvar_9 = min (max ((0.5 - 
    (((min (
      max (tmpvar_7.x, tmpvar_7.y)
    , 0.0) + sqrt(
      dot (tmpvar_8, tmpvar_8)
    )) - tmpvar_6) * tmpvar_3)
  ), 0.0), 1.0);
  float tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, (1.0 - tmpvar_9), vClipMode.x);
  float tmpvar_11;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_11 = tmpvar_10;
  } else {
    tmpvar_11 = 0.0;
  };
  vec4 tmpvar_12;
  tmpvar_12.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_12.x = tmpvar_11;
  oFragColor = tmpvar_12;
}

