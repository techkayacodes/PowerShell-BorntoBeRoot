###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Test-IsFileBinary.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Function to check if a file is binary 
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Function to check if a file is binary 
                 
    .DESCRIPTION         
    Function to check if a file is binary. Returns true for binary or false for text files.

	I found this code snippet on Stackoverflow: 
	https://stackoverflow.com/questions/1077634/powershell-search-script-that-ignores-binary-files
                                 
    .EXAMPLE
    Test-IsFileBinary -Path "C:\Scripts\FolderWithFiles\Test.zip"
       
	True
	
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function Test-IsFileBinary
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
			Mandatory=$true,
			HelpMessage="Path to file which should be checked")]
		[String]$Path
	)

	Begin{}
	Process{
        # Check if Path is a directory
        if((Get-Item $Path) -is [System.IO.DirectoryInfo])
        {
            Write-Host "Cannot check a directory ($Path)" -ForegroundColor Yellow
            return
        }

		# encoding variable
		$encoding = ""

		# Get the first 1024 bytes from the file
		$byteArray = Get-Content -Path $Path -Encoding Byte -TotalCount 1024

		if(("{0:X}{1:X}{2:X}" -f $byteArray) -eq "EFBBBF")
		{
			# Test for UTF-8 BOM
			$encoding = "UTF-8"
		}
		elseif(("{0:X}{1:X}" -f $byteArray) -eq "FFFE")
		{
			# Test for the UTF-16
			$encoding = "UTF-16"
		}
		elseif(("{0:X}{1:X}" -f $byteArray) -eq "FEFF")
		{
			# Test for the UTF-16 Big Endian
			$encoding = "UTF-16 BE"
		}
		elseif(("{0:X}{1:X}{2:X}{3:X}" -f $byteArray) -eq "FFFE0000")
		{
			# Test for the UTF-32
			$encoding = "UTF-32"
		}
		elseif(("{0:X}{1:X}{2:X}{3:X}" -f $byteArray) -eq "0000FEFF")
		{
			# Test for the UTF-32 Big Endian
			$encoding = "UTF-32 BE"
		}

		if($encoding)
		{
			# File is text encoded
			return $false
		}

		# So now we're done with Text encodings that commonly have '0's
		# in their byte steams.  ASCII may have the NUL or '0' code in
		# their streams but that's rare apparently.

		# Both GNU Grep and Diff use variations of this heuristic

		if($byteArray -contains 0 )
		{
			# Test for binary
			return $true
		}

		# This should be ASCII encoded 
		$encoding = "ASCII"

		return $false
	}
	End{}
}