###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Split-IPv4Subnet.ps1
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
    https://github.com/BornToBeRoot/
#>

[CmdletBinding()]
Param(
    [Parameter(
        Position=0,
        Mandatory=$true,
        HelpMessage='IPv4-Address which is in the subnet')]
    [IPAddress]$IPv4Address,

    [Parameter(
        ParameterSetName='CIDR',
        Position=1,
        Mandatory=$true,
        HelpMessage='CIDR like /24 without "/"')]
    [ValidateRange(0,32)]
    [Int32]$CIDR,

    [Parameter(
        ParameterSetName='CIDR',
        Position=2,
        Mandatory=$true,
        HelpMessage='New CIDR like /28 without "/"')]
    [ValidateRange(0,32)]
    [Int32]$NewCIDR,

    [Parameter(
        ParameterSetName='Mask',
        Position=1,
        Mandatory=$true,
        Helpmessage='Subnetmask like 255.255.255.0')]
    [IPAddress]$Mask,

    

    
)

Begin{

}

Process{

}

End{

}
