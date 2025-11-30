#version 150
// composite
// features: ["TEXTURE_RECT"]

uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vNormalizedWorldPos;
flat out vec2 vRoundedClipParams;
flat out vec4 vRoundedClipRadii;
out vec2 vUv;
flat out vec4 vColor;
flat out vec4 vUVBounds;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec4 aColor;
in vec4 aParams;
in vec2 aFlip;
in vec4 aDeviceRoundedClipRect;
in vec4 aDeviceRoundedClipRadii;
in vec4 aUvRect0;
void main ()
{
  vec4 uvBounds_1;
  vec4 tmpvar_2;
  tmpvar_2 = mix (aDeviceRect, aDeviceRect.zwxy, aFlip.xyxy);
  vec2 tmpvar_3;
  tmpvar_3 = min (max (mix (tmpvar_2.xy, tmpvar_2.zw, aPosition), aDeviceClipRect.xy), aDeviceClipRect.zw);
  vec2 tmpvar_4;
  tmpvar_4 = (0.5 * (aDeviceRoundedClipRect.zw - aDeviceRoundedClipRect.xy));
  vNormalizedWorldPos = ((aDeviceRoundedClipRect.xy + tmpvar_4) - tmpvar_3);
  vRoundedClipParams = tmpvar_4;
  vRoundedClipRadii = aDeviceRoundedClipRadii;
  vec2 tmpvar_5;
  tmpvar_5 = mix (aUvRect0.xy, aUvRect0.zw, ((tmpvar_3 - tmpvar_2.xy) / (tmpvar_2.zw - tmpvar_2.xy)));
  vec4 tmpvar_6;
  tmpvar_6.xy = min (aUvRect0.xy, aUvRect0.zw);
  tmpvar_6.zw = max (aUvRect0.xy, aUvRect0.zw);
  uvBounds_1 = tmpvar_6;
  if ((int(aParams.y) == 1)) {
    uvBounds_1 = (tmpvar_6 + vec4(0.5, 0.5, -0.5, -0.5));
  };
  vUv = tmpvar_5;
  vUVBounds = uvBounds_1;
  vColor = aColor;
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 1.0);
  tmpvar_7.xy = tmpvar_3;
  gl_Position = (uTransform * tmpvar_7);
}

