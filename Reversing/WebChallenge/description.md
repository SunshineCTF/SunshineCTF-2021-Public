# WebChallenge
## Story
Help!

Our travel backend has broken, and our valuable customers need assistance loading their credit cards from our database.

This is an emergency, just take the entire backend! The intern says something about a decryption script got encrypted or something, she left a lot of detailed comments and debug stuff, everything's well documented, and followed the best Water-Agile-Fall development cycle since the early 2000s.

We normally use the most advanced local webserver and reverse proxy into it from a Jump Box but this is such an emergency, just get it running! The decryptor script is critical to fixing this problem!

Oh how I wish TJ hadn't retired!

## Notes / hints to get going
May want to shove this in a VM. Also it'll probably trip your virus scanner, not that it's doing malicious stuff... just that it looks darn malicious what it's doing. Windows Sandbox would work well, and you can configure it much like you would a Windows box.

This challenge was tested with PowerShell 5.1.19041.1151, and it should also work with 7.2.0-preview.9, but your mileage may vary.

If Windows disables the mshta functionality due to the current zero-day, it's ok, it should be pretty simple to statically determine what's up with that file; that's not obfuscated.