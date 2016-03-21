###############################################################################################################
# Language     :  PowerShell 5.0
# Script Name  :  Get-WLANProfiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Script which returns all WLAN-Profiles, include password as SecureString or as plain text
# Repository   :  https://github.com/BornToBeRoot/PowerShell_Get-WLANProfiles
###############################################################################################################

<#
    .SYNOPSIS
    Script which returns all WLAN-Profiles on you local system, include password as SecureString or as plain text
   
   .DESCRIPTION
    This script returns all WLAN-Profiles, on your local system, as custom PowerShell-Object, include SSID, 
    Authentication, Name and Password as secure string or plain text. You don't need an additional application, 
    which is full of advertising. And for learning purposes it shows, how easy it is to find out the WLAN-Password, 
    if you have physical/remote access to the computer.
        
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in
    the links below.
    
    .EXAMPLE
    .\Get-WLANProfiles.ps1

    .EXAMPLE
    .\Get-WLANProfiles.ps1 -ShowPassword
       
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell_Get-WLANProfiles
#>

[CmdletBinding()]
param(
    [Parameter(
        Position=0,
        HelpMessage='Indicates that the password appears in plain text')]
    [Switch]$ShowPassword,
    
    [Parameter(
        Position=1,
        HelpMessage='Filter WLAN-Profiles by Name or SSID')]
    [String]$Search,

    [Parameter(
        Position=2,
        HelpMessage='Excat match, when filter WLAN-Profiles by Name or SSID')]
    [Switch]$ExactMatch
)

Begin
{
    # Get all WLAN Profiles from netsh
    $Netsh_WLANProfiles = (netsh WLAN show profiles)

    # Some vars to filter netsh results
    $IsProfile = 0
    $WLAN_Names = @()
    $WLAN_Profiles = @()

    # Filter result and get the wlan profile names
    foreach($Line in $Netsh_WLANProfiles)
    {
        if((($IsProfile -eq 2)) -and (-not([String]::IsNullOrEmpty($Line))))
        {
            $WLAN_Names += $Line.Split(':')[1].Trim()
        }
    
        if($Line.StartsWith("---"))
        {
            $IsProfile += 1
        }
    }
}

Process
{
    # Get details from every wlan profile, using the name (ssid/password/authentification/etc.)
    foreach($WLAN_Name in $WLAN_Names)
    {
        $Netsh_WLANProfile = (netsh WLAN show profiles name="$WLAN_Name" key=clear)
    
	    # Counter to filter netsh result... (useful for multiple languages / split would only work for one language )
        $InProfile = 0
        $IsConnectivity = 0
        $IsSecurity = 0
	
        foreach($Line in $Netsh_WLANProfile)
        {
            if((($InProfile -eq 2)) -and (-not([String]::IsNullOrEmpty($Line))))
            {			
                
			    if($IsConnectivity -eq 1) 
			    { 
				    $WLAN_SSID = $Line.Split(':')[1].Trim()
                    $WLAN_SSID = $WLAN_SSID.Substring(1,$WLAN_SSID.Length -2)
			    }

               $IsConnectivity += 1
            }

            if((($InProfile -eq 3)) -and (-not([String]::IsNullOrEmpty($Line))))
            {			
                if($IsSecurity -eq 0) # Get the authentication mode
                {
                    $WLAN_Authentication = $Line.Split(':')[1].Trim()
                }
                elseif($IsSecurity -eq 3) # Get the password
                {
                    $WLAN_Password_PlainText = $Line.Split(':')[1].Trim()
                }
            
                $IsSecurity += 1   
            }
    
            if($Line.StartsWith("---"))
            {
                $InProfile += 1
            }   
        }

        if($ShowPassword) # SecureString or plain text
        {
            $WLAN_Password = $WLAN_Password_PlainText
        }
        else
        {
            $WLAN_Password = ConvertTo-SecureString -String "$WLAN_Password_PlainText" -AsPlainText -Force
        }

	    # Built the custom PSObject
        $WLAN_Profile = New-Object -TypeName PSObject
        Add-Member -InputObject $WLAN_Profile -MemberType NoteProperty -Name Name -Value $WLAN_Name
        Add-Member -InputObject $WLAN_Profile -MemberType NoteProperty -Name SSID -Value $WLAN_SSID
        Add-Member -InputObject $WLAN_Profile -MemberType NoteProperty -Name Authentication -Value $WLAN_Authentication
        Add-Member -InputObject $WLAN_Profile -MemberType NoteProperty -Name Password -Value $WLAN_Password

	    # Add the custom PSObject to the array
        if($PSBoundParameters.ContainsKey('Search'))
        {
            if((($WLAN_Profile.Name -like $Search) -or ($WLAN_Profile.SSID -like $Search)) -and (-not($ExactMatch) -or ($WLAN_Profile.Name -eq $Search) -or ($WLAN_Profile.SSID -eq $Search)))
            {
                $WLAN_Profiles += $WLAN_Profile
            } 
        }
        else
        {
            $WLAN_Profiles += $WLAN_Profile
        }        
    }
}

End
{
    # Check if WLAN profiles where found and return them
    if($WLAN_Profiles -ne $null)
    {
        return $WLAN_Profiles
    }
    else
    {
        Write-Host "No WLAN-Profiles found!" -ForegroundColor Yellow
    }
}
