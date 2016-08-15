###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  EnablePSRemoting.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    
    .DESCRIPTION
    
    .EXAMPLE
        
    .EXAMPLE
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell
#>

[CmdletBinding()]
param(
    [Parameter(
        Position=0,
        HelpMessage='Trusted Hosts (Default="*")')]
    [String[]]$TrustedHosts,

    [Parameter(
        Position=1,
        HelpMessage='Continue ')]
    [switch]$Force
)

Begin{

}

Process{

}

End{

}
