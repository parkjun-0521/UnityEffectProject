// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/Study/08Week_Bubble"
{
	Properties
	{
		_Fade_Distance( "Fade_Distance", Float ) = 0
		[HDR] _FadeEdge_Color( "FadeEdge_Color", Color ) = ( 1, 1, 1, 0 )
		_Fresnel_Power( "Fresnel_Power", Range( 1, 10 ) ) = 1
		_Fresnel_Scale( "Fresnel_Scale", Range( 0, 1 ) ) = 1
		[HDR] _Fresnel_InColor( "Fresnel_InColor", Color ) = ( 1, 1, 1, 0 )
		[HDR] _Fresnel_OutColor( "Fresnel_OutColor", Color ) = ( 1, 0, 0, 0 )
		_Main_Texture( "Main_Texture", 2D ) = "white" {}
		_Main_UPanner( "Main_UPanner", Float ) = 0
		_Main_VPanner( "Main_VPanner", Float ) = 0
		_Noise_Textture( "Noise_Textture", 2D ) = "bump" {}
		_Noise_UPanner( "Noise_UPanner", Float ) = 0
		_Noise_VPanner( "Noise_VPanner", Float ) = 1
		_Ref_Scale( "Ref_Scale", Range( 0, 1 ) ) = 0.3269673
		_Cromatic( "Cromatic", Float ) = 0.05
		_Vertex_Normal_Texture( "Vertex_Normal_Texture", 2D ) = "white" {}
		_Vertex_Normal( "Vertex_Normal", Range( 0, 100 ) ) = 0
		_Vertex_UPanner( "Vertex_UPanner", Float ) = 0
		_Vertex_VPanner( "Vertex_VPanner", Float ) = 0
		_World_Cube( "World_Cube", CUBE ) = "white" {}
		_Refection( "Refection", Range( 0, 1 ) ) = 1
		_Merallic( "Merallic", Float ) = 0
		_Smoothness( "Smoothness", Float ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19901
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float3 worldRefl;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Vertex_Normal_Texture;
		uniform float _Vertex_UPanner;
		uniform float _Vertex_VPanner;
		uniform float4 _Vertex_Normal_Texture_ST;
		uniform float _Vertex_Normal;
		uniform float4 _FadeEdge_Color;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;
		uniform samplerCUBE _World_Cube;
		uniform float _Refection;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _Noise_Textture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Textture_ST;
		uniform float _Ref_Scale;
		uniform float4 _Fresnel_InColor;
		uniform float4 _Fresnel_OutColor;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Power;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Cromatic;
		uniform float _Merallic;
		uniform float _Smoothness;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult51 = (float2(_Vertex_UPanner , _Vertex_VPanner));
			float2 uv_Vertex_Normal_Texture = v.texcoord.xy * _Vertex_Normal_Texture_ST.xy + _Vertex_Normal_Texture_ST.zw;
			float2 panner48 = ( 1.0 * _Time.y * appendResult51 + uv_Vertex_Normal_Texture);
			float3 ase_normalOS = v.normal.xyz;
			v.vertex.xyz += ( ( tex2Dlod( _Vertex_Normal_Texture, float4( panner48, 0, 0.0) ) * float4( ase_normalOS , 0.0 ) ) * _Vertex_Normal ).rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_cast_0 = (0.0).xxxx;
			float4 ase_positionSS = float4( i.screenPos.xyz , i.screenPos.w + 1e-7 );
			float4 ase_positionSSNorm = ase_positionSS / ase_positionSS.w;
			ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
			float screenDepth66 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_positionSSNorm.xy ));
			float distanceDepth66 = abs( ( screenDepth66 - LinearEyeDepth( ase_positionSSNorm.z ) ) / ( _Fade_Distance ) );
			float4 lerpResult70 = lerp( _FadeEdge_Color , temp_cast_0 , saturate( distanceDepth66 ));
			float3 ase_reflectionWS = i.worldRefl;
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_positionSS );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult39 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Textture = i.uv_texcoord * _Noise_Textture_ST.xy + _Noise_Textture_ST.zw;
			float2 panner40 = ( 1.0 * _Time.y * appendResult39 + uv_Noise_Textture);
			float4 screenColor31 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _Noise_Textture, panner40 ), _Ref_Scale ) , 0.0 ) ).xy);
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float3 ase_normalWS = i.worldNormal;
			float fresnelNdotV1 = dot( ase_normalWS, ase_viewDirWS );
			float fresnelNode1 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV1, _Fresnel_Power ) );
			float temp_output_2_0 = saturate( fresnelNode1 );
			float2 appendResult20 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner16 = ( 1.0 * _Time.y * appendResult20 + uv_Main_Texture);
			float2 temp_cast_3 = (_Cromatic).xx;
			float3 appendResult28 = (float3(tex2D( _Main_Texture, ( panner16 - temp_cast_3 ) ).r , tex2D( _Main_Texture, panner16 ).g , tex2D( _Main_Texture, ( panner16 + _Cromatic ) ).b));
			float4 lerpResult10 = lerp( _Fresnel_InColor , _Fresnel_OutColor , float4( ( temp_output_2_0 * ( temp_output_2_0 + appendResult28 ) ) , 0.0 ));
			o.Emission = ( lerpResult70 + ( ( texCUBE( _World_Cube, ase_reflectionWS ) * _Refection ) + ( screenColor31 + lerpResult10 ) ) ).rgb;
			o.Metallic = _Merallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-2832,352;Inherit;False;1477.176;709.0014;Main;13;28;30;25;24;13;23;29;26;19;18;20;17;16;Main_Texture RGB 분리;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-2800,768;Inherit;False;Property;_Main_UPanner;Main_UPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-2800,832;Inherit;False;Property;_Main_VPanner;Main_VPanner;8;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-2672,640;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-2624,768;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-2208,0;Inherit;False;852;323;Main_Fresnel;4;8;9;1;2;외곽 라인 (Main_Fresnel);1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-2832,-880;Inherit;False;1476;531;Ref;10;31;35;32;33;34;40;38;39;36;37;굴절;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-2416,640;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-2400,816;Inherit;False;Property;_Cromatic;Cromatic;13;0;Create;True;0;0;0;False;0;False;0.05;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-2784,-544;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-2784,-464;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-2144,112;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;3;0;Create;True;0;0;0;False;0;False;1;0.616;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-2144,208;Inherit;False;Property;_Fresnel_Power;Fresnel_Power;2;0;Create;True;0;0;0;False;0;False;1;2.85;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-2128,512;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-2448,432;Inherit;True;Property;_Main_Texture;Main_Texture;6;0;Create;True;0;0;0;False;0;False;714f4664f55c45c46b53f75dcd662d4d;edf5781a5c61c924c8610f352884d5ff;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;-2112,816;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-2656,-672;Inherit;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-2592,-544;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-1952,432;Inherit;True;Property;_Main_Texture1111;Main_Texture1111;3;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-1952,624;Inherit;True;Property;_Main_Texture;Main_Texture1111;3;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;edf5781a5c61c924c8610f352884d5ff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-1952,816;Inherit;True;Property;_Main_Texture1;Main_Texture1111;3;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-1824,48;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-1312,592;Inherit;False;1412;459;Vertex_Normal;10;45;48;47;51;49;50;46;42;44;43;Vertex_Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;-2384,-544;Inherit;False;Property;_Ref_Scale;Ref_Scale;12;0;Create;True;0;0;0;False;0;False;0.3269673;0.015;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-2288,-672;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-1568,480;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-1520,48;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-1264,768;Inherit;False;Property;_Vertex_UPanner;Vertex_UPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-1264,848;Inherit;False;Property;_Vertex_VPanner;Vertex_VPanner;17;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-1312,-448;Inherit;False;292;445.3847;Color;2;11;12;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-1312,-896;Inherit;False;859;371;World_Refection;4;53;52;54;55;월드 반사;1,1,1,1;0;0
