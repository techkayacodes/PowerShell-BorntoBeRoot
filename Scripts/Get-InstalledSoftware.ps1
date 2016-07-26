###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-InstalledSoftware.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get all installed software with DisplayName, Publisher and UninstallString
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Get all installed software with DisplayName, Publisher and UninstallString
                 
    .DESCRIPTION         
    Get all installed software with DisplayName, Publisher and UninstallString from a local or remote computer. The result will also include the InstallLocation and the InstallDate. To reduce the results, you can use the parameter "-Search *PRODUCTNAME*".
                                 
    .EXAMPLE
    .\Get-InstalledSoftware.ps1
       
    .EXAMPLE
    .\Get-InstalledSoftware.ps1 -Search "*chrome*"

	DisplayName     : Google Chrome
	Publisher       : Google Inc.
	UninstallString : "C:\Program Files (x86)\Google\Chrome\Application\51.0.2704.103\Installer\setup.exe" --uninstall --multi-install --chrome --system-level
	InstallLocation : C:\Program Files (x86)\Google\Chrome\Application
	InstallDate     : 20160506

    .EXAMPLE
    .\Get-InstalledSoftware.ps1 -ComputerName TEST-PC-01 -Search "*firefox*" 
	
    DisplayName     : Mozilla Firefox 47.0.1 (x86 de)
    Publisher       : Mozilla
    UninstallString : "C:\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe"
    InstallLocation : C:\Program Files (x86)\Mozilla Firefox
    InstallDate     :

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-InstalledSoftware.README.md
#>

[CmdletBinding()]
param(
    [Parameter(
		Position=0,
		HelpMessage='ComputerName or IPv4-Address of the remote computer')]
	[String]$ComputerName = $env:COMPUTERNAME,

    [Parameter(
        Position=1,
        HelpMessage='Search for product name (You can use wildcards like "*ProductName*')]
    [String]$Search,

    [Parameter(
        Position=2,
        HelpMessage='PSCredential to authenticate agains a remote computer')]
    [System.Management.Automation.PSCredential]$Credential
)

Begin{
    $LocalAddress = @("127.0.0.1","localhost",".","$($env:COMPUTERNAME)")

    [System.Management.Automation.ScriptBlock]$Scriptblock = {
        # Location where all entrys for installed software should be stored
        return Get-ChildItem -Path  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Select-Object -Property DisplayName, Publisher, UninstallString, InstallLocation, InstallDate
    }
}

Process{
    if($LocalAddress -contains $ComputerName)
    {
        $ComputerName = $env:COMPUTERNAME
        $Strings = Invoke-Command -ScriptBlock $Scriptblock -ArgumentList $Search            
    }
    else
    {
        if(-not(Test-Connection -ComputerName $ComputerName -Count 2 -Quiet))
        {
            Write-Host "$ComputerName is not reachable!" -ForegroundColor Red
            continue
        }
    
        try {
            if($PSBoundParameters['Credential'] -is [System.Management.Automation.PSCredential])
            {
                $Strings = Invoke-Command -ScriptBlock $Scriptblock -ComputerName $ComputerName -ArgumentList $Search -Credential $Credential
            }
            else
            {					    
            	$Strings = Invoke-Command -ScriptBlock $Scriptblock -ComputerName $ComputerName -ArgumentList $Search
            }
        }
        catch {
            Write-Host "Error while connecting to $ComputerName`n$($_.Exception.Message)" -ForegroundColor Red
            continue
        }
    }

    foreach($String in $Strings)
    {
        # Check for each entry if data exists
        if((-not([String]::IsNullOrEmpty($String.DisplayName))) -and (-not([String]::IsNullOrEmpty($String.UninstallString))))
        {
            # Search (only if parameter is used)
            if($PSBoundParameters.ContainsKey('Search'))
            {                    
                if(($String.DisplayName -like $Search))
                {
                    $Software = [pscustomobject] @{
                        DisplayName = $String.DisplayName
                        Publisher = $String.Publisher
                        UninstallString = $String.UninstallString
                        InstallLocation = $String.InstallLocation
                        InstallDate = $String.InstallDate
                    }

                    $Software
                }   
            }
            else
            {
                $Software = [pscustomobject] @{
                    DisplayName = $String.DisplayName
                    Publisher = $String.Publisher
                    UninstallString = $String.UninstallString
                    InstallLocation = $String.InstallLocation
                    InstallDate = $String.InstallDate
                }

                $Software
            }
        }       
    }
}

End{
    
}
