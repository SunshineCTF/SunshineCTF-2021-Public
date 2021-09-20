# Build Instructions

```bash
sudo apt-get install libpng-devel
```

Then, build with PwnableHarness. Running `make publish` will create a
`recovered.tar.gz` archive in the publish directory for this challenge.
This archive should be made available for players to download.

## CTFd Instructions

This challenge needs to check the flag not as a static string but rather
with a regex. It must also be a case-insensitive comparison. The regex for
matching the flag string is stored in [flag.regex](flag.regex).
