Shader "Holistic/PropChallenge1" 
{
    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
         _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
         _Threshold ("Threshold", Range(0.0,1.0)) = 0.0
        _myTex ("Example Texture", 2D) = "white" {}
        _myCube ("Example Cube", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;
        float _RimPower;
        float _Threshold;


        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
        half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
        float4 temp;
        temp.rgb = pow (rim, _RimPower);
        if (((temp.r + temp.g + temp.b) / 3.0) > _Threshold){
        	//o.Emission = texCUBE (_myCube, IN.worldRefl).rgb;
        	o.Emission = (1,1,1,1);
        }
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColor).rgb;


        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
