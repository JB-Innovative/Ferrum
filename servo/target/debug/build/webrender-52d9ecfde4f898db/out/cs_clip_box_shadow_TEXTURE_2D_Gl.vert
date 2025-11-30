#version 150
// cs_clip_box_shadow
// features: ["TEXTURE_2D"]

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
in vec4 aClipDeviceArea;
in vec4 aClipOrigins;
in float aDevicePixelScale;
in ivec2 aTransformIds;
out vec4 vLocalPos;
out vec2 vUv;
flat out vec4 vUvBounds;
flat out vec4 vEdge;
flat out vec4 vUvBounds_NoClamp;
flat out vec2 vClipMode;
in ivec2 aClipDataResourceAddress;
in vec2 aClipSrcRectSize;
in int aClipMode;
in ivec2 aStretchMode;
in vec4 aClipDestRect;
void main ()
{
  mat4 transform_m_1;
  mat4 transform_inv_m_2;
  int tmpvar_3;
  tmpvar_3 = (aTransformIds.x & 8388607);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((8u * (
    uint(tmpvar_3)
   % 128u)));
  tmpvar_4.y = int((uint(tmpvar_3) / 128u));
  transform_m_1[0] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(0, 0));
  transform_m_1[1] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(1, 0));
  transform_m_1[2] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(2, 0));
  transform_m_1[3] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(3, 0));
  transform_inv_m_2[0] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(4, 0));
  transform_inv_m_2[1] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(5, 0));
  transform_inv_m_2[2] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(6, 0));
  transform_inv_m_2[3] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(7, 0));
  mat4 transform_m_5;
  int tmpvar_6;
  tmpvar_6 = (aTransformIds.y & 8388607);
  ivec2 tmpvar_7;
  tmpvar_7.x = int((8u * (
    uint(tmpvar_6)
   % 128u)));
  tmpvar_7.y = int((uint(tmpvar_6) / 128u));
  transform_m_5[0] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(0, 0));
  transform_m_5[1] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(1, 0));
  transform_m_5[2] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(2, 0));
  transform_m_5[3] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(3, 0));
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = aClipDestRect.xy;
  tmpvar_9 = aClipDestRect.zw;
  vec2 uv_rect_p0_10;
  vec2 uv_rect_p1_11;
  vec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sGpuCache, aClipDataResourceAddress, 0, ivec2(0, 0));
  uv_rect_p0_10 = tmpvar_12.xy;
  uv_rect_p1_11 = tmpvar_12.zw;
  vec4 pos_13;
  vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = ((aClipOrigins.zw + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition)) / aDevicePixelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (transform_m_5 * tmpvar_14);
  pos_13.w = tmpvar_15.w;
  pos_13.xyz = (tmpvar_15.xyz / tmpvar_15.w);
  vec2 tmpvar_16;
  tmpvar_16 = pos_13.xy;
  vec4 tmpvar_17;
  tmpvar_17 = (transform_m_1 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18 = transform_inv_m_2[uint(0)].xyz;
  tmpvar_19 = transform_inv_m_2[1u].xyz;
  tmpvar_20 = transform_inv_m_2[2u].xyz;
  mat3 tmpvar_21;
  tmpvar_21[0].x = tmpvar_18.x;
  tmpvar_21[1].x = tmpvar_18.y;
  tmpvar_21[2].x = tmpvar_18.z;
  tmpvar_21[0].y = tmpvar_19.x;
  tmpvar_21[1].y = tmpvar_19.y;
  tmpvar_21[2].y = tmpvar_19.z;
  tmpvar_21[0].z = tmpvar_20.x;
  tmpvar_21[1].z = tmpvar_20.y;
  tmpvar_21[2].z = tmpvar_20.z;
  vec3 tmpvar_22;
  tmpvar_22.z = -10000.0;
  tmpvar_22.xy = tmpvar_16;
  vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 * vec3(0.0, 0.0, 1.0));
  vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_17.xyz / tmpvar_17.w);
  float tmpvar_25;
  float tmpvar_26;
  tmpvar_26 = dot (tmpvar_23, vec3(0.0, 0.0, 1.0));
  float tmpvar_27;
  tmpvar_27 = abs(tmpvar_26);
  if ((1e-06 < tmpvar_27)) {
    tmpvar_25 = (dot ((tmpvar_24 - tmpvar_22), tmpvar_23) / tmpvar_26);
  };
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xy = tmpvar_16;
  tmpvar_28.z = (-10000.0 + tmpvar_25);
  vec4 tmpvar_29;
  tmpvar_29 = ((transform_inv_m_2 * tmpvar_28) * tmpvar_15.w);
  vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 1.0);
  tmpvar_30.xy = (aClipOrigins.xy + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition));
  gl_Position = (uTransform * tmpvar_30);
  vec4 tmpvar_31;
  tmpvar_31.xy = tmpvar_8;
  tmpvar_31.zw = tmpvar_9;
  vTransformBounds = tmpvar_31;
  vClipMode.x = float(aClipMode);
  vec2 tmpvar_32;
  tmpvar_32 = vec2(textureSize (sColor0, 0));
  vec2 tmpvar_33;
  tmpvar_33 = (tmpvar_29.xy / tmpvar_29.w);
  vLocalPos = tmpvar_29;
  vec2 tmpvar_34;
  tmpvar_34 = (aClipDestRect.zw - aClipDestRect.xy);
  bool tmpvar_35;
  bool tmpvar_36;
  tmpvar_36 = bool(0);
  tmpvar_35 = (0 == aStretchMode.x);
  if (tmpvar_35) {
    vEdge.x = 0.5;
    vEdge.z = ((tmpvar_34.x / aClipSrcRectSize.x) - 0.5);
    vUv.x = ((tmpvar_33.x - aClipDestRect.x) / aClipSrcRectSize.x);
    tmpvar_36 = bool(1);
  };
  tmpvar_35 = !(tmpvar_36);
  if (tmpvar_35) {
    vEdge.xz = vec2(1.0, 1.0);
    vUv.x = ((tmpvar_33.x - aClipDestRect.x) / tmpvar_34.x);
    tmpvar_36 = bool(1);
  };
  bool tmpvar_37;
  bool tmpvar_38;
  tmpvar_38 = bool(0);
  tmpvar_37 = (0 == aStretchMode.y);
  if (tmpvar_37) {
    vEdge.y = 0.5;
    vEdge.w = ((tmpvar_34.y / aClipSrcRectSize.y) - 0.5);
    vUv.y = ((tmpvar_33.y - aClipDestRect.y) / aClipSrcRectSize.y);
    tmpvar_38 = bool(1);
  };
  tmpvar_37 = !(tmpvar_38);
  if (tmpvar_37) {
    vEdge.yw = vec2(1.0, 1.0);
    vUv.y = ((tmpvar_33.y - aClipDestRect.y) / tmpvar_34.y);
    tmpvar_38 = bool(1);
  };
  vUv = (vUv * tmpvar_29.w);
  vec4 tmpvar_39;
  tmpvar_39.xy = (tmpvar_12.xy + vec2(0.5, 0.5));
  tmpvar_39.zw = (tmpvar_12.zw - vec2(0.5, 0.5));
  vUvBounds = (tmpvar_39 / tmpvar_32.xyxy);
  vec4 tmpvar_40;
  tmpvar_40.xy = uv_rect_p0_10;
  tmpvar_40.zw = uv_rect_p1_11;
  vUvBounds_NoClamp = (tmpvar_40 / tmpvar_32.xyxy);
}

