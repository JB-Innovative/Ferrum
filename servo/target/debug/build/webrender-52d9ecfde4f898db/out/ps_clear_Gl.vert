#version 150
// ps_clear
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
out vec4 vColor;
in vec4 aRect;
in vec4 aColor;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = mix (aRect.xy, aRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_1);
  gl_Position.z = gl_Position.w;
  vColor = aColor;
}

