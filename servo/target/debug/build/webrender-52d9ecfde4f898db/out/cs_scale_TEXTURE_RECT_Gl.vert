#version 150
// cs_scale
// features: ["TEXTURE_RECT"]

uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vUv;
flat out vec4 vUvRect;
in vec4 aScaleTargetRect;
in vec4 aScaleSourceRect;
in float aSourceRectType;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = min (aScaleSourceRect.xy, aScaleSourceRect.zw);
  vec2 tmpvar_2;
  tmpvar_2 = max (aScaleSourceRect.xy, aScaleSourceRect.zw);
  vec4 tmpvar_3;
  tmpvar_3.xy = tmpvar_1;
  tmpvar_3.zw = tmpvar_2;
  vUvRect = tmpvar_3;
  vUv = (aScaleSourceRect.xy + ((aScaleSourceRect.zw - aScaleSourceRect.xy) * aPosition));
  if ((int(aSourceRectType) == 1)) {
    vec4 tmpvar_4;
    tmpvar_4.xy = (tmpvar_1 + vec2(0.5, 0.5));
    tmpvar_4.zw = (tmpvar_2 - vec2(0.5, 0.5));
    vUvRect = tmpvar_4;
  };
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = mix (aScaleTargetRect.xy, aScaleTargetRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_5);
}

