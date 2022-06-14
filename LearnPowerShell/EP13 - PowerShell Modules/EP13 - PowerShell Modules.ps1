#____________________________________________________________
# https://www.techthoughts.info/powershell-modules/
#____________________________________________________________
# importing a psm1

# a psm1 module can now be imported
Import-Module .\learnpowershell.psm1

# we can confirm that the module is loaded
Get-Module learnpowershell

# now that the module is imported we can see what commands are available
Get-Command -Module learnpowershell
#____________________________________________________________
# importing a psd1

# create a basic module manifest
New-ModuleManifest -Path C:\learnpowershell\learnpowershell.psd1

# test a module manifest
Test-ModuleManifest .\learnpowershell.psd1

# import a module by specifying the manifest
Import-Module .\learnpowershell.psd1

# we can confirm that the module is loaded
Get-Module learnpowershell
#____________________________________________________________
# using a repository to find and install modules

# the PowerShell Gallery is registered by default
Get-PSRepository

# search for modules that are tagged with the Telegram key word
Find-Module -Tag Telegram | Format-List

# install a module from the PowerShell Gallery
Install-Module -Name PoshGram -Scope CurrentUser

# determine where a module was installed on the system
Get-Module -Name PoshGram -ListAvailable | Select-Object Path

# update installed module
Update-Module -Name PoshGram

# list all modules available on the system
Get-Module -ListAvailable

#____________________________________________________________
# manually installing a module

# PowerShell sources modules from paths specified in the PSModulePath environment variable
$env:PSModulePath

# change dir to the modules install folder
Set-Location $env:USERPROFILE\Documents\PowerShell\Modules

# create a new folder that is the same name as your module
New-Item -Name learnpowershell -ItemType Directory

# copy the psd1 and psm1 files to this new directory

# verify that PowerShell can now source that module
Get-Module learnpowershell -ListAvailable
#____________________________________________________________
# saving a module for testing / evaluation

# save a module to a directory of your choice
Save-Module PoshGram -Path C:\eval -Repository PSGallery

# change directory to the downloaded module
Set-Location 'C:\eval\PoshGram\2.2.2'

# import the module directly for testing and evaluation
Import-Module .\PoshGram.psd1
#____________________________________________________________
# publish your module to the PowerShell Gallery
Publish-Module -Name "learnpowershell" -NuGetApiKey "your-api-key-goes-here" -Repository PSGallery
