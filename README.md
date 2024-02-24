# Freelancer: BMOD Inno Installer Script

This is a setup script for [Freelancer: BMOD](https://github.com/better-modernized-combat/bmod-client). It was created using Inno Setup and uses custom Pascal scripting. This has been forked from the excellent [Freelancer HD Edition Installer](https://github.com/oliverpechey/Freelancer-HD-Edition-Installer)

## Build instructions
### All-in-one installer (default)
1. Clone the [Freelancer: BMOD GitHub repository](https://github.com/better-modernized-combat/bmod-client).
2. Place the DATA, DLL and EXE directories from mod-assets in a folder named `freelancer-bmod-0.1`.
3. Compress the `freelancer-bmod-0.1` folder using an archiver like [7-Zip](https://www.7-zip.org/). NOTE: The zip must NOT be larger than 2.05 GB!
    1. Compressing the folder using LZMA2 is highly recommended.
4. Name the zip `freelancerbmod.7z` and place it in `Assets/Mod`.
5. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

## Programs used
### [7-Zip executable](https://www.7-zip.org/download.html)
7-Zip is licensed under the GNU LGPL license. www.7-zip.org.