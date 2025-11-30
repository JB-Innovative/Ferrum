#version 150
// cs_fast_linear_gradient
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
out float vPos;
flat out vec4 vColor0;
flat out vec4 vColor1;
in vec4 aTaskRect;
in vec4 aColor0;
in vec4 aColor1;
in float aAxisSelect;
void main ()
{
  vPos = mix (aPosition.x, aPosition.y, aAxisSelect);
  vColor0 = aColor0;
  vColor1 = aColor1;
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = mix (aTaskRect.xy, aTaskRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_1);
}

