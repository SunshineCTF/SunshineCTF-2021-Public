# DynamicTypeLibraRII Writeup

## Additional notes

The solver (`solve/solve.py`) uses a House-of-Force-style tcache/top-chunk corruption: it forges a request size so that the next allocation lands on `__free_hook`, overwrites it with `system`, and then frees a chunk containing `"/bin/sh"` to pop a shell and read the flag.
