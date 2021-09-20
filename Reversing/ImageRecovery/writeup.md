# Writeup

This program reads in a PNG file as input using libpng and converts it to a "GRB8" file. This is a custom image file format I came up with for this challenge. It is incredibly simple but not obvious without reverse engineering the program.

Format:

* Magic header: `"GRB8"`, 4 bytes
* Chunk dimensions: `(cw << 4) | ch`, 1 byte
  * Chunk width: `cw`, 1 nybble
  * Chunk height: `ch`, 1 nybble
* Row count (in chunks): 1 byte
* Column count (in chunks): 1 byte
* Image data: `(cw * ch) * (rows * cols)` bytes
* Sentinel byte: `'.'`, 1 byte

Each pixel is represented as 1 byte, as follows:

```
Bit position:    76543210
Color component: gggrrrbb
```

This means that each the red and green components are comprised of 3 bits, whereas the blue component only uses 2 bits.

The program provided only converts from PNG to GRB, so the goal of this challenge is to understand the format well enough to write a program that either converts a GRB file back to something usable (like PNG) or displays a GRB file.

For fun (and to show more examples of GRB files), there are 5 image files provided, only 1 of which contains the flag. The flag is in [IMG_6942](IMG_6942.png).
