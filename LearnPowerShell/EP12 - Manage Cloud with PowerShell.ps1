#____________________________________________________________
# https://www.techthoughts.info/manage-cloud-with-powershell/
#____________________________________________________________

#region AWS

# ----------------------------------------------
# AWS
# ----------------------------------------------

# Install AWS.Tools - A Modularized Version of AWS Tools for PowerShell
Install-Module -Name AWS.Tools.Installer

# Get a list of AWS services supported by the Tools for PowerShell
Import-Module AWS.Tools.Common
Get-AWSService | Select-Object Service, ServiceName, ModuleName | Format-Table -AutoSize

# Discover available AWS regions
Get-AWSRegion

# Keep AWS.Tools versions in sync
Update-AWSToolsModule

#___________________________________
# Set AWS authentication and region
# Import the AWS Tools Common module
Import-Module AWS.Tools.Common
# set the credential for the session
Set-AWSCredential -AccessKey $aKey -SecretKey $sKey
# set the default region for the session
Set-DefaultAWSRegion -Region us-west-2
#___________________________________

# AWS FINAL EXAMPLE
# 1 - Create an S3 bucket
# 2 - Make the S3 bucket secure - NO PUBLIC ACCESS
# 3 - Upload a file to the new S3 bucket
# 4 - Create a pre-signed URL to enable people to securely download the file worldwide

# Install the AWS.Tools S3 module to work with Amazon Simple Storage Service (S3)
Install-Module AWS.Tools.S3
Import-Module AWS.Tools.S3

# 1 - This command creates a new private bucket named "techthoughts".
# https://docs.aws.amazon.com/powershell/latest/reference/items/New-S3Bucket.html
New-S3Bucket -BucketName 'techthoughts'
Get-S3PublicAccessBlock -BucketName 'techthoughts' # by default the bucket will not have public access blocked

# 2 - Adjust public access to the bucket to BLOCKED
# https://docs.aws.amazon.com/powershell/latest/reference/items/Add-S3PublicAccessBlock.html
$publicAccessBlockSplat = @{
    PublicAccessBlockConfiguration_BlockPublicAcl       = $true
    PublicAccessBlockConfiguration_IgnorePublicAcl      = $true
    PublicAccessBlockConfiguration_BlockPublicPolicy    = $true
    PublicAccessBlockConfiguration_RestrictPublicBucket = $true
    BucketName                                          = 'techthoughts'
}
Add-S3PublicAccessBlock @publicAccessBlockSplat
Get-S3PublicAccessBlock -BucketName 'techthoughts' # verify the new BLOCKED policy is in place

# 3 - Upload a local file on your drive to the new S3 bucket
$filePath = 'C:\rs-pkgs\techthoughts_text_file.txt'
$key = 'techthoughts_text_file.txt'
$bucketName = 'techthoughts'
# https://docs.aws.amazon.com/powershell/latest/reference/index.html?page=Write-S3Object.html&tocid=Write-S3Object
# http://iwantmyreal.name/s3-download-only-presigned-upload
$writeS3Splat = @{
    BucketName       = $bucketName
    File             = $filePath
    Key              = $key
    HeaderCollection = @{
        'Content-Disposition' = "attachment; filename=""$key"""
    }
}
Write-S3Object @writeS3Splat

# 4 - Create a pre-signed URL to securely allow others to download the file for a set period of time
# https://docs.aws.amazon.com/powershell/latest/reference/items/Get-S3PreSignedURL.html
# This URL will be good for 1 day - 24 hours!
$url = Get-S3PreSignedURL -BucketName $bucketName -Key $key -Expire (Get-Date).AddDays(1)

#endregion

#region Azure

# ----------------------------------------------
# Azure
# ----------------------------------------------

# Install the Az module
Install-Module -Name Az

# Get a list of Azure services supported by the Az modules
Get-Command -Noun Az* | Sort-Object Source
# List all (read only) Get cmdlets that contain VM in the Az.Compute module
Get-Command -Verb Get -Noun AzVM* -Module Az.Compute

# Get a list of available Azure locations to deploy resources to
Get-AzLocation | Select-Object DisplayName, Location

Import-Module Az.Accounts
# Connect to Azure with a browser sign in token
Connect-AzAccount
# If you have more than one subscription associated with your mail account, you can choose the default subscription.
Get-AzSubscription
Select-AzSubscription -Subscription "My Subscription"

Get-AzResourceGroup | Select-Object ResourceGroupName, Location

Set-AzDefault -ResourceGroupName myResourceGroup

# AZURE FINAL EXAMPLE
# 1 - Create a resource group to hold storage account
# 2 - Create a storage account
# 3 - Create a storage container
# 4 - Upload a file to the new storage container
# 5 - Create a pre-signed URL to enable people to securely download the file worldwide

#Resource Group
$resourceGroupName = "techthoughts"
$location = "westus"

# 1 - Create a resource group to hold storage account
# https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroup?view=azps-4.4.0
$newResourceGroupSplat = @{
    Name     = $resourceGroupName
    Location = $location
}
New-AzResourceGroup @newResourceGroupSplat

# 2 - Create a storage account
# https://docs.microsoft.com/powershell/module/az.storage/new-azstorageaccount?view=azps-4.4.0
$storageAccountName = 'techthoughtsstorage'
$newStorageAccountSplat = @{
    ResourceGroupName = $resourceGroupName
    AccountName       = $storageAccountName
    Location          = $location
    SkuName           = 'Standard_LRS'
    Kind              = 'StorageV2'
}
New-AzStorageAccount @newStorageAccountSplat

# 3 - Create a storage container
# https://docs.microsoft.com/powershell/module/az.storage/get-azstorageaccount?view=azps-4.4.0
$getStorageAccountSplat = @{
    ResourceGroupName = $resourceGroupName
    Name              = $storageAccountName
}
$storageContext = Get-AzStorageAccount @getStorageAccountSplat
# https://docs.microsoft.com/powershell/module/az.storage/new-azstoragecontainer?view=azps-4.4.0
$containerName = 'techthoughtscontainer'
$newStorageContainerSplat = @{
    Context    = $storageContext.Context
    Name       = $containerName
    Permission = 'Off'
}
New-AzStorageContainer @newStorageContainerSplat

# 4 - Upload a file to the new storage container
# https://docs.microsoft.com/powershell/module/az.storage/set-azstorageblobcontent?view=azps-4.4.0
$setAzStorageBlobSplat = @{
    Context   = $storageContext.Context
    Container = $containerName
    File      = 'C:\rs-pkgs\techthoughts_text_file.txt'
    Blob      = 'techthoughts_text_file.txt'
}
Set-AzStorageBlobContent @setAzStorageBlobSplat

# 5 - Create a pre-signed URL to enable people to securely download the file worldwide
# https://docs.microsoft.com/powershell/module/az.storage/new-azstorageblobsastoken?view=azps-4.4.0
$newStorageSASSplat = @{
    Context    = $storageContext.Context
    Container  = $containerName
    Blob       = 'techthoughts_text_file.txt'
    ExpiryTime = (Get-Date).AddDays(1)
    Permission = 'r'
    FullUri    = $true
}
$url = New-AzStorageBlobSASToken @newStorageSASSplat

#endregion
