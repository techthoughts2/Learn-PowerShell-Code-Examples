#____________________________________________________________
# https://www.techthoughts.info/powershell-errors-and-exceptions-handling/
#____________________________________________________________
#Github PowerShell error documentation:
#https://github.com/MicrosoftDocs/PowerShell-Docs/issues/1583

# Primary Pipeline aka output stream aka success pipeline
# error pipeline

#-------------------------------------------------
#non-terminating error
1 / 0; Write-Host 'Hello, will I run after an error?'

#non-terminating errors don't stop loops
$collection = @(
    'C:\Test\newcsv.csv',
    'c:\nope\nope.txt'
    'C:\Test\newcsv2.csv'
)
foreach ($item in $collection) {
    Get-Item $item
}
#-------------------------------------------------
#terminating errors

# Without ErrorAction
Get-Item -Path c:\nope\nope.txt; Write-Host 'Hello, will I run after an error?'
# With ErrorAction
Get-Item -Path c:\nope\nope.txt -ErrorAction Stop; Write-Host 'Hello, will I run after an error?'

#try/catch/finally
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-6

# throw causes PowerShell to terminate
try {
    1 / 0; Write-Host 'Hello, will I run after an error?'
}
catch {
    throw
}

# this example will not go the catch and will run the Write-Host
try {
    Get-Item -Path c:\nope\nope.txt; Write-Host 'Hello, will I run after an error?'
}
catch {
    Write-Host 'You are now in the catch'
}

# this example will error and go directly to the catch
try {
    Get-Item -Path c:\nope\nope.txt -ErrorAction Stop; Write-Host 'Hello, will I run after an error?'
}
catch {
    Write-Host 'You are now in the catch'
}


$processNames = @(
    'NotAProcess',
    'Notepad'

)
foreach ($item in $processNames) {
    try {
        Get-Process -Nam $item
    }
    catch {
        Write-Host $item
        throw
    }
}

#Write-Error simply prints the error for the user
try {
    1 / 0; Write-Host 'Hello, will I run after an error?'
}
catch {
    # Maybe Log Something Right here
    Write-Error $_
}

# Finally will log results regardless of what happens
try {
    Get-Content -Path c:\nope\nope.txt -ErrorAction Stop
}
catch {
    Write-Error $_
}
finally {
    # log results to a logging file
}
#-------------------------------------------------

#The website exists, but the page does not
try {
    $webResults = Invoke-WebRequest -Uri 'https://www.techthoughts.info/nope.htm'
}
catch {
    Write-Error $_
}

#The website exists, but the page does not
try {
    $webResults = Invoke-WebRequest -Uri 'https://www.techthoughts.info/nope.htm'
}
catch {
    $theError = $_
    if ($theError.Exception -like "*404*") {
        Write-Warning 'Web page not found. Check the address and try again.'
        #Retry code
    }
    else {
        throw
    }
}

#The website does not exist
try {
    $webResults = Invoke-WebRequest -Uri 'https://techthoughtssssssss.info/'
}
catch {
    $theError = $_
    $theError.Exception
}

#The website exists, but the page does not
try {
    $webResults = Invoke-WebRequest -Uri 'https://www.techthoughts.info/nope.htm'
}
catch {
    $theError = $_
    # see all the sub-properties
    $theError | Format-List * -Force
}

#-------------------------------------------------
# $Error

$Error
1 / 0; $Error
Get-Process -Name 'NotAProcess'
$Error
$Error.Clear()

$Error[5] | Format-List * -Force
#-------------------------------------------------

#this example will help display some helpful message to the user
#this example will only work in PowerShell 6.1+
$uri = Read-Host 'Enter the URL'
try {
    $webResults = Invoke-WebRequest -Uri $uri -ErrorAction Stop
}
catch {
    $statusCodeValue = $_.Exception.Response.StatusCode.value__
    switch ($statusCodeValue) {
        400 {
            Write-Warning -Message "HTTP Status Code 400 Bad Request. Check the URL and try again."
        }
        401 {
            Write-Warning -Message "HTTP Status Code 401 Unauthorized."
        }
        403 {
            Write-Warning -Message "HTTP Status Code 403 Forbidden. Server may be having issues. Check the URL and try again."
        }
        404 {
            Write-Warning -Message "HTTP Status Code 404 Not found. Check the URL and try again."
        }
        500 {
            Write-Warning -Message "HTTP Status Code 500 Internal Server Error."
        }
        Default {
            throw
        }
    }
}
