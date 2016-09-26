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

| Function | Category | Description | Help | 
| :--- | :--- | :--- | :---: |
| [Clear-ARPCache](Module/LazyAdmin/Functions/ARPCache/Clear-ARPCache.ps1) | [ARP Cache](Modules/LazyAdmin/Functions/ARPCache) | Clear the ARP cache | [:book:](Documentation/Function/Clear-ARPCache.README.md) |
| [Get-ARPCache](Module/LazyAdmin/Functions/ARPCache/Get-ARPCache.ps1) | [ARP Cache](Modules/LazyAdmin/Functions/ARPCache) | Get the ARP cache | [:book:](Documentation/Function/Get-ARPCache.README.md) |
| [ConvertFrom-Base64](Module/LazyAdmin/Functions/Base64Converter/ConvertFrom-Base64.ps1) | [Base64 Converter](Module/LazyAdmin/Functions/Base64Converter) | Convert a Base64 encoded string to a plain text string | [:book:](Documentation/Function/ConvertFrom-Base64.README.md) |
| [ConvertTo-Base64](Module/LazyAdmin/Functions/Base64Converter/ConvertTo-Base64.ps1) | [Base64 Converter](Module/LazyAdmin/Functions/Base64Converter) | Convert a text (command) to an Base64 encoded string | [:book:](Documentation/Function/ConvertTo-Base64.README.md) |
| [Find-StringInFile](Module/LazyAdmin/Functions/File/Find-StringInFile.ps1) | [File](Module/LazyAdmin/Functions/File) | Find a string in one or multiple files | [:book:](Documentation/Function/Find-StringInFile.README.md) |
| [Test-IsFileBinary](Module/LazyAdmin/Functions/File/Test-IsFileBinary.ps1) | [File](Module/LazyAdmin/Functions/File) | Test if a file is binary | [:book:](Documentation/Function/Test-IsFileBinary.README.md) |
| [Update-StringInFile](Module/LazyAdmin/Functions/File/Update-StringInFile.ps1) | [File](Module/LazyAdmin/Functions/File) | Replace a string in one or multiple files | [:book:](Documentation/Function/Update-StringInFile.README.md)
| [Get-InstalledSoftware](Module/LazyAdmin/Functions/Software/Get-InstalledSoftware.ps1) | [Software](Module/LazyAdmin/Functions/Software) | Get all installed software with DisplayName, Publisher and UninstallString | [:book:](Documentation/Function/Get-InstalledSoftware.README.md) |
| [Get-MACAddress](Module/LazyAdmin/Functions/Network/Get-MACAddress.ps1) | [Network](Module/LazyAdmin/Functions/Network) | Get the MAC-Address from a remote computer | [:book:](Documentation/Function/Get-MACAddress.README.md) |
| [Get-MACVendor](Module/LazyAdmin/Functions/Network/Get-MACVendor.ps1) | [Network](Module/LazyAdmin/Functions/Network) | Get Vendor from a MAC-Address | [:book:](Documentation/Function/Get-MACVendor.README.md) |
| [Invoke-IPv4NetworkScan](Module/LazyAdmin/Functions/Network/Invoke-IPv4NetworkScan.ps1) | [Network](Module/LazyAdmin/Functions/Network) | Powerful asynchronus IPv4 Network Scanner to scan an IP-Range or subnet | [:book:](Documentation/Function/Invoke-IPv4NetworkScan.README.md) |
| [Invoke-IPv4PortScan](Module/LazyAdmin/Functions/Network/Invoke-IPv4PortScan.ps1) | [Network](Module/LazyAdmin/Functions/Network) | Powerful asynchronus IPv4 Port Scanner to scan a TCP Port-Range | [:book:](Documentation/Function/Invoke-IPv4PortScan.README.md) |
| [Send-WakeOnLan](Module/LazyAdmin/Functions/Network/Send-WakeOnLan.ps1) | [Network](Module/LazyAdmin/Functions/Network) | Send a network message to turn on or wake up a remote computer | [:book:](Documentation/Function/Send-WakeOnLan.README.md) |
| [Get-ConsoleColor](Module/LazyAdmin/Functions/Other/Get-ConsoleColor.ps1) | [Other](Module/LazyAdmin/Functions/Other) | Get all available console colors | [:book:](Documentation/Function/Get-ConsoleColor.README.md) |
| [Get-RandomPassword](Module/LazyAdmin/Functions/Other/Get-RandomPassword.ps1) | [Other](Module/LazyAdmin/Functions/Other) | Generate passwords with a freely definable number of characters | [:book:](Documentation/Function/Get-RandomPassword.README.md) |
| [Get-RandomPIN](Module/LazyAdmin/Functions/Other/Get-RandomPIN.ps1) | [Other](Module/LazyAdmin/Functions/Other) | Generate PINs with freely definable number of numbers | [:book:](Documentation/Function/Get-RandomPIN.README.md) |
| [Convert-IPv4Address](Module/LazyAdmin/Functions/SubnetCalculator/Convert-IPv4Address.ps1) | [Subnet Calculator](Module/LazyAdmin/Functions/SubnetCalculator) | Convert an IPv4-Address to Int64 and vise versa | [:book:](Documentation/Function/Convert-IPv4Address.README.md) |
| [Convert-Subnetmask](Module/LazyAdmin/Functions/SubnetCalculator/Convert-Subnetmask.ps1) | [Subnet Calculator](Module/LazyAdmin/Functions/SubnetCalculator) | Convert a subnetmask to CIDR and vise versa | [:book:](Documentation/Function/Convert-Subnetmask.README.md) |
| [Get-IPv4Subnet](Module/LazyAdmin/Functions/SubnetCalculator/Get-IPv4Subnet.ps1) | [Subnet Calculator](Module/LazyAdmin/Functions/SubnetCalculator) | Calculate a subnet based on an IP-Address and the subnetmask or CIDR | [:book:](Documentation/Function/Get-IPv4Subnet.README.md) |
| [Split-IPv4Subnet](Module/LazyAdmin/Functions/SubnetCalculator/Split-IPv4Subnet.ps1) | [Subnet Calculator](Module/LazyAdmin/Functions/SubnetCalculator) | Split a subnet in multiple subnets with given subnetmasks | [:book:](Documentation/Function/Split-IPv4Subnet.README.md) |
| [Add-TrustedHost](Module/LazyAdmin/Functions/TrustedHost/Add-TrustedHost.ps1) | [TrustedHost](Module/LazyAdmin/Functions/TrustedHost) |Add a trusted host (WinRM) | [:book:](Documentation/Function/Add-TrustedHost.README.md) |
| [Get-TrustedHost](Module/LazyAdmin/Functions/TrustedHost/Get-TrustedHost.ps1) | [TrustedHost](Module/LazyAdmin/Functions/TrustedHost) | Get trusted hosts (WinRM) | [:book:](Documentation/Function/Get-TrustedHost.README.md) |
| [Remove-TrustedHost](Module/LazyAdmin/Functions/TrustedHost/Remove-TrustedHost.ps1) | [TrustedHost](Module/LazyAdmin/Functions/TrustedHost) | Remove a trusted host (WinRM) | [:book:](Documentation/Function/Remove-TrustedHost.README.md) |
| [Set-TrustedHost](Module/LazyAdmin/Functions/TrustedHost/Set-TrustedHost.ps1) | [TrustedHost](Module/LazyAdmin/Functions/TrustedHost) | Set a trusted host (WinRM) | [:book:](Documentation/Function/Set-TrustedHost.README.md) |
| [Get-LastBootTime](Module/LazyAdmin/Functions/Windows/Get-LastBootTime.ps1) | [Windows](Module/LazyAdmin/Functions/Windows) | Get the time when a computer is booted | [:book:](Documentation/Function/Get-LastBootTime.README.md) |
| [Get-WindowsProductKey](Module/LazyAdmin/Functions/Windows/Get-WindowsProductKey.ps1) | [Windows](Module/LazyAdmin/Functions/Windows) | Get the Windows product key and some usefull informations about the system | [:book:](Documentation/Function/Get-WindowsProductKey.README.md) |
| [Get-WLANProfile](Module/LazyAdmin/Functions/WLAN/Get-WLANProfile.ps1) | [WLAN](Module/LazyAdmin/Functions/WLAN) | Get WLAN profiles, include password as SecureString or as plain text | [:book:](Documentation/Function/Get-WLANProfile.README.md) |
  
