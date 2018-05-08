Shader "Custom/Cel" {
    Properties {
      _RimThickness ("Rim Thickness", Range(0.0,200.0)) = 0.1
      _RimThreshold ("Threshold", Range(0.0,0.001)) = 0.001
      _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
      _BaseColor ("Color", Color) = ( 1,1,1,1)
    }
    SubShader {
    Tags {"Queue"="Transparent" "RenderType"="Transparent" }

      Pass{
      	ZWrite On
      	ColorMask RGB
      }


      CGPROGRAM
      #pragma surface surf Lambert alpha:fade
      struct Input {
          float3 viewDir;
      };

      float _RimThickness;
      float _RimThreshold;
      float4 _BaseColor;
      float _RimPower;

      void surf (Input IN, inout SurfaceOutput o) {
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
		  	
          float4 temp;
          temp.rgb = _BaseColor.rgb * pow (rim, _RimPower);
		  if ((temp.r + temp.g + temp.b) < _RimThreshold) {
			  o.Albedo = (1, 1, 1);
			  o.Alpha = 0;
			  }
          else if ((temp.r + temp.g + temp.b) < (_RimThreshold * (1 + _RimThickness)))
		  {
			  o.Emission = _BaseColor.rgb * _BaseColor.a;
			  o.Albedo = _BaseColor.rgb *(1 - _BaseColor.a);
			  o.Alpha = _BaseColor.a;
		  }else{          	
			  o.Albedo = (0, 0, 0); 
			  o.Alpha = _BaseColor.a;
          	}
          	
          //o.Emission = temp.rgb;
          //o.Specular = 1;
          //o.Gloss = 1;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }