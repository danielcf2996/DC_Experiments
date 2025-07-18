Shader "Custom/PostProcess/InvertColors"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue" = "Overlay" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct vertexInput
            {
                float4 position : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct fragmentInput
            {
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            vertexInput vert (vertexInput v)
            {
                vertexInput o;
                o.position = UnityObjectToClipPos(v.position);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (fragmentInput i) : SV_Target
            {
                half4 color = tex2D(_MainTex, i.uv);
                return half4(1.0 - color.rgb, color.a); // Invert colors
            }
            ENDCG
        }
    }
}
