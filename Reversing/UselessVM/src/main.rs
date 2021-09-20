
use std::io::Read;
use std::fmt::Debug;
use std::ffi::CString;

const FLAG_ADDRESS: u16 = 0xe080;

#[cfg(feature="debug_print")]
fn debug_print(op: u8) {
    let msg = match op {
        0b001 => "ADD_LOW",
        0b010 => "ADD_HIGH",
        0b011 => "PUT_CHAR",
        0b100 => "HALT",
        0b101 => "LOAD",
        0b110 => "STORE",
        0b111 => "A_TO_M",
        other => "BAD_OPCODE"
    };
    println!("{}", msg);
}

#[cfg(not(feature="debug_print"))]
#[allow(unused)]
fn debug_print(op: u8) { }

#[derive(Debug)]
enum ExitReason {
    // Normal exit
    Exited,

    // Got a bad opcode
    BadOpcode,
}

struct Registers {
    // Accumulator - only register that holds the results of any math operation
    A: u16,

    // Only register that holds memory addresses - i.e., memory accesses only use this reg
    M: u16
}

impl Registers {
    fn new() -> Self {
        Registers {
            A: 0,
            M: 0
        }
    }
}

/// The virtual machine, with a set of registers and memory
struct Machine {
    registers: Registers,
    memory: Box<[u8]>,
    output_buffer: Vec<u8>,
}

impl Machine {
    fn new() -> Self {
        Machine {
            registers: Registers::new(),
            memory: Box::new([0u8; u16::MAX as usize]),
            output_buffer: vec!()
        }
    }

    fn execute_instruction(&mut self, opcode: u8) -> Result<(), ExitReason> {
        let operation = (opcode & 0xe0) >> 5;
        let value: u8 = opcode & 0x1f;
        // println!("OP: {} VAL: {}", operation, value);

        debug_print(operation);
        match operation {
            0b001 => {
                // ADD_LOW
                let A_high = self.registers.A & 0xff00;
                let mut A_low = (self.registers.A & 0xff) as u8;
                A_low = A_low.wrapping_add(value);
                self.registers.A = A_high + A_low as u16;
            },
            0b010 => {
                // ADD_HIGH
                // println!("Before add high: {:#x}", self.registers.A);
                let mut A_high = ((self.registers.A & 0xff00) >> 8) as u8;
                let A_low = (self.registers.A & 0xff) as u8;
                A_high = A_high.wrapping_add(value);
                
                self.registers.A = ((A_high as u16) << 8) + A_low as u16;
                // println!("After add high: {:#x}", self.registers.A);
            },
            0b011 => {
                // PUT_CHAR
                let chr = self.memory[self.registers.M as usize];
                self.output_buffer.push(chr);
            },
            0b100 => {
                // HALT
                let c_string = unsafe{ CString::from_vec_unchecked(self.output_buffer.clone())};
                println!("{:?}", c_string);
                return Err(ExitReason::Exited);
            },
            0b101 => {
                // LOAD
                // A = *M (zeroes out top u8)
                self.registers.A = self.memory[self.registers.M as usize] as u16;
            },
            0b110 => {
                // STORE
                // *M = A (only bottom u8)
                self.memory[self.registers.M as usize] = self.registers.A as u8;
            }
            0b111 => {
                // A_TO_M
                // M = A. Value is unused
                self.registers.M = self.registers.A;
            },
            others => {
                return Err(ExitReason::BadOpcode);
            }
        }

        Ok(())
    }
}

/// Read flag from file and insert into the VM memory
fn init_flag(machine: &mut Machine) -> Result<(), std::io::Error> {
    let flag = std::fs::read_to_string(std::path::Path::new("./flag.txt"))?;
    let flag_length = flag.len() as u16;

    // Copy flag into virtual machine memory
    machine.memory[FLAG_ADDRESS as usize..FLAG_ADDRESS.checked_add(flag_length).unwrap() as usize]
        .copy_from_slice(flag.as_bytes());

    Ok(())
}

fn main() -> Result<(), std::io::Error> {
    let mut m = Machine::new();
    init_flag(&mut m)?;

    for byte in std::io::stdin().bytes() {
        if let Err(reason) = m.execute_instruction(byte?) {
            match reason {
                ExitReason::Exited => {},

                _ => { println!("{:?}", reason)}
            }

        }
    }

    Ok(())
}
