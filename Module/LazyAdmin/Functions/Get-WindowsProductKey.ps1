###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-WindowsProductKey.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get the Windows product key and some usefull informations about the system
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS    
    Get the Windows product key and some usefull informations about the system

    .DESCRIPTION    
    Get the Windows product key from a local or remote system and some informations like Serialnumber, Windows version, Bit-Version etc. from one or more computers. Remote computers need WinRM enabled. To do this use "winrm quickconfig".
        
    Basic Logic found on: http://powershell.com/cs/blogs/tips/archive/2012/04/30/getting-windows-product-key.aspx          
                
    .EXAMPLE        
    Get-WindowsProductKey

	ComputerName   : TEST-PC-01
	WindowsVersion : Microsoft Windows 10 Pro
	CSDVersion     :
	BitVersion     : 64-bit
	BuildNumber    : 10586
	ProductID      : 00000-00000-00000-00000
	ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
	
    .EXAMPLE
    Get-WindowsProductKey -ComputerName TEST-PC-01,TEST-PC-02
	
	ComputerName   : TEST-PC-01
	WindowsVersion : Microsoft Windows 10 Pro
	CSDVersion     :
	BitVersion     : 64-bit
	BuildNumber    : 10586
	ProductID      : 00000-00000-00000-00000
	ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

	ComputerName   : TEST-PC-02
	WindowsVersion : Microsoft Windows 10 Pro
	CSDVersion     :
	BitVersion     : 64-bit
	BuildNumber    : 10586
	ProductID      : 00000-00000-00000-00000
	ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-WindowsProductKey.README.md
#>

function Get-WindowsProductKey
{
	[CmdletBinding()]
	param(
		[Parameter(
			Position=0,
			HelpMessage='ComputerName or IPv4-Address of the remote computer')]
		[String[]]$ComputerName = $env:COMPUTERNAME,

		[Parameter(
			Position=1,
			HelpMessage='PSCredential to authenticate agains a remote computer')]
		[System.Management.Automation.PSCredential]$Credential
	)

	Begin{
		$LocalAddress = @("127.0.0.1","localhost",".","$($env:COMPUTERNAME)")

		[System.Management.Automation.ScriptBlock]$Scriptblock_ProductKey = {
			return (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").digitalproductid[0x34..0x42]
		}

		[System.Management.Automation.ScriptBlock]$Scriptblock_Wmi = {
			return Get-WmiObject -Class Win32_OperatingSystem
		}
	}

	Process{   
		foreach($ComputerName2 in $ComputerName) 
		{              
			$Chars="BCDFGHJKMPQRTVWXY2346789" 

			# Don't use Invoke-Command on local machine. Prevent errors if WinRM is not configured
			if($LocalAddress -contains $ComputerName2)
			{
				$ComputerName2 = $env:COMPUTERNAME
				$ProductKeyValue =  Invoke-Command -ScriptBlock $Scriptblock_ProductKey
				$Wmi_Win32 = Invoke-Command -ScriptBlock $Scriptblock_Wmi
			}
			else
			{
				if(-not(Test-Connection -ComputerName $ComputerName2 -Count 2 -Quiet))
				{
					Write-Host "$ComputerName2 is not reachable!" -ForegroundColor Red
					continue
				}

				try {
					if($PSBoundParameters['Credential'] -is [System.Management.Automation.PSCredential])
					{
						$ProductKeyValue = Invoke-Command -ScriptBlock $Scriptblock_ProductKey -ComputerName $ComputerName2 -Credential $Credential
						$Wmi_Win32 = Invoke-Command -ScriptBlock $Scriptblock_Wmi -ComputerName $ComputerName2 -Credential $Credential
					}
					else
					{					    
						$ProductKeyValue = Invoke-Command -ScriptBlock $Scriptblock_ProductKey -ComputerName $ComputerName2
						$Wmi_Win32 = Invoke-Command -ScriptBlock $Scriptblock_Wmi -ComputerName $ComputerName2
					}
				}
				catch {
					Write-Host "Error while connecting to $ComputerName2`n$($_.Exception.Message)" -ForegroundColor Red
					continue
				}
			}
		
			$ProductKey = ""
		
			for($i = 24; $i -ge 0; $i--) 
			{ 
				$r = 0 

				for($j = 14; $j -ge 0; $j--) 
				{ 
					$r = ($r * 256) -bxor $ProductKeyValue[$j] 
					$ProductKeyValue[$j] = [math]::Floor([double]($r/24)) 
					$r = $r % 24 
				}
	
				$ProductKey = $Chars[$r] + $ProductKey 

				if (($i % 5) -eq 0 -and $i -ne 0) 
				{ 
					$ProductKey = "-" + $ProductKey 
				} 
			} 

			$Result = [pscustomobject] @{
				ComputerName = $ComputerName2
				Caption = $Wmi_Win32.Caption
				CSDVersion = $Wmi_Win32.CSDVersion
				WindowsVersion = $Wmi_Win32.Version
				OSArchitecture = $Wmi_Win32.OSArchitecture
				BuildNumber = $Wmi_Win32.BuildNumber
				SerialNumber = $Wmi_Win32.SerialNumber
				ProductKey = $ProductKey
			}

			$Result       
		}   
	}

	End{
		
	}
}