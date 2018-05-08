Shader "Holistic/Cutoff" {
    Properties {
      _RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
    }
    SubShader {
    Tags {"Queue"="Transparent" "RenderType"="Transparent" }

      Pass{
      	ZWrite On
      	ColorMask 0
      }

      CGPROGRAM
      #pragma surface surf Lambert alpha:fade
      struct Input {
          float3 viewDir;
          float3 worldPos;
      };

      float4 _RimColor;
      float _RimPower;

      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
          if (frac(IN.worldPos.y*10 * 0.5) > 0.4){
          	o.Emission =  float3(0,1,0)*rim;
          	o.Alpha = 1;
          	}
          else
          	o.Alpha =0;// = float4(0,0,0,0);
                          
      }

     
      ENDCG
    } 
    Fallback "Diffuse"
  }