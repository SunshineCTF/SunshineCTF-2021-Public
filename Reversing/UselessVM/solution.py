def add_low(value):
    assert 0 <= value <= 0b1_1111
    return (0b0010_0000 | value).to_bytes(1, 'little')

def add_high(value):
    assert 0 <= value <= 0b1_1111
    return (0b0100_0000 | value).to_bytes(1, 'little')

def put_char():
    return 0b0110_0000.to_bytes(1, 'little')

def move_A_to_M():
    return 0b1110_0000.to_bytes(1, 'little')

def halt():
    return 0b1000_0000.to_bytes(1, 'little')

def load():
    return 0b1010_0000.to_bytes(1, 'little')

def store():
    return 0b1100_0000.to_bytes(1, 'little')

with open("opcodes.bin", 'wb') as f:
    # Just testing
    # f.write(add_low(0x13))
    # f.write(store())
    # f.write(add_low(0x13))
    # f.write(load())
    # f.write(add_low(0))

    # Get address of flag in A
    f.write(add_low(31))
    f.write(add_low(31))
    f.write(add_low(31))
    f.write(add_low(31))
    f.write(add_low(4))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(31))
    f.write(add_high(7))

    # Put flag in output buffer, lenght unknown so just guess 30
    for _ in range(40):
        f.write(move_A_to_M())
        f.write(put_char())
        f.write(add_low(1))
    f.write(halt())