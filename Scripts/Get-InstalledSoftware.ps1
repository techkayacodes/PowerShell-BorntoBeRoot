###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-InstalledSoftware.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Script to get DisplayName and UninstallString of all installed software
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Script to get all installed software with DisplayName, Publisher and UninstallString
                 
    .DESCRIPTION         
    Script to get all installed software with DisplayName, Publisher and UninstallString. It also returns the InstallLocation
    and InstallDate property. With the parameter "-Search" you can filter the results.
	
	If you found a bug or have some ideas to improve this function... Let me know. You find my Github profile in 
	the links below.
	                     
    .EXAMPLE
    .\Get-InstalledSoftware.ps1
       
    .EXAMPLE
    .\Get-InstalledSoftware.ps1 -Search "*visual studio*"

	DisplayName                        UninstallString                    InstallLocation                    InstallDate
	-----------                        ---------------                    ---------------                    -----------
	Microsoft Visual Studio Team Fo... MsiExec.exe /I{04B5C251-079F-31...                                    20151217
	Visual Studio 2015 Prerequisite... MsiExec.exe /X{447A06BC-E1AC-4D...                                    20151217
	Microsoft Visual Studio 2015-Le... MsiExec.exe /I{4F4AD505-AAA6-40...                                    20151217
	Visual Studio 2010 Prerequisite... MsiExec.exe /X{53952792-BF16-30...                                    20150914
	Microsoft Visual Studio 2015 Vs... MsiExec.exe /I{599702AA-91EB-38...                                    20151217
	
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

[CmdletBinding()]
Param(
    [Parameter(
        Position=0,
        HelpMessage='Search for product name (You can use wildcards like "*ProductName*')]
    [String]$Search
)

Begin{
    # where to search for Software/UninstallStrings
    $Strings = Get-ChildItem -Path  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Select-Object -Property DisplayName, Publisher, UninstallString, InstallLocation, InstallDate
}

Process{
    # Array which get returned
    $Results = @()

    # Process results
    foreach($String in $Strings)
    {
        # Check for each entry if data exists
        if((-not([String]::IsNullOrEmpty($String.DisplayName))) -and (-not([String]::IsNullOrEmpty($String.UninstallString))))
        {
            # Search (only if parameter is used)
            if($PSBoundParameters.ContainsKey('Search'))
            {
                if($String.DisplayName -like $Search)
                {
                    $Result = New-Object -TypeName PSObject
                    Add-Member -InputObject $Result -MemberType NoteProperty -Name DisplayName -Value $String.DisplayName
					Add-Member -InputObject $Result -MemberType NoteProperty -Name Publisher -Value $String.Publisher
                    Add-Member -InputObject $Result -MemberType NoteProperty -Name UninstallString -Value $String.UninstallString
                    Add-Member -InputObject $Result -MemberType NoteProperty -Name InstallLocation -Value $String.InstallLocation
                    Add-Member -InputObject $Result -MemberType NoteProperty -Name InstallDate -Value $String.InstallDate
                    $Results += $Result   
                }
            }
            else
            {
                $Result = New-Object -TypeName PSObject
                Add-Member -InputObject $Result -MemberType NoteProperty -Name DisplayName -Value $String.DisplayName
				Add-Member -InputObject $Result -MemberType NoteProperty -Name Publisher -Value $String.Publisher
                Add-Member -InputObject $Result -MemberType NoteProperty -Name UninstallString -Value $String.UninstallString
                Add-Member -InputObject $Result -MemberType NoteProperty -Name InstallLocation -Value $String.InstallLocation
                Add-Member -InputObject $Result -MemberType NoteProperty -Name InstallDate -Value $String.InstallDate
                $Results += $Result   
            }
        }       
    }
}

End{
    return $Results
}