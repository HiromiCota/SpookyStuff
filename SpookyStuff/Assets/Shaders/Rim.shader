Shader "Holistic/Rim" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
      _BaseColor ("Color", Color) = ( 1,1,1,1)
      _Threshold ("Threshold", Range(0.0,3.0)) = 0.0
    }
    SubShader {
      Tags{"Queue" = "Transparent"}
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float3 viewDir;
      };

      float4 _RimColor;
      float4 _BaseColor;
      float _RimPower;
      float _Threshold;
      float4 temp;
      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
          //o.Albedo = _BaseColor.rgb;
          temp.rgb = _RimColor.rgb * pow (rim, _RimPower);
          if ((temp.r + temp.g + temp.b) < _Threshold)
          	temp = (0,0,0,0);
          else
          	temp = _RimColor;
          o.Emission = temp.rgb;
          o.Specular = 1;
          o.Alpha = 1;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }