#region Learn PowerShell Information

[System.Collections.ArrayList]$script:learnPowerShellInfo = @()

$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = '0'
        Title   = 'Should you learn PowerShell?'
        Blog    = 'https://www.techthoughts.info/ps1-should-you-learn-powershell/'
        YouTube = 'https://youtu.be/csuz7qSJv_Q'
        GitHub  = ''
        Tags    = @(
            'PowerShell'
            'Learn'
            'Time'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 1
        Title   = 'PowerShell Basics'
        Blog    = 'https://www.techthoughts.info/learn-and-use-powershell-with-just-three-commands/'
        YouTube = 'https://youtu.be/cDcS6iL1G4I'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP1%20-%20PowerShell%20Basics.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Cmdlets'
            'Verb'
            'Noun',
            'Command'
            'Help'
            'Get-Help'
            'Get-Command'
            'Get-Member'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 2
        Title   = 'PowerShell Pipeline'
        Blog    = 'https://www.techthoughts.info/working-with-the-powershell-pipeline/'
        YouTube = 'https://youtu.be/QKmyf6c83Rs'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP2%20-%20PowerShell%20Pipeline.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Pipeline'
            'PSItem'
            'Format'
            'Select'
            'Object'
            'Sort'
            'Parameters'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 3
        Title   = 'State of the Shell'
        Blog    = 'https://www.techthoughts.info/powershell-history-and-current-state/'
        YouTube = 'https://youtu.be/nQTZRJjcuE4'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP3%20-%20State%20of%20the%20Shell.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'History'
            'pwsh'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 4
        Title   = 'PowerShell Development Setup'
        Blog    = 'https://www.techthoughts.info/getting-setup-powershell-development/'
        YouTube = 'https://youtu.be/J6mQIISjXFA'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP4%20-%20PowerhShell%20Development.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Development'
            'VSCode'
            'Terminal'
            'PSScriptAnalyzer'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 5
        Title   = 'Working With PowerShell Variables'
        Blog    = 'https://www.techthoughts.info/working-with-powershell-variables/'
        YouTube = 'https://youtu.be/4Rc0aEMXiWw'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP5%20-%20PowerShell%20Variables.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Variables'
            'Variable'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 6
        Title   = 'Taking Control with PowerShell Logic'
        Blog    = 'https://www.techthoughts.info/taking-control-with-powershell-logic/'
        YouTube = 'https://youtu.be/nesN4Iznbco'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP6%20-%20PowerShell%20Logic.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Conditional'
            'Switch'
            'Loops'
            'For'
            'Foreach'
            'While'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 7
        Title   = 'PowerShell Input & Output'
        Blog    = 'https://www.techthoughts.info/powershell-input-output/'
        YouTube = 'https://youtu.be/nnTlsNA3hPk'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP7%20-%20PowerShell%20Input%20Output.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Input'
            'Output'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 8
        Title   = 'PowerShell Errors and Exceptions Handling'
        Blog    = 'https://www.techthoughts.info/powershell-errors-and-exceptions-handling/'
        YouTube = 'https://youtu.be/A6afjA5Q9eM'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP8%20-%20PowerShell%20Error%20Handling.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Errors'
            'Exceptions'
            'Terminating'
            'ErrorAction'
            'Try'
            'Catch'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 9
        Title   = 'PowerShell Remoting'
        Blog    = 'https://www.techthoughts.info/powershell-remoting/'
        YouTube = 'https://youtu.be/qvJRaYlxI1w'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP9%20-%20PowerShell%20Remoting.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Remoting'
            'WinRm'
            'SSH'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 10
        Title   = 'PowerShell Scripts'
        Blog    = 'https://www.techthoughts.info/powershell-scripts/'
        YouTube = 'https://youtu.be/IABNJEl2ZWk'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP10%20-%20PowerShell%20Script.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Scripts'
            'Script'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 11
        Title   = 'PowerShell Functions'
        Blog    = 'https://www.techthoughts.info/powershell-functions/'
        YouTube = 'https://youtu.be/qrwPvbCWRtI'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP11%20-%20PowerShell%20Functions.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Functions'
            'Function'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 12
        Title   = 'Manage Cloud with PowerShell'
        Blog    = 'https://www.techthoughts.info/manage-cloud-with-powershell/'
        YouTube = 'https://youtu.be/x-bAD3RX_P0'
        GitHub  = 'https://github.com/techthoughts2/Learn-PowerShell-Code-Examples/blob/master/LearnPowerShell/EP12%20-%20Manage%20Cloud%20with%20PowerShell.ps1'
        Tags    = @(
            'PowerShell'
            'Learn'
            'Cloud'
            'Azure'
            'AWS'
        )
    }) | Out-Null
