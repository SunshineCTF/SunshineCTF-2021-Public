
# 2017/11/09 lol what OW doesn't know won't hurt him. TJ
# 2017/11/09 if you're reading this, either you're a maintainer or a hacker. TJ
#
# 2017/11/09 If you're a hacker, get out. I will find you and hunt you down and give you this flag:
# sun{emoji_web_challenge_\ud83e\udd47_moral_just_use_git_never_use_zip_backups}
# if you're wondering what \ud83e\udd47 is... google it... it's an emoji... :D
# 2017/11/10 Well I guess I satisfy the maintainer either/or! I'm OW TJ!
# heheh. Ooops - TJ
# You're darn right! OW

param([Parameter(Mandatory=$true)] $Filename, [Parameter(Mandatory=$true)] $Key)

# safe filenaming so no one will overwrite a file accidentally -TJ
$end_thing = [System.IO.Path]::GetFileNameWithoutExtension($Filename)
$begin_thing = [System.IO.Path]::GetExtension($Filename)
$safe_filename = $end_thing + ".decrypted" + $begin_thing
$safe_path = [SYSTEM.IO.PATH]::Combine([System.IO.PATH]::GetDirectoryName($Filename), $safe_filename)


function fromEmoji64($str)
{
    $newstr=""
    for($i = 0; $i -lt $str.length; ) {
        # 2017/11/09 O(n^2) protection baby! Eat that hackers!
        $beginning_of_string = $str.substring($i, $str.length - $i)

        if ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,176)))) {
            $newstr += "A"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,176)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,177)))) {
            $newstr += "B"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,177)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]194,169)))) {
            $newstr += "C"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]194,169)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,152,160)))) {
            $newstr += "D"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,152,160)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,154)))) {
            $newstr += "E"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,154)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,135)))) {
            $newstr += "F"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,135)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,128,239,184,143)))) {
            $newstr += "G"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,128,239,184,143)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,177,226,128,141,240,159,146,187)))) {
            $newstr += "H"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,177,226,128,141,240,159,146,187)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,159)))) {
            $newstr += "I"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,159)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,131)))) {
            $newstr += "J"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,131)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,185)))) {
            $newstr += "K"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,142,185)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,172)))) {
            $newstr += "L"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,172)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,147,130)))) {
            $newstr += "M"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,147,130)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,153,143)))) {
            $newstr += "N"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,153,143)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,190)))) {
            $newstr += "O"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,190)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,191)))) {
            $newstr += "P"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,133,191)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,134)))) {
            $newstr += "Q"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,134)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,176)))) {
            $newstr += "R"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,176)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,185)))) {
            $newstr += "S"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,185)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,150)))) {
            $newstr += "T"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,150)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,184)))) {
            $newstr += "U"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,184)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,156,136)))) {
            $newstr += "V"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,156,136)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,171)))) {
            $newstr += "W"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,171)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,157,140)))) {
            $newstr += "X"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,157,140)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,185)))) {
            $newstr += "Y"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,185)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,170)))) {
            $newstr += "Z"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,164,170)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,160)))) {
            $newstr += "a"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,148,160)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,132)))) {
            $newstr += "b"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,132)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,147,134)))) {
            $newstr += "c"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,147,134)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,128)))) {
            $newstr += "d"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,146,128)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,154,161)))) {
            $newstr += "e"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,154,161)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,188)))) {
            $newstr += "f"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,188)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,130,239,184,143)))) {
            $newstr += "g"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,140,239,184,143,226,128,141,226,153,130,239,184,143)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,160)))) {
            $newstr += "h"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,155,160)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,132,185)))) {
            $newstr += "i"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,132,185)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,165,159)))) {
            $newstr += "j"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,165,159)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,182)))) {
            $newstr += "k"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,166,182)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,170)))) {
            $newstr += "l"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,170)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,153,226,128,141,226,153,130,239,184,143)))) {
            $newstr += "m"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,153,226,128,141,226,153,130,239,184,143)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,143,173)))) {
            $newstr += "n"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,143,173)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,173,149)))) {
            $newstr += "o"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,173,149)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,140,143)))) {
            $newstr += "p"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,140,143)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,175)))) {
            $newstr += "q"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,167,175)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]194,174)))) {
            $newstr += "r"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]194,174)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,141,182)))) {
            $newstr += "s"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,141,182)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,147)))) {
            $newstr += "t"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,143,147)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,189)))) {
            $newstr += "u"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,145,189)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,162)))) {
            $newstr += "v"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,162)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,169)))) {
            $newstr += "w"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,152,169)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,156,150)))) {
            $newstr += "x"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,156,150)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,159,168)))) {
            $newstr += "y"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,159,168)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,141)))) {
            $newstr += "z"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,141)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]48,239,184,143,226,131,163)))) {
            $newstr += "0"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]48,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]49,239,184,143,226,131,163)))) {
            $newstr += "1"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]49,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]50,239,184,143,226,131,163)))) {
            $newstr += "2"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]50,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]51,239,184,143,226,131,163)))) {
            $newstr += "3"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]51,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]52,239,184,143,226,131,163)))) {
            $newstr += "4"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]52,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]53,239,184,143,226,131,163)))) {
            $newstr += "5"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]53,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]54,239,184,143,226,131,163)))) {
            $newstr += "6"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]54,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]55,239,184,143,226,131,163)))) {
            $newstr += "7"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]55,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]56,239,184,143,226,131,163)))) {
            $newstr += "8"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]56,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]57,239,184,143,226,131,163)))) {
            $newstr += "9"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]57,239,184,143,226,131,163)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]226,143,175)))) {
            $newstr += "+"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]226,143,175)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,137)))) {
            $newstr += "/"
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,154,137)).length
        }
        elseif ($beginning_of_string.StartsWith([System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,142)))) {
            $newstr += "="
            $i += [System.Text.Encoding]::UTF8.GetString(@([byte]240,159,144,142)).length
        }
        else {
            $i++
        }
    }

    return $newstr
}

