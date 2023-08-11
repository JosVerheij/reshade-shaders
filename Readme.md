# Reshade shaders

These are shaders for reshade.

Note that the default Reshade shaders need to be available.

Also works with vkBasalt.

## Shaders

### RGBFullToLimited.fx

Converts full range 0-255 into limited range 16-235.

This shader is intended for devices that output an incorrect video signal and/or displays that apply an incorrect video signal, such that the original full RGB range is displayed as a limited range. The latter causes crushed blacks and clipped highlights.

The output remains a 0-255 signal, but all colors have been moved to the 16-235 range.

To install, simply copy the shader into the reshade shaders directory.
