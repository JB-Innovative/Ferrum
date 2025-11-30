#version 150
// debug_font
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vColorTexCoord;
out vec4 vColor;
in vec4 aColor;
in vec2 aColorTexCoord;
void main ()
{
  vec4 pos_1;
  vColor = aColor;
  vColorTexCoord = aColorTexCoord;
  vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  tmpvar_2.xy = aPosition;
  pos_1.zw = tmpvar_2.zw;
  pos_1.xy = floor((aPosition + 0.5));
  gl_Position = (uTransform * pos_1);
}