function decrypt($str, $key)
{
    $bytes = [System.Convert]::FromBase64String($str)
    $key_bytes = $key.toCharArray()

    # 2017/11/08 This is unbreakable, it uses a one-time pad - provably secure - TJ
    for($i = 0; $i -lt $bytes.length; $i++) {
        $bytes[$i] = ($bytes[$i] + 256 - $key_bytes[$i % $key_bytes.length]) % 256
    }

    # reverse Caesar to the rescue! to bad brutus got to him.
    for($i = 0; $i -lt $bytes.length; $i++) {
        $bytes[$i] = ($bytes[$i] + 253) % 256
    }

    # reverse shuffle. lol same as normal shuffle
    if ($bytes.length % 2 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 2); $i++) {
            $cur_pos = $i * 2
            $orig = $bytes[$cur_pos..$($cur_pos + 2)]
            $bytes[$cur_pos + 0] = $orig[1]
            $bytes[$cur_pos + 1] = $orig[0]
        }
    }
    
    # add to bytes
    if ($bytes.length % 3 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 3); $i++) {
            $cur_pos = $i * 3
            $orig = $bytes[$cur_pos..$($cur_pos + 3)]
            $orig[0] = ($orig[0] + 249) % 256
            $orig[1] = ($orig[1] + 253) % 256
            $orig[2] = ($orig[2] + 255) % 256
            $bytes[$cur_pos + 0] = $orig[0]
            $bytes[$cur_pos + 1] = $orig[1]
            $bytes[$cur_pos + 2] = $orig[2]
        }
    }
    
    # add and reverse shuffle bytes
    if ($bytes.length % 5 -eq 0) {
        for($i = 0; $i -lt $($bytes.length / 5); $i++) {
            $cur_pos = $i * 5
            $orig = $bytes[$cur_pos..$($cur_pos + 5)]
            $bytes[$cur_pos + 0] = $orig[1]
            $bytes[$cur_pos + 1] = $orig[2]
            $bytes[$cur_pos + 2] = $orig[3]
            $bytes[$cur_pos + 3] = $orig[4]
            $bytes[$cur_pos + 4] = $orig[0]
            $bytes[$cur_pos + 0] = ($bytes[$cur_pos + 0] + 253) % 256
            $bytes[$cur_pos + 1] = ($bytes[$cur_pos + 1] + 255) % 256
            $bytes[$cur_pos + 2] = ($bytes[$cur_pos + 2] + 0) % 256
            $bytes[$cur_pos + 3] = ($bytes[$cur_pos + 3] + 1) % 256
            $bytes[$cur_pos + 4] = ($bytes[$cur_pos + 4] + 2) % 256
        }
    }

    # shuffle bytes lol it's the same
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

    return [System.Text.Encoding]::UTF8.GetString($bytes)
}

$todecrypt=gc $Filename -Encoding utf8 -Raw
$todecrypt=fromEmoji64 "$todecrypt"
echo "file $Filename -> $safe_path w/$Key"
# $decrypted = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($todecrypt))
$decrypted=decrypt "$todecrypt" "$Key"
Set-content -Force -PAth $safe_path -Encoding utf8 -Value "$decrypted"