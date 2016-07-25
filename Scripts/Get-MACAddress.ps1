###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-MACAddress.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get the MAC-Address from a remote computer
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Get the MAC-Address from a remote computer

    .DESCRIPTION   
    Get the MAC-Address from a remote computer. If the MAC-Address could be resolved, the result contains the ComputerName, IPv4-Address and the MAC-Address of the system. Otherwise it returns null. To resolve the MAC-Address your computer need to be in the same subnet as the remote computer (Layer 2). If the result return null, try the parameter "-Verbose" to get more details.

    .EXAMPLE
    .\Get-MACAddress.ps1 -ComputerName TEST-PC-01
    
    ComputerName IPv4Address    MACAddress        Vendor
    ------------ -----------    ----------        ------
    TEST-PC-01   192.168.178.20 1D-00-00-00-00-F0 Cisco Systems, Inc

    .EXAMPLE
    .\Get-MACAddress.ps1 -ComputerName TEST-PC-01, TEST-PC-02
    
    ComputerName IPv4Address    MACAddress        Vendor
    ------------ -----------    ----------        ------
    TEST-PC-01   192.168.178.20 1D-00-00-00-00-F0 Cisco Systems, Inc
    TEST-PC-02   192.168.178.21 1D-00-00-00-00-F1 ASUSTek COMPUTER INC.

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
    # MAC-Vendor list path
    $CSV_MACVendorList_Path = "$PSScriptRoot\IEEE_Standards_Registration_Authority.csv"

    function AssignMACToVendor{
        param(
            $Result
        )

        Begin{

        }

        Process{
            $Vendor = [String]::Empty

            if(-not([String]::IsNullOrEmpty($Result.MACAddress)))
            {
                # Split it, so we can search the vendor (XX-XX-XX-XX-XX-XX to XX-XX-XX)
                $MAC_VendorSearch = $Result.MACAddress.Replace("-","").Substring(0,6)

                foreach($ListEntry in $MAC_VendorList)
                {
                    if($ListEntry.Assignment -eq $MAC_VendorSearch)
                    {
                        $Vendor = $ListEntry."Organization Name"
                        break
                    }
                }                    
            }
            
            $NewResult = [pscustomobject] @{
                ComputerName = $Result.ComputerName
                IPv4Address = $Result.IPv4Address
                MACAddress = $Result.MACAddress
                Vendor = $Vendor
            }

            return $NewResult
        }

        End{

        }
    }
}

Process{
    if([System.IO.File]::Exists($CSV_MACVendorList_Path))
    {
        $AssignToVendor = $true

        $MAC_VendorList = Import-Csv -Path $CSV_MACVendorList_Path | Select-Object "Assignment", "Organization Name"
    }
    else {
        $AssignToVendor = $false

        Write-Host "No CSV-File to assign vendor with MAC-Address found!" -ForegroundColor Yellow
    }

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
            Write-Verbose """$ComputerName2"" is not reachable via ICMP. ARP-Cache could not be refreshed!"

            $IsNotReachable = $true
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
        $MAC = [String]::Empty
       
        if(-not([String]::IsNullOrEmpty($IPv4Address)))
        {
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

                if([String]::IsNullOrEmpty($MAC))
                {
                    if($IsNotReachable)
                    {
                        Write-Host "Could not resolve MAC-Address for ""$ComputerName2"" ($IPv4Address). Make sure that your computer is in the same subnet as $ComputerName2 and $ComputerName2 is reachable." -ForegroundColor Red
                    }
                    else 
                    {
                        Write-Host "Could not resolve MAC-Address for ""$ComputerName2"" ($IPv4Address). Make sure that your computer is in the same subnet as $ComputerName2." -ForegroundColor Red
                    }

                    continue
                }
            }
        }
        else 
        {
            Write-Host "Could not resolve IPv4-Address for ""$ComputerName2"". MAC-Address resolving has been skipped. (Try to enter an IPv4-Address instead of the Hostname!)" -ForegroundColor Red

            continue
        }

        $Result = [pscustomobject] @{
            ComputerName = $ComputerName2
            IPv4Address = $IPv4Address
            MACAddress = $MAC
        }

        if($AssignToVendor)
        {
            AssignMACToVendor -Result $Result
        }
        else 
        {
            $Result  
        } 
    }   
}

End{

}
