// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_TwosideMesh"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTexture( "Main)Texture", 2D ) = "white" {}
		[HDR] _Front_Color( "Front_Color", Color ) = ( 1, 0, 0, 0 )
		[HDR] _Back_Color( "Back_Color", Color ) = ( 0, 1, 0, 0 )
		_Main_UPanner( "Main_UPanner", Float ) = 0
		_Main_VPanner( "Main_VPanner", Float ) = -0.1
		_Dissolve( "Dissolve", Range( -1.1, 1.1 ) ) = -0.2802208
		_Mask_Texture( "Mask_Texture", 2D ) = "white" {}
		_Mask_Range( "Mask_Range", Float ) = 1.7
		[Toggle( _USE_MASK_ON )] _Use_Mask( "Use_Mask", Float ) = 1
		_Mask_VRange( "Mask_VRange", Float ) = 1.09
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_MASK_ON
		#define ASE_VERSION 19901
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			half ASEIsFrontFacing : VFACE;
			float2 uv_texcoord;
		};

		uniform float4 _Front_Color;
		uniform float4 _Back_Color;
		uniform sampler2D _MainTexture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _MainTexture_ST;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_VRange;
		uniform float _Mask_Range;
		uniform float _Dissolve;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 switchResult1 = (((i.ASEIsFrontFacing>0)?(_Front_Color):(_Back_Color)));
			o.Emission = switchResult1.rgb;
			o.Alpha = 1;
			float2 appendResult10 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float2 panner7 = ( 1.0 * _Time.y * appendResult10 + uv_MainTexture);
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float4 tex2DNode13 = tex2D( _Mask_Texture, uv_Mask_Texture );
			float4 temp_cast_1 = (saturate( ( 1.0 - ( i.uv_texcoord.y * _Mask_VRange ) ) )).xxxx;
			#ifdef _USE_MASK_ON
				float4 staticSwitch24 = temp_cast_1;
			#else
				float4 staticSwitch24 = tex2DNode13;
			#endif
			float4 temp_cast_2 = (_Mask_Range).xxxx;
			clip( saturate( ( pow( ( ( tex2D( _MainTexture, panner7 ) + tex2DNode13 ) * staticSwitch24 ) , temp_cast_2 ) + _Dissolve ) ).r - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-1520,272;Inherit;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-1520,336;Inherit;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;0;False;0;False;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-1424,576;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1392,848;Inherit;False;Property;_Mask_VRange;Mask_VRange;10;0;Create;True;0;0;0;False;0;False;1.09;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-1328,272;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-1440,128;Inherit;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-1168,624;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-1168,128;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-976,624;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;-912,112;Inherit;True;Property;_MainTexture;Main)Texture;1;0;Create;True;0;0;0;False;0;False;-1;9e549e82edc764b418698981d4a88a61;9e549e82edc764b418698981d4a88a61;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-1088,352;Inherit;True;Property;_Mask_Texture;Mask_Texture;7;0;Create;True;0;0;0;False;0;False;-1;5186ad1d6a4d8f843b306ceebf8d6dfd;5186ad1d6a4d8f843b306ceebf8d6dfd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-816,624;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-592,112;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-656,576;Inherit;True;Property;_Use_Mask;Use_Mask;9;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-448,272;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-560,432;Inherit;False;Property;_Mask_Range;Mask_Range;8;0;Create;True;0;0;0;False;0;False;1.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-352,496;Inherit;False;Property;_Dissolve;Dissolve;6;0;Create;True;0;0;0;False;0;False;-0.2802208;0;-1.1;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-256,272;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-912,-320;Inherit;False;Property;_Front_Color;Front_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-912,-112;Inherit;False;Property;_Back_Color;Back_Color;3;1;[HDR];Create;True;0;0;0;False;0;False;0,1,0,0;0,1,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-32,272;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-592,-208;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;80,272;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;256,-256;Float;False;True;-1;2;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_TwosideMesh;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;25;0;20;2
WireConnection;25;1;22;0
WireConnection;7;0;6;0
WireConnection;7;2;10;0
WireConnection;23;0;25;0
WireConnection;4;1;7;0
WireConnection;26;0;23;0
WireConnection;14;0;4;0
WireConnection;14;1;13;0
WireConnection;24;1;13;0
WireConnection;24;0;26;0
WireConnection;15;0;14;0
WireConnection;15;1;24;0
WireConnection;18;0;15;0
WireConnection;18;1;19;0
WireConnection;16;0;18;0
WireConnection;16;1;12;0
WireConnection;1;0;2;0
WireConnection;1;1;3;0
WireConnection;17;0;16;0
WireConnection;0;2;1;0
WireConnection;0;10;17;0
ASEEND*/
//CHKSM=F7B0FEEC95D68EF6CD24D2E7FA66323E13953034