Shader "Unlit/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Color ("Main Color", Color) = (0,0,0,1)
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_OutlineWidth("Outline Width", Range(1.0,5.0)) = 1.0
    }

	CGINCLUDE
	#include "UnityCG.cginc"

	struct appdata
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f 
	{
		float4 pos: POSITION;
		float3 normal: NORMAL;
	};

	float4 _OutlineColor;
	float _OutlineWidth;

	v2f vert(appdata v)
	{
		v.vertex.xyz *= _OutlineWidth;

		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		return o;
	}

	ENDCG

    SubShader
    {
		Tags{"Queue" = "Transparent"}

       Pass // Render the Outline
	   {
			ZWrite Off
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			half4 frag(v2f i) : COLOR 
			{
				return _OutlineColor;
			}

			ENDCG
	   }

	   Pass // Normal Render
	   {
			ZWrite On

			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
			}

			Lighting On

			SetTexture[_MainTex]
			{
				ConstantColor[_Color]
			}

			SetTexture[_MainTex]
			{
				Combine previous * primary DOUBLE
			}
	   }
    }
}
