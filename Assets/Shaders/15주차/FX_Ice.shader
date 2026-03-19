// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_Ice"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Toggle( _USE_CUSTOM_ON )] _Use_Custom( "Use_Custom", Float ) = 0
		_Ice_Texture( "Ice_Texture", 2D ) = "white" {}
		_Desatuarte( "Desatuarte", Range( 0, 1 ) ) = 1
		[HDR] _Ice_Color( "Ice_Color", Color ) = ( 1, 1, 1, 0 )
		_Ice_Pow( "Ice_Pow", Float ) = 0
		_Ice_UPanner( "Ice_UPanner", Float ) = 0
		_Ice_VPanner( "Ice_VPanner", Float ) = 0
		_Ice_Normal_Texture( "Ice_Normal_Texture", 2D ) = "bump" {}
		_Normal_Scale( "Normal_Scale", Range( 0, 5 ) ) = 1
		_Fresnel_Scale( "Fresnel_Scale", Range( 0, 1 ) ) = 1
		_Fresnel_Power( "Fresnel_Power", Range( 1, 10 ) ) = 1
		[HDR] _Fresnel_In_Color( "Fresnel_In_Color", Color ) = ( 0, 0, 1, 0 )
		[HDR] _Fresnel_Out_Color( "Fresnel_Out_Color", Color ) = ( 1, 1, 1, 0 )
		_Parallax_Texture( "Parallax_Texture", 2D ) = "white" {}
		_Height_Scale( "Height_Scale", Range( 0, 5 ) ) = 1.521739
		_Dissolve_Texture( "Dissolve_Texture", 2D ) = "white" {}
		_Dissolve( "Dissolve", Range( -1.1, 1.1 ) ) = 0
		_Dissolve_UPanner( "Dissolve_UPanner", Float ) = 0
		_Dissolve_VPanner( "Dissolve_VPanner", Float ) = 0
		_Edge_Thinkness( "Edge_Thinkness", Float ) = 0.6
		[HDR] _Edge_Color( "Edge_Color", Color ) = ( 1, 1, 1, 0 )
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature_local _USE_CUSTOM_ON
		#define ASE_VERSION 19901
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float3 worldNormal;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Ice_Color;
		uniform sampler2D _Ice_Texture;
		uniform float _Ice_UPanner;
		uniform float _Ice_VPanner;
		uniform float4 _Ice_Texture_ST;
		uniform sampler2D _Parallax_Texture;
		uniform float4 _Parallax_Texture_ST;
		uniform float _Height_Scale;
		uniform float _Desatuarte;
		uniform float _Ice_Pow;
		uniform float4 _Fresnel_Out_Color;
		uniform float4 _Fresnel_In_Color;
		uniform sampler2D _Ice_Normal_Texture;
		uniform float4 _Ice_Normal_Texture_ST;
		uniform float _Normal_Scale;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Power;
		uniform float4 _Edge_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float _Edge_Thinkness;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 appendResult13 = (float2(_Ice_UPanner , _Ice_VPanner));
			float2 uv_Ice_Texture = i.uv_texcoord * _Ice_Texture_ST.xy + _Ice_Texture_ST.zw;
			float2 uv_Parallax_Texture = i.uv_texcoord * _Parallax_Texture_ST.xy + _Parallax_Texture_ST.zw;
			float2 Offset26 = ( ( tex2D( _Parallax_Texture, uv_Parallax_Texture ).r - 1 ) * i.viewDir.xy * _Height_Scale ) + uv_Ice_Texture;
			float2 panner10 = ( 1.0 * _Time.y * appendResult13 + Offset26);
			float3 desaturateInitialColor23 = tex2D( _Ice_Texture, panner10 ).rgb;
			float desaturateDot23 = dot( desaturateInitialColor23, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar23 = lerp( desaturateInitialColor23, desaturateDot23.xxx, _Desatuarte );
			float3 temp_cast_1 = (_Ice_Pow).xxx;
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float2 uv_Ice_Normal_Texture = i.uv_texcoord * _Ice_Normal_Texture_ST.xy + _Ice_Normal_Texture_ST.zw;
			float fresnelNdotV3 = dot( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Ice_Normal_Texture, uv_Ice_Normal_Texture ), _Normal_Scale ) )), ase_viewDirWS );
			float fresnelNode3 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV3, _Fresnel_Power ) );
			float4 lerpResult19 = lerp( _Fresnel_Out_Color , _Fresnel_In_Color , saturate( fresnelNode3 ));
			float4 temp_cast_3 = (0.5).xxxx;
			float2 appendResult49 = (float2(_Dissolve_UPanner , _Dissolve_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner46 = ( 1.0 * _Time.y * appendResult49 + uv_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch53 = i.uv2_texcoord2.z;
			#else
				float staticSwitch53 = _Dissolve;
			#endif
			float4 temp_output_31_0 = ( tex2D( _Dissolve_Texture, panner46 ) + staticSwitch53 );
			float4 temp_output_36_0 = step( temp_cast_3 , temp_output_31_0 );
			float4 temp_cast_4 = (_Edge_Thinkness).xxxx;
			o.Emission = ( ( ( ( _Ice_Color * float4( pow( desaturateVar23 , temp_cast_1 ) , 0.0 ) ) + lerpResult19 ) + ( _Edge_Color * ( temp_output_36_0 - step( temp_cast_4 , temp_output_31_0 ) ) ) ) * i.vertexColor ).rgb;
			o.Alpha = 1;
			clip( temp_output_36_0.r - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-3168,-576;Inherit;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;-2320,-64;Inherit;False;Property;_Ice_UPanner;Ice_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-2320,0;Inherit;False;Property;_Ice_VPanner;Ice_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-2832,-560;Inherit;True;Property;_Parallax_Texture;Parallax_Texture;14;0;Create;True;0;0;0;False;0;False;-1;7109c97ad318ceb45962b1e2d9353fd7;7b4c644fcbf33ac4d8587987df92fd4c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-2747.395,-255.3212;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;27;-2816,-368;Inherit;False;Property;_Height_Scale;Height_Scale;15;0;Create;True;0;0;0;False;0;False;1.521739;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-2064,1264;Inherit;False;Property;_Dissolve_UPanner;Dissolve_UPanner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-2064,1344;Inherit;False;Property;_Dissolve_VPanner;Dissolve_VPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-2778.395,-761.3212;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-2128,-80;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-2464,-560;Inherit;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-1785.379,1314.841;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-1952,1120;Inherit;False;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-2528,352;Inherit;False;Property;_Normal_Scale;Normal_Scale;9;0;Create;True;0;0;0;False;0;False;1;2.16;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-2560,144;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-2144,144;Inherit;True;Property;_Ice_Normal_Texture;Ice_Normal_Texture;8;0;Create;True;0;0;0;False;0;False;-1;8327b83befca67845a3c5cef30bce7e7;c0a677bf1956fc544a63673cbbd48c60;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-1968,-128;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-1635.379,1145.841;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-1872,1664;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;-1584,1408;Inherit;False;Property;_Dissolve;Dissolve;17;0;Create;True;0;0;0;False;0;False;0;1.1;-1.1;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-1712,528;Inherit;False;Property;_Fresnel_Power;Fresnel_Power;11;0;Create;True;0;0;0;False;0;False;1;1.98;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;-1728,432;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;10;0;Create;True;0;0;0;False;0;False;1;0.232;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-1728,176;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-1760,-112;Inherit;True;Property;_Ice_Texture;Ice_Texture;2;0;Create;True;0;0;0;False;0;False;-1;c01c4f8b1dbc5ec4fa0e0c66dd0a8209;c01c4f8b1dbc5ec4fa0e0c66dd0a8209;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-1488,80;Inherit;False;Property;_Desatuarte;Desatuarte;3;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;-1408,1152;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;16;0;Create;True;0;0;0;False;0;False;-1;None;43276e0bf183d4a4f87bd4acde8c078a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-1408,1600;Inherit;False;Property;_Use_Custom;Use_Custom;1;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-1200,-192;Inherit;False;Property;_Ice_Pow;Ice_Pow;5;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-1360,320;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-1264,-96;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-1072,1184;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-976,1040;Inherit;False;Constant;_Float0;Float 0;17;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-1056,1440;Inherit;False;Property;_Edge_Thinkness;Edge_Thinkness;20;0;Create;True;0;0;0;False;0;False;0.6;0.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-960,-96;Inherit;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-1008,-336;Inherit;False;Property;_Ice_Color;Ice_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-1120,320;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-912,320;Inherit;False;Property;_Fresnel_Out_Color;Fresnel_Out_Color;13;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-896,560;Inherit;False;Property;_Fresnel_In_Color;Fresnel_In_Color;12;1;[HDR];Create;True;0;0;0;False;0;False;0,0,1,0;1,1,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-800,1088;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-752,1360;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-704,-112;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-608,336;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-496,1184;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-464,944;Inherit;False;Property;_Edge_Color;Edge_Color;21;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.44399,8.109908,10.55606,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-448,0;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-160,1168;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;-80,144;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-192,16;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;160,0;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;448,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_Ice;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;1;51;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;26;0;28;0
WireConnection;26;1;25;1
WireConnection;26;2;27;0
WireConnection;26;3;29;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;2;1;50;0
WireConnection;2;5;8;0
WireConnection;10;0;26;0
WireConnection;10;2;13;0
WireConnection;46;0;45;0
WireConnection;46;2;49;0
WireConnection;6;0;2;0
WireConnection;1;1;10;0
WireConnection;30;1;46;0
WireConnection;53;1;32;0
WireConnection;53;0;52;3
WireConnection;3;0;6;0
WireConnection;3;2;4;0
WireConnection;3;3;5;0
WireConnection;23;0;1;0
WireConnection;23;1;24;0
WireConnection;31;0;30;0
WireConnection;31;1;53;0
WireConnection;15;0;23;0
WireConnection;15;1;16;0
WireConnection;7;0;3;0
WireConnection;36;0;37;0
WireConnection;36;1;31;0
WireConnection;38;0;39;0
WireConnection;38;1;31;0
WireConnection;17;0;18;0
WireConnection;17;1;15;0
WireConnection;19;0;22;0
WireConnection;19;1;20;0
WireConnection;19;2;7;0
WireConnection;41;0;36;0
WireConnection;41;1;38;0
WireConnection;14;0;17;0
WireConnection;14;1;19;0
WireConnection;42;0;43;0
WireConnection;42;1;41;0
WireConnection;44;0;14;0
WireConnection;44;1;42;0
WireConnection;34;0;44;0
WireConnection;34;1;33;0
WireConnection;0;2;34;0
WireConnection;0;10;36;0
ASEEND*/
//CHKSM=90E8F6CBFF2141E4679D5B9FFBC15E1F192792F6