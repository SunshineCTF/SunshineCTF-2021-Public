#!/bin/bash
# The exploit is probabilistic, so `pwnmake check` retries it a few times.
for _ in 1 2 3 4 5 6; do
	out=$(python3 "$(dirname "$0")/solve.py" 2>&1)
	printf '%s\n' "$out"
	grep -q 'sun{' <<<"$out" && exit 0
done
exit 1
