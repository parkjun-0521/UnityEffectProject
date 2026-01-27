// Made with Amplify Shader Editor v1.9.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JUNFX/FX_Laser02"
{
	Properties
	{
		_Main_Texture( "Main_Texture", 2D ) = "white" {}
		[HDR] _R_Color( "R_Color", Color ) = ( 1, 0, 0, 0 )
		_R_Panner( "R_Panner", Float ) = -0.1
		_R_Pow( "R_Pow", Float ) = 1
		_R_Ins( "R_Ins", Float ) = 1
		[HDR] _G_Color( "G_Color", Color ) = ( 0, 1, 0, 0 )
		_G_Panner( "G_Panner", Float ) = -0.54
		_G_Pow( "G_Pow", Float ) = 1
		_G_Ins( "G_Ins", Float ) = 1
		[HDR] _B_Color( "B_Color", Color ) = ( 0, 0, 1, 0 )
		_B_Panner( "B_Panner", Float ) = -0.15
		_B_Pow( "B_Pow", Float ) = 1
		_B_Ins( "B_Ins", Float ) = 1
		_Noise_Texture( "Noise_Texture", 2D ) = "bump" {}
		_Noise_Str( "Noise_Str", Float ) = 0.1
		_Noise_UPanner( "Noise_UPanner", Float ) = 0
		_Noise_VPanner( "Noise_VPanner", Float ) = 0
		_Opacity( "Opacity", Float ) = 1
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
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _R_Color;
		uniform float _R_Ins;
		uniform sampler2D _Main_Texture;
		uniform float _R_Panner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;
		uniform float _R_Pow;
		uniform float4 _G_Color;
		uniform float _G_Ins;
		uniform float _G_Panner;
		uniform float _G_Pow;
		uniform float4 _B_Color;
		uniform float _B_Ins;
		uniform float _B_Panner;
		uniform float _B_Pow;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult12 = (float2(_R_Panner , 0.0));
			float2 appendResult56 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner53 = ( 1.0 * _Time.y * appendResult56 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 temp_output_48_0 = (( ( (UnpackNormal( tex2D( _Noise_Texture, panner53 ) )).xy * _Noise_Str ) + uv_Main_Texture )).xy;
			float2 panner6 = ( 1.0 * _Time.y * appendResult12 + temp_output_48_0);
			float4 tex2DNode1 = tex2D( _Main_Texture, panner6 );
			float2 appendResult13 = (float2(_G_Panner , 0.0));
			float2 panner7 = ( 1.0 * _Time.y * appendResult13 + temp_output_48_0);
			float4 tex2DNode2 = tex2D( _Main_Texture, panner7 );
			float2 appendResult16 = (float2(_B_Panner , 0.0));
			float2 panner8 = ( 1.0 * _Time.y * appendResult16 + temp_output_48_0);
			float4 tex2DNode3 = tex2D( _Main_Texture, panner8 );
			o.Emission = ( i.vertexColor * ( ( ( _R_Color * ( _R_Ins * pow( tex2DNode1.r , _R_Pow ) ) ) + ( _G_Color * ( _G_Ins * pow( tex2DNode2.g , _G_Pow ) ) ) ) + ( _B_Color * ( _B_Ins * pow( tex2DNode3.b , _B_Pow ) ) ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( tex2DNode1.r + tex2DNode2.g ) + tex2DNode3.b ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19901
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-4960,-336;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-4944,-240;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-4688,-304;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-4816,-560;Inherit;False;0;46;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-4480,-368;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-4160,-400;Inherit;True;Property;_Noise_Texture;Noise_Texture;13;0;Create;True;0;0;0;False;0;False;-1;11dfe8ca7395e014dbce71f2e0f6ad12;11dfe8ca7395e014dbce71f2e0f6ad12;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-3840,-400;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-3830.28,-177.7757;Inherit;False;Property;_Noise_Str;Noise_Str;14;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-3504,112;Inherit;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-3536,-272;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-3056,448;Inherit;False;Constant;_Float2;Float 1;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-3072,352;Inherit;False;Property;_G_Panner;G_Panner;6;0;Create;True;0;0;0;False;0;False;-0.54;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-3184,-32;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-2944,16;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-2960,-80;Inherit;False;Property;_R_Panner;R_Panner;2;0;Create;True;0;0;0;False;0;False;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;13;-2800,384;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-2967.471,698.7963;Inherit;False;Constant;_Float3;Float 1;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-2983.471,602.7963;Inherit;False;Property;_B_Panner;B_Panner;10;0;Create;True;0;0;0;False;0;False;-0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;-2912,112;Inherit;False;True;True;True;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-2688,-48;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-2560,240;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;16;-2711.471,634.7963;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;-2272,64;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;0efaed6c498aba044a2f17d031f89432;0efaed6c498aba044a2f17d031f89432;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-2464,-48;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-1744,160;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.PannerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-2459.863,527.1715;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;-1760,-224;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-1568,-384;Inherit;False;Property;_R_Pow;R_Pow;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-1568,0;Inherit;False;Property;_G_Pow;G_Pow;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;-1744,368;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-1360,-400;Inherit;False;Property;_R_Ins;R_Ins;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;21;-1360,-192;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;30;-1360,-16;Inherit;False;Property;_G_Ins;G_Ins;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;31;-1360,192;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-1472,416;Inherit;False;Property;_B_Pow;B_Pow;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-1136,-192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;27;-1136,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-1280,608;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-1280,400;Inherit;False;Property;_B_Ins;B_Ins;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;-896,64;Inherit;False;Property;_G_Color;G_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;0,1,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-896,-320;Inherit;False;Property;_R_Color;R_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-206.0847,604.9225;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-1056,608;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-848,496;Inherit;False;Property;_B_Color;B_Color;9;1;[HDR];Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-640,224;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-624,-80;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;64,656;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;80,896;Inherit;False;Property;_Opacity;Opacity;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-576,528;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-288,32;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;320,608;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-48,272;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-48,-48;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;528,592;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;260.9827,199.3606;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;672,528;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;848,112;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;JUNFX/FX_Laser02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;55;0
WireConnection;56;1;54;0
WireConnection;53;0;57;0
WireConnection;53;2;56;0
WireConnection;46;1;53;0
WireConnection;47;0;46;0
WireConnection;51;0;47;0
WireConnection;51;1;52;0
WireConnection;49;0;51;0
WireConnection;49;1;5;0
WireConnection;13;0;15;0
WireConnection;13;1;14;0
WireConnection;48;0;49;0
WireConnection;12;0;9;0
WireConnection;12;1;10;0
WireConnection;7;0;48;0
WireConnection;7;2;13;0
WireConnection;16;0;18;0
WireConnection;16;1;17;0
WireConnection;6;0;48;0
WireConnection;6;2;12;0
WireConnection;2;0;4;0
WireConnection;2;1;7;0
WireConnection;8;0;48;0
WireConnection;8;2;16;0
WireConnection;1;0;4;0
WireConnection;1;1;6;0
WireConnection;3;0;4;0
WireConnection;3;1;8;0
WireConnection;21;0;1;1
WireConnection;21;1;25;0
WireConnection;31;0;2;2
WireConnection;31;1;29;0
WireConnection;22;0;26;0
WireConnection;22;1;21;0
WireConnection;27;0;30;0
WireConnection;27;1;31;0
WireConnection;40;0;3;3
WireConnection;40;1;37;0
WireConnection;58;0;1;1
WireConnection;58;1;2;2
WireConnection;35;0;38;0
WireConnection;35;1;40;0
WireConnection;28;0;32;0
WireConnection;28;1;27;0
WireConnection;23;0;24;0
WireConnection;23;1;22;0
WireConnection;59;0;58;0
WireConnection;59;1;3;3
WireConnection;36;0;39;0
WireConnection;36;1;35;0
WireConnection;42;0;23;0
WireConnection;42;1;28;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;43;0;42;0
WireConnection;43;1;36;0
WireConnection;62;0;60;0
WireConnection;44;0;45;0
WireConnection;44;1;43;0
WireConnection;63;0;45;4
WireConnection;63;1;62;0
WireConnection;0;2;44;0
WireConnection;0;9;63;0
ASEEND*/
//CHKSM=2A906176D850E03FA5651A41BE097650D2920CC1