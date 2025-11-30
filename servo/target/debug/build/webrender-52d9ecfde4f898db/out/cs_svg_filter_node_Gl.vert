#version 150
// cs_svg_filter_node
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
flat out ivec2 vFilterInputCountFilterKindVec;
flat out vec2 vFloat0;
flat out mat4 vColorMat;
in vec4 aFilterTargetRect;
in vec4 aFilterInput1ContentScaleAndOffset;
in vec4 aFilterInput2ContentScaleAndOffset;
in int aFilterInput1TaskAddress;
in int aFilterInput2TaskAddress;
in int aFilterKind;
in int aFilterInputCount;
in ivec2 aFilterExtraDataAddress;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = mix (aFilterTargetRect.xy, aFilterTargetRect.zw, aPosition);
  if ((0 < aFilterInputCount)) {
    vec2 tmpvar_2;
    tmpvar_2 = vec2(textureSize (sColor0, 0));
    ivec2 tmpvar_3;
    tmpvar_3.x = int((2u * (
      uint(aFilterInput1TaskAddress)
     % 512u)));
    tmpvar_3.y = int((uint(aFilterInput1TaskAddress) / 512u));
    vec4 tmpvar_4;
    tmpvar_4 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(0, 0));
    vec4 tmpvar_5;
    tmpvar_5.xy = (tmpvar_4.xy + vec2(0.5, 0.5));
    tmpvar_5.zw = (tmpvar_4.zw - vec2(0.5, 0.5));
    vInput1UvRect = (tmpvar_5 / tmpvar_2.xyxy);
    vInput1Uv = (((tmpvar_4.xy + aFilterInput1ContentScaleAndOffset.zw) + (aFilterInput1ContentScaleAndOffset.xy * aPosition)) / tmpvar_2);
  };
  if ((1 < aFilterInputCount)) {
    vec2 tmpvar_6;
    tmpvar_6 = vec2(textureSize (sColor1, 0));
    ivec2 tmpvar_7;
    tmpvar_7.x = int((2u * (
      uint(aFilterInput2TaskAddress)
     % 512u)));
    tmpvar_7.y = int((uint(aFilterInput2TaskAddress) / 512u));
    vec4 tmpvar_8;
    tmpvar_8 = texelFetchOffset (sRenderTasks, tmpvar_7, 0, ivec2(0, 0));
    vec4 tmpvar_9;
    tmpvar_9.xy = (tmpvar_8.xy + vec2(0.5, 0.5));
    tmpvar_9.zw = (tmpvar_8.zw - vec2(0.5, 0.5));
    vInput2UvRect = (tmpvar_9 / tmpvar_6.xyxy);
    vInput2Uv = (((tmpvar_8.xy + aFilterInput2ContentScaleAndOffset.zw) + (aFilterInput2ContentScaleAndOffset.xy * aPosition)) / tmpvar_6);
  };
  vFilterInputCountFilterKindVec.x = aFilterInputCount;
  vFilterInputCountFilterKindVec.y = aFilterKind;
  bool tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  tmpvar_10 = (0 == aFilterKind);
  tmpvar_10 = (tmpvar_10 || (1 == aFilterKind));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (2 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (3 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vFloat0.x = aFilterInput2ContentScaleAndOffset.x;
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (4 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (5 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (6 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (7 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (8 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (9 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (10 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (11 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (12 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (13 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (14 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (15 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (16 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (17 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (18 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (19 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (20 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (21 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (22 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (23 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (24 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (25 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (26 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (27 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (28 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (29 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (30 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (31 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (32 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (33 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (34 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (35 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (36 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (37 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (38 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (39 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    mat4 tmpvar_12;
    tmpvar_12[uint(0)] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(0, 0));
    tmpvar_12[1u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(1, 0));
    tmpvar_12[2u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(2, 0));
    tmpvar_12[3u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(3, 0));
    vColorMat = tmpvar_12;
    vFilterData0 = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(4, 0)), 0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (40 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (41 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    ivec4 tmpvar_13;
    tmpvar_13.zw = ivec2(0, 0);
    tmpvar_13.xy = aFilterExtraDataAddress;
    vData = tmpvar_13;
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (42 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (43 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (44 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (45 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (46 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (47 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (48 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (49 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (50 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (51 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (52 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (53 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (54 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (55 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (56 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (57 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (58 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (59 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (60 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (61 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (62 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (63 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (64 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (65 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (66 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (67 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (68 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (69 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (70 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vec4 tmpvar_14;
    tmpvar_14 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    vFilterData0.w = tmpvar_14.w;
    vFilterData0.xyz = (tmpvar_14.xyz * tmpvar_14.w);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (71 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vec4 tmpvar_15;
    tmpvar_15 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    vFilterData0.w = tmpvar_15.w;
    vFilterData0.xyz = mix ((tmpvar_15.xyz * vec3(0.07739938, 0.07739938, 0.07739938)), pow ((
      (tmpvar_15.xyz * vec3(0.9478673, 0.9478673, 0.9478673))
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (tmpvar_15.xyz, vec3(0.04045, 0.04045, 0.04045))));
    vFilterData0.xyz = (vFilterData0.xyz * tmpvar_15.w);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (72 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vFilterData0.w = aFilterInput2ContentScaleAndOffset.w;
    vFilterData0.xyz = (aFilterInput2ContentScaleAndOffset.xyz * aFilterInput2ContentScaleAndOffset.w);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (73 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vFilterData0.w = aFilterInput2ContentScaleAndOffset.w;
    vFilterData0.xyz = mix ((aFilterInput2ContentScaleAndOffset.xyz * vec3(0.07739938, 0.07739938, 0.07739938)), pow ((
      (aFilterInput2ContentScaleAndOffset.xyz * vec3(0.9478673, 0.9478673, 0.9478673))
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (aFilterInput2ContentScaleAndOffset.xyz, vec3(0.04045, 0.04045, 0.04045))));
    vFilterData0.xyz = (vFilterData0.xyz * aFilterInput2ContentScaleAndOffset.w);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (74 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (75 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (76 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (77 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (80 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (81 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (82 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (83 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    vFilterData0 = aFilterInput2ContentScaleAndOffset;
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (86 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (87 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (88 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (89 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (90 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (91 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (92 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (93 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (94 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (95 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (96 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (97 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (98 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (99 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (100 == aFilterKind));
  tmpvar_10 = (tmpvar_10 || (101 == aFilterKind));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = !(tmpvar_11);
  if (tmpvar_10) {
    tmpvar_11 = bool(1);
  };
  vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 1.0);
  tmpvar_16.xy = tmpvar_1;
  gl_Position = (uTransform * tmpvar_16);
}

