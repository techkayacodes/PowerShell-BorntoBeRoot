###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Test-IsFileBinary.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Test if a file is binary 
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Test if a file is binary 
                 
    .DESCRIPTION         
    Test if a file is binary like .exe or .zip.
	
	I found this code snippet on Stackoverflow: 
	https://stackoverflow.com/questions/1077634/powershell-search-script-that-ignores-binary-files
                                 
    .EXAMPLE
    Test-IsFileBinary -Path "E:\Temp\Files\File_01.txt"
       
	False
	
	.EXAMPLE
	Test-IsFileBinary -Path "E:\Temp\Files\File_04.zip"
       
	True

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Test-IsFileBinary.README.md
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

	Begin{
		
	}

	Process{
        # Check if path is a directory
        if((Get-Item $Path) -is [System.IO.DirectoryInfo])
        {
            Write-Error -Message "Checking a directory is not supported ($Path)" -Category InvalidArgument -ErrorAction Stop
        }

		# Encoding variable
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

	End{
		
	}
}