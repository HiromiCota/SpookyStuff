Shader "Custom/Hologram" {
	Properties {
		_RimColor ("Main Color", Color) = (1,1,1,1)
		_RimPower ("Rim Power", Range(0.0,10.0)) = 3.0

	}
	SubShader {
      Tags{"Queue" = "Transparent"}

      Pass{
      	ZWrite On
      	ColorMask 0
      }

      CGPROGRAM

      #pragma surface surf Lambert alpha:fade
      struct Input {
          float3 viewDir;
      };

      float4 _RimColor;
      float _RimPower;

      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
          half power = pow (rim, _RimPower);
          o.Emission = _RimColor.rgb * power * 10;
          o.Alpha = power;
        }
      ENDCG
	} 
	FallBack "Diffuse"
}

