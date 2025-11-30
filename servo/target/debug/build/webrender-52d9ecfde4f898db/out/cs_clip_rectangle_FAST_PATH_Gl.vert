#version 150
// cs_clip_rectangle
// features: ["FAST_PATH"]

uniform mat4 uTransform;
in vec2 aPosition;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
in vec4 aClipDeviceArea;
in vec4 aClipOrigins;
in float aDevicePixelScale;
in ivec2 aTransformIds;
out vec4 vLocalPos;
flat out vec4 v_clip_radii;
flat out vec2 v_clip_size;
flat out vec2 vClipMode;
in vec2 aClipLocalPos;
in vec4 aClipLocalRect;
in float aClipMode;
in vec4 aClipRadii_TL;
in vec4 aClipRadii_TR;
in vec4 aClipRadii_BL;
in vec4 aClipRadii_BR;
void main ()
{
  vec2 local_rect_p1_1;
  mat4 transform_m_2;
  mat4 transform_inv_m_3;
  int tmpvar_4;
  tmpvar_4 = (aTransformIds.x & 8388607);
  ivec2 tmpvar_5;
  tmpvar_5.x = int((8u * (
    uint(tmpvar_4)
   % 128u)));
  tmpvar_5.y = int((uint(tmpvar_4) / 128u));
  transform_m_2[0] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(0, 0));
  transform_m_2[1] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(1, 0));
  transform_m_2[2] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(2, 0));
  transform_m_2[3] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(3, 0));
  transform_inv_m_3[0] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(4, 0));
  transform_inv_m_3[1] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(5, 0));
  transform_inv_m_3[2] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(6, 0));
  transform_inv_m_3[3] = texelFetchOffset (sTransformPalette, tmpvar_5, 0, ivec2(7, 0));
  mat4 transform_m_6;
  int tmpvar_7;
  tmpvar_7 = (aTransformIds.y & 8388607);
  ivec2 tmpvar_8;
  tmpvar_8.x = int((8u * (
    uint(tmpvar_7)
   % 128u)));
  tmpvar_8.y = int((uint(tmpvar_7) / 128u));
  transform_m_6[0] = texelFetchOffset (sTransformPalette, tmpvar_8, 0, ivec2(0, 0));
  transform_m_6[1] = texelFetchOffset (sTransformPalette, tmpvar_8, 0, ivec2(1, 0));
  transform_m_6[2] = texelFetchOffset (sTransformPalette, tmpvar_8, 0, ivec2(2, 0));
  transform_m_6[3] = texelFetchOffset (sTransformPalette, tmpvar_8, 0, ivec2(3, 0));
  local_rect_p1_1 = (aClipLocalRect.zw + (aClipLocalPos - aClipLocalRect.xy));
  vec4 pos_9;
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 1.0);
  tmpvar_10.xy = ((aClipOrigins.zw + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition)) / aDevicePixelScale);
  vec4 tmpvar_11;
  tmpvar_11 = (transform_m_6 * tmpvar_10);
  pos_9.w = tmpvar_11.w;
  pos_9.xyz = (tmpvar_11.xyz / tmpvar_11.w);
  vec2 tmpvar_12;
  tmpvar_12 = pos_9.xy;
  vec4 tmpvar_13;
  tmpvar_13 = (transform_m_2 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_14;
  vec3 tmpvar_15;
  vec3 tmpvar_16;
  tmpvar_14 = transform_inv_m_3[uint(0)].xyz;
  tmpvar_15 = transform_inv_m_3[1u].xyz;
  tmpvar_16 = transform_inv_m_3[2u].xyz;
  mat3 tmpvar_17;
  tmpvar_17[0].x = tmpvar_14.x;
  tmpvar_17[1].x = tmpvar_14.y;
  tmpvar_17[2].x = tmpvar_14.z;
  tmpvar_17[0].y = tmpvar_15.x;
  tmpvar_17[1].y = tmpvar_15.y;
  tmpvar_17[2].y = tmpvar_15.z;
  tmpvar_17[0].z = tmpvar_16.x;
  tmpvar_17[1].z = tmpvar_16.y;
  tmpvar_17[2].z = tmpvar_16.z;
  vec3 tmpvar_18;
  tmpvar_18.z = -10000.0;
  tmpvar_18.xy = tmpvar_12;
  vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_17 * vec3(0.0, 0.0, 1.0));
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_13.xyz / tmpvar_13.w);
  float tmpvar_21;
  float tmpvar_22;
  tmpvar_22 = dot (tmpvar_19, vec3(0.0, 0.0, 1.0));
  float tmpvar_23;
  tmpvar_23 = abs(tmpvar_22);
  if ((1e-06 < tmpvar_23)) {
    tmpvar_21 = (dot ((tmpvar_20 - tmpvar_18), tmpvar_19) / tmpvar_22);
  };
  vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xy = tmpvar_12;
  tmpvar_24.z = (-10000.0 + tmpvar_21);
  vec4 tmpvar_25;
  tmpvar_25 = ((transform_inv_m_3 * tmpvar_24) * tmpvar_11.w);
  vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 1.0);
  tmpvar_26.xy = (aClipOrigins.xy + mix (aClipDeviceArea.xy, aClipDeviceArea.zw, aPosition));
  gl_Position = (uTransform * tmpvar_26);
  vec4 tmpvar_27;
  tmpvar_27.xy = aClipLocalPos;
  tmpvar_27.zw = local_rect_p1_1;
  vTransformBounds = tmpvar_27;
  vClipMode.x = aClipMode;
  vLocalPos.zw = tmpvar_25.zw;
  vec2 tmpvar_28;
  tmpvar_28 = (0.5 * (local_rect_p1_1 - aClipLocalPos));
  vLocalPos.xy = (tmpvar_25.xy - ((tmpvar_28 + aClipLocalPos) * tmpvar_25.w));
  v_clip_size = tmpvar_28;
  vec4 tmpvar_29;
  tmpvar_29.x = aClipRadii_BR.x;
  tmpvar_29.y = aClipRadii_TR.x;
  tmpvar_29.z = aClipRadii_BL.x;
  tmpvar_29.w = aClipRadii_TL.x;
  v_clip_radii = tmpvar_29;
}

