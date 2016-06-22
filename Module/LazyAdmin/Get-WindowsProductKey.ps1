###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-WindowsProductKey.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get Windows Product Key
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    
    Get the Windows product key and some usefull informations about the system

    .DESCRIPTION
    
    Get the Windows product key from a local or remote system and some informations like Serialnumber, 
    Windows version, Bit-Version etc. from one or more computers. Remote computers need WinRM enabled.
    To do this use "winrm quickconfig".
        
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.
          
    Basic Logic found on: http://powershell.com/cs/blogs/tips/archive/2012/04/30/getting-windows-product-key.aspx          
                
    .EXAMPLE
        
    Get-WindowsProductKey

    .EXAMPLE

    Get-WindowsProductKey -ComputerName TEST-SERVER-01,localhost

    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function Get-WindowsProductKey
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
            ValueFromPipelineByPropertyName=$true,
			HelpMessage='ComputerName or IP-Address of the remote computer')]
		[String[]]$ComputerName = $env:COMPUTERNAME,

        [Parameter(
            Position=1,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage='PSCredential to authentificate agains a remote computer')]
        [PSCredential]$Credential
	)

	Begin{
        $LocalAddress = @("127.0.0.1","localhost",".","$($env:COMPUTERNAME)")

        [System.Management.Automation.ScriptBlock]$ScriptBlock_ProductKey = {
            return (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").digitalproductid[0x34..0x42]
        }

        [System.Management.Automation.ScriptBlock]$ScriptBlock_Wmi = {
            return Get-WmiObject -Class Win32_OperatingSystem
        }
    }

    Process{   
	    $Results = @()	

        foreach($ComputerName2 in $ComputerName) 
	    {              
		    $Chars="BCDFGHJKMPQRTVWXY2346789" 

		    # Don't use Invoke-Command on local machine. Prevent errors if WinRM is not configured
		    if($LocalAddress -contains $ComputerName2)
		    {
                $ComputerName2 = $env:COMPUTERNAME
			    $ProductKeyValue =  Invoke-Command -ScriptBlock $ScriptBlock_ProductKey
                $Wmi_Win32 = Invoke-Command -ScriptBlock $ScriptBlock_Wmi
		    }
		    else
		    {
                if(-not(Test-Connection -ComputerName $ComputerName2 -Count 2 -Quiet))
                {
                    Write-Host "$ComputerName2 is not reachable!" -ForegroundColor Red
                    continue
                }

			    try {
                    if($PSBoundParameters['Credential'] -is [PSCredential])
                    {
                        $ProductKeyValue = Invoke-Command -ScriptBlock $ScriptBlock_ProductKey -ComputerName $ComputerName2 -Credential $Credential -ErrorAction Stop 
                        $Wmi_Win32 = Invoke-Command -ScriptBlock $ScriptBlock_Wmi -ComputerName $ComputerName2 -Credential $Credential
                    }
                    else
                    {					    
                        $ProductKeyValue = Invoke-Command -ScriptBlock $ScriptBlock_ProductKey -ComputerName $ComputerName2 -ErrorAction Stop
                        $Wmi_Win32 = Invoke-Command -ScriptBlock $ScriptBlock_Wmi -ComputerName $ComputerName2
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

		    $Result = New-Object -TypeName PSObject
		    Add-Member -InputObject $Result -MemberType NoteProperty -Name ComputerName -Value $ComputerName2
            Add-Member -InputObject $Result -MemberType NoteProperty -Name Caption -Value $Wmi_Win32.Caption
            Add-Member -InputObject $Result -MemberType NoteProperty -Name CSDVersion $Wmi_Win32.CSDVersion
            Add-Member -InputObject $Result -MemberType NoteProperty -Name WindowsVersion $Wmi_Win32.Version
		    Add-Member -InputObject $Result -MemberType NoteProperty -Name OSArchitecture $Wmi_Win32.OSArchitecture
		    Add-Member -InputObject $Result -MemberType NoteProperty -Name BuildNumber $Wmi_Win32.BuildNumber
		    Add-Member -InputObject $Result -MemberType NoteProperty -Name SerialNumber $Wmi_Win32.SerialNumber
		    Add-Member -InputObject $Result -MemberType NoteProperty -Name ProductKey -Value $ProductKey
		    $Results += $Result       
	    }   
    }

    End{
        return $Results
    }
}