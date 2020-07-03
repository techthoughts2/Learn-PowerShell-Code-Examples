#____________________________________________________________
# https://techthoughts.info/powershell-functions/
#____________________________________________________________

#region links

#Functions
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7

#Parameters
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters?view=powershell-7

#Functions Advanced
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7

#Functions Advanced Parameters
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7

#PowerShell Approved Verbs
#https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7

#CmdletBindingAttribute
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7

#endregion

# ----------------------------------------------
# Anatomy of a PowerShell Function
# ----------------------------------------------
# function help - (optional but strongly encouraged)
# function name
# CmdletBinding - (optional)
# parameters - (optional)
# function logic (optional Begin / Process / End)
# return - (optional)

function Verb-Noun {
    [CmdletBinding()]
    param (

    )

    begin {

    }

    process {

    }

    end {

    }
}

# ----------------------------------------------
# function Help
# ----------------------------------------------
<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    C:\PS>
    Example of how to use this cmdlet
.EXAMPLE
    C:\PS>
    Another example of how to use this cmdlet
.PARAMETER InputObject
    Specifies the object to be processed.  You can also pipe the objects to this command.
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
#>

# ----------------------------------------------
# function CmdletBinding
# ----------------------------------------------
[CmdletBinding()]

# ----------------------------------------------
# function parameters
# ----------------------------------------------

<#
.SYNOPSIS
    Returns weather report information.
.DESCRIPTION
    Console-oriented weather forecast that returns weather information for specified parameters.
.EXAMPLE
    Get-Weather

    Returns full weather information based on the location of your IP with all defaults.
.EXAMPLE
    Get-Weather -Short

    Returns basic weather information based on the location of your IP.
.EXAMPLE
    Get-Weather -City 'London' -Units Metric -Language 'en'

    Returns full weather information for the city of Londa in Metric units with UK language.
.EXAMPLE
    Get-Weather -City 'San Antonio' -Units USCS -Short

    Returns basic weather information for the city of San Antonio in United State customary units.
.PARAMETER City
    The city you would like to get the weather from. If not specified the city of your IP is used.
.PARAMETER Units
    Units to display Metric vs United States cusomtary units
.PARAMETER Language
    Language to display results in
.PARAMETER Short
    Will return only basic weather information
.NOTES
    https://github.com/chubin/wttr.in
    https://wttr.in/:help
#>
function Get-Weather {
    [CmdletBinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $false
        )]
        [string]
        $City,

        [Parameter(Position = 1)]
        [ValidateSet('Metric', 'USCS')]
        [string]
        $Units = 'USCS',

        [Parameter(Position = 2)]
        [ValidateSet('ar', 'af', 'be', 'ca', 'da', 'de', 'el', 'en', 'et', 'fr', 'fa', 'hu', 'ia', 'id', 'it', 'nb', 'nl', 'pl', 'pt-br', 'ro', 'ru', 'tr', 'th', 'uk', 'vi', 'zh-cn', 'zh-tw')]
        [string]
        $Language = 'en',

        [Parameter(Position = 3)]
        [switch]
        $Short
    )

    $uriString = 'https://wttr.in/'

    if ($City) {
        $uriString += "$City"
    }

    switch ($Units) {
        'Metric' {
            $uriString += "?m"
        }
        'USCS' {
            $uriString += "?u"
        }
    }

    if ($Short) {
        $uriString += "&format=4"
    }

    $uriString += "&lang=$Language"

    Write-Verbose "URI: $uriString"

    $invokeSplat = @{
        Uri         = $uriString
        ErrorAction = 'Stop'
    }

    try {
        Invoke-RestMethod @invokeSplat
    }
    catch {
        Write-Error $_
    }
}#Get-Weather

# ----------------------------------------------
# Begin Process End
# ----------------------------------------------

function Get-PipelineBeginEnd {
    param (
        [string]$SomeInput
    )
    begin {
        "Begin: The input is $SomeInput"
    }
    process {
        "The value is: $_"
    }
    end {
        "End:   The input is $SomeInput"
    }
}#Get-PipelineBeginEnd
1, 2, 3 | Get-PipelineBeginEnd -SomeInput 'Test'

# ----------------------------------------------
# Function Return
# ----------------------------------------------
function Get-Total {
    param (
        [int]$Number1,
        [int]$Number2
    )
    $total = $Number1 + $Number2

    return $total
}
Get-Total -Number1 2 -Number2 2

# ----------------------------------------------
# First Function
# ----------------------------------------------

<#
.SYNOPSIS
    Returns your public IP address.
.DESCRIPTION
    Queries the ipify Public IP Address API and returns your public IP.
.EXAMPLE
    Get-PublicIP

    Returns the public IP.
.OUTPUTS
    System.String
.NOTES
    https://github.com/rdegges/ipify-api
