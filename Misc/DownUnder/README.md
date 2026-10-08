# [Misc] DownUnder

This challenge is designed to be an introduction to GBA reverse engineering and an exploration of emulation tools.

## Building

All you really need to serve is `DownUnder.gba`. However, for documentation and education's sake, I am providing build direcitons and the challenge's source code, but the binary is provided.

1. [Install the GBA SDK from devkitPro](https://www.coranac.com/tonc/text/setup.htm)
2. [Build and install HeartLib](https://github.com/Sterophonick/HeartLib)
3. Run `make` while in the root directory of the challenge
4. A GBA ROM should be compiled, as would some intermediary files in `build/`. Have fun!

## Flag Customization

**tl;dr you can't without some fennagling.**

Because of how I designed the GBA challenges, it will not be possible to edit the flag, or to pull it into an external file.

See [writeup.md](writeup.md) for the solution.
