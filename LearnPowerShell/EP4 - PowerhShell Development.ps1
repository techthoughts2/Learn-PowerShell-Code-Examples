#____________________________________________________________
# https://techthoughts.info/getting-setup-powershell-development/
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

    // default shell
    // Windows
        // PowerShell 6
            "terminal.integrated.shell.windows": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
            "powershell.powerShellExePath": "C:\\Program Files\\PowerShell\\6\\pwsh.exe",
        //PowerShell 5.1 and below
            // "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
            // "powershell.powerShellExePath": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    // Linux
        // Ubuntu
            // "terminal.integrated.shell.linux": "/snap/powershell/36/opt/powershell/pwsh",
            // "powershell.powerShellExePath": "/snap/powershell/36/opt/powershell/pwsh",

    // powershell settings changes
    "powershell.codeFormatting.preset":"Stroustrup",
    "powershell.startAutomatically": true,
    "powershell.scriptAnalysis.enable": true,
    "powershell.integratedConsole.showOnStartup": false,
    "powershell.integratedConsole.focusConsoleOnExecute": true,
}
#>