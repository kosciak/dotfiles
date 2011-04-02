let PLUGIN_INFO =
<VimperatorPlugin>
<name>KosciaK-misc</name>
<description>Kosciak's Vimperator scripts</description>
<minVersion>2.0pre</minVersion>
<maxVersion>2.0</maxVersion>
<updateURL></updateURL>
<author mail="kosciak@kosciak.net" homepage="http://kosciak.blox.pl/">Wojciech 'KosciaK' Pietrzok</author>
<license></license>
<version>0.1</version>
<detail><![CDATA[
My custom Vimperator scripts

== Commands ==
  :fav[toggle]:
    Toggle Faviconize tab.
  :webd[eveloper], wd:
    Toggle Web Developer toolbar.
  :httpfox, hf:
    Toggle HttpFox.
  :httpfox!, hf!:
    Open HttpFox in window.
]]></detail>
</VimperatorPlugin>;

(function() {
    commands.addUserCommand(
        ['fav[toggle]'],
        'Faviconize tab ',
        function () {
            if (typeof(faviconize) == 'object') {
                faviconize.toggle();
            } else {
                liberator.echoerr('FaviconizeTab is not installed or disabled');
            }
        },
        true
    );
    
    commands.addUserCommand(
        ['httpfox', 'hf'],
        'Toggle HttpFox window ',
        function (args) {
            if (typeof(HttpFox) == 'object') {
                if (args.bang)
                    HttpFox.cmd_hf_detach();
                else
                    HttpFox.cmd_hf_togglePanel();
            } else {
                liberator.echoerr('HttpFox is not installed or disabled');
            }
        },
        { 
            bang: true 
        },
        true
    );
    
    commands.addUserCommand(
        ['webd[eveloper]', 'wd'],
        'Toggle Web Developer toolbar ',
        function () {
            if (document.getElementById("webdeveloper-toolbar")) {
                webdeveloper_toggleToolbar();
            } else {
                liberator.echoerr('Web Developer is not installed or disabled');
            }
        },
        true
    );
    
    commands.addUserCommand(
        ['fire[bug]', 'fb'],
        'Toggle Firebug toolbar ',
        function () {
            if (typeof(Firebug) == 'object') {
                Firebug.toggleBar();
            } else {
                liberator.echoerr('Firebug is not installed or disabled');
            }
        },
        true
    );
    
})();

