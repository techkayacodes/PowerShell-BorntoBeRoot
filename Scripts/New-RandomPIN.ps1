###############################################################################################################
# Language     :  PowerShell 5.0
# Filename     :  New-RandomPIN.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Generate a PIN with a freely definable number of numbers
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Generate a PIN with a freely definable number of numbers

    .DESCRIPTION
	Generate a PIN with a freely definable number of numbers. You can also set the smallest and greatest
	possible number. 
                
    .EXAMPLE
    .\New-RandomPIN.ps1 -Length 6

	698577

	.EXAMPLE
	New-RandomPIN -Length 8 -Minimum 4 -Maximum 8

	56655574
	
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/New-RandomPIN.README.md
#>

[CmdletBinding()]
Param(
	[Parameter(
		Position=0,
		HelpMessage='Length of the PIN (Default=4)')]
	[Int32]$Length=4,

	[Parameter(
		Position=1,
		HelpMessage='Smallest possible number (Default=0)')]
	[Int32]$Minimum=0,
	
	[Parameter(
		Position=2,
		HelpMessage='Greatest possible number (Default=10)')]
	[Int32]$Maximum=10,

	[Parameter(
		Position=3,
		HelpMessage='Copy PIN to clipboard')]
	[switch]$CopyToClipboard
)

Begin{

}

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

End{
	
}