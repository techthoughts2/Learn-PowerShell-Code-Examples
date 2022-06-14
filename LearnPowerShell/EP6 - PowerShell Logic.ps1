#____________________________________________________________
# https://www.techthoughts.info/taking-control-with-powershell-logic/
#____________________________________________________________
##################################################
#CONDITIONAL
# do something based on a condition
if ('a condition is met') {
    # do something / take an action
}
elseif ('a different condition is met') {
    # do something different
}
else {
    # do something else
}

#-------------------------------------------------

$path = 'C:\Test' #windows
# $path = /home #linux
$evalPath = Test-Path $path
if ($evalPath -eq $true) {
    Write-Host "$path VERIFIED"
}
elseif ($evalPath -eq $false) {
    Write-Host "$path NOT VERIFIED"
}

#COMPARISON OPERATORS
##################################################
#SWITCH
[int]$aValue = Read-Host 'Enter a number'
switch ($aValue) {
    1 {
        Write-Host 'You entered the number ONE'
    }
    2 {
        Write-Host 'You entered the number TWO'
    }
    3 {
        Write-Host 'You entered the number THREE'
    }
    4 {
        Write-Host 'You entered the number FOUR'
    }
    5 {
        Write-Host 'You entered the number FIVE'
    }
    Default {
        Write-Host "Sorry, I don't know what to do with $aValue"
    }
}

##################################################
# LOOPS
for ($i = 0; $i -le 15; $i++) {
    Write-Host $i -ForegroundColor $i
}

#-------------------------------------------------

$aString = 'Jean-Luc Picard'
$reverseString = ''
for ($i = $aString.Length; $i -ge 0; $i--) {
    $reverseString += $aString[$i]
}
$reverseString

##################################################

$path = 'C:\Test'
[int]$totalSize = 0
$fileInfo = Get-ChildItem $path -Recurse
foreach ($file in $fileInfo) {
    $totalSize += $file.Length
}
Write-Host "The total size of file in $path is $($totalSize /1MB) MB."

##################################################

#-------------------------------------------------
# do while loop
$pathVerified = $false
do {
    # in a do while, the user will always be prompted at least once
    $path = Read-Host 'Please enter a file path to evaluate'
    if (Test-Path $path) {
        $pathVerified = $true
    }
} while ($pathVerified -eq $false)
#-------------------------------------------------
# while loop
$pathVerified = $true
while ($pathVerified -eq $false) {
    # in a while loop, you might never enter the loop
    $path = Read-Host 'Please enter a file path to evaluate'
    if (Test-Path $path) {
        $pathVerified = $true
    }
}
#-------------------------------------------------

$largeProcesses = Get-Process | Where-Object { $_.WorkingSet64 -gt 50MB }

$largeProcesses = @()
$processes = Get-Process
foreach ($process in $processes) {
    if ($process.WorkingSet64 -gt 50MB) {
        $largeProcesses += $process
    }
}

#-------------------------------------------------

$path = 'C:\Test'
$folderCount = 0
Get-ChildItem $path | ForEach-Object -Process { if ($_.PSIsContainer) { $folderCount++ } }
$folderCount

#-------------------------------------------------

# declare a few variables for counting
[int]$fileCount = 0
[int]$folderCount = 0
[int]$totalSize = 0

# declare our path we want to evaluate
$path = 'C:\Test'

# get the file information
$rawFileInfo = Get-ChildItem $path -Recurse

# loop through that file information
foreach ($item in $rawFileInfo) {
    if ($item.PSIsContainer) {
        # this is a folder/directory
        $folderCount++
    }
    else {
        # this is a file, because it is not a PSIsContainer
        $fileCount++
        $totalSize += $item.Length
    }
}

# generate output
Write-Host "Breakdown of $path"
Write-Host "Total Directories: $folderCount"
Write-Host "Total Files: $fileCount"
Write-Host "Total Size of files: $($totalSize / 1MB) MB"

#-------------------------------------------------
