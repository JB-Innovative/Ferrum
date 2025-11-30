#version 150
// cs_border_segment
// features: []

uniform mat4 uTransform;
in vec2 aPosition;
flat out vec4 vColor00;
flat out vec4 vColor01;
flat out vec4 vColor10;
flat out vec4 vColor11;
flat out vec4 vColorLine;
flat out vec2 vSegmentClipMode;
flat out vec4 vStyleEdgeAxis;
flat out vec4 vClipCenter_Sign;
flat out vec4 vClipRadii;
flat out vec4 vEdgeReference;
flat out vec4 vPartialWidths;
flat out vec4 vClipParams1;
flat out vec4 vClipParams2;
out vec2 vPos;
in vec2 aTaskOrigin;
in vec4 aRect;
in vec4 aColor0;
in vec4 aColor1;
in int aFlags;
in vec2 aWidths;
in vec2 aRadii;
in vec4 aClipParams1;
in vec4 aClipParams2;
void main ()
{
  vec2 edge_reference_1;
  ivec2 edge_axis_2;
  vec2 clip_sign_3;
  int tmpvar_4;
  tmpvar_4 = (aFlags & 255);
  int tmpvar_5;
  tmpvar_5 = ((aFlags >> 8) & 255);
  int tmpvar_6;
  tmpvar_6 = ((aFlags >> 16) & 255);
  int tmpvar_7;
  tmpvar_7 = ((aFlags >> 24) & 15);
  vec2 tmpvar_8;
  tmpvar_8 = (aRect.zw - aRect.xy);
  vec2 p_9;
  bool tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  tmpvar_10 = (0 == tmpvar_4);
  if (tmpvar_10) {
    p_9 = vec2(0.0, 0.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (1 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(1.0, 0.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (2 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(1.0, 1.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = (tmpvar_10 || (3 == tmpvar_4));
  tmpvar_10 = (tmpvar_10 && !(tmpvar_11));
  if (tmpvar_10) {
    p_9 = vec2(0.0, 1.0);
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = !(tmpvar_11);
  if (tmpvar_10) {
    p_9 = vec2(0.0, 0.0);
    tmpvar_11 = bool(1);
  };
  vec2 tmpvar_12;
  tmpvar_12 = (p_9 * tmpvar_8);
  clip_sign_3 = (1.0 - (2.0 * p_9));
  edge_axis_2 = ivec2(0, 0);
  edge_reference_1 = vec2(0.0, 0.0);
  bool tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = bool(0);
  tmpvar_13 = (0 == tmpvar_4);
  if (tmpvar_13) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = tmpvar_12;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (1 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_15;
    tmpvar_15.x = (tmpvar_12.x - aWidths.x);
    tmpvar_15.y = tmpvar_12.y;
    edge_reference_1 = tmpvar_15;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (2 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = (tmpvar_12 - aWidths);
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (3 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_16;
    tmpvar_16.x = tmpvar_12.x;
    tmpvar_16.y = (tmpvar_12.y - aWidths.y);
    edge_reference_1 = tmpvar_16;
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = (tmpvar_13 || (5 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 || (7 == tmpvar_4));
  tmpvar_13 = (tmpvar_13 && !(tmpvar_14));
  if (tmpvar_13) {
    edge_axis_2 = ivec2(1, 1);
    tmpvar_14 = bool(1);
  };
  tmpvar_13 = !(tmpvar_14);
  if (tmpvar_13) {
    tmpvar_14 = bool(1);
  };
  vec2 tmpvar_17;
  tmpvar_17.x = float(tmpvar_4);
  tmpvar_17.y = float(tmpvar_7);
  vSegmentClipMode = tmpvar_17;
  vec4 tmpvar_18;
  tmpvar_18.x = float(tmpvar_5);
  tmpvar_18.y = float(tmpvar_6);
  tmpvar_18.z = float(edge_axis_2.x);
  tmpvar_18.w = float(edge_axis_2.y);
  vStyleEdgeAxis = tmpvar_18;
  vec4 tmpvar_19;
  tmpvar_19.xy = (aWidths / 3.0);
  tmpvar_19.zw = (aWidths / 2.0);
  vPartialWidths = tmpvar_19;
  vPos = (tmpvar_8 * aPosition);
  vec4 tmpvar_20;
  vec4 tmpvar_21;
  bool tmpvar_22;
  tmpvar_22 = (aColor0.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_23;
  bool tmpvar_24;
  tmpvar_24 = bool(0);
  tmpvar_23 = (6 == tmpvar_5);
  if (tmpvar_23) {
    vec4 tmpvar_25;
    if (tmpvar_22) {
      vec4 tmpvar_26;
      tmpvar_26.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_26.w = aColor0.w;
      tmpvar_25 = tmpvar_26;
    } else {
      vec4 tmpvar_27;
      tmpvar_27.xyz = aColor0.xyz;
      tmpvar_27.w = aColor0.w;
      tmpvar_25 = tmpvar_27;
    };
    tmpvar_20 = tmpvar_25;
    vec4 tmpvar_28;
    if (tmpvar_22) {
      vec4 tmpvar_29;
      tmpvar_29.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_29.w = aColor0.w;
      tmpvar_28 = tmpvar_29;
    } else {
      vec4 tmpvar_30;
      tmpvar_30.xyz = (aColor0.xyz * 0.6666667);
      tmpvar_30.w = aColor0.w;
      tmpvar_28 = tmpvar_30;
    };
    tmpvar_21 = tmpvar_28;
    tmpvar_24 = bool(1);
  };
  tmpvar_23 = (tmpvar_23 || (7 == tmpvar_5));
  tmpvar_23 = (tmpvar_23 && !(tmpvar_24));
  if (tmpvar_23) {
    vec4 tmpvar_31;
    if (tmpvar_22) {
      vec4 tmpvar_32;
      tmpvar_32.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_32.w = aColor0.w;
      tmpvar_31 = tmpvar_32;
    } else {
      vec4 tmpvar_33;
      tmpvar_33.xyz = (aColor0.xyz * 0.6666667);
      tmpvar_33.w = aColor0.w;
      tmpvar_31 = tmpvar_33;
    };
    tmpvar_20 = tmpvar_31;
    vec4 tmpvar_34;
    if (tmpvar_22) {
      vec4 tmpvar_35;
      tmpvar_35.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_35.w = aColor0.w;
      tmpvar_34 = tmpvar_35;
    } else {
      vec4 tmpvar_36;
      tmpvar_36.xyz = aColor0.xyz;
      tmpvar_36.w = aColor0.w;
      tmpvar_34 = tmpvar_36;
    };
    tmpvar_21 = tmpvar_34;
    tmpvar_24 = bool(1);
  };
  tmpvar_23 = !(tmpvar_24);
  if (tmpvar_23) {
    tmpvar_20 = aColor0;
    tmpvar_21 = aColor0;
    tmpvar_24 = bool(1);
  };
  vColor00 = tmpvar_20;
  vColor01 = tmpvar_21;
  vec4 tmpvar_37;
  vec4 tmpvar_38;
  bool tmpvar_39;
  tmpvar_39 = (aColor1.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_40;
  bool tmpvar_41;
  tmpvar_41 = bool(0);
  tmpvar_40 = (6 == tmpvar_6);
  if (tmpvar_40) {
    vec4 tmpvar_42;
    if (tmpvar_39) {
      vec4 tmpvar_43;
      tmpvar_43.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_43.w = aColor1.w;
      tmpvar_42 = tmpvar_43;
    } else {
      vec4 tmpvar_44;
      tmpvar_44.xyz = aColor1.xyz;
      tmpvar_44.w = aColor1.w;
      tmpvar_42 = tmpvar_44;
    };
    tmpvar_37 = tmpvar_42;
    vec4 tmpvar_45;
    if (tmpvar_39) {
      vec4 tmpvar_46;
      tmpvar_46.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_46.w = aColor1.w;
      tmpvar_45 = tmpvar_46;
    } else {
      vec4 tmpvar_47;
      tmpvar_47.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_47.w = aColor1.w;
      tmpvar_45 = tmpvar_47;
    };
    tmpvar_38 = tmpvar_45;
    tmpvar_41 = bool(1);
  };
  tmpvar_40 = (tmpvar_40 || (7 == tmpvar_6));
  tmpvar_40 = (tmpvar_40 && !(tmpvar_41));
  if (tmpvar_40) {
    vec4 tmpvar_48;
    if (tmpvar_39) {
      vec4 tmpvar_49;
      tmpvar_49.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_49.w = aColor1.w;
      tmpvar_48 = tmpvar_49;
    } else {
      vec4 tmpvar_50;
      tmpvar_50.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_50.w = aColor1.w;
      tmpvar_48 = tmpvar_50;
    };
    tmpvar_37 = tmpvar_48;
    vec4 tmpvar_51;
    if (tmpvar_39) {
      vec4 tmpvar_52;
      tmpvar_52.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_52.w = aColor1.w;
      tmpvar_51 = tmpvar_52;
    } else {
      vec4 tmpvar_53;
      tmpvar_53.xyz = aColor1.xyz;
      tmpvar_53.w = aColor1.w;
      tmpvar_51 = tmpvar_53;
    };
    tmpvar_38 = tmpvar_51;
    tmpvar_41 = bool(1);
  };
  tmpvar_40 = !(tmpvar_41);
  if (tmpvar_40) {
    tmpvar_37 = aColor1;
    tmpvar_38 = aColor1;
    tmpvar_41 = bool(1);
  };
  vColor10 = tmpvar_37;
  vColor11 = tmpvar_38;
  vec4 tmpvar_54;
  tmpvar_54.xy = (tmpvar_12 + (clip_sign_3 * aRadii));
  tmpvar_54.zw = clip_sign_3;
  vClipCenter_Sign = tmpvar_54;
  vec4 tmpvar_55;
  tmpvar_55.xy = aRadii;
  tmpvar_55.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_55;
  vec4 tmpvar_56;
  tmpvar_56.xy = tmpvar_12;
  tmpvar_56.z = (aWidths.y * -(clip_sign_3.y));
  tmpvar_56.w = (aWidths.x * clip_sign_3.x);
  vColorLine = tmpvar_56;
  vec4 tmpvar_57;
  tmpvar_57.xy = edge_reference_1;
  tmpvar_57.zw = (edge_reference_1 + aWidths);
  vEdgeReference = tmpvar_57;
  vClipParams1 = aClipParams1;
  vClipParams2 = aClipParams2;
  if ((tmpvar_7 == 3)) {
    float radius_58;
    radius_58 = aClipParams1.z;
    if ((0.5 < aClipParams1.z)) {
      radius_58 = (aClipParams1.z + 2.0);
    };
    vPos = (aClipParams1.xy + (radius_58 * (
      (2.0 * aPosition)
     - 1.0)));
    vPos = min (max (vPos, vec2(0.0, 0.0)), tmpvar_8);
  } else {
    if ((tmpvar_7 == 1)) {
      vec2 tmpvar_59;
      tmpvar_59 = ((aClipParams1.xy + aClipParams2.xy) * 0.5);
      vec2 tmpvar_60;
      tmpvar_60 = (aClipParams1.xy - aClipParams2.xy);
      vec2 tmpvar_61;
      tmpvar_61 = (vec2(max (sqrt(
        dot (tmpvar_60, tmpvar_60)
      ), max (aWidths.x, aWidths.y))) + 2.0);
      vPos = min (max (vPos, (tmpvar_59 - tmpvar_61)), (tmpvar_59 + tmpvar_61));
    };
  };
  vec4 tmpvar_62;
  tmpvar_62.zw = vec2(0.0, 1.0);
  tmpvar_62.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_62);
}

