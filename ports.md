Port Assignments
=====

Port assignment convention (shared across all SunshineCTF archive years):

    port = yycnn

- `yy` = last two digits of the competition year (21 for 2021)
- `c`  = category: 0 pwn, 1 reversing, 2 scripting, 3 web, 4 crypto,
        5 misc (also forensics/other), 6 speedrun, 7 pegasus
- `nn` = challenge index within the category

The two ports that were already convention-compliant in the original repo
(21001, 21101) are kept. Everything else is numbered starting at 01, ordered by
point value then name. ProcrastinatorProgrammer is one challenge split into three
parts, which take consecutive ports (21201-21203).

Only hosted challenges (those with a running server component) are listed. The
reversing challenges ChompFeed and ImageRecovery are build-only (downloadable)
and are not hosted.

| Challenge Name | Category | Author | Directory | Host | Port | Connection |
|----------------|----------|--------|-----------|------|-----:|------------|
| DynamicTypeLibraRII | Pwn | novafacing (RII) | Pwn/DynamicTypeLibraRII | ctf.hackucf.org | 21001 | `nc ctf.hackucf.org 21001` |
| UselessVM | Reversing | crandyman | Reversing/UselessVM | ctf.hackucf.org | 21101 | `nc ctf.hackucf.org 21101` |
| ProcrastinatorProgrammer (part 1) | Scripting | solarbonite | Scripting/ProcrastinatorProgrammer | ctf.hackucf.org | 21201 | `nc ctf.hackucf.org 21201` |
| ProcrastinatorProgrammer (part 2) | Scripting | solarbonite | Scripting/ProcrastinatorProgrammer | ctf.hackucf.org | 21202 | `nc ctf.hackucf.org 21202` |
| ProcrastinatorProgrammer (part 3) | Scripting | solarbonite | Scripting/ProcrastinatorProgrammer | ctf.hackucf.org | 21203 | `nc ctf.hackucf.org 21203` |
| emoji-browser | Web | shuga__ | Web/emoji-browser | emoji-browser.ctf.hackucf.org | 21301 | https://emoji-browser.ctf.hackucf.org |
| Flag Vault 1 | Web | Helithumper | Web/flag-vault-1 | flag-vault-1.ctf.hackucf.org | 21302 | https://flag-vault-1.ctf.hackucf.org |
| typing | Misc | aleccoder | Misc/typing | typing.ctf.hackucf.org | 21501 | https://typing.ctf.hackucf.org |
