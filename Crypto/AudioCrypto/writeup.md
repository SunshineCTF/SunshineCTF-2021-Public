While the comments in the source code talk a big game, since the state only outputs when it is smaller than 256, a single byte, the PRNG only has a loop of a maximum of 256. Since the bytes 0x42 are the appended to the end of the file it is guaranteed the PRNG will have at least one cycle over these bytes. This leaks all the bytes on the cycle of the prng.

Additionally, the size of the cycle will need to be determined. Hamming distance can be used in this area to succeed. Otherwise, you can theoretically try all 256-100 possibilities for the size of the cycle.
