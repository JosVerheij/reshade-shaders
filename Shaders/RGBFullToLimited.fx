/*
Convert Full RGB to Limited RGB within a Full RGB container.

0-255 within 0-255 container > 16-235 within 0-255 container.
*/

// Full range: 0 - 255
// Limited range: 16 - 235

#include "ReShade.fxh"

//crashes without this for some reason
uniform float  iGlobalTime < source = "timer"; >;

// Note that RGBA8 uses a range of 0.0-1.0, so we also need to divide by 255.

// RGB_Clamp: The minimum RGB value
// i.e. black is RGB(0, 0, 0) in full range, which should become RGB(16, 16, 16) in limited range.
// Clamp = 16
static const float3 RGB_Clamp =
float3(16.0/255.0, 16.0/255.0, 16.0/255.0);

// RGB_Gain: the factor to apply to the full range RGB value
// i.e. 255 should become 235.
// We have to calculate the factor over the effective range, which is 235 - 16 = 219
static const float RGB_Gain = 219.0/255.0;

// Shader
void FullToLimitedPass(float4 pos : SV_Position, float2 texcoord : TexCoord, out float3 color : SV_Target)
{
	float4 tex = tex2D(ReShade::BackBuffer,texcoord);
	color.r = tex.x;
	color.g = tex.y;
	color.b = tex.z;

	color = color * RGB_Gain + RGB_Clamp;

	color = saturate(color);
}

technique RGB_FULL_LIMITED
{
	pass
	{
		VertexShader = PostProcessVS;
		PixelShader = FullToLimitedPass;
	}
}
