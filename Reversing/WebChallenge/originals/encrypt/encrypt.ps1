# Man sure glad I can use SysMon to find this file without decrypting it manually, but don't tell OW - TJ
# IT WOULD""VE BEEEN NICE TO KNWO! - OW

# heh. oops - TJ

param([Parameter(Mandatory=$true)] $Filename, [Parameter(Mandatory=$true)] $Key)

# safe filenaming so no one will overwrite a file accidentally -TJ
$end_thing = [System.IO.Path]::GetFileNameWithoutExtension($Filename)
$begin_thing = [System.IO.Path]::GetExtension($Filename)
$safe_filename = $end_thing + ".encrypted" + $begin_thing
$safe_path = [SYSTEM.IO.PATH]::Combine([System.IO.PATH]::GetDirectoryName($Filename), $safe_filename)

# TJ: while writing this, was inspired in part by https://github.com/watson/base64-emoji
function toEmoji64($str)
{
    $newstr = ""
    $convert_to_table = New-Object system.collections.hashtable
    $convert_to_table["A"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,176))
    $convert_to_table["B"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,177))
    $convert_to_table["C"] = [System.Text.Encoding]::UTF8.GetString(@([byte]194,169))
    $convert_to_table["D"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,152,160))
    $convert_to_table["E"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,154))
    $convert_to_table["F"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,135))
    $convert_to_table["G"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,128,239,184,143))
    $convert_to_table["H"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,177,226,128,141,240,159,146,187))
    $convert_to_table["I"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,159))
    $convert_to_table["J"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,131))
    $convert_to_table["K"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,185))
    $convert_to_table["L"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,172))
    $convert_to_table["M"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,147,130))
    $convert_to_table["N"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,153,143))
    $convert_to_table["O"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,190))
    $convert_to_table["P"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,191))
    $convert_to_table["Q"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,134))
    $convert_to_table["R"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,176))
    $convert_to_table["S"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,185))
    $convert_to_table["T"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,150))
    $convert_to_table["U"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,184))
    $convert_to_table["V"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,156,136))
    $convert_to_table["W"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,171))
    $convert_to_table["X"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,157,140))
    $convert_to_table["Y"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,185))
    $convert_to_table["Z"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,170))
    $convert_to_table["a"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,160))
    $convert_to_table["b"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,132))
    $convert_to_table["c"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,147,134))
    $convert_to_table["d"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,128))
    $convert_to_table["e"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,154,161))
    $convert_to_table["f"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,188))
    $convert_to_table["g"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,130,239,184,143))
    $convert_to_table["h"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,160))
    $convert_to_table["i"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,132,185))
    $convert_to_table["j"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,165,159))
    $convert_to_table["k"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,182))
    $convert_to_table["l"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,170))
    $convert_to_table["m"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,153,226,128,141,226,153,130,239,184,143))
    $convert_to_table["n"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,143,173))
    $convert_to_table["o"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,173,149))
    $convert_to_table["p"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,140,143))
    $convert_to_table["q"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,175))
    $convert_to_table["r"] = [System.Text.Encoding]::UTF8.GetString(@([byte]194,174))
    $convert_to_table["s"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,141,182))
    $convert_to_table["t"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,147))
    $convert_to_table["u"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,189))
    $convert_to_table["v"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,162))
    $convert_to_table["w"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,169))
    $convert_to_table["x"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,156,150))
    $convert_to_table["y"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,159,168))
    $convert_to_table["z"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,141))
    $convert_to_table["0"] = [System.Text.Encoding]::UTF8.GetString(@([byte]48,239,184,143,226,131,163))
    $convert_to_table["1"] = [System.Text.Encoding]::UTF8.GetString(@([byte]49,239,184,143,226,131,163))
    $convert_to_table["2"] = [System.Text.Encoding]::UTF8.GetString(@([byte]50,239,184,143,226,131,163))
    $convert_to_table["3"] = [System.Text.Encoding]::UTF8.GetString(@([byte]51,239,184,143,226,131,163))
    $convert_to_table["4"] = [System.Text.Encoding]::UTF8.GetString(@([byte]52,239,184,143,226,131,163))
    $convert_to_table["5"] = [System.Text.Encoding]::UTF8.GetString(@([byte]53,239,184,143,226,131,163))
    $convert_to_table["6"] = [System.Text.Encoding]::UTF8.GetString(@([byte]54,239,184,143,226,131,163))
    $convert_to_table["7"] = [System.Text.Encoding]::UTF8.GetString(@([byte]55,239,184,143,226,131,163))
    $convert_to_table["8"] = [System.Text.Encoding]::UTF8.GetString(@([byte]56,239,184,143,226,131,163))
    $convert_to_table["9"] = [System.Text.Encoding]::UTF8.GetString(@([byte]57,239,184,143,226,131,163))
    $convert_to_table["+"] = [System.Text.Encoding]::UTF8.GetString(@([byte]226,143,175))
    $convert_to_table["/"] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,137))
    $convert_to_table["="] = [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,142))

    # man it's much easier to encode emojis than decode them. - TJ
    # good thing it's in the decryption script, that was a pain to write - OW
    # yeah but think of the security, no one will figure out it's base64 - TJ
    # true, true, true, -OW
    $chars=$str.toCharArray()
    foreach($letter in $chars) {
        $newstr += $convert_to_table["" + $letter]
    }

    return $newstr
}

