# Reshade shaders for Steam Deck

Some Reshade shaders that can be used with the Steam Deck. Of course, they work on non Steam Deck devices as well.

1. [How to use](#how-to-use)
2. [Shaders](#shaders)

## How to use

There are two ways to use Reshade shaders on the Steam deck:

1. Using the Reshadeck plugin for Decky (this is recommended)
2. Using vkBasalt

### Reshadeck (recommended)

Using Reshadeck is recommended, as it allows you to easily enable and disable shaders from within Gamescope.

1. Install [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader)
2. Install the [Reshadeck](https://github.com/safijari/Reshadeck) plugin from the Decky Loader Plugin Browser
3. Download your desired shaders
2. Place the shaders in the folder `/home/deck/.local/share/gamescope/reshade/Shaders`
3. Launch a game
4. Enable a shader through the Reshadeck configuration in the Decky Loader menu

### vkBasalt

If you don't want to install Decky Loader, you can also use Reshade shaders through [vkBasalt](https://github.com/DadSchoorse/vkBasalt).

Another advantage of vkBasalt is that you can run multiple effects at the same time, such as a *LUT* in addition to any number of (compatible) Reshade shaders.

> 1. Install vkBasalt by using this script for Steam Deck: <https://github.com/simons-public/steam-deck-vkbasalt-install>.
	* NOTE: after installing, vkBasalt is enabled by default for anything you launch through Gamescope! You must explicitly disable vkBasalt by adding `DISABLE_VKBASALT=1 %command%` to the launch paramaters. Alternatively you can edit `vkBasalt.json` and `vkBasalt.x86.json` in `/home/deck/.local/share/vulkan/implicit_layer.d/`.
2. Download your desired shaders
3. Place the shaders in the folder `/home/deck/.config/reshade/Shaders`. You might have to create the `Shaders` folder yourself.
4. Edit `/home/deck/.config/vkbasalt/vkbasalt.conf` (if it does not exist: copy and rename from `vkbasalt.default.conf`). See below.
5. Launch a game. The effects you configured in `vkbasalt.conf` will be enabled.

`vkbasalt.conf`:
```
[...]

effects = YOUR_SHADER
# for example: effects = fulltolimited
# you can also enable multiple effects: effects = lut,fulltolimited

reshadeTexturePath = "/home/deck/.config/reshade/Textures"
reshadeIncludePath = "/home/deck/.config/reshade/Shaders"

fulltolimited = "/home/deck/.config/reshade/Shaders/RGBFullToLimited.fx"

[...]
```

## Shaders

### RGBFullToLimited.fx

Converts the full range signal of 0-255 into a limited range of 16-235.

The Steam Deck can only output a so called *full range* signal. This is a problem for displays that can only display a *limited range* signal. The full range signal covers a range of 0-255 whereas limited range is 16-235. Displaying a full range signal on a limited range display causes the 0-15 range and the 236-255 range to be omitted. This will be visible as crushed blacks and clipped highlights.

This shader is intended for all devices that output an incorrect video signal and/or displays that apply an incorrect video signal, such that the original full RGB range is displayed within a limited range.

The output remains a 0-255 signal, but all colors have been moved to the 16-235 range.
