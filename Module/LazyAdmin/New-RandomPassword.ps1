###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  New-RandomPassword.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Function to generate PINs with a freely definable number of numbers
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Function to generate passwords with a freely definable number of characters

    .DESCRIPTION
	Function to generate passwords with a freely definable number of characters. You can also select which chars
	you want to use (upper case, lower case, numbers and special chars).

    If you found a bug or have some ideas to improve this function... Let me know. You find my Github profile in 
    the links below.
                
    .EXAMPLE
    New-RandomPassword.ps1 -Length 10 -SpecialChars:$false

    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function New-RandomPassword
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
			HelpMessage='Length of the Password  (Default=8)')]
		[Int32]$Length=8,

		[Parameter(
			Position=1,
			HelpMessage='Use lower case characters (Default=$true')]
		[switch]$LowerCase=$true,

		[Parameter(
			Position=2,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$UpperCase=$true,
	
		[Parameter(
			Position=3,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$Numbers=$true,

		[Parameter(
			Position=4,
			HelpMessage='Use upper case characters (Default=$true)')]
		[switch]$SpecialChars=$true,

		[Parameter(
			Position=5,
			HelpMessage='Copy passwprd to clipboard')]
		[switch]$CopyToClipboard
	)

	Begin{}
	Process{
		if($Length -eq 0)
		{
			Write-Host "Length of the password can not be 0... Check your input!" -ForegroundColor Red
			return
		}
		
		$Character_LowerCase = "abcdefghiklmnprstuvwxyz"
		$Character_UpperCase = "ABCDEFGHKLMNPRSTUVWXYZ"
		$Character_Numbers = "0123456789"
		$Character_SpecialChars = "§$%&/()=?+*#[]{}-_@"

		$Characters = [String]::Empty
		
		# Built string with characters
		if($LowerCase)
		{
			$Characters += $Character_LowerCase
		}

		if($UpperCase)
		{
			$Characters += $Character_UpperCase
		}

		if($Numbers)
		{
			$Characters += $Character_Numbers
		}
	
		if($SpecialChars)
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
			Write-Host "Select at least 1 character set (lower chase, upper case, numbers or special chars) to create a password." -ForegroundColor Red
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
	End{}
}