###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Split-IPv4Subnet.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Split a subnet in multiple subnets with given subnetmasks
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Split a subnet in multiple subnets with given subnetmasks
    
    .DESCRIPTION
    Split a subnet in multiple subnets with given subnetmasks. Each new subnet contains NetworkID, Broadcast, total available IPs and usable IPs for hosts.
    
    .EXAMPLE
    .\Split-IPv4Subnet.ps1 -IPv4Address 192.168.0.0 -CIDR 22 -NewCIDR 24

    NetworkID   Broadcast     IPs Hosts
    ---------   ---------     --- -----
    192.168.0.0 192.168.0.255 256   254
    192.168.1.0 192.168.1.255 256   254
    192.168.2.0 192.168.2.255 256   254
    192.168.3.0 192.168.3.255 256   254

    .EXAMPLE
    .\Split-IPv4Subnet.ps1 -IPv4Address 192.168.0.0 -Mask 255.255.255.0 -NewMask 255.255.255.128

    NetworkID     Broadcast     IPs Hosts
    ---------     ---------     --- -----
    192.168.0.0   192.168.0.127 128   126
    192.168.0.128 192.168.0.255 128   126
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Split-IPv4Subnet.README.md
#>

[CmdletBinding(DefaultParameterSetName='CIDR')]
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
    [ValidateRange(0,31)]
    [Int32]$CIDR,

    [Parameter(
        ParameterSetName='CIDR',
        Position=2,
        Mandatory=$true,
        HelpMessage='New CIDR like /28 without "/"')]
    [ValidateRange(0,31)]
    [Int32]$NewCIDR,

    [Parameter(
        ParameterSetName='Mask',
        Position=1,
        Mandatory=$true,
        Helpmessage='Subnetmask like 255.255.255.0')]
    [ValidatePattern("^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(254|252|248|240|224|192|128|0)$")]
    [String]$Mask,

    [Parameter(
        ParameterSetName='Mask',
        Position=2,
        Mandatory=$true,
        HelpMessage='Subnetmask like 255.255.255.128')]
    [ValidatePattern("^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(254|252|248|240|224|192|128|0)$")]
    [String]$NewMask  
)

