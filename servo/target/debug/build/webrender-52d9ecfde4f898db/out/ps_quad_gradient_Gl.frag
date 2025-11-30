#version 150
// ps_quad_gradient
// features: []

precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
uniform sampler2D sGpuBufferF;
flat in vec4 v_color;
flat in ivec4 v_flags;
in vec2 vLocalPos;
flat in ivec4 v_gradient_header;
in vec4 v_interpolated_data;
flat in vec4 v_flat_data;
flat in vec4 v_stop_offsets;
flat in vec4 v_color0;
flat in vec4 v_color1;
void main ()
{
  vec4 output_color_1;
  vec4 base_color_2;
  base_color_2 = v_color;
  float alpha_3;
  alpha_3 = 1.0;
  if ((v_flags.w != 0)) {
    vec2 tmpvar_4;
    tmpvar_4 = (max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw)) / (abs(
      dFdx(vLocalPos)
    ) + abs(
      dFdy(vLocalPos)
    )));
    alpha_3 = min (max ((0.5 - 
      max (tmpvar_4.x, tmpvar_4.y)
    ), 0.0), 1.0);
  };
  base_color_2 = (v_color * alpha_3);
  vec4 tmpvar_5;
  tmpvar_5 = base_color_2;
  float offset_6;
  offset_6 = 0.0;
  bool tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  tmpvar_7 = (0 == v_gradient_header.x);
  if (tmpvar_7) {
    offset_6 = (dot (v_interpolated_data.xy, v_flat_data.xy) - v_flat_data.z);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (1 == v_gradient_header.x));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    offset_6 = (sqrt(dot (v_interpolated_data.xy, v_interpolated_data.xy)) - v_flat_data.x);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = (tmpvar_7 || (2 == v_gradient_header.x));
  tmpvar_7 = (tmpvar_7 && !(tmpvar_8));
  if (tmpvar_7) {
    vec2 tmpvar_9;
    tmpvar_9 = abs(v_interpolated_data.xy);
    float tmpvar_10;
    tmpvar_10 = (min (tmpvar_9.x, tmpvar_9.y) / max (tmpvar_9.x, tmpvar_9.y));
    float tmpvar_11;
    tmpvar_11 = (tmpvar_10 * tmpvar_10);
    float tmpvar_12;
    tmpvar_12 = (((
      ((((-0.04649647 * tmpvar_11) + 0.1593142) * tmpvar_11) - 0.3276228)
     * tmpvar_11) * tmpvar_10) + tmpvar_10);
    float tmpvar_13;
    tmpvar_13 = mix (tmpvar_12, (1.570796 - tmpvar_12), float((tmpvar_9.x < tmpvar_9.y)));
    float tmpvar_14;
    tmpvar_14 = mix (tmpvar_13, (3.141593 - tmpvar_13), float((v_interpolated_data.x < 0.0)));
    float tmpvar_15;
    if ((v_interpolated_data.y < 0.0)) {
      tmpvar_15 = -(tmpvar_14);
    } else {
      tmpvar_15 = tmpvar_14;
    };
    offset_6 = ((fract(
      ((tmpvar_15 + v_flat_data.x) / 6.283185)
    ) * v_interpolated_data.w) - v_interpolated_data.z);
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = !(tmpvar_8);
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  float tmpvar_16;
  tmpvar_16 = (offset_6 - (floor(offset_6) * float(v_gradient_header.z)));
  offset_6 = tmpvar_16;
  if ((2 >= v_gradient_header.y)) {
    float factor_17;
    float tmpvar_18;
    tmpvar_18 = (v_stop_offsets.y - v_stop_offsets.x);
    factor_17 = 0.0;
    if ((tmpvar_16 < v_stop_offsets.x)) {
      factor_17 = 0.0;
    } else {
      if ((v_stop_offsets.y < tmpvar_16)) {
        factor_17 = 1.0;
      } else {
        if ((0.0 < tmpvar_18)) {
          factor_17 = min (max ((
            (tmpvar_16 - v_stop_offsets.x)
           / tmpvar_18), 0.0), 1.0);
        };
      };
    };
    tmpvar_5 = (base_color_2 * mix (v_color0, v_color1, factor_17));
  } else {
    float factor_19;
    vec4 current_stops_20;
    float next_offset_21;
    float prev_offset_22;
    int index_stride_23;
    int index_24;
    int offset_in_level_25;
    int level_stride_26;
    int level_base_addr_27;
    level_base_addr_27 = (v_gradient_header.w + v_gradient_header.y);
    level_stride_26 = 1;
    offset_in_level_25 = 0;
    index_24 = 0;
    index_stride_23 = 1;
    while (true) {
      if ((v_gradient_header.y < (index_stride_23 * 5))) {
        break;
      };
      index_stride_23 = (index_stride_23 * 5);
    };
    prev_offset_22 = 1.0;
    next_offset_21 = 0.0;
    current_stops_20 = v_stop_offsets;
    while (true) {
      int next_partition_28;
      if ((0 >= index_stride_23)) {
        break;
      };
      next_partition_28 = 4;
      if ((tmpvar_16 < current_stops_20.x)) {
        next_partition_28 = 0;
        next_offset_21 = current_stops_20.x;
      } else {
        if ((tmpvar_16 < current_stops_20.y)) {
          next_partition_28 = 1;
          prev_offset_22 = current_stops_20.x;
          next_offset_21 = current_stops_20.y;
        } else {
          if ((tmpvar_16 < current_stops_20.z)) {
            next_partition_28 = 2;
            prev_offset_22 = current_stops_20.y;
            next_offset_21 = current_stops_20.z;
          } else {
            if ((tmpvar_16 < current_stops_20.w)) {
              next_partition_28 = 3;
              prev_offset_22 = current_stops_20.z;
              next_offset_21 = current_stops_20.w;
            } else {
              prev_offset_22 = current_stops_20.w;
            };
          };
        };
      };
      index_24 = (index_24 + (next_partition_28 * index_stride_23));
      if ((index_stride_23 == 1)) {
        break;
      };
      index_stride_23 = (index_stride_23 / 5);
      level_base_addr_27 = (level_base_addr_27 + level_stride_26);
      level_stride_26 = (level_stride_26 * 5);
      offset_in_level_25 = ((offset_in_level_25 * 5) + next_partition_28);
      int tmpvar_29;
      tmpvar_29 = (level_base_addr_27 + offset_in_level_25);
      ivec2 tmpvar_30;
      tmpvar_30.x = int((uint(tmpvar_29) % 1024u));
      tmpvar_30.y = int((uint(tmpvar_29) / 1024u));
      current_stops_20 = texelFetch (sGpuBufferF, tmpvar_30, 0);
    };
    float tmpvar_31;
    tmpvar_31 = (next_offset_21 - prev_offset_22);
    factor_19 = 0.0;
    if ((index_24 >= v_gradient_header.y)) {
      factor_19 = 1.0;
    } else {
      if ((0.0 < tmpvar_31)) {
        factor_19 = min (max ((
          (tmpvar_16 - prev_offset_22)
         / tmpvar_31), 0.0), 1.0);
      };
    };
    if ((index_24 < 1)) {
      index_24 = 1;
    } else {
      if (((v_gradient_header.y - 1) < index_24)) {
        index_24 = (v_gradient_header.y - 1);
      };
    };
    int tmpvar_32;
    tmpvar_32 = ((v_gradient_header.w + index_24) - 1);
    ivec2 tmpvar_33;
    tmpvar_33.x = int((uint(tmpvar_32) % 1024u));
    tmpvar_33.y = int((uint(tmpvar_32) / 1024u));
    tmpvar_5 = (base_color_2 * mix (texelFetchOffset (sGpuBufferF, tmpvar_33, 0, ivec2(0, 0)), texelFetchOffset (sGpuBufferF, tmpvar_33, 0, ivec2(1, 0)), factor_19));
  };
  output_color_1 = tmpvar_5;
  if ((v_flags.z != 0)) {
    output_color_1 = tmpvar_5.xxxx;
  };
  oFragColor = output_color_1;
}

