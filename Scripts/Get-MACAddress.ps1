###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-MACAddress.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get the MAC-Address from remote computer
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Get the MAC-Address from a remote computer

    .DESCRIPTION   
    Get the MAC-Address from a remote computer. The result contain the ComputerName, IPv4-Address and the MAC-Address. The resolve of a MAC-Address only works if your computer and the remote computer are in the same subnet (Layer 2).

    .EXAMPLE
    .\Get-MACAddress -ComputerName TEST-PC-01

    .EXAMPLE
    .\Get-MACAddress -ComputerName TEST-PC-01, TEST-PC-02
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-MACAddress.README.md
#>

[CmdletBinding()]
param(
     [Parameter(
        Position=0,
        Mandatory=$true,
        HelpMessage='ComputerName or IPv4-Address of the device which you want to scan')]
    [String[]]$ComputerName
)

Begin{

}

Process{
    foreach($ComputerName2 in $ComputerName)
    {
        $LocalAddress = @("127.0.0.1","localhost",".")

        # Check if ComputerName is a local address, replace it with the computername
        if($LocalAddress -contains $ComputerName2)
        {
            $ComputerName2 = $env:COMPUTERNAME
        }

        # Send ICMP requests to refresh ARP-Cache
        if(-not(Test-Connection -ComputerName $ComputerName2 -Count 2 -Quiet))
        {
            Write-Verbose "$ComputerName2 is not reachable via ICMP. ARP-Cache could not be refreshed!"
        }
        
        # Check if ComputerName is already an IPv4-Address, if not... try to resolve it
        $IPv4Address = [String]::Empty
        
        if([bool]($ComputerName2 -as [IPAddress]))
        {
            $IPv4Address = $ComputerName2
        }
        else
        {
            # Get IP from Hostname (IPv4 only)
            try{
                $AddressList = @(([System.Net.Dns]::GetHostEntry($ComputerName2)).AddressList)
                
                foreach($Address in $AddressList)
                {
                    if($Address.AddressFamily -eq "InterNetwork") 
                    {					
                        $IPv4Address = $Address.IPAddressToString 
                        break					
                    }
                }					
            }
            catch{ }	# Can't get IPAddressList 					
        }
    
        # Try to get MAC from IPv4-Address
        if(-not([String]::IsNullOrEmpty($IPv4Address)))
        {
            $MAC = [String]::Empty

            # +++ ARP-Cache +++
            $Arp_Result = (arp -a ).ToUpper()
        
            foreach($Line in $Arp_Result)
            {
                if($Line.TrimStart().StartsWith($IPv4Address))
                {
                    # Some regex magic
                    $MAC = [Regex]::Matches($Line,"([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
                }
            }

            # +++ NBTSTAT +++ (try NBTSTAT if ARP-Cache is empty)            
            if([String]::IsNullOrEmpty($MAC))
            {
                try{              
                    $Nbtstat_Result = nbtstat -A $IPv4Address | Select-String "MAC"
                    $MAC = [Regex]::Matches($Nbtstat_Result, "([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
                }  
                catch { } # No MAC   
            }
        }
        else 
        {
            Write-Verbose "Could not resolve IPv4-Address for $ComputerName2. Try to enter an IPv4-Address instead of the Hostname!"   
        }

        $Result = [pscustomobject] @{
            ComputerName = $ComputerName2
            IPv4Address = $IPv4Address
            MACAddress = $MAC        
        }

        $Result
    }   
}

End{

}