## Scripts

| Script | Category | Description | Help |
| :--- | :--- | :--- | :---: |
| [Convert-ROT13](Scripts/Encryption/Convert-ROT13.ps1) | [Encryption](Scripts/Encryption) | Rotate lower and upper chars by n places (Caesar cipher) | [:book:](Documentation/Script/Convert-ROT13.README.md) |
| [Convert-ROT47](Scripts/Encryption/Convert-ROT47.ps1) | [Encryption](Scripts/Encryption) |Rotate ascii chars by n places (Caesar cipher) | [:book:](Documentation/Script/Convert-ROT47.README.md) |
| [OptimizePowerShellStartup.ps1](Scripts/Other/OptimizePowerShellStartup.ps1) | [Other](Scripts/Other) | Optimize PowerShell startup by reduce JIT compile time with ngen.exe | [:book:](Documentation/Script/OptimizePowerShellStartup.README.md) |

## Snippets 

| Snippet | Description | 
| :--- | :--- |
| [ConnectToExchange2010.ps1](Snippets/ConnectToExchange2010.ps1) | Connect to Exchange 2010 Management Shell in script |
| [CredentialParameter.ps1](Snippets/CredentialParameter.ps1) | Parameter to pass credentials into a function/script |
| [DefaultDisplayPropertySet.ps1](Snippets/DefaultDisplayPropertySet.ps1) | Set the default properties of an object |
| [New-Object.ps1](Snippets/New-Object.ps1) | Create a new PSObject with custom properties |
| [PressAnyKeyToContinue.ps1](Snippets/PressAnyKeyToContinue.ps1) | Wait until the user pressed a key | 
| [PromptForChoice.ps1](Snippets/PromptForChoice.ps1) | Prompt for choice |
| [PSCustomObject.ps1](Snippets/PSCustomObject.ps1) | Create a new PSObject with custom properties (faster than New-Object/Add-Member) |
| [RewriteInLine.ps1](Snippets/RewriteInLine.ps1) | Rewrite in Line (Write-Host "xx% complete") |
| [SelfElevatingScript.ps1](Snippets/SelfElevatingScript.ps1) | Self elevate a PowerShell script/console with parameters |
| [Send-MailMessage.ps1](Snippets/Send-MailMessage.ps1) | Send a mail message via PowerShell |

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
