###############################################################################################################
# Language     :  PowerShell 5.0
# Filename     :  New-RandomPIN.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Function to generate PINs with a freely definable number of numbers
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Function to generate PINs with a freely definable number of numbers

    .DESCRIPTION
	Function to generate PINs with a freely definable number of numbers. You can also set the smallest and greatest
	possible number. 

    If you found a bug or have some ideas to improve this function... Let me know. You find my Github profile in 
    the links below.
                
    .EXAMPLE
    New-RandomPIN -Length 6

	698577
	
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function New-RandomPIN
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
			HelpMessage='Length of the PIN  (Default=4)')]
		[Int32]$Length=4,

		[Parameter(
			Position=1,
			HelpMessage='Minimum PIN-Number (Default=0)')]
		[Int32]$Minimum=0,
	
		[Parameter(
			Position=2,
			HelpMessage='Maxmium PIN-Number  (Default=10)')]
		[Int32]$Maximum=10,

		[Parameter(
			Position=3,
			HelpMessage='Copy PIN to clipboard')]
		[switch]$CopyToClipboard
	)

	Begin{}
	Process{
		if($Length -eq 0)
		{
			Write-Host "Length of the PIN can not be 0... Check your input!" -ForegroundColor Red
		}

		if($Minimum -gt $Maximum)
		{
			Write-Host "Minimum PIN-Number can not be greater than maximum PIN-Number" -ForegroundColor Red
			return
		}

		$PIN = [String]::Empty
		
		while($PIN.Length -lt $Length)
		{
			# Create random numbers
			$PIN += (Get-Random -Minimum $Minimum -Maximum $Maximum).ToString()
		}

		if($CopyToClipboard)
		{
			Set-Clipboard -Value $PIN
		}

		# Return result
		return $PIN
	}
	End{}
}