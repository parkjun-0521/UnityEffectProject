// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_Shokewave04"
{
	Properties
	{
		_Opacity( "Opacity", Range( 0, 10 ) ) = 0
		_Main_Texture( "Main_Texture", 2D ) = "white" {}
		[HDR] _Main_Color( "Main_Color", Color ) = ( 1, 1, 1, 0 )
		_Main_Power( "Main_Power", Float ) = 1
		_Main_Ins( "Main_Ins", Float ) = 0
		_Main_UPanner( "Main_UPanner", Float ) = 0
		_Main_VPanner( "Main_VPanner", Float ) = 0
		_Main_UOffset( "Main_UOffset", Float ) = 0
		_Main_VOffeset( "Main_VOffeset", Float ) = 0
		_Main_VPower( "Main_VPower", Float ) = 1
		_Sub_Texture( "Sub_Texture", 2D ) = "white" {}
		[Toggle( _INVERSE_ON )] _Inverse( "Inverse", Float ) = 0
		[HDR] _Sub_Tex_Color( "Sub_Tex_Color", Color ) = ( 1, 1, 1, 0 )
		_SubTex_Power( "SubTex_Power", Range( 1, 10 ) ) = 1
		_SubTex_Ins( "SubTex_Ins", Float ) = 0
		_SubTex_UPanner( "SubTex_UPanner", Float ) = 0
		_SubTex_VPanner( "SubTex_VPanner", Float ) = 0.5
		_Noise_Texture( "Noise_Texture", 2D ) = "bump" {}
		_Noise_Str( "Noise_Str", Float ) = 0
		_Noise_UOffeset( "Noise_UOffeset", Float ) = 0
		_Noise_VOffeset( "Noise_VOffeset", Float ) = 0
		_Noise_UPanner( "Noise_UPanner", Float ) = 0
		_Noise_VPanner( "Noise_VPanner", Float ) = 0.5
		_Dissolve_Texture( "Dissolve_Texture", 2D ) = "white" {}
		_Dissolve_Offset( "Dissolve_Offset", Range( -1, 1 ) ) = 0.1521739
		_Dissolve_UOffeset( "Dissolve_UOffeset", Float ) = 0
		_Dissolve_VOffeset( "Dissolve_VOffeset", Float ) = 0
		_Dissolve_UPanner( "Dissolve_UPanner", Float ) = 0
		_Dissolve_VPanner( "Dissolve_VPanner", Float ) = 0.5
		_Mask_Texture( "Mask_Texture", 2D ) = "white" {}
		_Mask_Range( "Mask_Range", Range( 1, 10 ) ) = 0
		[HDR] _Outline_Color( "Outline_Color", Color ) = ( 1, 0, 0, 0 )
		_Outline_Ceil_Count( "Outline_Ceil_Count", Float ) = 5
		_Outline_Power( "Outline_Power", Float ) = 1.01
		_Rotation( "Rotation", Float ) = 1
		[Toggle( _USE_CUSTOM_ON )] _Use_Custom( "Use_Custom", Float ) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _Src( "Src", Float ) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _Dst( "Dst", Float ) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _CullMode( "CullMode", Float ) = 0
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma shader_feature_local _INVERSE_ON
		#define ASE_VERSION 19901
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv3_texcoord3;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float _Dst;
		uniform float _CullMode;
		uniform float _Src;
		uniform float4 _Outline_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_UOffeset;
		uniform float _Noise_VOffeset;
		uniform float _Rotation;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_VPower;
		uniform float _Main_UOffset;
		uniform float _Main_VOffeset;
		uniform float _Outline_Ceil_Count;
		uniform float _Outline_Power;
		uniform float4 _Sub_Tex_Color;
		uniform sampler2D _Sub_Texture;
		uniform float _SubTex_UPanner;
		uniform float _SubTex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _SubTex_Power;
		uniform float _SubTex_Ins;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Range;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve_UOffeset;
		uniform float _Dissolve_VOffeset;
		uniform float _Dissolve_Offset;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult47 = (float4(_Main_UPanner , _Main_VPanner , 0.0 , 0.0));
			float4 appendResult51 = (float4(_Noise_UPanner , _Noise_VPanner , 0.0 , 0.0));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner53 = ( 1.0 * _Time.y * appendResult51.xy + uv_Noise_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch88 = i.uv3_texcoord3.x;
			#else
				float staticSwitch88 = _Noise_VOffeset;
			#endif
			float4 appendResult89 = (float4(_Noise_UOffeset , staticSwitch88 , 0.0 , 0.0));
			float2 temp_output_90_0 = (panner53*1.0 + appendResult89.xy);
			float temp_output_152_0 = (temp_output_90_0).y;
			float2 appendResult157 = (float2(( (temp_output_90_0).x + ( temp_output_152_0 * _Rotation ) ) , temp_output_152_0));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult133 = (float2(uv_Main_Texture.x , pow( uv_Main_Texture.y , _Main_VPower )));
			float2 panner44 = ( 1.0 * _Time.y * appendResult47.xy + ( ( (UnpackNormal( tex2D( _Noise_Texture, appendResult157 ) )).xy * _Noise_Str ) + appendResult133 ));
			float temp_output_146_0 = (panner44).y;
			float2 appendResult150 = (float2(( (panner44).x + ( temp_output_146_0 * _Rotation ) ) , temp_output_146_0));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch79 = i.uv2_texcoord2.y;
			#else
				float staticSwitch79 = _Main_VOffeset;
			#endif
			float4 appendResult85 = (float4(_Main_UOffset , staticSwitch79 , 0.0 , 0.0));
			float4 tex2DNode5 = tex2D( _Main_Texture, (appendResult150*1.0 + appendResult85.xy) );
			float temp_output_102_0 = ( ceil( ( tex2DNode5.r * _Outline_Ceil_Count ) ) / _Outline_Ceil_Count );
			float4 appendResult174 = (float4(_SubTex_UPanner , _SubTex_VPanner , 0.0 , 0.0));
			float2 uv_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner176 = ( 1.0 * _Time.y * appendResult174.xy + uv_Sub_Texture);
			float temp_output_179_0 = (panner176).y;
			float2 appendResult183 = (float2(( (panner176).x + ( temp_output_179_0 * 0.0 * _Rotation ) ) , temp_output_179_0));
			float4 tex2DNode163 = tex2D( _Sub_Texture, (appendResult183*1.0 + float2( 0,0 )) );
			#ifdef _INVERSE_ON
				float staticSwitch164 = ( 1.0 - tex2DNode163.r );
			#else
				float staticSwitch164 = tex2DNode163.r;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch80 = i.uv2_texcoord2.z;
			#else
				float staticSwitch80 = _Main_Ins;
			#endif
			o.Emission = ( ( _Outline_Color * pow( saturate( ( ( 1.0 - temp_output_102_0 ) * temp_output_102_0 ) ) , _Outline_Power ) ) + ( ( ( _Sub_Tex_Color * ( pow( staticSwitch164 , _SubTex_Power ) * _SubTex_Ins ) ) + ( ( pow( tex2DNode5.r , _Main_Power ) * staticSwitch80 ) * _Main_Color ) ) * i.vertexColor ) ).rgb;
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float4 appendResult62 = (float4(_Dissolve_UPanner , _Dissolve_VPanner , 0.0 , 0.0));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner64 = ( 1.0 * _Time.y * appendResult62.xy + uv_Dissolve_Texture);
			float temp_output_158_0 = (panner64).y;
			float2 appendResult162 = (float2(( (panner64).x + ( temp_output_158_0 * _Rotation ) ) , temp_output_158_0));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch94 = i.uv3_texcoord3.y;
			#else
				float staticSwitch94 = _Dissolve_VOffeset;
			#endif
			float4 appendResult97 = (float4(_Dissolve_UOffeset , staticSwitch94 , 0.0 , 0.0));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch81 = i.uv2_texcoord2.w;
			#else
				float staticSwitch81 = _Dissolve_Offset;
			#endif
			o.Alpha = saturate( ( i.vertexColor.a * ( ( ( tex2DNode5.r * saturate( pow( tex2D( _Mask_Texture, uv_Mask_Texture ).r , _Mask_Range ) ) ) * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, (appendResult162*1.0 + appendResult97.xy) ).r + staticSwitch81 ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;71;-5286.654,-944;Inherit;False;1898.631;528.8831;Noise;13;57;55;54;90;89;53;92;88;52;51;87;49;50;Noise;1,1,0,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;86;-4352,-208;Inherit;True;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;87;-5152,-560;Inherit;False;Property;_Noise_VOffeset;Noise_VOffeset;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-5216,-736;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;21;0;Create;True;0;0;0;False;0;False;0;-0.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-5216,-656;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;22;0;Create;True;0;0;0;False;0;False;0.5;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;88;-4976,-560;Inherit;False;Property;_Use_Custom;Use_Custom;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;92;-4864,-656;Inherit;False;Property;_Noise_UOffeset;Noise_UOffeset;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-5008,-736;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-5072,-864;Inherit;False;0;54;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;89;-4672,-656;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-4816,-864;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;90;-4528,-864;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;-4544,-1168;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;-4288,-2512;Inherit;False;Property;_Rotation;Rotation;34;0;Create;True;0;0;0;False;0;False;1;1.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;154;-4224,-1504;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;155;-4544,-1376;Inherit;True;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;156;-4224,-1728;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;157;-3936,-1424;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-3920,-896;Inherit;True;Property;_Noise_Texture;Noise_Texture;17;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;93af8c0c4529885418a55118e8d82091;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-3744,-416;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;135;-3776,-256;Inherit;False;Property;_Main_VPower;Main_VPower;9;0;Create;True;0;0;0;False;0;False;1;1.93;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;72;-3280,-480;Inherit;False;2403.692;577.2638;Main;18;38;80;36;35;37;34;33;5;82;85;79;47;58;83;84;48;45;133;Main;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-3632,-896;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-3600,-816;Inherit;False;Property;_Noise_Str;Noise_Str;18;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;134;-3536,-288;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-3344,-896;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-3184,-272;Inherit;False;Property;_Main_UPanner;Main_UPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-3184,-192;Inherit;False;Property;_Main_VPanner;Main_VPanner;6;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;133;-3344,-400;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-2944,-400;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-2976,-272;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;173;-3472,-1840;Inherit;False;Property;_SubTex_UPanner;SubTex_UPanner;15;0;Create;True;0;0;0;False;0;False;0;-0.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;177;-3472,-1760;Inherit;False;Property;_SubTex_VPanner;SubTex_VPanner;16;0;Create;True;0;0;0;False;0;False;0.5;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-2816,-800;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;174;-3264,-1840;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;175;-3344,-2032;Inherit;False;0;163;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;-2592,-848;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-2836.403,608;Inherit;False;2004.361;460.7547;Dissolve;15;67;65;81;59;66;64;63;62;61;60;96;93;94;95;97;Dissolve;0,0,1,1;0;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;176;-3024,-2032;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;77;-3664,176;Inherit;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;84;-3264,-32;Inherit;False;Property;_Main_VOffeset;Main_VOffeset;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;-2272,-1184;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;-2592,-1056;Inherit;True;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-2640,800;Inherit;False;Property;_Dissolve_UPanner;Dissolve_UPanner;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-2640,880;Inherit;False;Property;_Dissolve_VPanner;Dissolve_VPanner;28;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;179;-2768,-1904;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;83;-3008,-128;Inherit;False;Property;_Main_UOffset;Main_UOffset;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;79;-3088,-32;Inherit;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;-2272,-1408;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-2416,800;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-2480,672;Inherit;False;0;59;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;180;-2448,-2240;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;181;-2768,-2112;Inherit;True;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;85;-2832,-128;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;-1984,-1104;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-2224,672;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;182;-2448,-2464;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;82;-2608,-400;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;158;-1904,1648;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;183;-2256,-2064;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;70;-2320,128;Inherit;False;1462.771;426.6414;Mask;8;73;41;40;32;31;30;29;28;Mask;1,0.5,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;93;-2608,976;Inherit;False;Property;_Dissolve_VOffeset;Dissolve_VOffeset;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-2384,-416;Inherit;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;e10898a30a88ad440a4fb66ca6e7959e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;98;-2176,-592;Inherit;False;Property;_Outline_Ceil_Count;Outline_Ceil_Count;32;0;Create;True;0;0;0;False;0;False;5;1.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;159;-1584,1312;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;160;-1904,1440;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;178;-1920,-2000;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;73;-2304,176;Inherit;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;95;-2272,880;Inherit;False;Property;_Dissolve_UOffeset;Dissolve_UOffeset;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;94;-2368,976;Inherit;False;Property;_Use_Custom;Use_Custom;24;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;100;-1904,-704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;161;-1584,1088;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;163;-1744,-1696;Inherit;True;Property;_Sub_Texture;Sub_Texture;10;0;Create;True;0;0;0;False;0;False;-1;f2e5e3def67a9f842931da78700f9160;f2e5e3def67a9f842931da78700f9160;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-2080,176;Inherit;True;Property;_Mask_Texture;Mask_Texture;29;0;Create;True;0;0;0;False;0;False;-1;None;5186ad1d6a4d8f843b306ceebf8d6dfd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-2080,368;Inherit;False;Property;_Mask_Range;Mask_Range;30;0;Create;True;0;0;0;False;0;False;0;6;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;97;-2064,880;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CeilOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;101;-1760,-704;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;162;-1296,1392;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;165;-1456,-1600;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;-1776,224;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-1824,880;Inherit;False;Property;_Dissolve_Offset;Dissolve_Offset;24;0;Create;True;0;0;0;False;0;False;0.1521739;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;96;-1872,672;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;102;-1568,-704;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-1952,-64;Inherit;False;Property;_Main_Ins;Main_Ins;4;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-1856,-192;Inherit;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;0;False;0;False;1;1.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;164;-1296,-1696;Inherit;False;Property;_Inverse;Inverse;11;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;167;-1184,-1568;Inherit;False;Property;_SubTex_Power;SubTex_Power;13;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-1584,656;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;23;0;Create;True;0;0;0;False;0;False;-1;bb360f7fb669e824fb85c785fbe9d8e9;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-1552,224;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;81;-1536,880;Inherit;False;Property;_Use_Custom;Use_Custom;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;136;-1328,-832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;-1600,-368;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;80;-1760,-80;Inherit;False;Property;_Use_Custom;Use_Custom;22;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;166;-928,-1696;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;169;-864,-1584;Inherit;False;Property;_SubTex_Ins;SubTex_Ins;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-1280,704;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;-1328,208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-1392,432;Inherit;False;Property;_Opacity;Opacity;0;0;Create;True;0;0;0;False;0;False;0;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;137;-1168,-736;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;-1344,-368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-1344,-144;Inherit;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.3813932,0.9643359,2.608238,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;168;-688,-1696;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;170;-704,-1456;Inherit;False;Property;_Sub_Tex_Color;Sub_Tex_Color;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-1056,704;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-1104,208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;-912,-736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;140;-944,-640;Inherit;False;Property;_Outline_Power;Outline_Power;33;0;Create;True;0;0;0;False;0;False;1.01;0.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-1104,-368;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;171;-480,-1712;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-704,16;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;68;-704,208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;-736,-736;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;141;-736,-944;Inherit;False;Property;_Outline_Color;Outline_Color;31;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;0,29.16469,9.950705,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;172;-31.66431,-1041.07;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;240,16;Inherit;False;162;257;Setting;3;2;1;3;Setting;1,0.5896168,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;76;-416,208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;75;-448,-192;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;142;-496,-768;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;256,192;Inherit;False;Property;_Dst;Dst;38;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;256,64;Inherit;False;Property;_CullMode;CullMode;39;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;256,128;Inherit;False;Property;_Src;Src;37;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-160,208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;-208,-608;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;0,16;Float;False;True;-1;2;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_Shokewave04;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;True;_Src;10;True;_Dst;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;36;-1;-1;-1;0;False;0;0;True;_CullMode;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;88;1;87;0
WireConnection;88;0;86;1
WireConnection;51;0;49;0
WireConnection;51;1;50;0
WireConnection;89;0;92;0
WireConnection;89;1;88;0
WireConnection;53;0;52;0
WireConnection;53;2;51;0
WireConnection;90;0;53;0
WireConnection;90;2;89;0
WireConnection;152;0;90;0
WireConnection;154;0;152;0
WireConnection;154;1;149;0
WireConnection;155;0;90;0
WireConnection;156;0;155;0
WireConnection;156;1;154;0
WireConnection;157;0;156;0
WireConnection;157;1;152;0
WireConnection;54;1;157;0
WireConnection;55;0;54;0
WireConnection;134;0;43;2
WireConnection;134;1;135;0
WireConnection;56;0;55;0
WireConnection;56;1;57;0
WireConnection;133;0;43;1
WireConnection;133;1;134;0
WireConnection;58;0;56;0
WireConnection;58;1;133;0
WireConnection;47;0;45;0
WireConnection;47;1;48;0
WireConnection;44;0;58;0
WireConnection;44;2;47;0
WireConnection;174;0;173;0
WireConnection;174;1;177;0
WireConnection;146;0;44;0
WireConnection;176;0;175;0
WireConnection;176;2;174;0
WireConnection;147;0;146;0
WireConnection;147;1;149;0
WireConnection;145;0;44;0
WireConnection;179;0;176;0
WireConnection;79;1;84;0
WireConnection;79;0;77;2
WireConnection;151;0;145;0
WireConnection;151;1;147;0
WireConnection;62;0;60;0
WireConnection;62;1;61;0
WireConnection;180;0;179;0
WireConnection;180;2;149;0
WireConnection;181;0;176;0
WireConnection;85;0;83;0
WireConnection;85;1;79;0
WireConnection;150;0;151;0
WireConnection;150;1;146;0
WireConnection;64;0;63;0
WireConnection;64;2;62;0
WireConnection;182;0;181;0
WireConnection;182;1;180;0
WireConnection;82;0;150;0
WireConnection;82;2;85;0
WireConnection;158;0;64;0
WireConnection;183;0;182;0
WireConnection;183;1;179;0
WireConnection;5;1;82;0
WireConnection;159;0;158;0
WireConnection;159;1;149;0
WireConnection;160;0;64;0
WireConnection;178;0;183;0
WireConnection;94;1;93;0
WireConnection;94;0;86;2
WireConnection;100;0;5;1
WireConnection;100;1;98;0
WireConnection;161;0;160;0
WireConnection;161;1;159;0
WireConnection;163;1;178;0
WireConnection;28;1;73;0
WireConnection;97;0;95;0
WireConnection;97;1;94;0
WireConnection;101;0;100;0
WireConnection;162;0;161;0
WireConnection;162;1;158;0
WireConnection;165;0;163;1
WireConnection;30;0;28;1
WireConnection;30;1;29;0
WireConnection;96;0;162;0
WireConnection;96;2;97;0
WireConnection;102;0;101;0
WireConnection;102;1;98;0
WireConnection;164;1;163;1
WireConnection;164;0;165;0
WireConnection;59;1;96;0
WireConnection;31;0;30;0
WireConnection;81;1;66;0
WireConnection;81;0;77;4
WireConnection;136;0;102;0
WireConnection;33;0;5;1
WireConnection;33;1;35;0
WireConnection;80;1;36;0
WireConnection;80;0;77;3
WireConnection;166;0;164;0
WireConnection;166;1;167;0
WireConnection;65;0;59;1
WireConnection;65;1;81;0
WireConnection;32;0;5;1
WireConnection;32;1;31;0
WireConnection;137;0;136;0
WireConnection;137;1;102;0
WireConnection;34;0;33;0
WireConnection;34;1;80;0
WireConnection;168;0;166;0
WireConnection;168;1;169;0
WireConnection;67;0;65;0
WireConnection;41;0;32;0
WireConnection;41;1;40;0
WireConnection;144;0;137;0
WireConnection;37;0;34;0
WireConnection;37;1;38;0
WireConnection;171;0;170;0
WireConnection;171;1;168;0
WireConnection;68;0;41;0
WireConnection;68;1;67;0
WireConnection;139;0;144;0
WireConnection;139;1;140;0
WireConnection;172;0;171;0
WireConnection;172;1;37;0
WireConnection;76;0;74;4
WireConnection;76;1;68;0
WireConnection;75;0;172;0
WireConnection;75;1;74;0
WireConnection;142;0;141;0
WireConnection;142;1;139;0
WireConnection;42;0;76;0
WireConnection;143;0;142;0
WireConnection;143;1;75;0
WireConnection;0;2;143;0
WireConnection;0;9;42;0
ASEEND*/
//CHKSM=142F46F639B1DDC04D11FCD5D1351C5DD1DFF546