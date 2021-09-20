# Useless Machine

This is a very simple, and quite pointless, virtual machine. The flag is loaded
from a file by the "runtime" and copied to the virtual machine at address
0xe080. The entire premise is just based on doing some (relatively) simple Rust
reversing. There are two `u16`-wide registers: Accumulator (A) and Memory (M).
There are multiple simple opcodes of the following format:

```
01234567
ooovvvvv
```

where `o` is an opcode and `v` is a value. Valid opcodes are:

| Opcode | Value | Description |
|--------|-------|-------------|
| 001    | Any   | ADD_LOW     |
| 010    | Any   | ADD_HIGH    |
| 011    | Unused| PUT_CHAR    |
| 100    | Unused| HALT        |
| 101    | Unused| LOAD        |
| 110    | Unused| STORE       |
| 111    | Unused| A_TO_M      |

Accumulator is the only register which can be modified, via either ADD_LOW or
ADD_HIGH, or LOAD. The Value is only 5-bits wide, and an ADD operation is
wrapping, and only affects one byte of the register. LOAD and STORE are
available, but not required to solve the challenge. The M register can be set to
the current value of A via the A_TO_M instruction. A character can be added to
the output buffer using PUT_CHAR, reading the byte pointed to by M. However, the
output buffer is only printed when the machine is gracefully HALTed.

Thus, by using the provided opcodes, the flag can be printed. See the attached
python example solution.
