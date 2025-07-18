Shader "Shader Graphs/SGGenerated_SImpleFullscrenTemplate"
{
    Properties
    {
        _Color("Color", Color) = (1, 0, 0, 0)
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

        _StencilTex("Stencil Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType" = "Opaque"
            // Queue: <None>
            // DisableBatching: <None>
            // "ShaderGraphShader"="true"
            //"ShaderGraphTargetId"="UniversalFullscreenSubTarget"
            
        }

        Stencil
        {
                Ref 1              // Reference value; matches the value written by Shader A
                Comp Always         // Compare current stencil buffer value with Ref; only pass if they are equal
                Pass keep          // Keep the current stencil buffer value if the stencil test passes
                Fail keep          // Keep the current stencil buffer value if the stencil test fails
                ZFail keep         // Keep the current stencil buffer value if the depth test fails
        }


        Pass
        {
            Name "DrawProcedural"
        
        // Render State
        Cull Off
        Blend Off
        ZTest Off
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma vertex vert
        #pragma fragment frag
        // #pragma enable_d3d11_debug_symbols
        
        /* WARNING: $splice Could not find named fragment 'DotsInstancingOptions' */
        /* WARNING: $splice Could not find named fragment 'HybridV1InjectedBuiltinProperties' */
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        #define FULLSCREEN_SHADERGRAPH
        
        // Defines
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_VERTEXID
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        
        // Force depth texture because we need it for almost every nodes
        // TODO: dependency system that triggers this define from position or view direction usage
        #define REQUIRE_DEPTH_TEXTURE
        #define REQUIRE_NORMAL_TEXTURE
        
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DRAWPROCEDURAL
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenShaderPass.cs.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/SpaceTransforms.hlsl"
        #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
             uint vertexID : VERTEXID_SEMANTIC;
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
             float4 texCoord1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
        };
        struct VertexDescriptionInputs
        {
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        CBUFFER_END
        
        
        // Object and Global properties
        float _FlipY;
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        // GraphVertex: <None>
        
        // Custom interpolators, pre surface
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreSurface' */
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_809736d7e5474532b2d49a3a35ea72c1_Out_0_Vector4 = _Color;
            float4 _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4 = IN.uv0;
            float _Split_adcd41413e4f4443a1bac3b414aa686e_R_1_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[0];
            float _Split_adcd41413e4f4443a1bac3b414aa686e_G_2_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[1];
            float _Split_adcd41413e4f4443a1bac3b414aa686e_B_3_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[2];
            float _Split_adcd41413e4f4443a1bac3b414aa686e_A_4_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[3];
            float4 _Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_809736d7e5474532b2d49a3a35ea72c1_Out_0_Vector4, (_Split_adcd41413e4f4443a1bac3b414aa686e_G_2_Float.xxxx), _Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4);
            surface.BaseColor = (_Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4.xyz);
            surface.Alpha = 1;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            float3 normalWS = SHADERGRAPH_SAMPLE_SCENE_NORMAL(input.texCoord0.xy);
            float4 tangentWS = float4(0, 1, 0, 0); // We can't access the tangent in screen space
        
        
        
        
            float3 viewDirWS = normalize(input.texCoord1.xyz);
            float linearDepth = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(input.texCoord0.xy), _ZBufferParams);
            float3 cameraForward = -UNITY_MATRIX_V[2].xyz;
            float camearDistance = linearDepth / dot(viewDirWS, cameraForward);
            float3 positionWS = viewDirWS * camearDistance + GetCameraPositionWS();
        
        
            output.uv0 = input.texCoord0;
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenCommon.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenDrawProcedural.hlsl"
        
        ENDHLSL
        }



        Pass
        {
            Name "StencilVisualizerPass"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha

            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #pragma target 3.0

            // Texture for sampling stencil values
            Texture2D<float> _StencilTex;
            SamplerState samplerState;

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            Varyings Vert(Attributes v)
            {
                Varyings o;
                // Transform vertex position to clip space
                o.positionCS = float4(v.positionOS.xy * 2.0 - 1.0, 0.0, 1.0); // Fullscreen quad
                o.uv = v.uv;
                return o;
            }

            float4 Frag(Varyings i) : SV_Target
            {
                // Sample the stencil texture
                float stencilValue = _StencilTex.Sample(samplerState, i.uv).r;

                // Output white if the stencil value is 1, otherwise black
                float4 color = (stencilValue == 1.0) ? float4(1.0, 1.0, 1.0, 1.0) : float4(0.0, 0.0, 0.0, 1.0);

                return color;
            }
            ENDHLSL
        }
        //Pass
        //{
        //    Name "Blit"
        
        //// Render State
        //Cull Off
        //Blend Off
        //ZTest Off
        //ZWrite Off

        //Stencil{
        //                Ref 1              // Reference value; matches the value written by Shader A
        //        Comp equal         // Compare current stencil buffer value with Ref; only pass if they are equal
        //        Pass keep          // Keep the current stencil buffer value if the stencil test passes
        //        Fail keep          // Keep the current stencil buffer value if the stencil test fails
        //        ZFail keep 
        //}
        //// Debug
        //// <None>
        
        //// --------------------------------------------------
        //// Pass
        
        //HLSLPROGRAM
        
        //// Pragmas
        //#pragma target 3.0
        //#pragma vertex vert
        //#pragma fragment frag
        //// #pragma enable_d3d11_debug_symbols
        
        ///* WARNING: $splice Could not find named fragment 'DotsInstancingOptions' */
        ///* WARNING: $splice Could not find named fragment 'HybridV1InjectedBuiltinProperties' */
        
        //// Keywords
        //// PassKeywords: <None>
        //// GraphKeywords: <None>
        
        //#define FULLSCREEN_SHADERGRAPH
        
        //// Defines
        //#define ATTRIBUTES_NEED_TEXCOORD0
        //#define ATTRIBUTES_NEED_TEXCOORD1
        //#define ATTRIBUTES_NEED_VERTEXID
        //#define VARYINGS_NEED_TEXCOORD0
        //#define VARYINGS_NEED_TEXCOORD1
        
        //// Force depth texture because we need it for almost every nodes
        //// TODO: dependency system that triggers this define from position or view direction usage
        //#define REQUIRE_DEPTH_TEXTURE
        //#define REQUIRE_NORMAL_TEXTURE
        
        ///* WARNING: $splice Could not find named fragment 'PassInstancing' */
        //#define SHADERPASS SHADERPASS_BLIT
        
        //// custom interpolator pre-include
        ///* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        //// Includes
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        //#include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenShaderPass.cs.hlsl"
        //#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
        //#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        //#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        //#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        //#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/SpaceTransforms.hlsl"
        //#include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"
        
        //// --------------------------------------------------
        //// Structs and Packing
        
        //// custom interpolators pre packing
        ///* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        //struct Attributes
        //{
        //    #if UNITY_ANY_INSTANCING_ENABLED
        //     uint instanceID : INSTANCEID_SEMANTIC;
        //    #endif
        //     uint vertexID : VERTEXID_SEMANTIC;
        //     float3 positionOS : POSITION;
        //};
        //struct SurfaceDescriptionInputs
        //{
        //     float4 uv0;
        //};
        //struct Varyings
        //{
        //     float4 positionCS : SV_POSITION;
        //     float4 texCoord0;
        //     float4 texCoord1;
        //    #if UNITY_ANY_INSTANCING_ENABLED
        //     uint instanceID : CUSTOM_INSTANCE_ID;
        //    #endif
        //    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        //     uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        //    #endif
        //    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        //     uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        //    #endif
        //};
        //struct VertexDescriptionInputs
        //{
        //};
        //struct PackedVaryings
        //{
        //     float4 positionCS : SV_POSITION;
        //     float4 texCoord0 : INTERP0;
        //     float4 texCoord1 : INTERP1;
        //    #if UNITY_ANY_INSTANCING_ENABLED
        //     uint instanceID : CUSTOM_INSTANCE_ID;
        //    #endif
        //    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        //     uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
        //    #endif
        //    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        //     uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
        //    #endif
        //};
        
        //PackedVaryings PackVaryings (Varyings input)
        //{
        //    PackedVaryings output;
        //    ZERO_INITIALIZE(PackedVaryings, output);
        //    output.positionCS = input.positionCS;
        //    output.texCoord0.xyzw = input.texCoord0;
        //    output.texCoord1.xyzw = input.texCoord1;
        //    #if UNITY_ANY_INSTANCING_ENABLED
        //    output.instanceID = input.instanceID;
        //    #endif
        //    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        //    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        //    #endif
        //    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        //    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        //    #endif
        //    return output;
        //}
        
        //Varyings UnpackVaryings (PackedVaryings input)
        //{
        //    Varyings output;
        //    output.positionCS = input.positionCS;
        //    output.texCoord0 = input.texCoord0.xyzw;
        //    output.texCoord1 = input.texCoord1.xyzw;
        //    #if UNITY_ANY_INSTANCING_ENABLED
        //    output.instanceID = input.instanceID;
        //    #endif
        //    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
        //    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
        //    #endif
        //    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
        //    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
        //    #endif
        //    return output;
        //}
        
        
        //// --------------------------------------------------
        //// Graph
        
        //// Graph Properties
        //CBUFFER_START(UnityPerMaterial)
        //float4 _Color;
        //CBUFFER_END
        
        
        //// Object and Global properties
        //float _FlipY;
        
        //// Graph Includes
        //// GraphIncludes: <None>
        
        //// Graph Functions
        
        //void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        //{
        //    Out = A * B;
        //}
        
        //// Custom interpolators pre vertex
        ///* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        //// Graph Vertex
        //// GraphVertex: <None>
        
        //// Custom interpolators, pre surface
        ///* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreSurface' */
        
        //// Graph Pixel
        //struct SurfaceDescription
        //{
        //    float3 BaseColor;
        //    float Alpha;
        //};
        
        //SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        //{
        //    SurfaceDescription surface = (SurfaceDescription)0;
        //    float4 _Property_809736d7e5474532b2d49a3a35ea72c1_Out_0_Vector4 = _Color;
        //    float4 _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4 = IN.uv0;
        //    float _Split_adcd41413e4f4443a1bac3b414aa686e_R_1_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[0];
        //    float _Split_adcd41413e4f4443a1bac3b414aa686e_G_2_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[1];
        //    float _Split_adcd41413e4f4443a1bac3b414aa686e_B_3_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[2];
        //    float _Split_adcd41413e4f4443a1bac3b414aa686e_A_4_Float = _UV_9bc979789fc54feda185d9abdf3f342d_Out_0_Vector4[3];
        //    float4 _Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4;
        //    Unity_Multiply_float4_float4(_Property_809736d7e5474532b2d49a3a35ea72c1_Out_0_Vector4, (_Split_adcd41413e4f4443a1bac3b414aa686e_G_2_Float.xxxx), _Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4);
        //    surface.BaseColor = (_Multiply_5976b86ff8104814a5a651a65674c757_Out_2_Vector4.xyz);
        //    surface.Alpha = 1;
        //    return surface;
        //}
        
        //// --------------------------------------------------
        //// Build Graph Inputs
        
        //SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        //{
        //    SurfaceDescriptionInputs output;
        //    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        //    float3 normalWS = SHADERGRAPH_SAMPLE_SCENE_NORMAL(input.texCoord0.xy);
        //    float4 tangentWS = float4(0, 1, 0, 0); // We can't access the tangent in screen space
        
        
        
        
        //    float3 viewDirWS = normalize(input.texCoord1.xyz);
        //    float linearDepth = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(input.texCoord0.xy), _ZBufferParams);
        //    float3 cameraForward = -UNITY_MATRIX_V[2].xyz;
        //    float camearDistance = linearDepth / dot(viewDirWS, cameraForward);
        //    float3 positionWS = viewDirWS * camearDistance + GetCameraPositionWS();
        
        
        //    output.uv0 = input.texCoord0;
        
        //#if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        //#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        //#else
        //#define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        //#endif
        //#undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
        //        return output;
        //}
        
        //// --------------------------------------------------
        //// Main
        
        //#include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenCommon.hlsl"
        //#include "Packages/com.unity.shadergraph/Editor/Generation/Targets/Fullscreen/Includes/FullscreenBlit.hlsl"
        
        //ENDHLSL
        //}
    }
    CustomEditor "UnityEditor.Rendering.Fullscreen.ShaderGraph.FullscreenShaderGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
