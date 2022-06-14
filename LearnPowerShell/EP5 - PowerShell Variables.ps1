#____________________________________________________________
# https://www.techthoughts.info/working-with-powershell-variables/
#____________________________________________________________
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-6
#https://docs.microsoft.com/en-us/powershell/scripting/learn/using-variables-to-store-objects?view=powershell-6
#____________________________________________________________
Get-Process
$processes = Get-Process
$processes
#----------------------------------------
# not using variable
Get-Process | Where-Object { $_.CPU -gt 5000 } #find processes keeping the CPU busy
Get-Process | Sort-Object WorkingSet64 -Descending #sort processes by memory usage
#----------------------------------------
# using variable
$processes = Get-Process
$processes | Where-Object { $_.CPU -gt 5000 } #find processes keeping the CPU busy
$processes | Sort-Object WorkingSet64 -Descending #sort processes by memory usage
#----------------------------------------
# not strong typed
$myNewVariable

# data types
#----------------------------------------
$total = 2 + 2
$total
$total | Get-Member
#----------------------------------------
$total = '2 + 2'
$total
$total | Get-Member
#____________________________________________________________
# understanding data types

$num1 = 2
$num2 = 2
$total = $num1 + $num2
$total
#----------------------------------------
$num1 = '2'
$num2 = '2'
$total = $num1 + $num2
$total
#----------------------------------------

#strong type
#----------------------------------------
[int]$num1 = '2'
[int]$num2 = '2'
$total = $num1 + $num2
#----------------------------------------

#convert
#----------------------------------------
$stringReturn = $total.ToString()
$total | Get-Member
#----------------------------------------

#quotes
$literal = 'Two plus one equals: $(1 + 2)'
$literal
$escaped = "Two plus one equals: $(1 + 2)"
$escaped
Write-Host '$escaped'
Write-Host "$escaped"

#constant variables are reserved
Get-Variable
# you can't use these
$HOME = 'c:\test'

#environment variables
Get-ChildItem env:
$env:COMPUTERNAME
$env:USERNAME

#putting it all together with an example
$path = Read-Host -Prompt 'Please enter the file path you wish to scan for large files...'
$rawFileData = Get-ChildItem -Path $path -Recurse
$largeFiles = $rawFileData | Where-Object { $_.Length -gt 100MB }
$largeFilesCount = $largeFiles | Measure-Object | Select-Object -ExpandProperty Count
Write-Host "You have $largeFilesCount large file(s) in $path"
#____________________________________________________________
