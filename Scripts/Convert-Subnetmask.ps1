###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Convert-Subnetmask.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Convert a subnetmask from CIDR and vise versa
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Convert a subnetmask (XXX.XXX.XXX.XXX) to CIDR (/XX) or vise versa

    .DESCRIPTION
    Convert a subnetmask (XXX.XXX.XXX.XXX) to CIDR (/XX) or vise versa
        
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.
                
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
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

[CmdLetBinding(DefaultParameterSetName='CIDR')]
param( 
    [Parameter( 
        ParameterSetName='CIDR',       
        Position=0,
        HelpMessage='CIDR like /24 without "/"')]
    [ValidateRange(0,32)]
    [Int32]$CIDR,

    [Parameter(
        ParameterSetName='Mask',
        Position=0,
        HelpMessage='Subnetmask like 255.255.255.0')]
    [IPAddress]$Mask 
)

Begin {
    # Functions to convert IP to Int64 and vise versa 
    function Int64toIP() { 
        param ([long]$Int) 

        return (([System.Math]::Truncate($Int/16777216)).ToString() + "." + ([System.Math]::Truncate(($Int%16777216)/65536)).tostring() + "." + ([System.Math]::Truncate(($int%65536)/256)).ToString() + "." + ([System.Math]::Truncate($int%256)).ToString())
    }	

    function IPtoInt64() { 
        param ($IPAddr) 
     
        $Octets = $IPAddr.split(".") 
        return [long]([long]$Octets[0]*16777216 + [long]$Octets[1]*65536 + [long]$Octets[2]*256 + [long]$Octets[3]) 
    } 
}

Process {
    # Switch from what to what you want to convert the subnet mask
    switch($PSCmdlet.ParameterSetName)
    {
        "CIDR" {       
            $CIDR_Bits = [String]::Empty

            # Make a string of bits (16 to 11111111111111110000000000000000)
            for($i = 0; $i -lt 32; $i ++)
            {
                if($i -lt $CIDR)
                {    
                    $CIDR_Bits += "1"
                }
                else
                {
                    $CIDR_Bits += "0"
                }
            }
               
            # Convert the Bits to an Integer (11111111111111110000000000000000 to 4294901760)
            $Mask_Int64 = [Convert]::ToInt64($CIDR_Bits,2)   
                        
            # Convert the Integer to an IPAddress (4294901760 to 255.255.0.0)                
            $Mask = Int64toIP($Mask_Int64)
        }

        "Mask" {
            # Convert the IPAddress to and Integer (255.255.0.0 to 4294901760)
            $Mask_Int64 = IPtoInt64($Mask.ToString())

            # Convert the Integer to Bits (4294901760 to 11111111111111110000000000000000)
            $CIDR_Bits = [System.Convert]::ToString($Mask_Int64,2)

            $CIDR = 0

            # Go through each Char and check if the bit is set to "1"
            foreach($Bit in [char[]]$CIDR_Bits)
            {            
                if($Bit -eq "1")
                {
                    $CIDR ++
                }
            }
        }               
    }

    $Result = New-Object -TypeName PSObject
    Add-Member -InputObject $Result -MemberType NoteProperty -Name Mask -Value $Mask
    Add-Member -InputObject $Result -MemberType NoteProperty -Name CIDR -Value $CIDR
}

End {       
    return $Result
}
