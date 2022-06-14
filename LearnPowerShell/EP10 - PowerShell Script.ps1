#____________________________________________________________
# https://www.techthoughts.info/powershell-scripts/
#____________________________________________________________

#region links

#About Execution Policies
#https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6

#About Scripts
#https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scripts?view=powershell-6

#endregion

#region running scripts

#get the execution policy of all scopes in the order of precedence
Get-ExecutionPolicy -List

#change execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#unblock a script downloaded from the internet after you have read and understood the code
Unblock-File -Path .\drive_warn.ps1

#run a local script
.\drive_warn.ps1

#run a local script in the current scope
. .\drive_warn.ps1

#endregion

#region script example

param (
    [Parameter(Mandatory = $true)]
    [string]
    $Drive
)

if ($PSVersionTable.Platform -eq 'Unix') {
    $logPath = '/tmp'
}
else {
    $logPath = 'C:\Logs' #log path location
}

#need linux path

$logFile = "$logPath\driveCheck.log" #log file

#verify if log directory path is present. if not, create it.
try {
    if (-not (Test-Path -Path $logPath -ErrorAction Stop )) {
        # Output directory not found. Creating...
        New-Item -ItemType Directory -Path $logPath -ErrorAction Stop | Out-Null
        New-Item -ItemType File -Path $logFile -ErrorAction Stop | Out-Null
    }
}
catch {
    throw
}

Add-Content -Path $logFile -Value "[INFO] Running $PSCommandPath"

#verify that the required Telegram module is installed.
if (-not (Get-Module -ListAvailable -Name PoshGram)) {
    Add-Content -Path $logFile -Value '[INFO] PoshGram not installed.'
    throw
}
else {
    Add-Content -Path $logFile -Value '[INFO] PoshGram module verified.'
}

#get hard drive volume information and free space
try {
    if ($PSVersionTable.Platform -eq 'Unix') {
        $volume = Get-PSDrive -Name $Drive -ErrorAction Stop
        #verify volume actually exists
        if ($volume) {
            $total = $volume.Free + $volume.Used
            $percentFree = [int](($volume.Free / $total) * 100)
            Add-Content -Path $logFile -Value "[INFO] Percent Free: $percentFree%"
        }
        else {
            Add-Content -Path $logFile -Value "[ERROR] $Drive was not found."
            throw
        }
    }
    else {
        $volume = Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter -eq $Drive }
        #verify volume actually exists
        if ($volume) {
            $total = $volume.Size
            $percentFree = [int](($volume.SizeRemaining / $total) * 100)
            Add-Content -Path $logFile -Value "[INFO] Percent Free: $percentFree%"
        }
        else {
            Add-Content -Path $logFile -Value "[ERROR] $Drive was not found."
            throw
        }
    }
}
catch {
    Add-Content -Path $logFile -Value '[ERROR] Unable to retrieve volume information:'
    Add-Content -Path $logFile -Value $_
    throw
}

#evaluate if a message needs to be sent if the drive is below 20GB free space
if ($percentFree -le 20) {

    try {
        Import-Module PoshGram -ErrorAction Stop
        Add-Content -Path $logFile -Value '[INFO] PoshGram imported successfully.'
    }
    catch {
        Add-Content -Path $logFile -Value '[ERROR] PoshGram could not be imported:'
        Add-Content -Path $logFile -Value $_
        throw
    }

    Add-Content -Path $logFile -Value '[INFO] Sending Telegram notification'

    $messageSplat = @{
        BotToken    = "#########:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        ChatID      = "-#########"
        Message     = "[LOW SPACE] Drive at: $percentFree%"
        ErrorAction = 'Stop'
    }

    try {
        Send-TelegramTextMessage @messageSplat
        Add-Content -Path $logFile -Value '[INFO] Message sent successfully'
    }
    catch {
        Add-Content -Path $logFile -Value '[ERROR] Error encountered sending message:'
        Add-Content -Path $logFile -Value $_
        throw
    }

}

#endregion
