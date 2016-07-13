###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  New-RandomPassword.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Generate passwords with a freely definable number of characters
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Generate passwords with a freely definable number of characters

    .DESCRIPTION
	Generate passwords with a freely definable number of characters. You can also select which chars you want to use (upper case, lower case, numbers and special chars).

	.EXAMPLE
	New-RandomPassword -Length 8

	NX58m2B$    

    .EXAMPLE
    New-RandomPassword -Length 10 -DisableSpecialChars

	7UZE6pyyGM
		
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/New-RandomPassword.README.md
#>

function New-RandomPassword
{
	[CmdletBinding()]
	param(
		[Parameter(
			Position=0,
			HelpMessage='Length of the Password  (Default=8)')]
		[Int32]$Length=8,

		[Parameter(
			Position=1,
			HelpMessage='Use lower case characters (Default=$true')]
		[switch]$DisableLowerCase,

		[Parameter(
			Position=2,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$DisableUpperCase,
		
		[Parameter(
			Position=3,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$DisableNumbers,

		[Parameter(
			Position=4,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$DisableSpecialChars,

		[Parameter(
			Position=5,
			HelpMessage='Copy password to clipboard')]
		[switch]$CopyToClipboard
	)

	Begin{

	}

	Process{
		if($Length -eq 0)
		{
			Write-Host "Length of the password can not be 0... Check your input!" -ForegroundColor Red
			return
		}
			
		$Character_LowerCase = "abcdefghiklmnprstuvwxyz"
		$Character_UpperCase = "ABCDEFGHKLMNPRSTUVWXYZ"
		$Character_Numbers = "0123456789"
		$Character_SpecialChars = "�$%&/()=?+*#[]{}-_@"

		$Characters = [String]::Empty
			
		# Built string with characters
		if($DisableLowerCase.IsPresent -eq $false)
		{
			$Characters += $Character_LowerCase
		}

		if($DisableUpperCase.IsPresent -eq $false)
		{
			$Characters += $Character_UpperCase
		}

		if($DisableNumbers.IsPresent -eq $false)
		{
			$Characters += $Character_Numbers
		}
		
		if($DisableSpecialChars.IsPresent -eq $false)
		{
			$Characters += $Character_SpecialChars
		}
		
		$Password = [String]::Empty
		
		if(-not([String]::IsNullOrEmpty($Characters)))
		{		
			# Create random password
			while($Password.Length -lt $Length)
			{
				# Create random numbers
				$RandomNumber = Get-Random -Maximum $Characters.Length
				$Password += $Characters[$RandomNumber]
			}
		}
		else
		{
			Write-Host "Select at least 1 character set (lower case, upper case, numbers or special chars) to create a password." -ForegroundColor Red
			return
		}

		# Set to clipboard
		if($CopyToClipboard)
		{
			Set-Clipboard -Value $Password
		}

		# Return result
		return $Password
	}

	End{
		
	}
}