#____________________________________________________________
# https://www.techthoughts.info/powershell-history-and-current-state/
#____________________________________________________________
# determine what version of PowerShell you are running with the following:
$PSVersionTable
# The PSVersion number is the version. you can get it specifically like this:
$PSVersionTable.PSVersion
#____________________________________________________________
# in a 5.1 window count the number of cmdlets:
Get-Command | Measure-Object
# now try the same thing in a 6+ console window
Get-Command | Measure-Object
#____________________________________________________________
# in a 6+ console window run the following:
Install-Module WindowsCompatibility -Scope CurrentUser
#____________________________________________________________
