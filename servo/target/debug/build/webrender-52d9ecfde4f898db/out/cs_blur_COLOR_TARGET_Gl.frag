#version 150
// cs_blur
// features: ["COLOR_TARGET"]

precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
in vec2 vUv;
flat in vec4 vUvRect;
flat in vec4 vUvClampRect;
flat in vec2 vOffsetScale;
flat in ivec2 vSupport;
flat in vec2 vGaussCoefficients;
void main ()
{
  int i_1;
  vec4 avg_color_2;
  vec3 gauss_coefficient_3;
  vec3 tmpvar_4;
  tmpvar_4.xy = vGaussCoefficients;
  tmpvar_4.z = (vGaussCoefficients.y * vGaussCoefficients.y);
  gauss_coefficient_3 = tmpvar_4;
  avg_color_2 = (texture (sColor0, mix (vUvRect.xy, vUvRect.zw, vUv)) * vGaussCoefficients.x);
  int tmpvar_5;
  tmpvar_5 = min (vSupport.x, 300);
  i_1 = 1;
  for (; tmpvar_5 >= i_1; i_1 += 2) {
    vec2 uv1_6;
    vec2 uv0_7;
    float gauss_coefficient_subtotal_8;
    gauss_coefficient_3.xy = (gauss_coefficient_3.xy * gauss_coefficient_3.yz);
    float tmpvar_9;
    tmpvar_9 = gauss_coefficient_3.x;
    gauss_coefficient_3.xy = (gauss_coefficient_3.xy * gauss_coefficient_3.yz);
    gauss_coefficient_subtotal_8 = (tmpvar_9 + gauss_coefficient_3.x);
    vec2 tmpvar_10;
    tmpvar_10 = (vOffsetScale * (float(i_1) + (gauss_coefficient_3.x / gauss_coefficient_subtotal_8)));
    vec2 tmpvar_11;
    tmpvar_11 = (vUv - tmpvar_10);
    uv0_7 = tmpvar_11;
    vec2 tmpvar_12;
    tmpvar_12 = (vUv + tmpvar_10);
    uv1_6 = tmpvar_12;
    if ((vSupport.y == 1)) {
      vec2 tmpvar_13;
      tmpvar_13 = abs(tmpvar_11);
      vec2 tmpvar_14;
      tmpvar_14 = floor(tmpvar_13);
      vec2 tmpvar_15;
      tmpvar_15 = (tmpvar_13 - tmpvar_14);
      uv0_7 = mix (tmpvar_15, (vec2(1.0, 1.0) - tmpvar_15), (vec2(mod (tmpvar_14, vec2(2.0, 2.0)))));
      vec2 tmpvar_16;
      tmpvar_16 = abs(tmpvar_12);
      vec2 tmpvar_17;
      tmpvar_17 = floor(tmpvar_16);
      vec2 tmpvar_18;
      tmpvar_18 = (tmpvar_16 - tmpvar_17);
      uv1_6 = mix (tmpvar_18, (vec2(1.0, 1.0) - tmpvar_18), (vec2(mod (tmpvar_17, vec2(2.0, 2.0)))));
    };
    vec2 tmpvar_19;
    tmpvar_19 = max (mix (vUvRect.xy, vUvRect.zw, uv0_7), vUvClampRect.xy);
    uv0_7 = tmpvar_19;
    vec2 tmpvar_20;
    tmpvar_20 = min (mix (vUvRect.xy, vUvRect.zw, uv1_6), vUvClampRect.zw);
    uv1_6 = tmpvar_20;
    avg_color_2 = (avg_color_2 + ((texture (sColor0, tmpvar_19) + texture (sColor0, tmpvar_20)) * gauss_coefficient_subtotal_8));
  };
  oFragColor = avg_color_2;
}

