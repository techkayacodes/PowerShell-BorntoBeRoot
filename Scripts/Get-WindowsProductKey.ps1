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
    
    Get the Windows product key and some informations about the system like Serialnumber, Windows version, 
	Bit-Version etc. from one or more computers. Remote computers need WinRM enabled. To do this use 
	`winrm quickconfig`. Both computer must be a member of the domain to authentificate each other.
        
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.
        
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.
          
    Basic Logic found on: http://powershell.com/cs/blogs/tips/archive/2012/04/30/getting-windows-product-key.aspx          
                
    .EXAMPLE
        
    .\Get-WindowsProductKey.ps1

    .EXAMPLE

    .\Get-WindowsProductKey.ps1 -ComputerName TEST-SERVER-01,localhost

    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

[CmdletBinding()]
Param(
    [Parameter(
        Position=0,
        HelpMessage='ComputerName or IP-Address of the remote computer')]
    [String[]]$ComputerName = $env:COMPUTERNAME
)

Begin{
    
}

Process{
    $Results = @()

    $LocalAddress = @("127.0.0.1","localhost",".","$($env:COMPUTERNAME)")

    foreach($ComputerName2 in $ComputerName) 
    {          
        $Chars="BCDFGHJKMPQRTVWXY2346789" 

        # Don't use Invoke-Command on local machine. Prevent errors if WinRM is not configured
        if($LocalAddress -contains $ComputerName2)
        {
            $ProductKeyValue =  (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").digitalproductid[0x34..0x42]
        }
        else
        {
            try {
                $ProductKeyValue = Invoke-Command -ScriptBlock { (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").digitalproductid[0x34..0x42] } -ComputerName $ComputerName2 -ErrorAction Stop
            }
            catch {
                Write-Host "Error while connecting to $ComputerName2`n$($_.Exception.Message)" -ForegroundColor Red
                continue
            }
        }
   
        $ProductKey = ""
   
        for ($i = 24; $i -ge 0; $i--) { 
          $r = 0 
          for ($j = 14; $j -ge 0; $j--) { 
            $r = ($r * 256) -bxor $ProductKeyValue[$j] 
            $ProductKeyValue[$j] = [math]::Floor([double]($r/24)) 
            $r = $r % 24 
          } 
          $ProductKey = $Chars[$r] + $ProductKey 
          if (($i % 5) -eq 0 -and $i -ne 0) { 
            $ProductKey = "-" + $ProductKey 
          } 
        } 
    
        try {
            $Wmi_Win32 = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName2 -ErrorAction Stop
        }
        catch { 
            $_.Exception.Message 
        }

        $Result = New-Object -TypeName PSObject
        Add-Member -InputObject $Result -MemberType NoteProperty -Name ComputerName -Value $ComputerName2
        Add-Member -InputObject $Result -MemberType NoteProperty -Name WindowsVersion $Wmi_Win32.Caption
        Add-Member -InputObject $Result -MemberType NoteProperty -Name CSDVersion $Wmi_Win32.CSDVersion
        Add-Member -InputObject $Result -MemberType NoteProperty -Name BitVersion $Wmi_Win32.OSArchitecture
        Add-Member -InputObject $Result -MemberType NoteProperty -Name BuildNumber $Wmi_Win32.BuildNumber
        Add-Member -InputObject $Result -MemberType NoteProperty -Name ProductID $Wmi_Win32.SerialNumber
        Add-Member -InputObject $Result -MemberType NoteProperty -Name ProductKey -Value $ProductKey
        $Results += $Result       
    }
   
    return $Results   
}

End{

}