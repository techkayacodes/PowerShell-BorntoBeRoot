# PowerShell

My collection of useful functions, scripts, snippets and templates written by myself.

## Description

Automate all the Things!

## Module

#### How to install the module?

1. Download the [latest Release](https://github.com/BornToBeRoot/PowerShell/releases/latest)
2. Copy the folder [Module\LazyAdmin](Module/LazyAdmin) to `C:\Users\%username%\Documents\WindowsPowerShell\Modules\`
3. Open up a PowerShell as an admin and set the execution policy: `Set-ExecutionPolicy RemoteSigned`
4. Import the Module with the command `Import-Module LazyAdmin` (Maybe add this command to your PowerShell profile) 

#### Available functions:

| Function | Description | Help | 
| :--- | :--- | :---: |
| [Clear-ARPCache](Module/LazyAdmin/Functions/Clear-ARPCache.ps1) | Clear the ARP cache | [:book:](Documentation/Clear-ARPCache.README.md) |
| [Convert-IPv4Address](Module/LazyAdmin/Functions/Convert-IPv4Address.ps1) | Convert an IPv4-Address to Int64 and vise versa | [:book:](Documentation/Convert-IPv4Address.README.md) |
| [Convert-Subnetmask](Module/LazyAdmin/Functions/Convert-Subnetmask.ps1) | Convert a subnetmask to CIDR and vise versa | [:book:](Documentation/Convert-Subnetmask.README.md) |
| [Find-StringInFile](Module/LazyAdmin/Functions/Find-StringInFile.ps1) | Find a string in one or multiple files | [:book:](Documentation/Find-StringInFile.README.md) |
| [Get-ARPCache](Module/LazyAdmin/Functions/Get-ARPCache.ps1) | Get the ARP cache | [:book:](Documentation/Get-ARPCache.README.md) |
| [Get-ConsoleColors](Module/LazyAdmin/Functions/Get-ConsoleColors.ps1) | Get all available console colors | [:book:](Documentation/Get-ConsoleColors.README.md) |
| [Get-InstalledSoftware](Module/LazyAdmin/Functions/Get-InstalledSoftware.ps1) | Get all installed software with DisplayName, Publisher and UninstallString | [:book:](Documentation/Get-InstalledSoftware.README.md) |
| [Get-IPv4Subnet](Module/LazyAdmin/Functions/Get-IPv4Subnet.ps1) | Calculate a subnet based on an IP-Address and the subnetmask or CIDR | [:book:](Documentation/Get-IPv4Subnet.README.md) |
| [Get-MACAddress](Module/LazyAdmin/Functions/Get-MACAddress.ps1) | Get the MAC-Address from a remote computer | [:book:](Documentation/Get-MACAddress.README.md) |
| [Get-MACVendor](Module/LazyAdmin/Functions/Get-MACVendor.ps1) | Get Vendor from a MAC-Address | [:book:](Documentation/Get-MACVendor.README.md) |
| [Get-RandomPassword](Module/LazyAdmin/Functions/Get-RandomPassword.ps1) | Generate passwords with a freely definable number of characters | [:book:](Documentation/Get-RandomPassword.README.md) |
| [Get-RandomPIN](Module/LazyAdmin/Functions/Get-RandomPIN.ps1) | Generate PINs with freely definable number of numbers | [:book:](Documentation/Get-RandomPIN.README.md) |
| [Get-WindowsProductKey](Module/LazyAdmin/Functions/Get-WindowsProductKey.ps1) | Get the Windows product key and some usefull informations about the system | [:book:](Documentation/Get-WindowsProductKey.README.md) |
| [Get-WLANProfile](Module/LazyAdmin/Functions/Get-WLANProfile.ps1) | Get WLAN profiles, include password as SecureString or as plain text | [:book:](Documentation/Get-WLANProfile.README.md) |
| [Invoke-IPv4NetworkScan](Module/LazyAdmin/Functions/Invoke-IPv4NetworkScan.ps1) | Powerful asynchronus IPv4 Network Scanner to scan an IP-Range or subnet | [:book:](Documentation/Invoke-IPv4NetworkScan.README.md) |
| [Invoke-IPv4PortScan](Module/LazyAdmin/Functions/Invoke-IPv4PortScan.ps1) | Powerful asynchronus IPv4 Port Scanner to scan a TCP Port-Range | [:book:](Documentation/Invoke-IPv4PortScan.README.md) |
| [Send-WakeOnLan](Module/LazyAdmin/Functions/Send-WakeOnLan.ps1) | Send a network message to turn on or wake up a remote computer | [:book:](Documentation/Send-WakeOnLan.README.md) | 
| [Split-IPv4Subnet](Module/LazyAdmin/Functions/Split-IPv4Subnet.ps1) | Split a subnet in multiple subnets with given subnetmasks | [:book:](Documentation/Split-IPv4Subnet.README.md) |
| [Test-IsFileBinary](Module/LazyAdmin/Functions/Test-IsFileBinary.ps1) | Test if a file is binary | [:book:](Documentation/Test-IsFileBinary.README.md) |
| [Update-StringInFile](Module/LazyAdmin/Functions/Update-StringInFile.ps1) | Replace a string in one or multiple files | [:book:](Documentation/Update-StringInFile.README.md)
  
## Scripts

| Script | Description | Help |
| :--- | :--- | :---: |
| [Convert-ROT13](Scripts/Convert-ROT13.ps1) | Rotate lower and upper chars by n places (Caesar cipher) | [:book:](Documentation/Convert-ROT13.README.md) |
| [Convert-ROT47](Scripts/Convert-ROT47.ps1) | Rotate ascii chars by n places (Caesar cipher) | [:book:](Documentation/Convert-ROT47.README.md) |
| [OptimizePowerShellStartup.ps1](Scripts/OptimizePowerShellStartup.ps1) | Optimize PowerShell startup by reduce JIT compile time with ngen.exe | [:book:](Documentation/OptimizePowerShellStartup.README.md) |

## Snippets 

| Snippet | Description | 
| :--- | :--- |
| [ConnectToExchange2010.ps1](Snippets/ConnectToExchange2010.ps1) | Connect to Exchange 2010 Management Shell in script |
| [New-Object.ps1](Snippets/New-Object.ps1) | Create a new PSObject with custom properties |
| [PressAnyKeyToContinue.ps1](Snippets/PressAnyKeyToContinue.ps1) | Wait until the user pressed a key | 
| [PromptForChoice.ps1](Snippets/PromptForChoice.ps1) | Prompt for choice |
| [PSCustomObject.ps1](Snippets/PSCustomObject.ps1) | Create a new PSObject with custom properties (faster than New-Object/Add-Member) |
| [RewriteInLine.ps1](Snippets/RewriteInLine.ps1) | Rewrite in Line (Write-Host "xx% complete") |
| [SelfElevatingScript.ps1](Snippets/SelfElevatingScript.ps1) | Self elevate a PowerShell script/console with parameters |
| [Send-MailMessage.ps1](Snippets/Send-MailMessage.ps1) | Send a mail message via PowerShell |
| [SourcecodeFromFunction.ps1](Snippets/SourcecodeFromFunction.ps1) | Get the sourcecode of an existing function |

## Regex

| Regex | Description |
| :--- | :--- |
| [IPv4Address.ps1](Regex/IPv4Address.ps1) | Validate an IPv4-Address like 192.168.1.0 |
| [MACAddress.ps1](Regex/MACAddress.ps1) | Validate a MAC-Address like 00:00:00:00:00:00 or 00-00-00-00-00-00 or 000000000000 |
| [Subnetmask.ps1](Regex/Subnetmask.ps1) | Validate an Subnetmask like 255.255.255.0 |

## Templates

| Template | Description |
| :--- | :--- |
| [Default.ps1](Templates/Default.ps1) | Default template for new scripts |
| [Default.README.md](Templates/Default.README.md) | Default template for documentation on GitHub |
| [RunspacePool.ps1](Templates/RunspacePool.ps1) | RunspacePool template - run code asynchron (faster than PSJobs) |
