SunshineCTF 2021 Challenges
-----

This is the public release of the challenges from SunshineCTF 2021. Unless otherwise specified, all challenges are released under the MIT license.

## How to build/deploy Reversing and Pwn challenges

```bash
git clone https://github.com/C0deH4cker/PwnableHarness.git && cd PwnableHarness
git clone --recursive https://github.com/SunshineCTF/SunshineCTF-2021-Public.git sun21 && cd sun21
```

* To compile all binaries: `make`
* To build Docker images for all server-based challenges: `make docker-build`
* To run Docker containers for all server-based challenges: `make docker-start`
* To publish all build artifacts that should be distributed to players to the `publish` folder/symlink: `make publish`

Most of the server-based challenges will be deployed to https://ctf.hackucf.org soon.
