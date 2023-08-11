/*
Convert Full RGB to Limited RGB within a Full RGB container.

0-255 within 0-255 container > 16-235 within 0-255 container.
*/

// Full range: 0 - 255
// Limited range: 16 - 235

// Note that RGBA8 uses a range of 0.0-1.0, so we also need to divide by 255.

// RGB_Clamp: The minimum RGB value
// i.e. black is RGB(0, 0, 0) in full range, which should become RGB(16, 16, 16) in limited range.
// Clamp = 16
static const float3 RGB_Clamp =
float3(16.0/255.0, 16.0/255.0, 16.0/255.0);

// RGB_Gain: the factor to apply to the full range RGB value
// i.e. 255 should become 235.
// We have to take the clamp value into account such that 235 must be 235 - 16 = 219
static const float3 RGB_Gain =
float(219.0/255.0);


#include "ReShade.fxh"

// Shader
void FullToLimitedPass(float4 pos : SV_Position, float2 texcoord : TexCoord, out float3 color : SV_Target)
{

	color = tex2D(ReShade::BackBuffer, texcoord).rgb;

	color = color * RGB_Gain + RGB_Clamp;

	color = saturate(color);
}

technique RGB_YUV_RGB
{
	pass
	{
		VertexShader = PostProcessVS;
		PixelShader = FullToLimitedPass;
	}
}
