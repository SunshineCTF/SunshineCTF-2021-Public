# DynamicTypeLibraRII is a docker-compose + xinetd pwn challenge (NOT built by
# PwnableHarness). `pwnmake check` starts it, runs the solver, and tears it down.
$(call ctf_check_tcp,$(DIR),21001,bash solve/check.sh)

# Handouts players download (served from publish/ at /files/...)
PUBLISH += dist/dynamic_type_librarii dist/ld-linux-x86-64.so.2 dist/libc.so.6
