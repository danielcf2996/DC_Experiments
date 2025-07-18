Shader "Shader Graphs Generated/SG_BattleGroundPlatform"
{
    Properties
    {
        [HDR]_EmmisiveColor("EmmisiveColor", Color) = (0.07035923, 1, 0, 0)
        _SurfaceABaseColor("SurfaceABaseColor", Color) = (0, 0, 0, 0)
        _SurfaceAMetallic("SurfaceAMetallic", Float) = 0
        _SurfaceBBaseColor("SurfaceBBaseColor", Color) = (0, 0, 0, 0)
        _SurfaceBMetallic("SurfaceBMetallic", Float) = 0
        _SurfaceASmoothness("SurfaceASmoothness", Float) = 0
        _SurfaceBSmoothness("SurfaceBSmoothness", Float) = 0
        [NoScaleOffset]_Texture2D("Texture2D", 2D) = "white" {}
        _XOffset("XOffset", Range(-1, 1)) = 0
        _YOffset("YOffset", Range(-1, 1)) = 0
        _PulsingSpeed("PulsingSpeed", Float) = 1
        _Repeat("Repeat", Float) = 1
        [HDR]_PatterColor("PatterColor", Color) = (1, 1, 1, 0)
        _stepsPulse("stepsPulse", Int) = 4
        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="Geometry"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma multi_compile_fragment _ _LIGHT_COOKIES
        #pragma multi_compile _ _FORWARD_PLUS
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_COLOR
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 color;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 VertexColor;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV : INTERP0;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP2;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord : INTERP3;
            #endif
             float4 tangentWS : INTERP4;
             float4 color : INTERP5;
             float4 fogFactorAndVertexLight : INTERP6;
             float3 positionWS : INTERP7;
             float3 normalWS : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.color.xyzw = input.color;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.color = input.color.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Posterize_float(float In, float Steps, out float Out)
        {
            Out = floor(In / (1 / Steps)) * (1 / Steps);
        }
        
        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4 = _SurfaceABaseColor;
            float4 _Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_PatterColor) : _PatterColor;
            UnityTexture2D _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float _Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float = _Repeat;
            float3 _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3);
            float _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[0];
            float _Split_6546f1f8347b491ebb7361bcab98279f_G_2_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[1];
            float _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[2];
            float _Split_6546f1f8347b491ebb7361bcab98279f_A_4_Float = 0;
            float _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float);
            float _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float);
            float _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float, _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float);
            float _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float;
            Unity_Add_float(_Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float, -1, _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float);
            float _Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float = _XOffset;
            float _Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float = _PulsingSpeed;
            float _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float;
            Unity_Multiply_float_float(_Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float, IN.TimeParameters.x, _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float);
            float _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float;
            Unity_Sine_float(_Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float, _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float);
            float _Property_454b5fdaed724331a4234747d100679e_Out_0_Float = _stepsPulse;
            float _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float;
            Unity_Posterize_float(_Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float, _Property_454b5fdaed724331a4234747d100679e_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float);
            float _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float;
            Unity_Multiply_float_float(_Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float);
            float _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float;
            Unity_Multiply_float_float(_Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float, _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float);
            float _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float;
            Unity_Add_float(_Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float);
            float2 _Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2 = float2(_Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2) );
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.r;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_G_5_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.g;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_B_6_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.b;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_A_7_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.a;
            float _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float);
            float _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float);
            float _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float, _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float);
            float _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float;
            Unity_Add_float(_Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float, -1, _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float);
            float _Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float = _YOffset;
            float _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float;
            Unity_Multiply_float_float(_Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float);
            float _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float;
            Unity_Multiply_float_float(_Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float);
            float _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float;
            Unity_Add_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float2 _Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float4 _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2) );
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_R_4_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.r;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.g;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_B_6_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.b;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_A_7_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.a;
            float _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float;
            Unity_Maximum_float(_SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float, _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float, _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float);
            float2 _Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2) );
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_R_4_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.r;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_G_5_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.g;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.b;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_A_7_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.a;
            float _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float);
            float _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float;
            Unity_Minimum_float(_Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float);
            float _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float;
            Unity_Smoothstep_float(0.1, 1, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float, _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float);
            float4 _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4, (_Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float.xxxx), _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4);
            float4 _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4 = _SurfaceBBaseColor;
            float4 _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4;
            Unity_Add_float4(_Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4, _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4);
            float _Split_2205628f854547de89b3b335ed8e707d_R_1_Float = IN.VertexColor[0];
            float _Split_2205628f854547de89b3b335ed8e707d_G_2_Float = IN.VertexColor[1];
            float _Split_2205628f854547de89b3b335ed8e707d_B_3_Float = IN.VertexColor[2];
            float _Split_2205628f854547de89b3b335ed8e707d_A_4_Float = IN.VertexColor[3];
            float4 _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4;
            Unity_Lerp_float4(_Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4, (_Split_2205628f854547de89b3b335ed8e707d_R_1_Float.xxxx), _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4);
            float _Property_d7918f37c8d641f4b5d826a449edbed3_Out_0_Float = _SurfaceAMetallic;
            float _Property_ea48924d8556410fa10dcc2b524e0821_Out_0_Float = _SurfaceBMetallic;
            float _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float;
            Unity_Lerp_float(_Property_d7918f37c8d641f4b5d826a449edbed3_Out_0_Float, _Property_ea48924d8556410fa10dcc2b524e0821_Out_0_Float, _Split_2205628f854547de89b3b335ed8e707d_R_1_Float, _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float);
            float _Property_527c2d4eeec2499dbc4faaaac4069be4_Out_0_Float = _SurfaceASmoothness;
            float _Property_fee7680c689c452a89f0c204ae3870e1_Out_0_Float = _SurfaceBSmoothness;
            float _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float;
            Unity_Lerp_float(_Property_527c2d4eeec2499dbc4faaaac4069be4_Out_0_Float, _Property_fee7680c689c452a89f0c204ae3870e1_Out_0_Float, _Split_2205628f854547de89b3b335ed8e707d_R_1_Float, _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float);
            surface.BaseColor = (_Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4.xyz);
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float;
            surface.Smoothness = _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float;
            surface.Occlusion = 1;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.VertexColor = input.color;
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
        #pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_COLOR
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 color;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float3 WorldSpacePosition;
             float4 VertexColor;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV : INTERP0;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP2;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord : INTERP3;
            #endif
             float4 tangentWS : INTERP4;
             float4 color : INTERP5;
             float4 fogFactorAndVertexLight : INTERP6;
             float3 positionWS : INTERP7;
             float3 normalWS : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.color.xyzw = input.color;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.color = input.color.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Posterize_float(float In, float Steps, out float Out)
        {
            Out = floor(In / (1 / Steps)) * (1 / Steps);
        }
        
        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4 = _SurfaceABaseColor;
            float4 _Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_PatterColor) : _PatterColor;
            UnityTexture2D _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float _Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float = _Repeat;
            float3 _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3);
            float _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[0];
            float _Split_6546f1f8347b491ebb7361bcab98279f_G_2_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[1];
            float _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[2];
            float _Split_6546f1f8347b491ebb7361bcab98279f_A_4_Float = 0;
            float _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float);
            float _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float);
            float _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float, _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float);
            float _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float;
            Unity_Add_float(_Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float, -1, _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float);
            float _Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float = _XOffset;
            float _Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float = _PulsingSpeed;
            float _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float;
            Unity_Multiply_float_float(_Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float, IN.TimeParameters.x, _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float);
            float _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float;
            Unity_Sine_float(_Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float, _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float);
            float _Property_454b5fdaed724331a4234747d100679e_Out_0_Float = _stepsPulse;
            float _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float;
            Unity_Posterize_float(_Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float, _Property_454b5fdaed724331a4234747d100679e_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float);
            float _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float;
            Unity_Multiply_float_float(_Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float);
            float _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float;
            Unity_Multiply_float_float(_Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float, _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float);
            float _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float;
            Unity_Add_float(_Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float);
            float2 _Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2 = float2(_Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2) );
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.r;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_G_5_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.g;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_B_6_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.b;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_A_7_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.a;
            float _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float);
            float _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float);
            float _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float, _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float);
            float _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float;
            Unity_Add_float(_Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float, -1, _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float);
            float _Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float = _YOffset;
            float _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float;
            Unity_Multiply_float_float(_Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float);
            float _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float;
            Unity_Multiply_float_float(_Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float);
            float _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float;
            Unity_Add_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float2 _Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float4 _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2) );
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_R_4_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.r;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.g;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_B_6_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.b;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_A_7_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.a;
            float _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float;
            Unity_Maximum_float(_SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float, _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float, _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float);
            float2 _Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2) );
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_R_4_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.r;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_G_5_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.g;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.b;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_A_7_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.a;
            float _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float);
            float _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float;
            Unity_Minimum_float(_Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float);
            float _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float;
            Unity_Smoothstep_float(0.1, 1, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float, _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float);
            float4 _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4, (_Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float.xxxx), _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4);
            float4 _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4 = _SurfaceBBaseColor;
            float4 _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4;
            Unity_Add_float4(_Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4, _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4);
            float _Split_2205628f854547de89b3b335ed8e707d_R_1_Float = IN.VertexColor[0];
            float _Split_2205628f854547de89b3b335ed8e707d_G_2_Float = IN.VertexColor[1];
            float _Split_2205628f854547de89b3b335ed8e707d_B_3_Float = IN.VertexColor[2];
            float _Split_2205628f854547de89b3b335ed8e707d_A_4_Float = IN.VertexColor[3];
            float4 _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4;
            Unity_Lerp_float4(_Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4, (_Split_2205628f854547de89b3b335ed8e707d_R_1_Float.xxxx), _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4);
            float _Property_d7918f37c8d641f4b5d826a449edbed3_Out_0_Float = _SurfaceAMetallic;
            float _Property_ea48924d8556410fa10dcc2b524e0821_Out_0_Float = _SurfaceBMetallic;
            float _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float;
            Unity_Lerp_float(_Property_d7918f37c8d641f4b5d826a449edbed3_Out_0_Float, _Property_ea48924d8556410fa10dcc2b524e0821_Out_0_Float, _Split_2205628f854547de89b3b335ed8e707d_R_1_Float, _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float);
            float _Property_527c2d4eeec2499dbc4faaaac4069be4_Out_0_Float = _SurfaceASmoothness;
            float _Property_fee7680c689c452a89f0c204ae3870e1_Out_0_Float = _SurfaceBSmoothness;
            float _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float;
            Unity_Lerp_float(_Property_527c2d4eeec2499dbc4faaaac4069be4_Out_0_Float, _Property_fee7680c689c452a89f0c204ae3870e1_Out_0_Float, _Split_2205628f854547de89b3b335ed8e707d_R_1_Float, _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float);
            surface.BaseColor = (_Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4.xyz);
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Lerp_40424f364bdc48e4a0e66b2f60a7e719_Out_3_Float;
            surface.Smoothness = _Lerp_3553c7747f4d44c7b4b5e93cd357d0e8_Out_3_Float;
            surface.Occlusion = 1;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.VertexColor = input.color;
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define VARYINGS_NEED_NORMAL_WS
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull Back
        ZTest LEqual
        ZWrite On
        ColorMask R
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define VARYINGS_NEED_COLOR
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 VertexColor;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
             float4 texCoord2 : INTERP2;
             float4 color : INTERP3;
             float3 positionWS : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.color.xyzw = input.color;
            output.positionWS.xyz = input.positionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.color = input.color.xyzw;
            output.positionWS = input.positionWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Posterize_float(float In, float Steps, out float Out)
        {
            Out = floor(In / (1 / Steps)) * (1 / Steps);
        }
        
        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4 = _SurfaceABaseColor;
            float4 _Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_PatterColor) : _PatterColor;
            UnityTexture2D _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float _Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float = _Repeat;
            float3 _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3);
            float _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[0];
            float _Split_6546f1f8347b491ebb7361bcab98279f_G_2_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[1];
            float _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[2];
            float _Split_6546f1f8347b491ebb7361bcab98279f_A_4_Float = 0;
            float _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float);
            float _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float);
            float _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float, _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float);
            float _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float;
            Unity_Add_float(_Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float, -1, _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float);
            float _Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float = _XOffset;
            float _Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float = _PulsingSpeed;
            float _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float;
            Unity_Multiply_float_float(_Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float, IN.TimeParameters.x, _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float);
            float _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float;
            Unity_Sine_float(_Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float, _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float);
            float _Property_454b5fdaed724331a4234747d100679e_Out_0_Float = _stepsPulse;
            float _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float;
            Unity_Posterize_float(_Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float, _Property_454b5fdaed724331a4234747d100679e_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float);
            float _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float;
            Unity_Multiply_float_float(_Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float);
            float _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float;
            Unity_Multiply_float_float(_Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float, _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float);
            float _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float;
            Unity_Add_float(_Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float);
            float2 _Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2 = float2(_Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2) );
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.r;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_G_5_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.g;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_B_6_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.b;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_A_7_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.a;
            float _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float);
            float _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float);
            float _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float, _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float);
            float _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float;
            Unity_Add_float(_Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float, -1, _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float);
            float _Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float = _YOffset;
            float _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float;
            Unity_Multiply_float_float(_Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float);
            float _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float;
            Unity_Multiply_float_float(_Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float);
            float _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float;
            Unity_Add_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float2 _Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float4 _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2) );
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_R_4_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.r;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.g;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_B_6_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.b;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_A_7_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.a;
            float _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float;
            Unity_Maximum_float(_SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float, _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float, _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float);
            float2 _Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2) );
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_R_4_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.r;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_G_5_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.g;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.b;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_A_7_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.a;
            float _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float);
            float _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float;
            Unity_Minimum_float(_Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float);
            float _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float;
            Unity_Smoothstep_float(0.1, 1, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float, _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float);
            float4 _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4, (_Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float.xxxx), _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4);
            float4 _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4 = _SurfaceBBaseColor;
            float4 _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4;
            Unity_Add_float4(_Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4, _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4);
            float _Split_2205628f854547de89b3b335ed8e707d_R_1_Float = IN.VertexColor[0];
            float _Split_2205628f854547de89b3b335ed8e707d_G_2_Float = IN.VertexColor[1];
            float _Split_2205628f854547de89b3b335ed8e707d_B_3_Float = IN.VertexColor[2];
            float _Split_2205628f854547de89b3b335ed8e707d_A_4_Float = IN.VertexColor[3];
            float4 _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4;
            Unity_Lerp_float4(_Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4, (_Split_2205628f854547de89b3b335ed8e707d_R_1_Float.xxxx), _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4);
            surface.BaseColor = (_Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.VertexColor = input.color;
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_COLOR
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 VertexColor;
             float3 TimeParameters;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 color : INTERP0;
             float3 positionWS : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.color.xyzw = input.color;
            output.positionWS.xyz = input.positionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.color = input.color.xyzw;
            output.positionWS = input.positionWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _EmmisiveColor;
        float4 _SurfaceABaseColor;
        float4 _SurfaceBBaseColor;
        float _SurfaceBMetallic;
        float _SurfaceASmoothness;
        float _SurfaceBSmoothness;
        float _SurfaceAMetallic;
        float4 _Texture2D_TexelSize;
        float _YOffset;
        float _XOffset;
        float _PulsingSpeed;
        float _Repeat;
        float4 _PatterColor;
        float _stepsPulse;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Posterize_float(float In, float Steps, out float Out)
        {
            Out = floor(In / (1 / Steps)) * (1 / Steps);
        }
        
        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4 = _SurfaceABaseColor;
            float4 _Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_PatterColor) : _PatterColor;
            UnityTexture2D _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float _Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float = _Repeat;
            float3 _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_403219d3be9b4bb6951bfc267d4bd64b_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3);
            float _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[0];
            float _Split_6546f1f8347b491ebb7361bcab98279f_G_2_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[1];
            float _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float = _Multiply_387f52223f524974a5b95a0d5b8f9166_Out_2_Vector3[2];
            float _Split_6546f1f8347b491ebb7361bcab98279f_A_4_Float = 0;
            float _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float);
            float _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_dca0376dc39946fda529ff0d5b007134_Out_1_Float, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float);
            float _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_8133fbabd4cd4675b2abc08d50b55e58_Out_2_Float, _Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float);
            float _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float;
            Unity_Add_float(_Multiply_264d968f15334d07a4b70098141c9f1f_Out_2_Float, -1, _Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float);
            float _Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float = _XOffset;
            float _Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float = _PulsingSpeed;
            float _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float;
            Unity_Multiply_float_float(_Property_9501b155dd3749a4a50a74aad4fc6087_Out_0_Float, IN.TimeParameters.x, _Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float);
            float _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float;
            Unity_Sine_float(_Multiply_5c8db555d6084481916bdabcbac0f0b2_Out_2_Float, _Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float);
            float _Property_454b5fdaed724331a4234747d100679e_Out_0_Float = _stepsPulse;
            float _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float;
            Unity_Posterize_float(_Sine_c7b3e0f2b5754f72875b694c7d0d1001_Out_1_Float, _Property_454b5fdaed724331a4234747d100679e_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float);
            float _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float;
            Unity_Multiply_float_float(_Property_cd3bb162be1b4141bbb8cbb275b257b7_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float);
            float _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float;
            Unity_Multiply_float_float(_Add_9a711e30f818456ca3f74f6b62d19ec1_Out_2_Float, _Multiply_af335ba3902343d6bcd13f0ff849e875_Out_2_Float, _Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float);
            float _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float;
            Unity_Add_float(_Multiply_4540cd40388e4be4a024247b6d779250_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float);
            float2 _Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2 = float2(_Add_44a43b8ec46743e1872ae6471ccfd604_Out_2_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_d03e90aa8d29403aa61c893cdd377015_Out_0_Vector2) );
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.r;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_G_5_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.g;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_B_6_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.b;
            float _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_A_7_Float = _SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_RGBA_0_Vector4.a;
            float _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float;
            Unity_Fraction_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float);
            float _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float;
            Unity_Step_float(0.5, _Fraction_a48ad37b4c2c4a1e80ffdad3d6d0bfaf_Out_1_Float, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float);
            float _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float;
            Unity_Multiply_float_float(2, _Step_f997f6fd2d7f487ca13724e65a3210a6_Out_2_Float, _Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float);
            float _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float;
            Unity_Add_float(_Multiply_5dd31af5898149389a8f5a329d080f39_Out_2_Float, -1, _Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float);
            float _Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float = _YOffset;
            float _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float;
            Unity_Multiply_float_float(_Property_5cb5a5fc75114cfcb164b9443fca6d2a_Out_0_Float, _Posterize_d9b7864210774ad5b50f0f1d8c8a3512_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float);
            float _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float;
            Unity_Multiply_float_float(_Add_a126b7e348d14141b7bb7b3be068711e_Out_2_Float, _Multiply_382a8678cf0f4c28ac3e69809e499f69_Out_2_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float);
            float _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float;
            Unity_Add_float(_Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float, _Multiply_7fce0bd48486435099d3d0f6fa901a49_Out_2_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float2 _Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Add_f93e24de1e2347d59d2c370913b6e04b_Out_2_Float);
            float4 _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_b5a3a4449d2a495e96fd47cc2f9f1444_Out_0_Vector2) );
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_R_4_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.r;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.g;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_B_6_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.b;
            float _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_A_7_Float = _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_RGBA_0_Vector4.a;
            float _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float;
            Unity_Maximum_float(_SampleTexture2D_4ed45db4a848490cb099cba9cbdad836_R_4_Float, _SampleTexture2D_f0ebc229199840aaa29b572ed1249f20_G_5_Float, _Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float);
            float2 _Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2 = float2(_Split_6546f1f8347b491ebb7361bcab98279f_R_1_Float, _Split_6546f1f8347b491ebb7361bcab98279f_B_3_Float);
            float4 _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.tex, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.samplerstate, _Property_47238628d73f4ba1803462c25ab51553_Out_0_Texture2D.GetTransformedUV(_Vector2_8586440132e340f48309249d1a0fe087_Out_0_Vector2) );
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_R_4_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.r;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_G_5_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.g;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.b;
            float _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_A_7_Float = _SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_RGBA_0_Vector4.a;
            float _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_7739b8a8dd6941ce9ec154086638a5c4_B_6_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float);
            float _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float;
            Unity_Minimum_float(_Maximum_4bbbe299a6914638aec27e235217726c_Out_2_Float, _OneMinus_144722e8da1241b1bb805339d95509a6_Out_1_Float, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float);
            float _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float;
            Unity_Smoothstep_float(0.1, 1, _Minimum_a9cce971eb0246e38e4ec97a1de25e68_Out_2_Float, _Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float);
            float4 _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_0d675f6ddc0948a68f921061be6cb4a3_Out_0_Vector4, (_Smoothstep_d62384ed46224cf18819297b3f20d88c_Out_3_Float.xxxx), _Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4);
            float4 _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4 = _SurfaceBBaseColor;
            float4 _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4;
            Unity_Add_float4(_Multiply_2d10c64ca70b410295562da804a179e3_Out_2_Vector4, _Property_50bf3fb96c604596af97100e8337c282_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4);
            float _Split_2205628f854547de89b3b335ed8e707d_R_1_Float = IN.VertexColor[0];
            float _Split_2205628f854547de89b3b335ed8e707d_G_2_Float = IN.VertexColor[1];
            float _Split_2205628f854547de89b3b335ed8e707d_B_3_Float = IN.VertexColor[2];
            float _Split_2205628f854547de89b3b335ed8e707d_A_4_Float = IN.VertexColor[3];
            float4 _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4;
            Unity_Lerp_float4(_Property_4e56f36caed94df1afeaff9439be09ba_Out_0_Vector4, _Add_2fb4dd8b383441d2b8f2d90ce0f85ead_Out_2_Vector4, (_Split_2205628f854547de89b3b335ed8e707d_R_1_Float.xxxx), _Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4);
            surface.BaseColor = (_Lerp_4bda14c277f84e8ca565ff3da40f7861_Out_3_Vector4.xyz);
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.VertexColor = input.color;
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphLitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}
