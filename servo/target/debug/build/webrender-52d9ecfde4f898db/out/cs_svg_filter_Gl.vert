#version 150
// cs_svg_filter
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
out vec2 vInput1Uv;
out vec2 vInput2Uv;
flat out vec4 vInput1UvRect;
flat out vec4 vInput2UvRect;
flat out ivec4 vData;
flat out vec4 vFilterData0;
flat out vec4 vFilterData1;
flat out ivec2 vFilterInputCountFilterKindVec;
flat out vec2 vFloat0;
flat out mat4 vColorMat;
flat out ivec4 vFuncs;
in int aFilterRenderTaskAddress;
in int aFilterInput1TaskAddress;
in int aFilterInput2TaskAddress;
in int aFilterKind;
in int aFilterInputCount;
in int aFilterGenericInt;
in ivec2 aFilterExtraDataAddress;
void main ()
{
  vec2 input_1_task_p0_1;
  vec2 input_1_task_p1_2;
  ivec2 tmpvar_3;
  tmpvar_3.x = int((2u * (
    uint(aFilterRenderTaskAddress)
   % 512u)));
  tmpvar_3.y = int((uint(aFilterRenderTaskAddress) / 512u));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(0, 0));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(1, 0));
  vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  vec2 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4.xy, tmpvar_4.zw, aPosition);
  if ((0 < aFilterInputCount)) {
    vec2 tmpvar_8;
    tmpvar_8 = vec2(textureSize (sColor0, 0));
    ivec2 tmpvar_9;
    tmpvar_9.x = int((2u * (
      uint(aFilterInput1TaskAddress)
     % 512u)));
    tmpvar_9.y = int((uint(aFilterInput1TaskAddress) / 512u));
    vec4 tmpvar_10;
    tmpvar_10 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(0, 0));
    input_1_task_p0_1 = tmpvar_10.xy;
    input_1_task_p1_2 = tmpvar_10.zw;
    vec4 tmpvar_11;
    tmpvar_11.xy = (tmpvar_10.xy + vec2(0.5, 0.5));
    tmpvar_11.zw = (tmpvar_10.zw - vec2(0.5, 0.5));
    vInput1UvRect = (tmpvar_11 / tmpvar_8.xyxy);
    vInput1Uv = mix ((tmpvar_10.xy / tmpvar_8), (floor(tmpvar_10.zw) / tmpvar_8), aPosition);
  };
  if ((1 < aFilterInputCount)) {
    vec2 tmpvar_12;
    tmpvar_12 = vec2(textureSize (sColor1, 0));
    ivec2 tmpvar_13;
    tmpvar_13.x = int((2u * (
      uint(aFilterInput2TaskAddress)
     % 512u)));
    tmpvar_13.y = int((uint(aFilterInput2TaskAddress) / 512u));
    vec4 tmpvar_14;
    tmpvar_14 = texelFetchOffset (sRenderTasks, tmpvar_13, 0, ivec2(0, 0));
    vec4 tmpvar_15;
    tmpvar_15.xy = (tmpvar_14.xy + vec2(0.5, 0.5));
    tmpvar_15.zw = (tmpvar_14.zw - vec2(0.5, 0.5));
    vInput2UvRect = (tmpvar_15 / tmpvar_12.xyxy);
    vInput2Uv = mix ((tmpvar_14.xy / tmpvar_12), (floor(tmpvar_14.zw) / tmpvar_12), aPosition);
  };
  vFilterInputCountFilterKindVec.x = aFilterInputCount;
  vFilterInputCountFilterKindVec.y = aFilterKind;
  vFuncs.x = ((aFilterGenericInt >> 12) & 15);
  vFuncs.y = ((aFilterGenericInt >> 8) & 15);
  vFuncs.z = ((aFilterGenericInt >> 4) & 15);
  vFuncs.w = (aFilterGenericInt & 15);
  bool tmpvar_16;
  bool tmpvar_17;
  tmpvar_17 = bool(0);
  tmpvar_16 = (0 == aFilterKind);
  if (tmpvar_16) {
    ivec4 tmpvar_18;
    tmpvar_18.yzw = ivec3(0, 0, 0);
    tmpvar_18.x = aFilterGenericInt;
    vData = tmpvar_18;
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (1 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (4 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    vFloat0.x = tmpvar_6.x;
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (5 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    mat4 tmpvar_19;
    tmpvar_19[uint(0)] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(0, 0));
    tmpvar_19[1u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(1, 0));
    tmpvar_19[2u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(2, 0));
    tmpvar_19[3u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(3, 0));
    vColorMat = tmpvar_19;
    vFilterData0 = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(4, 0)), 0);
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (6 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (7 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    vec2 tmpvar_20;
    tmpvar_20 = vec2(textureSize (sColor0, 0));
    vec4 tmpvar_21;
    tmpvar_21.zw = vec2(0.0, 0.0);
    tmpvar_21.xy = (-(tmpvar_5.xy) / tmpvar_20);
    vFilterData0 = tmpvar_21;
    vec4 tmpvar_22;
    tmpvar_22.xy = input_1_task_p0_1;
    tmpvar_22.zw = input_1_task_p1_2;
    vFilterData1 = (tmpvar_22 / tmpvar_20.xyxy);
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (8 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    ivec4 tmpvar_23;
    tmpvar_23.zw = ivec2(0, 0);
    tmpvar_23.xy = aFilterExtraDataAddress;
    vData = tmpvar_23;
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = (tmpvar_16 || (10 == aFilterKind));
  tmpvar_16 = (tmpvar_16 && !(tmpvar_17));
  if (tmpvar_16) {
    ivec4 tmpvar_24;
    tmpvar_24.yzw = ivec3(0, 0, 0);
    tmpvar_24.x = aFilterGenericInt;
    vData = tmpvar_24;
    if ((aFilterGenericInt == 6)) {
      vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    };
    tmpvar_17 = bool(1);
  };
  tmpvar_16 = !(tmpvar_17);
  if (tmpvar_16) {
    tmpvar_17 = bool(1);
  };
  vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 1.0);
  tmpvar_25.xy = tmpvar_7;
  gl_Position = (uTransform * tmpvar_25);
}

