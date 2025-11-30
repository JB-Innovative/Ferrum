#version 150
// ps_split_composite
// features: []

struct RectWithEndpoint {
  vec2 p0;
  vec2 p1;
};
struct RenderTaskData {
  RectWithEndpoint task_rect;
  vec4 user_data;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec2 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 vUv;
flat out vec2 vPerspective;
flat out vec4 vUvSampleBounds;
void main ()
{
  float ci_z_1;
  ci_z_1 = float(aData.z);
  ivec2 tmpvar_2;
  tmpvar_2.x = int((uint(aData.y) % 1024u));
  tmpvar_2.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_3;
  tmpvar_3 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(0, 0));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(1, 0));
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(0, 0));
  ivec2 tmpvar_7;
  tmpvar_7.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_7.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_7, 0, ivec2(1, 0));
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_9.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(0, 0));
  vec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(1, 0));
  mat4 transform_m_12;
  int tmpvar_13;
  tmpvar_13 = (texelFetchOffset (sPrimitiveHeadersI, tmpvar_7, 0, ivec2(0, 0)).z & 8388607);
  ivec2 tmpvar_14;
  tmpvar_14.x = int((8u * (
    uint(tmpvar_13)
   % 128u)));
  tmpvar_14.y = int((uint(tmpvar_13) / 128u));
  transform_m_12[0] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(0, 0));
  transform_m_12[1] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(1, 0));
  transform_m_12[2] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(2, 0));
  transform_m_12[3] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(3, 0));
  ivec2 tmpvar_15;
  tmpvar_15.x = int((uint(tmpvar_8.x) % 1024u));
  tmpvar_15.y = int((uint(tmpvar_8.x) / 1024u));
  vec4 tmpvar_16;
  tmpvar_16 = texelFetchOffset (sGpuCache, tmpvar_15, 0, ivec2(0, 0));
  RenderTaskData task_data_17;
  if ((tmpvar_8.w >= 2147483647)) {
    task_data_17 = RenderTaskData(RectWithEndpoint(vec2(0.0, 0.0), vec2(0.0, 0.0)), vec4(0.0, 0.0, 0.0, 0.0));
  } else {
    RectWithEndpoint task_rect_18;
    ivec2 tmpvar_19;
    tmpvar_19.x = int((2u * (
      uint(tmpvar_8.w)
     % 512u)));
    tmpvar_19.y = int((uint(tmpvar_8.w) / 512u));
    vec4 tmpvar_20;
    tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(0, 0));
    task_rect_18.p0 = tmpvar_20.xy;
    task_rect_18.p1 = tmpvar_20.zw;
    task_data_17.task_rect = task_rect_18;
    task_data_17.user_data = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(1, 0));
  };
  RectWithEndpoint tmpvar_21;
  tmpvar_21 = task_data_17.task_rect;
  vec2 tmpvar_22;
  tmpvar_22 = mix (mix (tmpvar_3.xy, tmpvar_3.zw, aPosition.x), mix (tmpvar_4.zw, tmpvar_4.xy, aPosition.x), aPosition.y);
  vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 1.0);
  tmpvar_23.xy = tmpvar_22;
  vec4 tmpvar_24;
  tmpvar_24 = (transform_m_12 * tmpvar_23);
  vec4 tmpvar_25;
  tmpvar_25.xy = (((tmpvar_10.xy - tmpvar_11.yz) * tmpvar_24.w) + (tmpvar_24.xy * tmpvar_11.x));
  tmpvar_25.z = (tmpvar_24.w * ci_z_1);
  tmpvar_25.w = tmpvar_24.w;
  vec4 tmpvar_26;
  tmpvar_26.xy = tmpvar_21.p0;
  tmpvar_26.zw = tmpvar_21.p1;
  vClipMaskUvBounds = tmpvar_26;
  vClipMaskUv = ((tmpvar_24.xy * task_data_17.user_data.x) + (tmpvar_24.w * (tmpvar_21.p0 - task_data_17.user_data.yz)));
  gl_Position = (uTransform * tmpvar_25);
  vec2 tmpvar_27;
  tmpvar_27 = vec2(textureSize (sColor0, 0));
  vec4 tmpvar_28;
  tmpvar_28.xy = (min (tmpvar_16.xy, tmpvar_16.zw) + vec2(0.5, 0.5));
  tmpvar_28.zw = (max (tmpvar_16.xy, tmpvar_16.zw) - vec2(0.5, 0.5));
  vUvSampleBounds = (tmpvar_28 / tmpvar_27.xyxy);
  vec2 tmpvar_29;
  tmpvar_29 = ((tmpvar_22 - tmpvar_6.xy) / (tmpvar_6.zw - tmpvar_6.xy));
  int tmpvar_30;
  tmpvar_30 = (tmpvar_8.x + 2);
  ivec2 tmpvar_31;
  tmpvar_31.x = int((uint(tmpvar_30) % 1024u));
  tmpvar_31.y = int((uint(tmpvar_30) / 1024u));
  vec4 tmpvar_32;
  tmpvar_32 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(1, 0)), tmpvar_29.x), mix (texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(3, 0)), tmpvar_29.x), tmpvar_29.y);
  float tmpvar_33;
  tmpvar_33 = float(tmpvar_8.y);
  vUv = ((mix (tmpvar_16.xy, tmpvar_16.zw, 
    (tmpvar_32.xy / tmpvar_32.w)
  ) / tmpvar_27) * mix (gl_Position.w, 1.0, tmpvar_33));
  vPerspective.x = tmpvar_33;
}

