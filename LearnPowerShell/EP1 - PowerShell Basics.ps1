#____________________________________________________________
# https://www.techthoughts.info/learn-and-use-powershell-with-just-three-commands/
#____________________________________________________________
# your first cmdlet - getting timezone information

Get-TimeZone
#____________________________________________________________
# Get-Command

Get-Command *
# An asterisk (*) in many languages acts as a wildcard. This syntax is saying: get me ALL of the commands

Get-Command *process*
# the wild cards around process will find ANY command that contains the word process

# Get-Command can't always find everything, you may have to Google
Get-Command *file*
#____________________________________________________________
# Get-Help

# Windows Users:
Get-Help Stop-Process
#Linux/MacOs Users
Get-Help Stop-Process -Online

Get-Help Stop-Process -Examples
#____________________________________________________________
# Get-Member

Get-Date | Get-Member

Get-Random | Get-Member
#____________________________________________________________
# Expand the available viewable properties of a cmdlet with Format-List

Get-Date | Format-List
#____________________________________________________________
# Find-Module

Find-Module -Tag Telegram
#____________________________________________________________
