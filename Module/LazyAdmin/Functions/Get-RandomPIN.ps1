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
	Generate a PIN with a freely definable number of numbers. You can also set the smallest and greatest possible number. 
	
    .EXAMPLE
    Get-RandomPIN -Length 8

	PIN
	---
	18176072

	.EXAMPLE
	Get-RandomPIN -Length 6 -Count 5 -Minimum 4 -Maximum 8

	Count PIN
	----- ---
		1 767756
		2 755655
		3 447667
		4 577646
		5 644665
	
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-RandomPIN.README.md
#>

function Get-RandomPIN
{
	[CmdletBinding(DefaultParameterSetName='NoClipboard')]
	param(
		[Parameter(
			Position=0,
			HelpMessage='Length of the PIN (Default=4)')]
		[Int32]$Length=4,

		[Parameter(
			ParameterSetName='NoClipboard',
			Position=1,
			HelpMessage='Number of PINs to be generated (Default=1)')]
		[Int32]$Count=1,

		[Parameter(
			ParameterSetName='Clipboard',
			Position=1,
			HelpMessage='Copy PIN to clipboard')]
		[switch]$CopyToClipboard,

		[Parameter(
			Position=2,
			HelpMessage='Smallest possible number (Default=0)')]
		[Int32]$Minimum=0,
		
		[Parameter(
			Position=3,
			HelpMessage='Greatest possible number (Default=9)')]
		[Int32]$Maximum=9		
	)

	Begin{

	}

	Process{
		if($Length -eq 0)
		{
			Write-Error -Message "Length of the PIN can not be 0... Check your input!" -Category InvalidArgument -ErrorAction Stop
		}

		if($Count -eq 0)
		{
			Write-Error -Message "Number of PINs to be generated can not be 0... Check your input!" -Category InvalidArgument -ErrorAction Stop
		}

		if($Minimum -gt $Maximum)
		{
			Write-Error -Message "Minimum PIN-Number can not be greater than maximum PIN-Number" -Category InvalidArgument -ErrorAction Stop
		}

		for($i = 1; $i -ne $Count + 1; $i++)
		{ 
			$PIN = [String]::Empty
				
			while($PIN.Length -lt $Length)
			{
				# Create random numbers
				$PIN += (Get-Random -Minimum $Minimum -Maximum $Maximum).ToString()
			}
			
			# Return result
			if($Count -eq 1)
			{
				# Set to clipboard
				if($CopyToClipboard)
				{
					Set-Clipboard -Value $PIN
				}

				[pscustomobject] @{
					PIN = $PIN
				}
			}
			else 
			{			
				[pscustomobject] @{
					Count = $i
					PIN = $PIN
				}	
			}
		}
	}

	End{
		
	}
}