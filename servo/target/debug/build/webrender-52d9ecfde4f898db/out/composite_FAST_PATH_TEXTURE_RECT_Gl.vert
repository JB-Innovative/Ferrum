#version 150
// composite
// features: ["FAST_PATH", "TEXTURE_RECT"]

uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vUv;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec2 aFlip;
in vec4 aUvRect0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = mix (aDeviceRect, aDeviceRect.zwxy, aFlip.xyxy);
  vec2 tmpvar_2;
  tmpvar_2 = min (max (mix (tmpvar_1.xy, tmpvar_1.zw, aPosition), aDeviceClipRect.xy), aDeviceClipRect.zw);
  vUv = mix (aUvRect0.xy, aUvRect0.zw, ((tmpvar_2 - tmpvar_1.xy) / (tmpvar_1.zw - tmpvar_1.xy)));
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 1.0);
  tmpvar_3.xy = tmpvar_2;
  gl_Position = (uTransform * tmpvar_3);
}

