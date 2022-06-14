#____________________________________________________________
# https://www.techthoughts.info/powershell-remoting/
#____________________________________________________________

#region WinRM Links

#Running Remote Commands
#https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-6

#Windows Remote Management
#https://docs.microsoft.com/en-us/windows/win32/winrm/portal

#Installation and Configuration for Windows Remote Management
#https://docs.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management

#Making the second hop in PowerShell Remoting
#https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ps-remoting-second-hop?view=powershell-6

#PowerShell remoting over SSH
#https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-6

#How to configure WinRM for HTTPS manually
#https://www.visualstudiogeeks.com/devops/how-to-configure-winrm-for-https-manually

#endregion

#region ComputerName

# Per PowerShell documentation you can find a list of cmdlets that support ComputerName with the following:
Get-Command | Where-Object { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session" }

# this will prompt you to enter your access credentials. the creds will be securely stored in the variable
$creds = Get-Credential

# restart a single computer
Restart-Computer -ComputerName RemoteDevice -Credential $creds

# restart several computers
Restart-Computer -ComputerName RemoteDevice1, RemoteDevice2, RemoteDevice3 -Credential $creds

# restart an entire list of computers
$devices = Get-Content -Path C:\listOfServers.txt
Restart-Computer -ComputerName $devices -Credential $Creds -Force

#endregion

#region WinRM

#verify that WinRM is setup and configured locally
Test-WSMan

# basic WinRM configuration with default settings
winrm quickconfig

# example of WinRM configuration with more specific settings
winrm quickconfig -transport:https

# check winrm settings
winrm get winrm/config/client
winrm get winrm/config/service

Get-Process C:\> winrm enumerate winrm/config/listener
Listener
Address = *
Transport = HTTP
Port = 5985
Hostname
Enabled = true
URLPrefix = wsman
CertificateThumbprint
ListeningOn = 10.0.3.253, 127.0.0.1, 192.168.1.253, ::1,

#verify that WinRM is setup and responding on a remote device
#you must specify the authentication type when testing a remote device.
#if you are unsure about the authentication, set it to Negotiate
$credential = Get-Credential
Test-WSMan RemoteDeviceName -Authentication Negotiate -Credential $credential

#verify local device is listening on WinRM port
Get-NetTCPConnection -LocalPort 5985

#verify a remote device is listening on WinRM port
Test-NetConnection -Computername 192.168.34.13 -Port 5985

#establish an interactive remote session
$credential = Get-Credential
Enter-PSSession -ComputerName RemoteDeviceName -Credential $credential

#basic session opened to remote device
$session = New-PSSession -ComputerName RemoteDeviceName -Credential domain\user

#session opened to device over SSL
$credential = Get-Credential
$sessionHTTPS = New-PSSession -ComputerName RemoteDeviceName -Credential $credential -UseSSL

#establish sessions to multiple devices
$credential = Get-Credential
$multiSession = New-PSSession -ComputerName RemoteDeviceName1, RemoteDeviceName2, RemoteDeviceName3 -Credential $credential

#establish session to an entire list of devices
$devices = Get-Content -Path C:\listOfServers.txt
$credential = Get-Credential
$multiSession = New-PSSession -ComputerName $devices -Credential $credential

#session opened with advanced session options configured
$sessionOptions = New-PSSessionOption -SkipCNCheck -SkipCACheck -SkipRevocationCheck
$advancedSession = New-PSSession -ComputerName 10.0.3.27 -Credential user -UseSSL -SessionOption $so

#endRegion

#region Invoke-Command examples

#get the number of CPUs for each remote device
Invoke-Command -Session $sessions -ScriptBlock { (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors }

#get the amount of RAM for each remote device
Invoke-Command -Session $sessions -ScriptBlock { Get-CimInstance Win32_OperatingSystem | Measure-Object -Property TotalVisibleMemorySize -Sum | ForEach-Object { [Math]::Round($_.sum / 1024 / 1024) } }

#get the amount of free space on the C: drive for each remote device
Invoke-Command -Session $sessions -ScriptBlock {
    $driveData = Get-PSDrive C | Select-Object Used, Free
    $total = $driveData.Used + $driveData.Free
    $calc = [Math]::Round($driveData.Free / $total, 2)
    $perFree = $calc * 100
    return $perFree
}

#get the number of CPUs for each remote device
Invoke-Command -Session $sessions -ScriptBlock { (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors }

#get the amount of RAM for each remote device
Invoke-Command -Session $sessions -ScriptBlock { Get-CimInstance Win32_OperatingSystem | Measure-Object -Property TotalVisibleMemorySize -Sum | ForEach-Object { [Math]::Round($_.sum / 1024 / 1024) } }

#get the amount of free space on the C: drive for each remote device
Invoke-Command -Session $sessions -ScriptBlock {
    $driveData = Get-PSDrive C | Select-Object Used, Free
    $total = $driveData.Used + $driveData.Free
    $calc = [Math]::Round($driveData.Free / $total, 2)
    $perFree = $calc * 100
    return $perFree
}

#stop the BITS service on all remote devices
Invoke-Command -Session $sessions -ScriptBlock { Stop-Service BITS -Force }

#endregion

#region PowerShell-Linux-Remote-Access

#install openssh
sudo apt install openssh-client
sudo apt install openssh-server

#Edit the sshd_config file at location /etc/ssh
#Make sure password authentication is enabled:
PasswordAuthentication yes

#Add a PowerShell subsystem entry:
Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile

#Optionally, enable key authentication:
PubkeyAuthentication yes

#Restart the sshd service.
sudo service sshd restart

#establish an interactive session to a remote Linux device
$session = New-PSSession -HostName RemoteDevice -UserName user -SSHTransport
Enter-PSSession $session

#execute commands on a remote Linux device
$session = New-PSSession -HostName RemoteDevice -UserName user -SSHTransport
Invoke-Command -Session $session -ScriptBlock { Get-Process }

#alternative to running Invoke-Command in parallel
#foreach forces sequential connection and return for each server in the list
#establish session to an entire list of devices
$devices = Get-Content -Path C:\listOfServers.txt
$credential = Get-Credential
foreach ($server in $devices) {
    Invoke-Command -ComputerName $server -ScriptBlock { $env:COMPUTERNAME } -Credential $credential
}

#endregion

#region advanced WinRM

#add server to trusted hosts
Get-ChildItem WSMan:\localhost\Client\TrustedHosts
winrm s winrm/config/client '@{TrustedHosts="673448-RAXDC01"}'
winrm s winrm/config/client '@{TrustedHosts="579188-HYP1"}'

#domain to domain (http)
New-PSSession -ComputerName Test-Join -Credential domain\user
$domainToDomainHTTP = New-PSSession -ComputerName RemoteDeviceName -Credential domain\account

#domain to domain (requires https listener and certificates pre-configured)
New-PSSession -ComputerName Test-Join -Credential domain\user -UseSSL
$domainToDomainHTTPS = New-PSSession -ComputerName PDC2 -Credential domain\account -UseSSL

#by IP self-signed cert
$so = New-PSSessionOption -SkipCNCheck -SkipCACheck -SkipRevocationCheck
$test = New-PSSession -ComputerName 10.0.3.27 -Credential domain/account -UseSSL -SessionOption $so

#change port WinRM listens on
winrm/config/Listener?Address=*+Transport=HTTP '@{Port="8888"}'

#check WinRM settings
Get-WSManInstance -ResourceURI winrm/config/service/Auth
Get-WSManInstance -ResourceURI winrm/config/client/Auth
Get-WSManInstance -ResourceURI winrm/config/client

#endregion

#region final Example

#declare servers we will connect to remotely
$servers = 'Server1', 'Server2', 'Server3', 'Server4'
#capture credentials used for remote access
$creds = Get-Credential

#declare array to hold remote command results
$remoteResults = @()

#declare a splat for our Invoke-Command parameters
$invokeSplat = @{
    ComputerName  = $servers
    Credential    = $creds
    ErrorVariable = 'connectErrors'
    ErrorAction   = 'SilentlyContinue'
}

#execute remote command with splatted parameters.
#store results in variable
#errors will be stored in connectErrors
$remoteResults = Invoke-Command @invokeSplat -ScriptBlock {
    #declare a custom object to store result in and return
    $obj = [PSCustomObject]@{
        Name      = $env:COMPUTERNAME
        CPUs      = "-------"
        Memory    = "-------"
        FreeSpace = "-------"
    }
    #retrieve the CPU / Memory / Hard Drive information
    $obj.CPUs = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
    $obj.Memory = Get-CimInstance Win32_OperatingSystem `
    | Measure-Object -Property TotalVisibleMemorySize -Sum `
    | ForEach-Object { [Math]::Round($_.sum / 1024 / 1024) }
    $driveData = Get-PSDrive C | Select-Object Used, Free
    $total = $driveData.Used + $driveData.Free
    $calc = [Math]::Round($driveData.Free / $total, 2)
    $obj.FreeSpace = $calc * 100
    return $obj
}

#capture any connection errors
$remoteFailures = $connectErrors.CategoryInfo `
| Where-Object { $_.Reason -eq 'PSRemotingTransportException' } `
| Select-Object TargetName, @{n = 'ErrorInfo'; E = { $_.Reason } }

#endregion
