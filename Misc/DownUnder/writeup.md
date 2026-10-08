# DownUnder Writeup

Text is printed off-screen, which the player must view by using tools built into emualtors like mGBA.

## Solution

(This solution guide will assume you are using mGBA)

1. Open the ROM in mGBA.
2. Go to Tools -> View Map
3. The flag will be printed on the bottom of the map.

**Now, why does this work?** For that, let's look at how GBA graphics work.

There are a total of six modes: three tile modes and three bitmap modes. For us, the former is what we care about.
The tile modes allow us to use sprites and place them anywhere on the screen, including off the screeen.
*But why would we ever put anything off screen?* For scrolling. Think of how Super Mario Bros. scrolls to the right: that's a hardware feature on the GBA!

So, I wrote the flag outside of the visible part of the screen. Many emulator debugging tools, such as mGBA's allow users to view everything on the current map, including what's off screen. This makes it possible to view the flag without having to manipulate the scrolling registers.

Alternatively, players may manipulate the register responsible for scrolling directly. This is handled by address `0x4000012` (scroll BG0 vertically), which emulators can also write to.

For more information on tile maps, you can read [this article](http://ianfinlayson.net/class/cpsc305/notes/13-tiles).

## Embedded Hint

There is an embedded hint in case a user decides to run `strings` on the ROM. This will yield a partial flag with the hint "check the map" nearby. Due to how the challenge is written, it may be possible to guess the full flag without executing the ROM, but that's no fun, now, is it?

## Flag Storage

While this challenge does store it as a string (to a degree), it is manipulated at runtime to prevent `strings`-ing, and future GBA challenges will likely store the flags as sprites or as a bitmap anyways.
