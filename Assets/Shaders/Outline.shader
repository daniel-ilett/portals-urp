Shader "Portals/Outline"
{
    Properties
    {
		_OutlineColour("Outline Colour", Color) = (1, 1, 1, 1)
		_MaskID("Mask ID", Int) = 1
    }
    SubShader
    {
        Tags 
		{ 
			"RenderType" = "Opaque" 
			"Queue" = "Geometry+2"
			"RenderPipeline" = "UniversalPipeline"
		}

		HLSLINCLUDE
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
		ENDHLSL
        
		Stencil
		{
			Ref 0
			Comp equal
		}

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

			uniform float4 _OutlineColour;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return _OutlineColour;
            }
            ENDHLSL
        }
    }
}
