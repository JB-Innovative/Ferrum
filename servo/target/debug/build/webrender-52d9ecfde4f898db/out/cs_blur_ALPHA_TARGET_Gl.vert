#version 150
// cs_blur
// features: ["ALPHA_TARGET"]

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sRenderTasks;
out vec2 vUv;
flat out vec4 vUvRect;
flat out vec4 vUvClampRect;
flat out vec2 vOffsetScale;
flat out ivec2 vSupport;
flat out vec2 vGaussCoefficients;
in int aBlurRenderTaskAddress;
in int aBlurSourceTaskAddress;
in int aBlurDirection;
in int aBlurEdgeMode;
in vec3 aBlurParams;
void main ()
{
  ivec2 tmpvar_1;
  tmpvar_1.x = int((2u * (
    uint(aBlurRenderTaskAddress)
   % 512u)));
  tmpvar_1.y = int((uint(aBlurRenderTaskAddress) / 512u));
  vec4 tmpvar_2;
  tmpvar_2 = texelFetchOffset (sRenderTasks, tmpvar_1, 0, ivec2(0, 0));
  ivec2 tmpvar_3;
  tmpvar_3.x = int((2u * (
    uint(aBlurSourceTaskAddress)
   % 512u)));
  tmpvar_3.y = int((uint(aBlurSourceTaskAddress) / 512u));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(0, 0));
  vec2 tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_5 = tmpvar_4.xy;
  tmpvar_6 = tmpvar_4.zw;
  vec2 tmpvar_7;
  tmpvar_7 = vec2(textureSize (sColor0, 0));
  vSupport.x = (int(ceil(
    (1.5 * aBlurParams.x)
  )) * 2);
  vSupport.y = aBlurEdgeMode;
  if ((0 < vSupport.x)) {
    int i_8;
    float gauss_coefficient_total_9;
    vec3 gauss_coefficient_10;
    float tmpvar_11;
    tmpvar_11 = exp((-0.5 / (aBlurParams.x * aBlurParams.x)));
    vec2 tmpvar_12;
    tmpvar_12.x = (1.0/((2.506628 * aBlurParams.x)));
    tmpvar_12.y = tmpvar_11;
    vGaussCoefficients = tmpvar_12;
    vec3 tmpvar_13;
    tmpvar_13.xy = tmpvar_12;
    tmpvar_13.z = (tmpvar_11 * tmpvar_11);
    gauss_coefficient_10 = tmpvar_13;
    gauss_coefficient_total_9 = tmpvar_13.x;
    i_8 = 1;
    for (; vSupport.x >= i_8; i_8 += 2) {
      gauss_coefficient_10.xy = (gauss_coefficient_10.xy * gauss_coefficient_10.yz);
      float tmpvar_14;
      tmpvar_14 = gauss_coefficient_10.x;
      gauss_coefficient_10.xy = (gauss_coefficient_10.xy * gauss_coefficient_10.yz);
      gauss_coefficient_total_9 = (gauss_coefficient_total_9 + (2.0 * (tmpvar_14 + gauss_coefficient_10.x)));
    };
    vGaussCoefficients.x = (tmpvar_12.x / gauss_coefficient_total_9);
  } else {
    vGaussCoefficients = vec2(1.0, 1.0);
  };
  bool tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = bool(0);
  tmpvar_15 = (0 == aBlurDirection);
  if (tmpvar_15) {
    vec2 tmpvar_17;
    tmpvar_17.y = 0.0;
    tmpvar_17.x = (1.0/((tmpvar_4.z - tmpvar_4.x)));
    vOffsetScale = tmpvar_17;
    tmpvar_16 = bool(1);
  };
  tmpvar_15 = (tmpvar_15 || (1 == aBlurDirection));
  tmpvar_15 = (tmpvar_15 && !(tmpvar_16));
  if (tmpvar_15) {
    vec2 tmpvar_18;
    tmpvar_18.x = 0.0;
    tmpvar_18.y = (1.0/((tmpvar_4.w - tmpvar_4.y)));
    vOffsetScale = tmpvar_18;
    tmpvar_16 = bool(1);
  };
  tmpvar_15 = !(tmpvar_16);
  if (tmpvar_15) {
    vOffsetScale = vec2(0.0, 0.0);
  };
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_5;
  tmpvar_19.zw = tmpvar_6;
  vUvRect = (tmpvar_19 / tmpvar_7.xyxy);
  vec4 tmpvar_20;
  tmpvar_20.xy = (tmpvar_4.xy + vec2(0.5, 0.5));
  tmpvar_20.zw = ((tmpvar_4.xy + aBlurParams.yz) - vec2(0.5, 0.5));
  vUvClampRect = (tmpvar_20 / tmpvar_7.xyxy);
  vUv = aPosition;
  vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 1.0);
  tmpvar_21.xy = mix (tmpvar_2.xy, tmpvar_2.zw, aPosition);
  gl_Position = (uTransform * tmpvar_21);
}