Begin{
    # Helper function to convert a subnetmask
    function Convert-Subnetmask 
    {
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
            [ValidatePattern("^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(255|254|252|248|240|224|192|128|0)$")]
            [String]$Mask
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
                    $Octets = $Mask.ToString().Split(".") | foreach {[Convert]::ToString($_, 2)}
                    $CIDR_Bits = ($Octets -join "").TrimEnd("0")

                    # Count the "1" (111111111111111111111111 --> /24)                     
                    $CIDR = $CIDR_Bits.Length             
                }               
            }

            $Result = New-Object -TypeName PSObject
            Add-Member -InputObject $Result -MemberType NoteProperty -Name Mask -Value $Mask
            Add-Member -InputObject $Result -MemberType NoteProperty -Name CIDR -Value $CIDR

            return $Result
        }

        End {
            
        }
    }

    # Helper function to convert an IPv4-Address to Int64 and vise versa
    function Convert-IPv4Address
    {
        [CmdletBinding(DefaultParameterSetName='String')]
        param(
            [Parameter(
                ParameterSetName='String',
                Position=0,
                Mandatory=$true,
                HelpMessage='IPv4-Address as string like "192.168.1.1"')]
            [ValidatePattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")]
            [String]$IPv4Address,

            [Parameter(
                    ParameterSetName='Int64',
                    Position=0,
                    Mandatory=$true,
                    HelpMessage='IPv4-Address as Int64 like 2886755428')]
            [long]$Int64
        ) 

        Begin {

        }

        Process {
            switch($PSCmdlet.ParameterSetName)
            {
                # Convert IPv4-Address as string into Int64
                "String" {
                    $Octets = $IPv4Address.split(".") 
                    $Int64 = [long]([long]$Octets[0]*16777216 + [long]$Octets[1]*65536 + [long]$Octets[2]*256 + [long]$Octets[3]) 
                }
        
                # Convert IPv4-Address as Int64 into string 
                "Int64" {            
                    $IPv4Address = (([System.Math]::Truncate($Int64/16777216)).ToString() + "." + ([System.Math]::Truncate(($Int64%16777216)/65536)).ToString() + "." + ([System.Math]::Truncate(($Int64%65536)/256)).ToString() + "." + ([System.Math]::Truncate($Int64%256)).ToString())
                }      
            }

            $Result = New-Object -TypeName PSObject    
            Add-Member -InputObject $Result -MemberType NoteProperty -Name IPv4Address -Value $IPv4Address
            Add-Member -InputObject $Result -MemberType NoteProperty -Name Int64 -Value $Int64

            return $Result	
        }

        End {

        }
    }

    # Helper function to create a new Subnet
    function New-IPv4Subnet
    {
        [CmdletBinding(DefaultParameterSetName='CIDR')]
        param(
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
            [ValidateRange(0,31)]
            [Int32]$CIDR,

            [Parameter(
                ParameterSetName='Mask',
                Position=1,
                Mandatory=$true,
                Helpmessage='Subnetmask like 255.255.255.0')]
            [ValidatePattern("^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(254|252|248|240|224|192|128|0)$")]
            [String]$Mask
        )

        Begin{
        
        }

        Process{
            # Convert Mask or CIDR - because we need both in the code below
            switch($PSCmdlet.ParameterSetName)
            {
                "CIDR" {                          
                    $Mask = (Convert-Subnetmask -CIDR $CIDR).Mask            
                }
                "Mask" {
                    $CIDR = (Convert-Subnetmask -Mask $Mask).CIDR          
                }                  
            }
            
            # Get CIDR Address by parsing it into an IP-Address
            $CIDRAddress = [System.Net.IPAddress]::Parse([System.Convert]::ToUInt64(("1"* $CIDR).PadRight(32, "0"), 2))
        
            # Binary AND ... this is how subnets work.
            $NetworkID_bAND = $IPv4Address.Address -band $CIDRAddress.Address

            # Return an array of bytes. Then join them.
            $NetworkID = [System.Net.IPAddress]::Parse([System.BitConverter]::GetBytes([UInt32]$NetworkID_bAND) -join ("."))
            
            # Get HostBits based on SubnetBits (CIDR) // Hostbits (32 - /24 = 8 -> 00000000000000000000000011111111)
            $HostBits = ('1' * (32 - $CIDR)).PadLeft(32, "0")
            
            # Convert Bits to Int64
            $AvailableIPs = [Convert]::ToInt64($HostBits,2)

            # Convert Network Address to Int64
            $NetworkID_Int64 = (Convert-IPv4Address -IPv4Address $NetworkID.ToString()).Int64

            # Convert add available IPs and parse into IPAddress
            $Broadcast = [System.Net.IPAddress]::Parse((Convert-IPv4Address -Int64 ($NetworkID_Int64 + $AvailableIPs)).IPv4Address)
            
            # Change useroutput ==> (/27 = 0..31 IPs -> AvailableIPs 32)
            $AvailableIPs += 1

            # Hosts = AvailableIPs - Network Address + Broadcast Address
            $Hosts = ($AvailableIPs - 2)
                
            # Build custom PSObject
            $Result = New-Object -TypeName PSObject
            Add-Member -InputObject $Result -MemberType NoteProperty -Name NetworkID -Value $NetworkID
            Add-Member -InputObject $Result -MemberType NoteProperty -Name Broadcast -Value $Broadcast
            Add-Member -InPutObject $Result -MemberType NoteProperty -Name IPs -Value $AvailableIPs
            Add-Member -InPutObject $Result -MemberType NoteProperty -Name Hosts -Value $Hosts

            return $Result
        }

        End{

        }
    }   
}

Process{
    if($PSCmdlet.ParameterSetName -eq 'Mask')
    {
        $CIDR = (Convert-Subnetmask -Mask $Mask).CIDR 
        $NewCIDR = (Convert-Subnetmask -Mask $NewMask).CIDR
    }
    
    if($CIDR -ge $NewCIDR)
    {
        Write-Host "Subnet (/$CIDR) can't be greater or equal than new subnet (/$NewCIDR)" -ForegroundColor Yellow
        return
    }

    # Calculate the current Subnet
    $Subnet = New-IPv4Subnet -IPv4Address $IPv4Address -CIDR $CIDR
    
    # Get new  HostBits based on SubnetBits (CIDR) // Hostbits (32 - /24 = 8 -> 00000000000000000000000011111111)
    $NewHostBits = ('1' * (32 - $NewCIDR)).PadLeft(32, "0")

    # Convert Bits to Int64, add +1 to get all available IPs
    $NewAvailableIPs = ([Convert]::ToInt64($NewHostBits,2) + 1)

    # Convert the NetworkID to Int64
    $NetworkID_Int64 = (Convert-IPv4Address -IPv4Address $Subnet.NetworkID).Int64
    
    # Build new subnets, and return them
    for($i = 0; $i -lt $Subnet.IPs;$i += $NewAvailableIPs)
    {
        New-IPv4Subnet -IPv4Address (Convert-IPv4Address -Int64 ($NetworkID_Int64 + $i)).IPv4Address -CIDR $NewCIDR
    }
}

End{

}