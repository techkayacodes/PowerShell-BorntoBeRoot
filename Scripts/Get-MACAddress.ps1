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

    .EXAMPLE
    .\Get-MACAddress -ComputerName TEST-PC-01
    
    IPv4Address    MACAddress
    -----------    ----------
    192.168.178.22 D0-00-00-00-00-75
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-MACAddress.README.md
#>

[CmdletBinding()]
param(
     [Parameter(
        Position=0,
        Mandatory=$true,
        HelpMessage='ComputerName or IPv4-Address of the device which you want to scan')]
    [String]$ComputerName
)

Begin{

}

Process{
    $LocalAddress = @("127.0.0.1","localhost",".")

    if($LocalAddress -contains $ComputerName)
    {
        $ComputerName = $env:COMPUTERNAME
    }

    if(-not(Test-Connection -ComputerName $ComputerName -Count 2 -Quiet))
    {
        Write-Host "$ComputerName is not reachable! Maybe MAC address is not longer in ARP cache." -ForegroundColor Yellow
    }    
    
    # Check if ComputerName is already an IPv4-Address, if not... try to resolve it
    $IPv4Address = [String]::Empty
	
	if([bool]($ComputerName -as [IPAddress]))
	{
		$IPv4Address = $ComputerName
	}
	else
	{
		# Get IP from Hostname (IPv4 only)
		try{
			$AddressList = @(([System.Net.Dns]::GetHostEntry($ComputerName)).AddressList)
			
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

       	if([String]::IsNullOrEmpty($IPv4Address))
		{
			Write-Host "Could not get IPv4-Address for $ComputerName. (Try to enter an IPv4-Address instead of the Hostname)" -ForegroundColor Red
            return
		}		
	}
 
    $MAC = [String]::Empty

    $Arp_Result = (arp -a ).ToUpper()
 
    foreach($Line in $Arp_Result)
    {
        if($Line.TrimStart().StartsWith($IPv4Address))
        {
            # Some regex magic
            $MAC = [Regex]::Matches($Line,"([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
        }
    }

	# If the MAC is not available in the ARP-Cache (the local machine for example)            
    if([String]::IsNullOrEmpty($MAC))
	{
        try{              
            $Nbtstat_Result = nbtstat -A $IPv4Address | Select-String "MAC"
            $MAC = [Regex]::Matches($Nbtstat_Result, "([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
        }  
        catch { } # No MAC   
    }

    if([String]::IsNullOrEmpty($MAC))
    {
        Write-Host "Could not resolve MAC-Address. Please check if your computer and $ComputerName are in the same subnet and $ComputerName is reachable." -ForegroundColor Red
        return
    }

	$Result = [pscustomobject] @{
        IPv4Address = $IPv4Address
        MACAddress = $MAC        
    }

    return $Result   
}

End{

}