# this is super secure - TJ
# i know, I tried for a while to break it, couldn't find a way - OW
# I moved the decrypt to another file, so no one could break it - TJ
# Good good good, now they'll never decrypt our customer credit card data - OW
function encrypt($str, $key)
{
    $bytes = [system.Text.Encoding]::UTF8.GetBytes($str)

    # shuffle bytes
    if ($bytes.length % 7 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 7); $i++) {
            $cur_pos = $i * 7
            $orig = $bytes[$cur_pos..$($cur_pos + 7)]
            $bytes[$cur_pos + 0] = $orig[0]
            $bytes[$cur_pos + 1] = $orig[2]
            $bytes[$cur_pos + 2] = $orig[1]
            $bytes[$cur_pos + 3] = $orig[6]
            $bytes[$cur_pos + 4] = $orig[5]
            $bytes[$cur_pos + 5] = $orig[4]
            $bytes[$cur_pos + 6] = $orig[3]
        }
    }

    # add and shuffle bytes
    if ($bytes.length % 5 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 5); $i++) {
            $cur_pos = $i * 5
            $orig = $bytes[$cur_pos..$($cur_pos + 5)]
            $orig[0] = ($orig[0] + 3) % 256
            $orig[1] = ($orig[1] + 1) % 256
            $orig[2] = ($orig[2] + 0) % 256
            $orig[3] = ($orig[3] + 255) % 256
            $orig[4] = ($orig[4] + 254) % 256
            $bytes[$cur_pos + 0] = $orig[4]
            $bytes[$cur_pos + 1] = $orig[0]
            $bytes[$cur_pos + 2] = $orig[1]
            $bytes[$cur_pos + 3] = $orig[2]
            $bytes[$cur_pos + 4] = $orig[3]
        }
    }

    # add to bytes
    if ($bytes.length % 3 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 3); $i++) {
            $cur_pos = $i * 3
            $orig = $bytes[$cur_pos..$($cur_pos + 3)]
            $orig[0] = ($orig[0] + 7) % 256
            $orig[1] = ($orig[1] + 3) % 256
            $orig[2] = ($orig[2] + 1) % 256
            $bytes[$cur_pos + 0] = $orig[0]
            $bytes[$cur_pos + 1] = $orig[1]
            $bytes[$cur_pos + 2] = $orig[2]
        }
    }

    # shuffle
    if ($bytes.length % 2 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 2); $i++) {
            $cur_pos = $i * 2
            $orig = $bytes[$cur_pos..$($cur_pos + 2)]
            $bytes[$cur_pos + 0] = $orig[1]
            $bytes[$cur_pos + 1] = $orig[0]
        }
    }

    # Caesar to the rescue! to bad brutus got to him.
    for($i = 0; $i -lt $bytes.length; $i++) {
        $bytes[$i] = ($bytes[$i] + 3) % 256
    }

    $key_bytes = $key.toCharArray()
    # 2017/11/08 This is unbreakable, it uses a one-time pad - provably secure - TJ
    for($i = 0; $i -lt $bytes.length; $i++) {
        $bytes[$i] = ($bytes[$i] + $key_bytes[$i % $key_bytes.length]) % 256
    }

    [System.Convert]::ToBase64String($bytes)
}

$toencrypt=gc $Filename -Encoding utf8 -Raw
echo "file $Filename -> $safe_path w/$Key"
# $encrypted = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($toencrypt))
$encrypted=encrypt "$toencrypt" "$Key"
$encrypted=toEmoji64 "$encrypted" 
SET-CONTENT -Force -PaTH $safe_path -NoNewLine -Encoding utf8 -Value "$encrypted"