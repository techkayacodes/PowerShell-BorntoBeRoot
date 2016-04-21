# PowerShell
Collection of useful PowerShell modules, scripts, snippets and templates

## Description

Make your admin life easier to have more time for :coffee:

>Some functions are also available in the module and as script

## Module

### LazyAdmin

Download the folder [Module/LazyAdmin](Module/LazyAdmin) and save it under `C:\Users\%username%\Documents\WindowsPowerShell\Modules`. Then run the command `Import-Module LazyAdmin`

Available Functions:

* [Get-InstalledSoftware](Module/LazyAdmin/Get-InstalledSoftware.ps1) - Get all installed software with DisplayName, Publisher and UninstallString ([view Doku](Doku/Get-InstalledSoftware.README.md))
* [Get-WLANProfile](Module/LazyAdmin/Get-WLANProfile.ps1) - Get all WLAN-Profiles on your **local system**, include password ([view Doku](Doku/Get-WLANProfile.README.md))
* [New-RandomPassword](Module/LazyAdmin/New-RandomPassword.ps1) - Generate a random password with a freely definable number of chracters ([view Doku](Doku/New-RandomPassword.README.md))
* [New-RandomPIN](Module/LazyAdmin/New-RandomPIN.ps1) - Generate a random PIN with a freely definable number of numbers ([view Doku](Doku/New-RandomPIN.README.md))
* [Test-IsFileBinary](Module/LazyAdmin/Test-IsFileBinary.ps1) - Test if a file is binary or just a text file ([view Doku](Doku/Test-IsFileBinary.README.md))

## Scripts

* [Get-InstalledSoftware.ps1](Scripts/Get-InstalledSoftware.ps1) - Get all installed software with DisplayName, Publisher and UninstallString ([view Doku](Doku/Get-InstalledSoftware.README.md))
* [Get-WLANProfile.ps1](Scripts/Get-WLANProfile.ps1) - Get all WLAN-Profiles on your **local system**, include password ([view Doku](Doku/Get-WLANProfile.README.md))
* [New-RandomPassword.ps1](Scripts/New-RandomPassword.ps1) - Generate a random password with a freely definable number of chracters ([view Doku](Doku/New-RandomPassword.README.md))
* [New-RandomPIN.ps1](Scripts/New-RandomPIN.ps1) - Generate a random PIN with a freely definable number of numbers ([view Doku](Doku/New-RandomPIN.README.md))
* [Test-IsFileBinary.ps1](Scripts/Test-IsFileBinary.ps1) - Test if a file is binary or just a text file ([view Doku](Doku/Test-IsFileBinary.README.md))

## Snippets

* [CustomPSObject](Snippets/CustomPSObject.ps1) - Built custom PSObject to process or return as result
* [PressAnyKeyToContinue.ps1](Snippets/PressAnyKeyToContinue.ps1) - Wait for user interaction e.g. at the end of a script

## Templates

* [Default.ps1](Templates/Default.ps1) - Default template for all new scripts
* [RunspacePool.ps1](Templates/RunspacePool.ps1) - Run code async with RunspacePool