#>
function Get-PublicIP {
    $uri = 'https://api.ipify.org'
    try {
        $invokeRestMethodSplat = @{
            Uri         = $uri
            ErrorAction = 'Stop'
        }
        $publicIP = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        Write-Error $_
    }

    return $publicIP
}#Get-PublicIP

# ----------------------------------------------
# Function Scope
# ----------------------------------------------

function Get-NumberTimesTwo {
    [CmdletBinding()]
    param (
        [int]$Number
    )
    $total = $Number * 2
    Write-Debug $total
    return $total
}#Get-NumberTimesTwo
Get-NumberTimesTwo -Number 2 -Debug


<#
.SYNOPSIS
    Launches the default browser to display reddit pictures.
.DESCRIPTION
    Long description
.EXAMPLE
    Show-Pics -URL https://i.imgur.com/fcuRqwl.jpg

    Launches default browser to provided link.
.EXAMPLE
    $severalURLs | Show-Pics

    Launches default browser tab for each provided link.
.PARAMETER URL
    i.redd.it or v.redd.it or imgur URL
.NOTES
    Jake Morrison - @jakemorrison - https://techthoughts.info
#>
function Show-Pics {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'i.redd.it or v.redd.it or imgur URL')]
        [ValidatePattern('i.redd.it|v.redd.it|imgur')]
        [string]$URL
    )

    begin {
        Write-Verbose "Starting Show-Pics function."
    }
    process {
        try {
            Start-Process $URL -ErrorAction Stop
            Write-Verbose "Browser launch successful."
        }
        catch {
            Write-Error $_
        }
    }
    end {
        Write-Verbose "All done."
    }
}#Show-Pics

<#
.SYNOPSIS
    PowerShell based interactive reddit browser
.DESCRIPTION
    Uses PowerShell to establish a connection to reddit and pulls down a JSON payload for the specified subreddit.  The number of threads (default 3) specified by the user is then evaluated and output to the console window.  If the thread is picture-based the user has the option to display those images in their native browser.
.PARAMETER Subreddit
    The name of the desired subreddit - Ex PowerShell or aww
.PARAMETER Threads
    The number of threads that will be pulled down - the default is 3
.PARAMETER ShowPics
    Determines if pics will be shown (if available)
.EXAMPLE
    Get-Reddit -Subreddit PowerShell
    Retrieves the top 3 threads of the PowerShell subreddit
.EXAMPLE
    Get-Reddit -Subreddit aww -Threads 4 -ShowPics
    Retrieves the top 4 threads of the aww subreddit and if pictures are available, displays them in the native browser
.NOTES
    Jake Morrison - @jakemorrison - https://techthoughts.info
#>
function Get-Reddit {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $false,
            Position = 1,
            HelpMessage = 'The name of the desired subreddit')]
        [string]$Subreddit,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $false,
            Position = 2,
            HelpMessage = 'The number of threads that will be pulled down')]
        [ValidateRange(1, 25)]
        [int]$Threads = 3,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $false,
            Position = 3,
            HelpMessage = 'Determines if pics will be shown (if available)')]
        [switch]$ShowPics
    )

    Write-Verbose "Specified subreddit: $Subreddit"
    Write-Verbose "Specified # of threads: $Threads"

    $results = [System.Collections.ArrayList]@()

    Write-Verbose "Initiating Download"
    $uri = "http://www.reddit.com/r/$Subreddit/.json"
    Write-Verbose "URI: $uri"

    try {
        $invokeWebRequestSplat = @{
            Uri         = $uri
            ErrorAction = 'Stop'
        }
        $rawReddit = Invoke-WebRequest @invokeWebRequestSplat
        Write-Verbose "Download successful."
    }
    catch {
        Write-Error $_
        return $results
    }

    if ($rawReddit) {

        Write-Verbose "Converting JSON..."
        $redditInfo = $rawReddit | ConvertFrom-Json

        Write-Verbose "Generating output..."
        for ($i = 0; $i -lt $Threads; $i++) {
            $childObject = $null #reset
            $childObject = $redditInfo.data.children.data[$i]

            $obj = [PSCustomObject]@{
                Title    = $childObject.title
                URL      = $childObject.url
                # PermaLink = $childObject.permalink
                Score    = $childObject.score
                # Ups       = $childObject.ups
                # Downs     = $childObject.downs
                Author   = $childObject.author
                Comments = $childObject.num_comments
            }
            $results.Add($obj) | Out-Null
            if ($obj.URL -like "*i.redd.it*" -or $obj.URL -like "*imgur*" -or $obj.URL -like "*v.redd.it*" -and $ShowPics) {
                Show-Pics -url $obj.URL
            }
        }
    }#if_rawReddit
    else {
        Write-Warning -Message 'No information was returned from reddit.'
    }#else_rawReddit

    return $results

}#Get-Reddit