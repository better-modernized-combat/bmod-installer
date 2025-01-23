# Freelancer: BMOD Inno Installer Script

![Discord](https://img.shields.io/discord/676300713210413087?logo=discord&label=Discord&color=purple)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/better-modernized-combat/bmod-client?label=Issues)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-closed/better-modernized-combat/bmod-client?color=green&label=Issues)
![GitHub Release](https://img.shields.io/github/v/release/better-modernized-combat/bmod-client?label=Release)

This is a setup script for [Freelancer: BMOD](https://github.com/better-modernized-combat/bmod-client). It was created using Inno Setup and uses custom Pascal scripting. This has been forked from the excellent [Freelancer HD Edition Installer](https://github.com/oliverpechey/Freelancer-HD-Edition-Installer)

## Usage

### Windows

1. Install a vanilla copy of Freelancer to a non-read only directory (i.e. *not* Program Files).
2. Download and run the [latest release](https://github.com/better-modernized-combat/bmod-installer/releases/).
3. Point the release at your vanilla Freelancer directory and let the installer run.
4. That's it, you're done!

### Linux

1. Set up a new wineprefix and run the installer as normal, selecting a vanilla copy of Freelancer to copy, and a destination within the wineprefix to install the mod to.
2. Install the following to the wineprefix via winetricks:

- `d3dx9`
- `dinput8`
- `directplay`
- `l3codecx`
- `msacm32`
- `vcrun2022`

3. Set DLL overrides for `d3d8.dll` and `dinput8.dll` with the value `n,b`
4. Run the game. Wine versions `UMU-Proton-9.0.3.2` and `GE-Proton9-23` have been observed to have good results.

## Build instructions

### All-in-one installer (default)

1. Clone the [Freelancer: BMOD GitHub repository](https://github.com/better-modernized-combat/bmod-client).
2. Place the DATA, DLL and EXE directories from mod-assets in a folder named `freelancer-bmod-0.1`.
3. Compress the `freelancer-bmod-0.1` folder using an archiver like [7-Zip](https://www.7-zip.org/). NOTE: The zip must NOT be larger than 2.05 GB!
    1. Compressing the folder using LZMA2 is highly recommended.
4. Name the zip `freelancerbmod.7z` and place it in `Assets/Mod`.
5. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

## Programs used

- [7-Zip executable](https://www.7-zip.org/download.html)
7-Zip is licensed under the GNU LGPL license. www.7-zip.org.
