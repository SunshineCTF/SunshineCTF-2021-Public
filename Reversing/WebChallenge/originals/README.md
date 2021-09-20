# How to recreate the challenges from these raw files
## database
1. take the contents of the vbs file, dump it into VS Code, replace newlines with \ns, replace "s with \"s and then dump it into a web browser console as an argument string to the method encode()
   ```js
   encode("vbs\"stuffhere\nhiworld")
   ```
2. Take that string and dump it into the jscript_stage where the insert section is marked.
3. Take the completed jscript, dump it into the site https://www.browserling.com/tools/number-lines.
4. Dump that into https://www.browserling.com/tools/random-lines, and remove the .s in the front with a regex, ie `"^([0-9]+)\." --> "$1"`.
5. Convert them into strings, with more regexes: `'"' --> '\"'`, `"^(.*)$" --> '"$1"'`, `"^(.*)$" --> "$1,"`, then take those string array entries  place it inside the csharp script file.
6. Convert the c# script into a base64 string.
7. Shove that into the batch file in the f15 line.
8. Profit!

## decryption
1. easy-peasy.
2. Take the encrypt script, pass it the pat to the decrypt script, and the key "4263435718112958".
3. Profit!

## encryption
1. harder. or more annoying anyhow.
2. Take the encrypt script, and pass it to Invoke-Obfuscation (obtain from https://github.com/danielbohannon/Invoke-Obfuscation).
3. I don't trust it too much, so run it in a VM, I didn't see anything in the module output but wasn't really looking.
4. Be very careful with the options, particularly encode and compress, they sometimes error out > 65k characters.
5. Apply a bunch of rounds of compress (do not let it go beyond 65k).
6. Apply several rounds of AES (if it goes beyond 65k, test to make sure it's still working).
7. You can apply as many rounds of Token All obfuscation as you want, no limit.
8. Store the output and copy it out of the VM. At this point it'll probably trip your virus scanner and you won't be able to run it outside the VM.