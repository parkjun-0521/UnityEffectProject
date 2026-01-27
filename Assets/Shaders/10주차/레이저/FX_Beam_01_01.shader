// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_Beam_01_01"
{
	Properties
	{
		[HDR] _Main_Color( "Main_Color", Color ) = ( 0.254717, 0, 0, 0 )
		_Main_Texture( "Main_Texture", 2D ) = "white" {}
		_Main_UPanner( "Main_UPanner", Float ) = 0
		_Main_VPanner( "Main_VPanner", Float ) = -0.25
		_Dissolve( "Dissolve", Range( -1.2, 1.2 ) ) = 0.1371731
		[HDR] _Edge_Color( "Edge_Color", Color ) = ( 1, 1, 1, 0 )
		_Edge_Thinkness( "Edge_Thinkness", Float ) = 0.59
		_Rotation( "Rotation", Float ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#define ASE_VERSION 19901
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Rotation;
		uniform float _Dissolve;
		uniform float _Edge_Thinkness;
		uniform float4 _Edge_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_cast_0 = (0.5).xxxx;
			float2 appendResult7 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float4 appendResult22 = (float4(( uv_Main_Texture.x + ( uv_Main_Texture.y * _Rotation ) ) , uv_Main_Texture.y , 0.0 , 0.0));
			float2 panner4 = ( 1.0 * _Time.y * appendResult7 + appendResult22.xy);
			float4 temp_output_8_0 = ( tex2D( _Main_Texture, panner4 ) + _Dissolve );
			float4 temp_output_10_0 = step( temp_cast_0 , temp_output_8_0 );
			float4 temp_cast_2 = (_Edge_Thinkness).xxxx;
			o.Emission = ( ( _Main_Color + ( ( temp_output_10_0 - step( temp_cast_2 , temp_output_8_0 ) ) * _Edge_Color ) ) * i.vertexColor ).rgb;
			float4 temp_cast_4 = (0.5).xxxx;
			o.Alpha = saturate( ( i.vertexColor.a * temp_output_10_0 ) ).r;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-2624,64;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-2592,240;Inherit;False;Property;_Rotation;Rotation;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-2368,160;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-2112,320;Inherit;False;Property;_Main_UPanner;Main_UPanner;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-2112,400;Inherit;False;Property;_Main_VPanner;Main_VPanner;3;0;Create;True;0;0;0;False;0;False;-0.25;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-2192,-48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-1936,320;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-2016,16;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;-1712,192;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-1472,192;Inherit;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-1456,400;Inherit;False;Property;_Dissolve;Dissolve;4;0;Create;True;0;0;0;False;0;False;0.1371731;0.18;-1.2;1.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-1136,192;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;11;-1168,96;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-1152,448;Inherit;False;Property;_Edge_Thinkness;Edge_Thinkness;6;0;Create;True;0;0;0;False;0;False;0.59;0.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-976,176;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-976,448;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-704,336;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-704,560;Inherit;False;Property;_Edge_Color;Edge_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0.5910436,7.464264,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-464,336;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-832,-144;Inherit;False;Property;_Main_Color;Main_Color;0;1;[HDR];Create;True;0;0;0;False;0;False;0.254717,0,0,0;0.4948659,0,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-368,-48;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-560,-96;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-192,160;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-78,-96.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;21;-32,160;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;144,-16;Float;False;True;-1;2;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_Beam_01_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;3;2
WireConnection;23;1;24;0
WireConnection;25;0;3;1
WireConnection;25;1;23;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;22;0;25;0
WireConnection;22;1;3;2
WireConnection;4;0;22;0
WireConnection;4;2;7;0
WireConnection;2;1;4;0
WireConnection;8;0;2;0
WireConnection;8;1;9;0
WireConnection;10;0;11;0
WireConnection;10;1;8;0
WireConnection;15;0;16;0
WireConnection;15;1;8;0
WireConnection;17;0;10;0
WireConnection;17;1;15;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;20;0;1;0
WireConnection;20;1;18;0
WireConnection;14;0;12;4
WireConnection;14;1;10;0
WireConnection;13;0;20;0
WireConnection;13;1;12;0
WireConnection;21;0;14;0
WireConnection;0;2;13;0
WireConnection;0;9;21;0
ASEEND*/
//CHKSM=7EEAB98684ED61E30AF97499A03859B945266271