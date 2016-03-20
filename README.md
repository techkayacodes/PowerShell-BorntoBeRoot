# PowerShell Get-WLANProfiles
Script to get all WLAN-Profiles on your **local system**, include password as SecureString or as plain text

## Description

This script returns all WLAN profiles on your local system, as custom PowerShell-Object, include SSID, Authentication, Name and Password as SecureString or plain text. You don't need an additional application, which is full of advertising. And for learning purposes it shows, how easy it is to find out the WLAN password, if you have physical/remote access to the computer.

![Screenshot of the results](https://github.com/BornToBeRoot/PowerShell_Get-WLANProfiles/blob/master/Images/Results.png?raw=true)

_In Windows 7 there was a graphical interface in the network settings, where you could get the wlan password in plain text. In Windows 8, 8.1 and 10 this function is hidden or difficult to find._

## Syntax

```powershell
.\ScanNetworkAsync.ps1 [[-ShowPassword]] [[-Search] <String>] [[-ExactMatch]] [<CommonParameters>]
```

## Example

```powershell
.\Get-WLANProfiles.ps1                                          # As SecureString
```

```powershell
.\Get-WLANProfiles.ps1 -ShowPassword -Search "MyHomeNetwork*"   # As plain text
```

## Output

```powershell
Name              SSID               Authentification    Password
----              ----               ---------------     ------
MyHomeNetwork01   MyHomeNetwork      WPA2-Personal       System.Security.SecureString
MyHomeNetwork02   MyHomenetwork5G    WPA2-Personal       System.Security.SecureString
```

or

```powershell
Name              SSID               Authentification    Password
----              ----               ---------------     ------
MyHomeNetwork01   MyHomeNetwork      WPA2-Personal       MyPassword123456789
MyHomeNetwork02   MyHomenetwork5G    WPA2-Personal       MyPassword987654321
```

## How does it works?

This script uses the Network Shell (`netsh.exe`) from Windows.

* [Netsh Command Reference - Technet](https://technet.microsoft.com/en-us/library/cc754516(v=ws.10).aspx)
* [Netsh Commands for WLAN - Technet](https://technet.microsoft.com/en-US/library/cc755301(v=ws.10).aspx)

## Inspired by

* [PoshCode](http://poshcode.org/4520)
* [Technet](https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/23/get-wireless-network-ssid-and-password-with-powershell/)
