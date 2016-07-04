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
    Get all installed software with DisplayName, Publisher and UninstallString. The result will also include the InstallLocation and the InstallDate. To reduce the results, you can use the parameter "-Search *PRODUCTNAME*".
                                 
    .EXAMPLE
    .\Get-InstalledSoftware.ps1
       
    .EXAMPLE
    .\Get-InstalledSoftware.ps1 -Search "*chrome*"

	DisplayName     : Google Chrome
	Publisher       : Google Inc.
	UninstallString : "C:\Program Files (x86)\Google\Chrome\Application\51.0.2704.103\Installer\setup.exe" --uninstall --multi-install --chrome --system-level
	InstallLocation : C:\Program Files (x86)\Google\Chrome\Application
	InstallDate     : 20160506
	
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-InstalledSoftware.README.md
#>

[CmdletBinding()]
Param(
    [Parameter(
        Position=0,
        HelpMessage='Search for product name (You can use wildcards like "*ProductName*')]
    [String]$Search
)

Begin{
    # Location where all entrys for installed software should be stored
    $Strings = Get-ChildItem -Path  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Select-Object -Property DisplayName, Publisher, UninstallString, InstallLocation, InstallDate
}

Process{
    $Results = @()
    
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
    
return $Results	
}

End{
    
}