// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_EnergyBall"
{
	Properties
	{
		[HDR] _Out_Fresnel_In_Color( "Out_Fresnel_In_Color", Color ) = ( 1, 0, 0, 0 )
		[HDR] _Out_Fresnel_Out_Color( "Out_Fresnel_Out_Color", Color ) = ( 0.9593928, 1, 0, 0 )
		_Out_Fresnel_Scale( "Out_Fresnel_Scale", Range( 0, 1 ) ) = 0.4606018
		_Out_Fresnel_Power( "Out_Fresnel_Power", Range( 0, 10 ) ) = 1.956739
		_Noise_Texture( "Noise_Texture", 2D ) = "bump" {}
		_Normal_Scale( "Normal_Scale", Range( 0, 1 ) ) = 0.531484
		_Noise_Rotation( "Noise_Rotation", Float ) = -1.45
		_Noise_UPanner( "Noise_UPanner", Float ) = 1
		_Noise_VPanner( "Noise_VPanner", Float ) = 1
		_In_Fresnel_Power( "In_Fresnel_Power", Range( 0, 10 ) ) = 1.956739
		_In_Fresnel_Scale( "In_Fresnel_Scale", Range( -10, 100 ) ) = 0.4606018
		[HDR] _In_Fresnel_In_Color( "In_Fresnel_In_Color", Color ) = ( 0, 0, 0, 0 )
		_Dissolve_Texture( "Dissolve_Texture", 2D ) = "white" {}
		_Dissolve( "Dissolve", Range( -1, 1 ) ) = 0
		_Dissolve_UPanner( "Dissolve_UPanner", Float ) = 1
		_Dissolve_VPanner( "Dissolve_VPanner", Float ) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19901
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Out_Fresnel_In_Color;
		uniform float4 _Out_Fresnel_Out_Color;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Rotation;
		uniform float _Normal_Scale;
		uniform float _Out_Fresnel_Scale;
		uniform float _Out_Fresnel_Power;
		uniform float _In_Fresnel_Scale;
		uniform float _In_Fresnel_Power;
		uniform float4 _In_Fresnel_In_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float2 appendResult22 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 appendResult15 = (float2(( uv_Noise_Texture.x + ( uv_Noise_Texture.y * _Noise_Rotation ) ) , uv_Noise_Texture.y));
			float2 panner19 = ( 1.0 * _Time.y * appendResult22 + appendResult15);
			float3 newWorldNormal11 = (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Noise_Texture, panner19 ), _Normal_Scale ) ));
			float fresnelNdotV1 = dot( newWorldNormal11, ase_viewDirWS );
			float fresnelNode1 = ( 0.0 + _Out_Fresnel_Scale * pow( 1.0 - fresnelNdotV1, _Out_Fresnel_Power ) );
			float4 lerpResult3 = lerp( _Out_Fresnel_In_Color , _Out_Fresnel_Out_Color , saturate( fresnelNode1 ));
			float fresnelNdotV23 = dot( newWorldNormal11, ase_viewDirWS );
			float fresnelNode23 = ( 0.0 + _In_Fresnel_Scale * pow( 1.0 - fresnelNdotV23, _In_Fresnel_Power ) );
			o.Emission = ( ( lerpResult3 + ( ( 1.0 - saturate( fresnelNode23 ) ) * _In_Fresnel_In_Color ) ) * i.vertexColor ).rgb;
			float2 appendResult45 = (float2(_Dissolve_UPanner , _Dissolve_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 appendResult44 = (float2(( uv_Dissolve_Texture.x + ( uv_Dissolve_Texture.y * _Noise_Rotation ) ) , uv_Dissolve_Texture.y));
			float2 panner46 = ( 1.0 * _Time.y * appendResult45 + appendResult44);
			o.Alpha = ( i.vertexColor.a * step( ( 1.0 - tex2D( _Dissolve_Texture, panner46 ).r ) , _Dissolve ) );
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-2560,-768;Inherit;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-2720,-592;Inherit;False;Property;_Noise_Rotation;Noise_Rotation;6;0;Create;True;0;0;0;False;0;False;-1.45;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-2400,-656;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-2224,-912;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-2032,-560;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;7;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;21;-2048,-480;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;8;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-1952,-832;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1824,-560;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-1904,-368;Inherit;False;Property;_Normal_Scale;Normal_Scale;5;0;Create;True;0;0;0;False;0;False;0.531484;0.141;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-1684.854,-771.4429;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-2144,864;Inherit;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-1552,-512;Inherit;True;Property;_Noise_Texture;Noise_Texture;4;0;Create;True;0;0;0;False;0;False;-1;11dfe8ca7395e014dbce71f2e0f6ad12;11dfe8ca7395e014dbce71f2e0f6ad12;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-1984,976;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;-1104,-160;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-1808,720;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-1632,1152;Inherit;False;Property;_Dissolve_VPanner;Dissolve_VPanner;15;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-1616,1072;Inherit;False;Property;_Dissolve_UPanner;Dissolve_UPanner;14;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-1360,544;Inherit;False;Property;_In_Fresnel_Power;In_Fresnel_Power;9;0;Create;True;0;0;0;False;0;False;1.956739;1.47;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-1360,480;Inherit;False;Property;_In_Fresnel_Scale;In_Fresnel_Scale;10;0;Create;True;0;0;0;False;0;False;0.4606018;100;-10;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-1136,128;Inherit;False;Property;_Out_Fresnel_Power;Out_Fresnel_Power;3;0;Create;True;0;0;0;False;0;False;1.956739;2.13;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-1136,64;Inherit;False;Property;_Out_Fresnel_Scale;Out_Fresnel_Scale;2;0;Create;True;0;0;0;False;0;False;0.4606018;0.632;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-1536,800;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-1408,1072;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-1008,320;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-848,-16;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-688,320;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-1264,848;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-528,-16;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-640,-496;Inherit;False;Property;_Out_Fresnel_In_Color;Out_Fresnel_In_Color;0;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-640,-256;Inherit;False;Property;_Out_Fresnel_Out_Color;Out_Fresnel_Out_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;0.9593928,1,0,0;0.5149906,2.810965,6.422235,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;27;-528,320;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-576,544;Inherit;False;Property;_In_Fresnel_In_Color;In_Fresnel_In_Color;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0.9575536,7.906699,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;-1008,848;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;12;0;Create;True;0;0;0;False;0;False;-1;None;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-352,-64;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-320,336;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-672,864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-736,1008;Inherit;False;Property;_Dissolve;Dissolve;13;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;-112,144;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-96,288;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-384,864;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;112,160;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;100.33,587.4862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;75;-1744,240;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;86;-1888,272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;87;-1920,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;85;-2080,272;Inherit;False;Property;_Float0;Float 0;17;0;Create;True;0;0;0;False;0;False;2.41;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;84;-1952,144;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;83;-2176,144;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;73;-1536,240;Inherit;True;Property;_TextureSample0;Texture Sample 0;16;0;Create;True;0;0;0;False;0;False;-1;None;66e9f2f309eba6543886cbfc714d5276;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-1248,240;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;368,32;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_EnergyBall;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;13;2
WireConnection;17;1;18;0
WireConnection;16;0;13;1
WireConnection;16;1;17;0
WireConnection;15;0;16;0
WireConnection;15;1;13;2
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;19;0;15;0
WireConnection;19;2;22;0
WireConnection;10;1;19;0
WireConnection;10;5;12;0
WireConnection;40;0;38;2
WireConnection;40;1;18;0
WireConnection;11;0;10;0
WireConnection;41;0;38;1
WireConnection;41;1;40;0
WireConnection;44;0;41;0
WireConnection;44;1;38;2
WireConnection;45;0;42;0
WireConnection;45;1;43;0
WireConnection;23;0;11;0
WireConnection;23;2;24;0
WireConnection;23;3;25;0
WireConnection;1;0;11;0
WireConnection;1;2;8;0
WireConnection;1;3;9;0
WireConnection;26;0;23;0
WireConnection;46;0;44;0
WireConnection;46;2;45;0
WireConnection;2;0;1;0
WireConnection;27;0;26;0
WireConnection;33;1;46;0
WireConnection;3;0;6;0
WireConnection;3;1;7;0
WireConnection;3;2;2;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;36;0;33;1
WireConnection;30;0;3;0
WireConnection;30;1;28;0
WireConnection;35;0;36;0
WireConnection;35;1;37;0
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;47;0;31;4
WireConnection;47;1;35;0
WireConnection;75;0;84;0
WireConnection;75;1;86;0
WireConnection;75;2;87;0
WireConnection;86;0;85;0
WireConnection;87;0;85;0
WireConnection;84;0;83;0
WireConnection;73;1;75;0
WireConnection;74;0;73;0
WireConnection;0;2;32;0
WireConnection;0;9;47;0
ASEEND*/
//CHKSM=02362CAEDB6D651B0F50E73D57A2FD38CFCAFE09