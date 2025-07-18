Shader "Hidden/URP/OutlinePostProcess"
{
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            // Declare the required textures and variables
            TEXTURE2D(_CameraDepthTexture);
            SAMPLER(sampler_CameraDepthTexture);

            TEXTURE2D(_CameraNormalsTexture);
            SAMPLER(sampler_CameraNormalsTexture);

            float4 _MainTex_TexelSize;
            float _Scale;
            float4 _Color;
            float _DepthThreshold;
            float _DepthNormalThreshold;
            float _DepthNormalThresholdScale;
            float _NormalThreshold;
            float4x4 _ClipToView;

            // Vertex input structure
            struct Varyings
            {
                float4 vertex : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };

            // Vertex shader
            Varyings vert(float4 pos : POSITION)
            {
                Varyings o;
                o.vertex = TransformObjectToHClip(pos);  // Use correct transform for vertex to clip space
                o.texcoord = pos.xy * 0.5 + 0.5; // Convert from clip space to UV (0,1) range
                return o;
            }

            // Alpha blending helper function
            float4 alphaBlend(float4 top, float4 bottom)
            {
                float3 color = (top.rgb * top.a) + (bottom.rgb * (1 - top.a));
                float alpha = top.a + bottom.a * (1 - top.a);
                return float4(color, alpha);
            }

            // Fragment shader
            float4 frag(Varyings i) : SV_Target
            {
                float halfScaleFloor = floor(_Scale * 0.5);
                float halfScaleCeil = ceil(_Scale * 0.5);

                // Sample pixels in an X-shape
                float2 bottomLeftUV = i.texcoord - float2(_MainTex_TexelSize.x, _MainTex_TexelSize.y) * halfScaleFloor;
                float2 topRightUV = i.texcoord + float2(_MainTex_TexelSize.x, _MainTex_TexelSize.y) * halfScaleCeil;
                float2 bottomRightUV = i.texcoord + float2(_MainTex_TexelSize.x * halfScaleCeil, -_MainTex_TexelSize.y * halfScaleFloor);
                float2 topLeftUV = i.texcoord + float2(-_MainTex_TexelSize.x * halfScaleFloor, _MainTex_TexelSize.y * halfScaleCeil);

                // Sample the depth texture instead of the main texture
                float depth0 = SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_CameraDepthTexture, bottomLeftUV).r;
                float depth1 = SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_CameraDepthTexture, topRightUV).r;
                float depth2 = SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_CameraDepthTexture, bottomRightUV).r;
                float depth3 = SAMPLE_TEXTURE2D(_CameraDepthTexture, sampler_CameraDepthTexture, topLeftUV).r;

                // Sample the normals texture
                float3 normal0 = SAMPLE_TEXTURE2D(_CameraNormalsTexture, sampler_CameraNormalsTexture, bottomLeftUV).rgb;
                float3 normal1 = SAMPLE_TEXTURE2D(_CameraNormalsTexture, sampler_CameraNormalsTexture, topRightUV).rgb;
                float3 normal2 = SAMPLE_TEXTURE2D(_CameraNormalsTexture, sampler_CameraNormalsTexture, bottomRightUV).rgb;
                float3 normal3 = SAMPLE_TEXTURE2D(_CameraNormalsTexture, sampler_CameraNormalsTexture, topLeftUV).rgb;

                // Compute view normal and edge detection
                float3 viewNormal = normal0 * 2 - 1;
                float NdotV = 1 - dot(viewNormal, normalize(float3(0, 0, 1)));  // Assuming view direction along Z-axis

                float normalThreshold01 = saturate((NdotV - _DepthNormalThreshold) / (1 - _DepthNormalThreshold));
                float normalThreshold = normalThreshold01 * _DepthNormalThresholdScale + 1;
                float depthThreshold = _DepthThreshold * depth0 * normalThreshold;

                float depthFiniteDifference0 = depth1 - depth0;
                float depthFiniteDifference1 = depth3 - depth2;
                float edgeDepth = sqrt(pow(depthFiniteDifference0, 2) + pow(depthFiniteDifference1, 2)) * 100;
                edgeDepth = edgeDepth > depthThreshold ? 1 : 0;

                float3 normalFiniteDifference0 = normal1 - normal0;
                float3 normalFiniteDifference1 = normal3 - normal2;
                float edgeNormal = sqrt(dot(normalFiniteDifference0, normalFiniteDifference0) + dot(normalFiniteDifference1, normalFiniteDifference1));
                edgeNormal = edgeNormal > _NormalThreshold ? 1 : 0;

                float edge = max(edgeDepth, edgeNormal);

                float4 edgeColor = float4(_Color.rgb, _Color.a * edge);

                // Sample a color for output. Adjust as needed.
                float4 color = float4(depth0, depth0, depth0, 1); // Simple grayscale output based on depth

                return alphaBlend(edgeColor, color);
            }
            ENDHLSL
        }
    }
}
