Shader "Custom/StencilReceiver" {
	Properties {

		_Color("Main Color", Color) = (1,1,1,1)
		_Texture("Texture", 2D) = "white" {}
		_Bump("Bump Texture", 2D) = "bump" {}
		_BumpMod("Bump Modifier", Range(0,10)) = 1


		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("If Z buffer", Float) = 4 //Equals
		_SRef("This Number", Float) = 1
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Then ", Float) = 4 //Keep

	}
	SubShader {
		
		Stencil{
			Ref [_SRef]
			Comp [_SComp]
			Pass [_SOp]

		}

		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _Texture;
			sampler2D _Bump;
			half _BumpMod;
			float4 _Color;

			struct Input {
				float2 uv_Texture;
				float2 uv_Bump;
			};

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb * _Color.rgb;
				o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
				o.Normal *= float3(_BumpMod, _BumpMod, 1);
			}
		ENDCG
	}
	FallBack "Diffuse"
}
