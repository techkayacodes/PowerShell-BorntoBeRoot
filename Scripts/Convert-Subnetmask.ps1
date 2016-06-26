###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Convert-Subnetmask.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Convert a subnetmask to CIDR and vise versa
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Convert a subnetmask to CIDR and vise versa

    .DESCRIPTION
    Convert a subnetmask like 255.255.255 to CIDR (/24) and vise versa.
                
    .EXAMPLE
    .\Convert-Subnetmask.ps1 -CIDR 24

    Mask          CIDR
    ----          ----
    255.255.255.0   24

    .EXAMPLE
    .\Convert-Subnetmask.ps1 -Mask 255.255.0.0

    Mask        CIDR
    ----        ----
    255.255.0.0   16
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Convert-Subnetmask.README.md
#>

[CmdLetBinding(DefaultParameterSetName='CIDR')]
param( 
    [Parameter( 
        ParameterSetName='CIDR',       
        Position=0,
        Mandatory=$true,
        HelpMessage='CIDR like /24 without "/"')]
    [ValidateRange(0,32)]
    [Int32]$CIDR,

    [Parameter(
        ParameterSetName='Mask',
        Position=0,
        Mandatory=$true,
        HelpMessage='Subnetmask like 255.255.255.0')]
    [IPAddress]$Mask 
)

Begin {

}

Process {
    switch($PSCmdlet.ParameterSetName)
    {
        "CIDR" {                          
            # Make a string of bits (24 to 11111111111111111111111100000000)
            $CIDR_Bits = ('1' * $CIDR).PadRight(32, "0")
            # Split into groups of 8 bits, convert to Ints, join up into a string
            $Octets = $CIDR_Bits -split '(.{8})' -ne ''
            $Mask = ($Octets | foreach { [Convert]::ToInt32($_, 2) }) -join '.'
        }

        "Mask" {
            # Convert the numbers into 8 bit blocks, join them all together, count the 1
            $Octets = $Mask.ToString().Split('.') | foreach {[Convert]::ToString($_, 2)}
            $CIDR = ($Octets -Join "").TrimEnd('0').Length
        }               
    }

    $Result = New-Object -TypeName PSObject
    Add-Member -InputObject $Result -MemberType NoteProperty -Name Mask -Value $Mask
    Add-Member -InputObject $Result -MemberType NoteProperty -Name CIDR -Value $CIDR

    return $Result
}

End {
    
}