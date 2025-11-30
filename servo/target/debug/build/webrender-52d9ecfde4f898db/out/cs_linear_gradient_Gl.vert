#version 150
// cs_linear_gradient
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
flat out ivec2 v_gradient_address;
flat out vec2 v_gradient_repeat;
out vec2 v_pos;
flat out vec2 v_scale_dir;
flat out vec2 v_start_offset;
in vec4 aTaskRect;
in vec2 aStartPoint;
in vec2 aEndPoint;
in vec2 aScale;
in int aExtendMode;
in int aGradientStopsAddress;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = mix (aTaskRect.xy, aTaskRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_1);
  v_pos = (aPosition * aScale);
  vec2 tmpvar_2;
  tmpvar_2 = (aEndPoint - aStartPoint);
  v_scale_dir = (tmpvar_2 / dot (tmpvar_2, tmpvar_2));
  v_start_offset.x = dot (aStartPoint, v_scale_dir);
  v_scale_dir = (v_scale_dir * (aTaskRect.zw - aTaskRect.xy));
  v_gradient_repeat.x = float((aExtendMode == 1));
  v_gradient_address.x = aGradientStopsAddress;
}