Node;AmplifyShaderEditor.GrabScreenPosition, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;-2016,-832;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;-2080,-672;Inherit;True;Property;_Noise_Textture;Noise_Textture;9;0;Create;True;0;0;0;False;0;False;-1;11dfe8ca7395e014dbce71f2e0f6ad12;93af8c0c4529885418a55118e8d82091;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-1248,112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-1040,768;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-1168,640;Inherit;False;0;45;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldReflectionVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-1248,-848;Inherit;True;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-1712,-832;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-1264,-208;Inherit;False;Property;_Fresnel_OutColor;Fresnel_OutColor;5;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;1.735083,3.537555,4.541205,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;-1264,-400;Inherit;False;Property;_Fresnel_InColor;Fresnel_InColor;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-1056,48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-1184,-1152;Inherit;False;Property;_Fade_Distance;Fade_Distance;0;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-848,640;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-1008,-848;Inherit;True;Property;_World_Cube;World_Cube;18;0;Create;True;0;0;0;False;0;False;-1;34a763168147f4182a21b9fd004d67de;66e51860485ae4048a30f7e029e65af7;True;0;False;white;Auto;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-1008,-640;Inherit;False;Property;_Refection;Refection;19;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-1568,-832;Inherit;False;Global;_GrabScreen0;Grab Screen 0;7;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-816,0;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-1008,-1152;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-656,640;Inherit;True;Property;_Vertex_Normal_Texture;Vertex_Normal_Texture;14;0;Create;True;0;0;0;False;0;False;-1;bb360f7fb669e824fb85c785fbe9d8e9;147d45afa3bdffc43b9d9808b0636126;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.NormalVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-560,864;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-672,-848;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-384,-80;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-752,-1168;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;68;-768,-1280;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-848,-1504;Inherit;False;Property;_FadeEdge_Color;FadeEdge_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;144,-528;Inherit;False;728;485;Fresnel_원리;4;3;4;5;6;Fresnel_원리;0,1,0.5017924,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-352,640;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-352,864;Inherit;False;Property;_Vertex_Normal;Vertex_Normal;15;0;Create;True;0;0;0;False;0;False;0;0.15;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;70;-592,-1296;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-272,-576;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;192,-480;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;192,-272;Inherit;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;464,-480;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;672,-480;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-80,640;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-112,64;Inherit;False;Property;_Smoothness;Smoothness;21;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-112,0;Inherit;False;Property;_Merallic;Merallic;20;0;Create;True;0;0;0;False;0;False;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;71;-112,-592;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;144,-32;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;JUNFX/Study/08Week_Bubble;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;18;0
WireConnection;20;1;19;0
WireConnection;16;0;17;0
WireConnection;16;2;20;0
WireConnection;29;0;16;0
WireConnection;29;1;26;0
WireConnection;30;0;16;0
WireConnection;30;1;26;0
WireConnection;39;0;36;0
WireConnection;39;1;37;0
WireConnection;13;0;23;0
WireConnection;13;1;29;0
WireConnection;24;0;23;0
WireConnection;24;1;16;0
WireConnection;25;0;23;0
WireConnection;25;1;30;0
WireConnection;1;2;8;0
WireConnection;1;3;9;0
WireConnection;40;0;38;0
WireConnection;40;2;39;0
WireConnection;28;0;13;1
WireConnection;28;1;24;2
WireConnection;28;2;25;3
WireConnection;2;0;1;0
WireConnection;33;1;40;0
WireConnection;33;5;34;0
WireConnection;14;0;2;0
WireConnection;14;1;28;0
WireConnection;51;0;49;0
WireConnection;51;1;50;0
WireConnection;35;0;32;0
WireConnection;35;1;33;0
WireConnection;15;0;2;0
WireConnection;15;1;14;0
WireConnection;48;0;47;0
WireConnection;48;2;51;0
WireConnection;53;1;52;0
WireConnection;31;0;35;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;10;2;15;0
WireConnection;66;0;65;0
WireConnection;45;1;48;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;41;0;31;0
WireConnection;41;1;10;0
WireConnection;67;0;66;0
WireConnection;46;0;45;0
WireConnection;46;1;42;0
WireConnection;70;0;69;0
WireConnection;70;1;68;0
WireConnection;70;2;67;0
WireConnection;56;0;54;0
WireConnection;56;1;41;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;6;0;5;0
WireConnection;44;0;46;0
WireConnection;44;1;43;0
WireConnection;71;0;70;0
WireConnection;71;1;56;0
WireConnection;0;2;71;0
WireConnection;0;3;57;0
WireConnection;0;4;58;0
WireConnection;0;11;44;0
ASEEND*/
//CHKSM=F597FB60FD6D68F931B3B088D385FE31B00D32FE