$script:learnPowerShellInfo.Add([PSCustomObject]@{
        Episode = 13
        Title   = 'PowerShell Modules'
        Blog    = ''
        YouTube = ''
        GitHub  = ''
        Tags    = @(
            'PowerShell'
            'Learn'
            'Module'
            'Modules'
            'psm1'
            'psd1'
        )
    }) | Out-Null
# $script:learnPowerShellInfo.Add([PSCustomObject]@{
#         Episode = 14
#         Title   = ''
#         Blog    = ''
#         YouTube = ''
#         GitHub  = ''
#         Tags    = @(
#             'PowerShell'
#             'Learn'
#         )
#     }) | Out-Null
# $script:learnPowerShellInfo.Add([PSCustomObject]@{
#         Episode = 15
#         Title   = ''
#         Blog    = ''
#         YouTube = ''
#         GitHub  = ''
#         Tags    = @(
#             'PowerShell'
#             'Learn'
#         )
#     }) | Out-Null
# $script:learnPowerShellInfo.Add([PSCustomObject]@{
#         Episode = 16
#         Title   = ''
#         Blog    = ''
#         YouTube = ''
#         GitHub  = ''
#         Tags    = @(
#             'PowerShell'
#             'Learn'
#         )
#     }) | Out-Null
# $script:learnPowerShellInfo.Add([PSCustomObject]@{
#         Episode = 17
#         Title   = ''
#         Blog    = ''
#         YouTube = ''
#         GitHub  = ''
#         Tags    = @(
#             'PowerShell'
#             'Learn'
#         )
#     }) | Out-Null
# $script:learnPowerShellInfo.Add([PSCustomObject]@{
#         Episode = 18
#         Title   = ''
#         Blog    = ''
#         YouTube = ''
#         GitHub  = ''
#         Tags    = @(
#             'PowerShell'
#             'Learn'
#         )
#     }) | Out-Null


#endregion

#region main

<#
.SYNOPSIS
    Returns episode information about the Learn PowerShell series
.DESCRIPTION
    Returns episode information about the Learn PowerShell series
.EXAMPLE
    Get-LearnPowerShellInfo

    Returns all episode information from the Learn PowerShell series
.EXAMPLE
    Get-LearnPowerShellInfo -Tag 'vscode'

    Returns all episode(s) information that are tagged with vscode in the Learn PowerShell series
.EXAMPLE
    Get-LearnPowerShellInfo -EpisodeNumber 5

    Returns information for Episode 5 from the Learn PowerShell series
.PARAMETER Tag
    Topic Tag
.PARAMETER EpisodeNumber
    Episode Number
.OUTPUTS
    System.Management.Automation.PSCustomObject
.NOTES
    Have fun learning PowerShell!
.COMPONENT
    LearnPowerShell
.LINK
    https://www.techthoughts.info/learn-powershell-series/
.LINK
    https://github.com/techthoughts2/Learn-PowerShell-Code-Examples
#>
function Get-LearnPowerShellInfo {
    [CmdletBinding(
        DefaultParameterSetName = 'x'
    )]
    param (
        [Parameter(ParameterSetName = 'Tag',
            Mandatory = $true,
            HelpMessage = 'Topic tag')]
        [string]
        $Tag,
        [Parameter(ParameterSetName = 'Episode',
            Mandatory = $true,
            HelpMessage = 'Episode Number')]
        [ValidateRange(1, 15)]
        [int]
        $EpisodeNumber
    )

    Write-Verbose -Message ('ParameterSetName: {0}' -f $($PSCmdlet.ParameterSetName))

    if ($Tag) {
        Write-Verbose -Message 'Finding episode(s) by tag'
        $result = $script:learnPowerShellInfo | Where-Object { $_.Tags -like "*$Tag*" }
    }
    elseif ($EpisodeNumber) {
        Write-Verbose -Message 'Finding episode by episode number'
        $result = $script:learnPowerShellInfo | Where-Object { $_.Episode -eq $EpisodeNumber }
    }
    else {
        Write-Verbose -Message 'Returning all episode information'
        $result = $script:learnPowerShellInfo
    }

    return $result
}

#endregion
