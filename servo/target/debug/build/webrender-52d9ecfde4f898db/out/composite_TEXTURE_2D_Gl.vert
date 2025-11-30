#version 150
// composite
// features: ["TEXTURE_2D"]

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
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
  vec2 uv_2;
  vec4 tmpvar_3;
  tmpvar_3 = mix (aDeviceRect, aDeviceRect.zwxy, aFlip.xyxy);
  vec2 tmpvar_4;
  tmpvar_4 = min (max (mix (tmpvar_3.xy, tmpvar_3.zw, aPosition), aDeviceClipRect.xy), aDeviceClipRect.zw);
  vec2 tmpvar_5;
  tmpvar_5 = (0.5 * (aDeviceRoundedClipRect.zw - aDeviceRoundedClipRect.xy));
  vNormalizedWorldPos = ((aDeviceRoundedClipRect.xy + tmpvar_5) - tmpvar_4);
  vRoundedClipParams = tmpvar_5;
  vRoundedClipRadii = aDeviceRoundedClipRadii;
  vec2 tmpvar_6;
  tmpvar_6 = mix (aUvRect0.xy, aUvRect0.zw, ((tmpvar_4 - tmpvar_3.xy) / (tmpvar_3.zw - tmpvar_3.xy)));
  uv_2 = tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xy = min (aUvRect0.xy, aUvRect0.zw);
  tmpvar_7.zw = max (aUvRect0.xy, aUvRect0.zw);
  uvBounds_1 = tmpvar_7;
  if ((int(aParams.y) == 1)) {
    vec2 tmpvar_8;
    tmpvar_8 = vec2(textureSize (sColor0, 0));
    uvBounds_1 = (tmpvar_7 + vec4(0.5, 0.5, -0.5, -0.5));
    uv_2 = (tmpvar_6 / tmpvar_8);
    uvBounds_1 = (uvBounds_1 / tmpvar_8.xyxy);
  };
  vUv = uv_2;
  vUVBounds = uvBounds_1;
  vColor = aColor;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 1.0);
  tmpvar_9.xy = tmpvar_4;
  gl_Position = (uTransform * tmpvar_9);
}

