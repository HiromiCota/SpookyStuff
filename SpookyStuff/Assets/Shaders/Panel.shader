Shader "Custom/Panel" {
	Properties {
		
		_MainTex ("Texture", 2D) = "white" {}
		}

		SubShader {
			Tags {"Queue" = "Transparent"}

			Blend One One
			Pass {
				SetTexture [_MainTex] {combine texture}
		}
	}
}


