# UselessVM is a reversing challenge: a prebuilt Rust "VM" binary that reads
# bytecode on stdin. We run the prebuilt Intel binary via PwnableHarness (no
# rebuild).
DOCKER_IMAGE := sun21-uselessvm
DOCKER_CHALLENGE_PATH := $(DIR)/bins/rust_vm_intel

# The Rust binary needs glibc >= 2.18; the 2021-era PwnableHarness base (16.04,
# glibc 2.23) satisfies that.
UBUNTU_VERSION := 16.04

DOCKER_PORTS := 21101
DOCKER_TIMELIMIT := 30

PUBLISH := bins/rust_vm_intel bins/rust_vm_m1

# `pwnmake check`: run the solver and verify it prints the flag.
$(call ctf_check,$(DIR),$(DOCKER_PORTS),python3 solution.py)
