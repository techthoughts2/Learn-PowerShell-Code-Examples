#____________________________________________________________
# https://www.techthoughts.info/getting-setup-powershell-development/
#____________________________________________________________
code --list-extensions
code --install-extension ms-vscode.PowerShell

# PowerShell base VSCode settings:
<#
{
    // editor
    "editor.quickSuggestionsDelay": 1,
    "editor.tabCompletion": "on",
    "files.defaultLanguage": "powershell",

    // powershell settings changes

    // you can specify a custom location for the powershell.exe/pwsh.exe file
    // not required if you just want to use the default locations
    "powershell.powerShellAdditionalExePaths": {
        "PS7": "C:\\Program Files\\PowerShell\\7\\pwsh.exe",
        "PS5.1": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
    },
    "powershell.powerShellDefaultVersion": "PS7",
    "powershell.codeFormatting.preset":"Stroustrup",
    "powershell.startAutomatically": true,
    "powershell.scriptAnalysis.enable": true,
    "powershell.integratedConsole.showOnStartup": false,
    "powershell.integratedConsole.focusConsoleOnExecute": true
}
#>
