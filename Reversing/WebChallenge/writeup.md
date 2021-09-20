# Writeup
## Idea of Challenge
The design of the challenge was to troll the users who complained about not having enough web challenges last year.

Also I was thinking it'd be interesting to do web-type attacks on a completely locally hosted app, kinda like Web RE. :D

So the original idea was a local SQL database using VBS, and doing all sorts of stuff. That's not installed by default though, so switched tactics.

Instead, the challenge uses every default-installed scripting language I could find in Windows.

Batch? ✅

PowerShell? ✅

VBScript? ✅

JScript (not JavaScript... JScript)? ✅

I thought about VBA but that's not installed as far as I could tell, and didn't want to force users to grab a copy of Word to complete the challenge.

It would be more realistic, but that's that.

### Story
At some point everyone works something legacy. So I used every legacy thing I could find, and made the code base hard to follow, although not unintuitive.

An intern-type person accidentally encrypted their precious decrypt script, and you have to figure out how to undo the damage.

# Solve process
There are three main parts of the challenge:
1. The encryption script
2. The "database"
3. The decryption script that has been ironically encrypted with a terrifically bad encryption scheme.

## Possible solve:
1. You can immediately solve it as a crypto challenge. I mean it's possible, but highly not recommended, in this case it's way easier to treat it as an RE type web challenge.
## Recommended solve:
1. Dump the scripts into a VM, and execute them dynamically.
2. I like to use Windows Sandbox as it's isolated from the host, well-tested, but can access network resources if needed (for this challenge other than making it slightly less ugly it isn't needed).
3. Start up an instance.
4. Dump the scripts into it.
5. Setup PowerShell module logging following the guide here: https://adamtheautomator.com/powershell-logging-2/
6. Execute the encrypt script dynamically passing some junk values in.
7. Fetch the encryption script.
8. Wail and realize you're not done.
9. Reverse the dumb thing it's doing.
10. Create a decryption script.
11. Realize you need a key.
12. Read the notes in the HTA.
13. Realize the stunningly well-written plot, showing that the intern encrypted it with the test cc data! Somehow.
14. hack open the database (ok hack may not be a super term... it prints to the screen what it's doing, you can skip a step here and go to the JScript directly)
    1.  Open the batch, realize the thin disguise on the powershell... containing C#!!!
    2.  Open the C#, realize that it sucks, and you hate me, but you can grab another file inside it, which is... JavaScript?
    3.  Futz around before you realize it's JScript, despise me more.
    4.  Go the wrong path, and then go the right path, and reveal another masterpiece...
15. An entire database written in Visual Basic... err Visual Basic Script.
16. Fetch the credit card number from the file "4263435718112958"
17. Realize that you can't just decode emoji directly as it's not that simple they're multi-byte chars.
18. Decode the emoji64! Perhaps using python, or some other programming language where you can treat the individual emoji as chars. Heck just dump it in VS Code once you figure out the association.
19. Reverse the decryption script, and be met with the flag.
20. Never complain about lack of WebChallenges with Emoji again!
# Note
This is a web challenge, super truthful in the marketing here. :D