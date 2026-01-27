// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_MagicMask"
{
	Properties
	{
		_TextureSample1( "Texture Sample 1", 2D ) = "white" {}
		_Mask_Range( "Mask_Range", Float ) = 1.64
		[HDR] _Main_Color( "Main_Color", Color ) = ( 1, 0, 0, 0 )
		_Main_Ins( "Main_Ins", Float ) = 1
		_Main_Pow( "Main_Pow", Float ) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19901
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform float _Main_Ins;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		sampler2D _Sampler602;
		uniform float _Mask_Range;
		uniform float _Main_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 temp_output_1_0_g2 = float2( 1,1 );
			float2 appendResult10_g2 = (float2(( (temp_output_1_0_g2).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g2).y )));
			float2 temp_output_11_0_g2 = float2( 0,0 );
			float2 panner18_g2 = ( ( (temp_output_11_0_g2).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g2 = ( ( _Time.y * (temp_output_11_0_g2).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g2 = (float2((panner18_g2).x , (panner19_g2).y));
			float2 temp_output_47_0_g2 = float2( 0,0 );
			float2 uv_TexCoord78_g2 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g2 = ( uv_TexCoord78_g2 - float2( 1,1 ) );
			float2 appendResult39_g2 = (float2(frac( ( atan2( (temp_output_31_0_g2).x , (temp_output_31_0_g2).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g2 )));
			float2 panner54_g2 = ( ( (temp_output_47_0_g2).x * _Time.y ) * float2( 1,0 ) + appendResult39_g2);
			float2 panner55_g2 = ( ( _Time.y * (temp_output_47_0_g2).y ) * float2( 0,1 ) + appendResult39_g2);
			float2 appendResult58_g2 = (float2((panner54_g2).x , (panner55_g2).y));
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( _Main_Color * ( _Main_Ins * pow( ( tex2D( _TextureSample1, uv_TextureSample1 ) * step( (( ( (tex2D( _Sampler602, ( appendResult10_g2 + appendResult24_g2 ) )).rg * 1.0 ) + ( float2( 1,1 ) * appendResult58_g2 ) )).x , _Mask_Range ) ) , temp_cast_0 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.Vector2Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-1440,96;Inherit;False;Constant;_Vector2;Vector 2;0;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-1200,-32;Inherit;True;RadialUVDistortion;-1;;2;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler602;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;-768,-32;Inherit;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-768,224;Inherit;False;Property;_Mask_Range;Mask_Range;1;0;Create;True;0;0;0;False;0;False;1.64;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-480,80;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-512,-256;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;a306871ad5223c04b83a94ea6953a53b;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-160,-80;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;0,-224;Inherit;False;Property;_Main_Pow;Main_Pow;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;106.9255,-62.68933;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;208,-224;Inherit;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;309.9255,-62.68933;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;352,-416;Inherit;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;1,1,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;512,-64;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;784,-96;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_MagicMask;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;47;3;0
WireConnection;4;0;2;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;8;0;9;0
WireConnection;8;1;7;0
WireConnection;11;0;8;0
WireConnection;11;1;16;0
WireConnection;14;0;17;0
WireConnection;14;1;11;0
WireConnection;15;0;18;0
WireConnection;15;1;14;0
WireConnection;0;2;15;0
ASEEND*/
//CHKSM=B1A1DBF86E0E387D75D3E50A6983C4A1BB0069B8