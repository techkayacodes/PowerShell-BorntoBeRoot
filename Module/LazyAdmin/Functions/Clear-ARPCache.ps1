###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Clear-ARPCache.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Clear the ARP cache
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS 
    Clear the ARP cache 

    .DESCRIPTION
    Clear the Address Resolution Protocol (ARP) cache, which is used for resolution of internet layer addresses into link layer addresses.

    .EXAMPLE
    Clear-ARPCache
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Clear-ARPCache.README.md
#>

function Clear-ARPCache
{
    [CmdletBinding()]
    param(

    )

    Begin{

    }

    Process{
        if(-not([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
        {
            Write-Host "Administrator rights are required to clear the ARP cache! Try to start the process with elevated privileges..." -ForegroundColor Yellow      
        }

        try{
            Start-Process -FilePath "$env:SystemRoot\System32\netsh.exe" -ArgumentList "interface ip delete arpcache" -Verb "RunAs" -WindowStyle Hidden -Wait
        }
        catch{
            Write-Host "$($_.Exception.Message)" -ForegroundColor Red
        }
    }

    End{

    }
}