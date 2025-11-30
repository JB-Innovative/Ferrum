#version 150
// cs_conic_gradient
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
flat out ivec2 v_gradient_address;
flat out vec2 v_gradient_repeat;
out vec2 v_pos;
flat out vec2 v_center;
flat out vec3 v_start_offset_offset_scale_angle_vec;
in vec4 aTaskRect;
in vec2 aCenter;
in vec2 aScale;
in float aStartOffset;
in float aEndOffset;
in float aAngle;
in int aExtendMode;
in int aGradientStopsAddress;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = (aEndOffset - aStartOffset);
  float tmpvar_2;
  if ((tmpvar_1 != 0.0)) {
    tmpvar_2 = (1.0/(tmpvar_1));
  } else {
    tmpvar_2 = 0.0;
  };
  v_start_offset_offset_scale_angle_vec.y = tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = mix (aTaskRect.xy, aTaskRect.zw, aPosition);
  gl_Position = (uTransform * tmpvar_3);
  v_start_offset_offset_scale_angle_vec.z = (1.570796 - aAngle);
  v_start_offset_offset_scale_angle_vec.x = (aStartOffset * tmpvar_2);
  v_center = (aCenter * tmpvar_2);
  v_pos = (((
    (aTaskRect.zw - aTaskRect.xy)
   * aPosition) * tmpvar_2) * aScale);
  v_gradient_repeat.x = float((aExtendMode == 1));
  v_gradient_address.x = aGradientStopsAddress;
}

