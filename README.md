# PowerShell

My collection of useful functions, scripts, snippets and templates written by myself.

## Description

Automate all the Things.

## Module

#### How to install the module?

1. Download the [latest Release](https://github.com/BornToBeRoot/PowerShell/releases/latest)
2. Copy the folder [Module\LazyAdmin](Module/LazyAdmin) to `C:\Users\%username%\Documents\WindowsPowerShell\Modules\`
3. Open up a PowerShell as an admin and set the execution policy: `Set-ExecutionPolicy RemoteSigned`
4. Import the Module with the command `Import-Module LazyAdmin` (Maybe add this command to your PowerShell profile) 

#### Available functions:

| Function | Description | Help | 
| :--- | :--- | :---: |
| [Convert-IPv4Address](Module/LazyAdmin/Functions/Convert-IPv4Address.ps1) | Convert an IPv4-Address to Int64 and vise versa | [:book:](Documentation/Convert-IPv4Address.README.md) |
| [Convert-Subnetmask](Module/LazyAdmin/Functions/Convert-Subnetmask.ps1) | Convert a subnetmask to CIDR and vise versa | [:book:](Documentation/Convert-Subnetmask.README.md) |
| [Get-InstalledSoftware](Module/LazyAdmin/Functions/Get-InstalledSoftware.ps1) | Get all installed software with DisplayName, Publisher and UninstallString | [:book:](Documentation/Get-InstalledSoftware.README.md) |
| [Get-WindowsProductKey](Module/LazyAdmin/Functions/Get-WindowsProductKey.ps1) | Get the Windows product key and some usefull informations about the system | [:book:](Documentation/Get-WindowsProductKey.README.md) |
| [Get-WLANProfile](Module/LazyAdmin/Functions/Get-WLANProfile.ps1) | Get WLAN profiles, include password as SecureString or as plain text | [:book:](Documentation/Get-WLANProfile.README.md) |
| [New-IPv4NetworkScan](Module/LazyAdmin/Functions/New-IPv4NetworkScan.ps1) | Powerful asynchronus IPv4-Scanner to scan an IP-Range or subnet | [:book:](Documentation/New-IPv4NetworkScan.README.md) |
| [New-IPv4Subnet](Module/LazyAdmin/Functions/New-IPv4Subnet.ps1) | Calculate a subnet based on an IP-Address and the subnetmask or CIDR | [:book:](Documentation/New-IPv4Subnet.README.md) |
| [New-RandomPassword](Module/LazyAdmin/Functions/New-RandomPassword.ps1) | Generate passwords with a freely definable number of characters | [:book:](Documentation/New-RandomPassword.README.md) |
| [New-RandomPIN](Module/LazyAdmin/Functions/New-RandomPIN.ps1) | Generate a PIN with a freely definable number of numbers | [:book:](Documentation/New-RandomPIN.README.md) |
| [Search-StringInFiles](Module/LazyAdmin/Functions/Search-StringInFiles.ps1) | Find a string in one or multiple files | [:book:](Documentation/Search-StringInFiles.README.md) |
| [Split-IPv4Subnet](Module/LazyAdmin/Functions/Split-IPv4Subnet.ps1) | Split a subnet in multiple subnets with given subnetmasks | [:book:](Documentation/Split-IPv4Subnet.README.md) |
| [Test-IsFileBinary](Module/LazyAdmin/Functions/Test-IsFileBinary.ps1) | Test if a file is binary | [:book:](Documentation/Test-IsFileBinary.README.md) |
| [Update-StringInFiles](Module/LazyAdmin/Functions/Update-StringInFiles.ps1) | Replace a string in one or multiple files | [:book:](Documentation/Update-StringInFiles.README.md)

## Scripts

| Script | Description | Help | 
| :--- | :--- | :---: |
| [Convert-IPv4Address.ps1](Scripts/Convert-IPv4Address.ps1) | Convert an IPv4-Address to Int64 and vise versa | [:book:](Documentation/Convert-IPv4Address.README.md) |
| [Convert-Subnetmask.ps1](Scripts/Convert-Subnetmask.ps1) | Convert a subnetmask to CIDR and vise versa | [:book:](Documentation/Convert-Subnetmask.README.md) |
| [Get-InstalledSoftware.ps1](Scripts/Get-InstalledSoftware.ps1) | Get all installed software with DisplayName, Publisher and UninstallString | [:book:](Documentation/Get-InstalledSoftware.README.md) |
| [Get-WindowsProductKey.ps1](Scripts/Get-WindowsProductKey.ps1) | Get the Windows product key and some usefull informations about the system | [:book:](Documentation/Get-WindowsProductKey.README.md) |
| [Get-WLANProfile.ps1](Scripts/Get-WLANProfile.ps1) | Get WLAN profiles, include password as SecureString or as plain text | [:book:](Documentation/Get-WLANProfile.README.md)
| [New-IPv4NetworkScan.ps1](Scripts/New-IPv4NetworkScan.ps1) | Powerful asynchronus IPv4-Scanner to scan an IP-Range or subnet | [:book:](Documentation/New-IPv4NetworkScan.README.md) |
| [New-IPv4Subnet.ps1](Scripts/New-IPv4Subnet.ps1) | Calculate a subnet based on an IP-Address and the subnetmask or CIDR | [:book:](Documentation/New-IPv4Subnet.README.md) |
| [New-RandomPassword.ps1](Scripts/New-RandomPassword.ps1) | Generate passwords with a freely definable number of characters | [:book:](Documentation/New-RandomPassword.README.md)
| [New-RandomPIN.ps1](Scripts/New-RandomPIN.ps1) | Generate a PIN with a freely definable number of numbers | [:book:](Documentation/New-RandomPIN.README.md) |
| [Search-StringInFiles.ps1](Scripts/Search-StringInFiles.ps1) | Find a string in one or multiple files | [:book:](Documentation/Search-StringInFiles.README.md) |
| [Split-IPv4Subnet.ps1](Scripts/Split-IPv4Subnet.ps1) | Split a subnet in multiple subnets with given subnetmasks | [:book:](Documentation/Split-IPv4Subnet.README.md) |
| [Test-IsFileBinary.ps1](Scripts/Test-IsFileBinary.ps1) | Test if a file is binary | [:book:](Documentation/Test-IsFileBinary.README.md) |
| [Update-StringInFiles.ps1](Scripts/Update-StringInFiles.ps1) | Replace a string in one or multiple files | [:book:](Documentation/Update-StringInFiles.README.md) |

## Snippets

| Snippet | Description | 
| :--- | :--- |
| [Custom_PSObject.ps1](Snippets/Custom_PSObject.ps1) | Create a custom PSObject |
| [Connect-ExchangeManagementShell2010.ps1.ps1](Snippets/Connect-ExchangeManagementShell2010.ps1.ps1) | Connect to Exchange 2010 Management Shell in script |
| [Get-ConsoleColors.ps1](Snippets/Get-ConsoleColors.ps1) | Show all available foreground and background console colors |
| [Get_sourcecode_of_a_function.ps1](Snippets/Get_sourcecode_of_a_function.ps1) | Get the sourcecode of an existing function | 
| [Press_any_key_to_continue.ps1](Snippets/Press_any_key_to_continue.ps1) | Wait until the user pressed a key | 
| [Self_elevating_script.ps1](Snippets/Self_elevating_script.ps1) | Self elevate a PowerShell script/console with parameter |
| [Send-MailMessage.ps1](Snippets/Send-MailMessage.ps1) | Send a mail message via PowerShell |

| Regex | Description |
| :--- | :--- |
| [IPv4Address.ps1](Snippets/Regex/IPv4Address.ps1) | Validate an IPv4-Address like 192.168.1.0 |
| [Subnetmask.ps1](Snippets/Regex/Subnetmask.ps1) | Validate an Subnetmask like 255.255.255.0 |

## Templates

| Template | Description |
| :--- | :--- |
| [Default.ps1](Templates/Default.ps1) | Default template for all new scripts |
| [Default.README.md](Templates/Default.README.md) | Default template for script/function documentation on GitHub |
| [RunspacePool.ps1](Templates/RunspacePool.ps1) | Run code asynchron in a RunspacePool - more efficient than PSJobs |
