Shader "Shader Graphs Generated/SG_BattlegroundCubes"
{
    Properties
    {
        _Fade("Fade", Range(0, 1)) = 1
        _FadeColor("FadeColor", Color) = (0.2033437, 1, 0, 0)
        _multi("multi", Float) = 2
        _add("add", Float) = 0
        _Metallic("Metallic", Range(0, 1)) = 0
        [HDR]_YGradientColor("YGradientColor", Color) = (1, 0, 0, 0)
        _YGradientOffset("YGradientOffset", Float) = 0
        _YGradientContrast("YGradientContrast", Float) = 1
        _FresnelPower("FresnelPower", Float) = 0
        [HDR]_FresnelColor("FresnelColor", Color) = (0, 1, 0.9905014, 0)
        [NoScaleOffset]_MetallicSmoothness("MetallicSmoothness", 2D) = "white" {}
        _Smothness("Smothness", Float) = 0
        [NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
        [NoScaleOffset]_Emmisive("Emmisive", 2D) = "white" {}
        [HDR]_EmmisionColor("EmmisionColor", Color) = (0, 0, 0, 0)
        [NoScaleOffset]_Normal("Normal", 2D) = "white" {}
        _RotatinSpeed("RotatinSpeed", Float) = 0
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
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
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
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
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
             float4 texCoord0;
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
             float3 WorldSpaceNormal;
             float3 TangentSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 TimeParameters;
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
             float4 texCoord0 : INTERP5;
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
            output.texCoord0.xyzw = input.texCoord0;
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
            output.texCoord0 = input.texCoord0.xyzw;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A - B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            UnityTexture2D _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.tex, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.samplerstate, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_R_4_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.r;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_G_5_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.g;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_B_6_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.b;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_A_7_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.a;
            float4 _Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_FresnelColor) : _FresnelColor;
            float _Property_9858161811ac4df59c781d502277c701_Out_0_Float = _FresnelPower;
            float _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_9858161811ac4df59c781d502277c701_Out_0_Float, _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float);
            float4 _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4, (_FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float.xxxx), _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4);
            float4 _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4;
            Unity_Add_float4(_SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4, _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4, _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4);
            float4 _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4 = _FadeColor;
            float _Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float = _add;
            float _Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float = _multi;
            float _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float;
            Unity_Distance_float3(float3(0, 0, 0), SHADERGRAPH_OBJECT_POSITION, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float);
            float _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float;
            Unity_Multiply_float_float(_Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float);
            float _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float;
            Unity_Add_float(_Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float, _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float);
            float _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float;
            Unity_Saturate_float(_Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float, _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float);
            float4 _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4;
            Unity_Lerp_float4(_Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4, _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4, (_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float.xxxx), _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4);
            float4 _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_YGradientColor) : _YGradientColor;
            float _Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float = _YGradientOffset;
            float _Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float = _YGradientContrast;
            float3 _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3);
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_R_1_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[0];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[1];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_B_3_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[2];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_A_4_Float = 0;
            float _Add_310bc398208442b0994d7b94279e5463_Out_2_Float;
            Unity_Add_float(_Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float, _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float, _Add_310bc398208442b0994d7b94279e5463_Out_2_Float);
            float _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float;
            Unity_Saturate_float(_Add_310bc398208442b0994d7b94279e5463_Out_2_Float, _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float);
            float _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float;
            Unity_OneMinus_float(_Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float, _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float);
            float4 _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4;
            Unity_Lerp_float4(_Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4, _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4, (_OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float.xxxx), _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4);
            UnityTexture2D _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.tex, _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.samplerstate, _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4);
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_R_4_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.r;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_G_5_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.g;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_B_6_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.b;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_A_7_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.a;
            float _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.98, _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float);
            float _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float;
            Unity_OneMinus_float(_Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float, _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float);
            float4 _Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_EmmisionColor) : _EmmisionColor;
            UnityTexture2D _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emmisive);
            float4 _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.tex, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.samplerstate, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_R_4_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.r;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_G_5_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.g;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_B_6_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.b;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_A_7_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.a;
            float4 _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4, _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4, _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4);
            float4 _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4;
            Unity_Multiply_float4_float4((_OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float.xxxx), _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4, _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4);
            float _Property_a3fb2fb19c3d4019ab2001ddb7f96619_Out_0_Float = _Metallic;
            UnityTexture2D _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MetallicSmoothness);
            float4 _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.tex, _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.samplerstate, _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_R_4_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.r;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_G_5_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.g;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_B_6_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.b;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_A_7_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.a;
            float4 _Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4;
            Unity_Multiply_float4_float4((_Property_a3fb2fb19c3d4019ab2001ddb7f96619_Out_0_Float.xxxx), _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4, _Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4);
            float _Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.5, _Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float);
            float4 _Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4;
            Unity_Subtract_float4(_Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4, (_Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float.xxxx), _Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4);
            float _Property_f7d8101ead2a4f3eb4afde73ea6530cd_Out_0_Float = _Smothness;
            float _Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float;
            Unity_Multiply_float_float(_Property_f7d8101ead2a4f3eb4afde73ea6530cd_Out_0_Float, _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_A_7_Float, _Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float);
            float _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.4, _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float);
            float _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float;
            Unity_Subtract_float(_Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float, _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float, _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float);
            surface.BaseColor = (_Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.xyz);
            surface.Emission = (_Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4.xyz);
            surface.Metallic = (_Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4).x;
            surface.Smoothness = _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpaceViewDirection = GetWorldSpaceNormalizeViewDir(input.positionWS);
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
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
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
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
             float4 texCoord0;
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
             float3 WorldSpaceNormal;
             float3 TangentSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 TimeParameters;
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
             float4 texCoord0 : INTERP5;
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
            output.texCoord0.xyzw = input.texCoord0;
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
            output.texCoord0 = input.texCoord0.xyzw;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Subtract_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A - B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            UnityTexture2D _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.tex, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.samplerstate, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_R_4_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.r;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_G_5_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.g;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_B_6_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.b;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_A_7_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.a;
            float4 _Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_FresnelColor) : _FresnelColor;
            float _Property_9858161811ac4df59c781d502277c701_Out_0_Float = _FresnelPower;
            float _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_9858161811ac4df59c781d502277c701_Out_0_Float, _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float);
            float4 _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4, (_FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float.xxxx), _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4);
            float4 _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4;
            Unity_Add_float4(_SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4, _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4, _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4);
            float4 _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4 = _FadeColor;
            float _Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float = _add;
            float _Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float = _multi;
            float _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float;
            Unity_Distance_float3(float3(0, 0, 0), SHADERGRAPH_OBJECT_POSITION, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float);
            float _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float;
            Unity_Multiply_float_float(_Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float);
            float _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float;
            Unity_Add_float(_Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float, _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float);
            float _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float;
            Unity_Saturate_float(_Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float, _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float);
            float4 _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4;
            Unity_Lerp_float4(_Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4, _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4, (_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float.xxxx), _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4);
            float4 _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_YGradientColor) : _YGradientColor;
            float _Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float = _YGradientOffset;
            float _Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float = _YGradientContrast;
            float3 _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3);
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_R_1_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[0];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[1];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_B_3_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[2];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_A_4_Float = 0;
            float _Add_310bc398208442b0994d7b94279e5463_Out_2_Float;
            Unity_Add_float(_Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float, _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float, _Add_310bc398208442b0994d7b94279e5463_Out_2_Float);
            float _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float;
            Unity_Saturate_float(_Add_310bc398208442b0994d7b94279e5463_Out_2_Float, _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float);
            float _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float;
            Unity_OneMinus_float(_Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float, _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float);
            float4 _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4;
            Unity_Lerp_float4(_Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4, _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4, (_OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float.xxxx), _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4);
            UnityTexture2D _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.tex, _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.samplerstate, _Property_1cb96bc574d047d2bb95552dcfded080_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4);
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_R_4_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.r;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_G_5_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.g;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_B_6_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.b;
            float _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_A_7_Float = _SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.a;
            float _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.98, _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float);
            float _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float;
            Unity_OneMinus_float(_Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float, _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float);
            float4 _Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_EmmisionColor) : _EmmisionColor;
            UnityTexture2D _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emmisive);
            float4 _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.tex, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.samplerstate, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_R_4_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.r;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_G_5_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.g;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_B_6_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.b;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_A_7_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.a;
            float4 _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4, _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4, _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4);
            float4 _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4;
            Unity_Multiply_float4_float4((_OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float.xxxx), _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4, _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4);
            float _Property_a3fb2fb19c3d4019ab2001ddb7f96619_Out_0_Float = _Metallic;
            UnityTexture2D _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MetallicSmoothness);
            float4 _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.tex, _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.samplerstate, _Property_28a6cbdac6054f179b5a628ccbf33fe4_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_R_4_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.r;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_G_5_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.g;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_B_6_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.b;
            float _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_A_7_Float = _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4.a;
            float4 _Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4;
            Unity_Multiply_float4_float4((_Property_a3fb2fb19c3d4019ab2001ddb7f96619_Out_0_Float.xxxx), _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_RGBA_0_Vector4, _Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4);
            float _Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.5, _Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float);
            float4 _Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4;
            Unity_Subtract_float4(_Multiply_c3885efdc0c54e4bbefcf3102cb9ca43_Out_2_Vector4, (_Multiply_2092fff13d8e43d3be86a3e14fa2c609_Out_2_Float.xxxx), _Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4);
            float _Property_f7d8101ead2a4f3eb4afde73ea6530cd_Out_0_Float = _Smothness;
            float _Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float;
            Unity_Multiply_float_float(_Property_f7d8101ead2a4f3eb4afde73ea6530cd_Out_0_Float, _SampleTexture2D_177dc785cf4845489fe678ddeb21e78a_A_7_Float, _Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float);
            float _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.4, _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float);
            float _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float;
            Unity_Subtract_float(_Multiply_1602ce9630374a2d90b72deeb85af59e_Out_2_Float, _Multiply_7679c8db36174800b7fc1c4110b12959_Out_2_Float, _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float);
            surface.BaseColor = (_Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_60d6713c01624aab81a6ede90b8d47f8_RGBA_0_Vector4.xyz);
            surface.Emission = (_Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4.xyz);
            surface.Metallic = (_Subtract_3109595f22d64a5ea63f12f6c1e1f6d7_Out_2_Vector4).x;
            surface.Smoothness = _Subtract_25165ad0e6a940658e734f15514f3ce0_Out_2_Float;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
            output.WorldSpaceViewDirection = GetWorldSpaceNormalizeViewDir(input.positionWS);
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
             float3 TimeParameters;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
             float3 TimeParameters;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
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
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
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
             float3 WorldSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
             float4 texCoord2 : INTERP2;
             float3 positionWS : INTERP3;
             float3 normalWS : INTERP4;
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
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            UnityTexture2D _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.tex, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.samplerstate, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_R_4_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.r;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_G_5_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.g;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_B_6_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.b;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_A_7_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.a;
            float4 _Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_FresnelColor) : _FresnelColor;
            float _Property_9858161811ac4df59c781d502277c701_Out_0_Float = _FresnelPower;
            float _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_9858161811ac4df59c781d502277c701_Out_0_Float, _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float);
            float4 _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4, (_FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float.xxxx), _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4);
            float4 _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4;
            Unity_Add_float4(_SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4, _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4, _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4);
            float4 _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4 = _FadeColor;
            float _Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float = _add;
            float _Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float = _multi;
            float _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float;
            Unity_Distance_float3(float3(0, 0, 0), SHADERGRAPH_OBJECT_POSITION, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float);
            float _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float;
            Unity_Multiply_float_float(_Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float);
            float _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float;
            Unity_Add_float(_Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float, _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float);
            float _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float;
            Unity_Saturate_float(_Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float, _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float);
            float4 _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4;
            Unity_Lerp_float4(_Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4, _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4, (_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float.xxxx), _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4);
            float4 _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_YGradientColor) : _YGradientColor;
            float _Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float = _YGradientOffset;
            float _Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float = _YGradientContrast;
            float3 _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3);
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_R_1_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[0];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[1];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_B_3_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[2];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_A_4_Float = 0;
            float _Add_310bc398208442b0994d7b94279e5463_Out_2_Float;
            Unity_Add_float(_Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float, _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float, _Add_310bc398208442b0994d7b94279e5463_Out_2_Float);
            float _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float;
            Unity_Saturate_float(_Add_310bc398208442b0994d7b94279e5463_Out_2_Float, _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float);
            float _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float;
            Unity_OneMinus_float(_Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float, _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float);
            float4 _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4;
            Unity_Lerp_float4(_Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4, _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4, (_OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float.xxxx), _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4);
            float _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float;
            Unity_Multiply_float_float(_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float, 0.98, _Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float);
            float _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float;
            Unity_OneMinus_float(_Multiply_6fdae24a78a0440eb2a9a728fcbd10eb_Out_2_Float, _OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float);
            float4 _Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_EmmisionColor) : _EmmisionColor;
            UnityTexture2D _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emmisive);
            float4 _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.tex, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.samplerstate, _Property_a0a4ccf1ba2d4723910dade9d000a9eb_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_R_4_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.r;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_G_5_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.g;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_B_6_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.b;
            float _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_A_7_Float = _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4.a;
            float4 _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_9021ab9ce3a945448c0120d31d73a9d0_Out_0_Vector4, _SampleTexture2D_97778fffcafc42e0b7f7e735ac8dcf18_RGBA_0_Vector4, _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4);
            float4 _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4;
            Unity_Multiply_float4_float4((_OneMinus_a22428e01ec8455b9161e984ec2493dc_Out_1_Float.xxxx), _Multiply_c1a855b3fc7f4b45af4be1bae29e2844_Out_2_Vector4, _Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4);
            surface.BaseColor = (_Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4.xyz);
            surface.Emission = (_Multiply_c856f6b2b6d6438cae9359d9160a6bc8_Out_2_Vector4.xyz);
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        
        
            output.WorldSpaceViewDirection = GetWorldSpaceNormalizeViewDir(input.positionWS);
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
             float3 TimeParameters;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
             float3 TimeParameters;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
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
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 texCoord0;
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
             float3 WorldSpaceNormal;
             float3 WorldSpaceViewDirection;
             float3 WorldSpacePosition;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 TimeParameters;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float3 positionWS : INTERP1;
             float3 normalWS : INTERP2;
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
            output.texCoord0 = input.texCoord0.xyzw;
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
        float4 _Normal_TexelSize;
        float4 _MetallicSmoothness_TexelSize;
        float4 _Emmisive_TexelSize;
        float4 _MainTex_TexelSize;
        float4 _EmmisionColor;
        float _RotatinSpeed;
        float _Smothness;
        float _YGradientContrast;
        float _YGradientOffset;
        float4 _FresnelColor;
        float4 _YGradientColor;
        float _FresnelPower;
        float _Fade;
        float4 _FadeColor;
        float _multi;
        float _add;
        float _Metallic;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        TEXTURE2D(_MetallicSmoothness);
        SAMPLER(sampler_MetallicSmoothness);
        TEXTURE2D(_Emmisive);
        SAMPLER(sampler_Emmisive);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
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
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Rotate_About_Axis_Radians_float(float3 In, float3 Axis, float Rotation, out float3 Out)
        {
            float s = sin(Rotation);
            float c = cos(Rotation);
            float one_minus_c = 1.0 - c;
        
            Axis = normalize(Axis);
        
            float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                      one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                      one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                    };
        
            Out = mul(rot_mat,  In);
        }
        
        void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
        {
            Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
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
            float _Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float = _RotatinSpeed;
            float _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float;
            Unity_Multiply_float_float(_Property_a9b42aa21cfe4c76bf7b5ec043c200cb_Out_0_Float, IN.TimeParameters.x, _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float);
            float3 _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpacePosition, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3);
            float3 _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
            Unity_Rotate_About_Axis_Radians_float(IN.ObjectSpaceNormal, float3 (0, 1, 0), _Multiply_bfa153920a6e46178763fe2900a0507f_Out_2_Float, _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3);
            description.Position = _RotateAboutAxis_50e8c104c1cb44b09d00381723393a65_Out_3_Vector3;
            description.Normal = _RotateAboutAxis_e115170c0c7f4d338a2e8ab4d67a8cf3_Out_3_Vector3;
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
            UnityTexture2D _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.tex, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.samplerstate, _Property_8561f41f7bdf4395a646f21cb869bd00_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_R_4_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.r;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_G_5_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.g;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_B_6_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.b;
            float _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_A_7_Float = _SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4.a;
            float4 _Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_FresnelColor) : _FresnelColor;
            float _Property_9858161811ac4df59c781d502277c701_Out_0_Float = _FresnelPower;
            float _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float;
            Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_9858161811ac4df59c781d502277c701_Out_0_Float, _FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float);
            float4 _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_4b170df0f8cc414cbdce297a72d56b0d_Out_0_Vector4, (_FresnelEffect_1c8277d49a0641babb1014a9406a26d4_Out_3_Float.xxxx), _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4);
            float4 _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4;
            Unity_Add_float4(_SampleTexture2D_51cd7ee9a7034d1b90783a73fa5ec851_RGBA_0_Vector4, _Multiply_e2524c0f10314c2aabc2359bcce120c5_Out_2_Vector4, _Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4);
            float4 _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4 = _FadeColor;
            float _Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float = _add;
            float _Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float = _multi;
            float _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float;
            Unity_Distance_float3(float3(0, 0, 0), SHADERGRAPH_OBJECT_POSITION, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float);
            float _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float;
            Unity_Multiply_float_float(_Property_a528f65acc9244c9897a6a3b45303ba7_Out_0_Float, _Distance_2dc08a55020040ef8032e1e7d0282fe7_Out_2_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float);
            float _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float;
            Unity_Add_float(_Property_305d2547d0134e3288bdc7c89869a175_Out_0_Float, _Multiply_52a0135066314134a04cd1f79b1e5382_Out_2_Float, _Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float);
            float _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float;
            Unity_Saturate_float(_Add_b0813cf7e07848dc81daee9256fa1094_Out_2_Float, _Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float);
            float4 _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4;
            Unity_Lerp_float4(_Add_4265d22a066a446c8e35349d1ce4b340_Out_2_Vector4, _Property_41e6ca7c1b4e42b1a8c1b0ce66553481_Out_0_Vector4, (_Saturate_6a945f22ca8e470e9f1ec3bdc6480ea0_Out_1_Float.xxxx), _Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4);
            float4 _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_YGradientColor) : _YGradientColor;
            float _Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float = _YGradientOffset;
            float _Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float = _YGradientContrast;
            float3 _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Property_a20e7f5d92c84ae1862e372c1a001597_Out_0_Float.xxx), IN.WorldSpacePosition, _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3);
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_R_1_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[0];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[1];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_B_3_Float = _Multiply_3785a6ab9e61488fa8fe78998503ff08_Out_2_Vector3[2];
            float _Split_4b7e4dc2b66c41df81058082ab9b61b9_A_4_Float = 0;
            float _Add_310bc398208442b0994d7b94279e5463_Out_2_Float;
            Unity_Add_float(_Property_10a51bcafc3348ad91b5b5f7fc90aab5_Out_0_Float, _Split_4b7e4dc2b66c41df81058082ab9b61b9_G_2_Float, _Add_310bc398208442b0994d7b94279e5463_Out_2_Float);
            float _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float;
            Unity_Saturate_float(_Add_310bc398208442b0994d7b94279e5463_Out_2_Float, _Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float);
            float _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float;
            Unity_OneMinus_float(_Saturate_e4b82998b08142ce8e8c4735d6d343f3_Out_1_Float, _OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float);
            float4 _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4;
            Unity_Lerp_float4(_Lerp_5f1f6e89e2524cecad5258b9f95e150a_Out_3_Vector4, _Property_e8a7dabdd44849879d2fbbca73607827_Out_0_Vector4, (_OneMinus_6e358830cb794a7991e7b2677666921a_Out_1_Float.xxxx), _Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4);
            surface.BaseColor = (_Lerp_ded6de9e38a449a5b22e9e550d259c2c_Out_3_Vector4.xyz);
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
            output.TimeParameters =                             _TimeParameters.xyz;
        
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
        
            
        
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        
        
            output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        
        
            output.WorldSpaceViewDirection = GetWorldSpaceNormalizeViewDir(input.positionWS);
            output.WorldSpacePosition = input.positionWS;
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
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
