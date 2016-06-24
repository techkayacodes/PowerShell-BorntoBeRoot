###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  New-IPv4Subnet.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Calculate a subnet based on an IP-Address within the subnet and the subnetmask/CIDR
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Calculate a subnet based on an IP-Address within the subnet and the subnetmask/CIDR

    .DESCRIPTION
    Calculate a subnet based on an IP-Address within the subnet and the subnetmask/CIDR    

    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.
                
    .EXAMPLE
    New-IPv4Subnet -IPv4Address 192.168.24.96 -CIDR 27
    
    NetworkID     Broadcast      IPs Hosts
    ---------     ---------      --- -----
    192.168.24.96 192.168.24.127  32    30
            
    .EXAMPLE
    New-IPv4Subnet -IPv4Address 192.168.1.0 -Mask 255.255.255.0

    NetworkID   Broadcast     IPs Hosts
    ---------   ---------     --- -----
    192.168.1.0 192.168.1.255 256   254

    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function New-IPv4Subnet
{
    [CmdletBinding(DefaultParameterSetName='CIDR')]
    param(
        [Parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage='IPv4 Address which is in the subnet')]
        [IPAddress]$IPv4Address,

        [Parameter(
            ParameterSetName='CIDR',
            Position=1,
            Mandatory=$true,
            HelpMessage='CIDR like /24 without "/"')]
        [ValidateRange(0,32)]
        [Int32]$CIDR,

        [Parameter(
            ParameterSetName='Mask',
            Position=1,
            Mandatory=$true,
            Helpmessage='Subnetmask like 255.255.255.0')]
        [IPAddress]$Mask
    )

    Begin{
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

    Process{
        # Convert Mask or CDIR - because we need both in the code below
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
    
        # calculate the networt address
        [string[]]$IP_Octets = $IPv4Address.ToString().Split(".")
        [string[]]$Mask_Octets = $Mask.ToString().Split(".")

        [string[]] $NetworkAddress_Octets = @()

        # Go through each octet and compare...
        for($i = 0; $i -lt 4; $i++)
        {
            [byte]$IP_Octet_Byte = [Convert]::ToByte($IP_Octets[$i])
            [byte]$Mask_Octet_Byte = [Convert]::ToByte($Mask_Octets[$i])

            # bitwise operator to compare octet (-band --> Bitwise AND)
            $NetworkAddress_Octets += ($IP_Octet_Byte -band $Mask_Octet_Byte).ToString()
        }
    
        # Create IP-Address
        $NetworkAddress = [string]::Join(".", $NetworkAddress_Octets)
    
        # calculate broadcast address
        $HostBits = [string]::Empty
    
        # Get HostBits based on SubnetBits (CDIR) // Hostbits (32 - /24 = 8 -> 00000000000000000000000011111111) 
        for($j = 32; $j -gt 0; $j--)
        {
            if($j -gt (32 - $CIDR))
            {
                $HostBits += "0"
            }
            else
            {
                $HostBits += "1"
            }
        }

        # Convert Bits to Int64
        $AvailableIPs = [Convert]::ToInt64($HostBits,2)
      
        # Convert IP to Int64
        $NetworkAddress_Int64 = IPtoInt64($NetworkAddress)

        # Add IPs to Network Address to get Broadcast Address
        $BroadcastAddress = Int64toIP($NetworkAddress_Int64 + $AvailableIPs)

        # Change useroutput ==> (/27 = 0..31 IPs -> AvailableIPs 32)
        $AvailableIPs += 1

        # Hosts = AvailableIPs - Network Address + Broadcast Address
        $Hosts = ($AvailableIPs - 2)
        
        # Build custom PSObject
        $Result = New-Object -TypeName PSObject
        Add-Member -InputObject $Result -MemberType NoteProperty -Name NetworkID -Value $NetworkAddress
        Add-Member -InputObject $Result -MemberType NoteProperty -Name Broadcast -Value $BroadcastAddress
        Add-Member -InPutObject $Result -MemberType NoteProperty -Name IPs -Value $AvailableIPs
        Add-Member -InPutObject $Result -MemberType NoteProperty -Name Hosts -Value $Hosts
        return $Result
    }

    End{}
}