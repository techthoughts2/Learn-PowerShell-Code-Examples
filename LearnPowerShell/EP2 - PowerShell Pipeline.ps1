#____________________________________________________________
# https://www.techthoughts.info/working-with-the-powershell-pipeline/
#____________________________________________________________
# the pipeline operator

Get-Process | Sort-Object Id
#____________________________________________________________
# In this example, every command found will be "piped" to Get-Help
# This will run Get-Help against EVERY command found

Get-Command | Get-Help
#____________________________________________________________
# This example would restart the BITS service!

Get-Service -Name BITS | Restart-Service
#____________________________________________________________
# try running this command on your machine to see the results.
# the WhatIf parameter will make Stop-Process take no actual action

Get-Process | Stop-Process -WhatIf
#____________________________________________________________
# PSItem
# Get all processes. For each process (object) found,
# display that object

Get-Process | ForEach-Object {$PSItem}

# In this simple example, we will display the current object
# to the console
1,2,3 | ForEach-Object {$PSItem}

# Spelling out $PSItem (not common)
1,2,3 | ForEach-Object {$PSItem}
# using $PSItem shorthand (common)
1,2,3 | ForEach-Object {$_}
#____________________________________________________________
# Format-List & Format-Table

# Note the way things look using Format-Table
Get-Process | Format-Table
# Now see how that differs if you pipe instead to Format-List
Get-Process | Format-List

# Note the return from just Get-Date
Get-Date
# Now see how the whole object is returned if you pipe to Format-List
Get-Date | Format-List

# basic information about the notepad process
Get-Process notepad
# more information about the notepad process
Get-Process notepad | Format-List
# all available information about the notepad process
Get-Process notepad | Format-List
#____________________________________________________________
# Select-Object

# Using Select-Object you can retrieve only the properties you are after
Get-Process | Select-Object Name,Id,CPU,Responding
#____________________________________________________________
# Sort-Object

# This example pipes all processes to Sort-Object which sorts by CPU use
# Use to quickly identify your busiest processes. Very handy!
Get-Process | Sort-Object CPU

# You can combine multiple pipelines together as well
Get-Process | Select-Object Name,Id,CPU,Responding | Sort-Object CPU
#____________________________________________________________
# Where-Object

# Get Processes, return only those where current object $_ is greater than 15
Get-Process | Where-Object {$_.CPU -gt 15}

# Get file information for all files found in the $HOME directory
# Return information for only files that are greater than 5MB in size
Get-ChildItem $HOME -Recurse | Where-Object {$_.Length -gt 5MB}

# Count the number of large file in your $HOME directory
Get-ChildItem $HOME -Recurse | Where-Object {$_.Length -gt 50MB} | Measure-Object
#____________________________________________________________
