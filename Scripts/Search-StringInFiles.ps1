###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Search-StringInFiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Find a string in multiple files
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Find a string in one or multiple files
                 
    .DESCRIPTION         
    Find a string in one or multiple files. The search is performed recursively from the start folder.
                                 
    .EXAMPLE
    .\Search-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Search "Test01"
       
	Filename    Path                      LineNumber IsBinary Matches
	--------    ----                      ---------- -------- -------
	File_01.txt E:\Temp\Files\File_01.txt          1    False {Test01}
	File_02.txt E:\Temp\Files\File_02.txt          1    False {TEST01}
	File_03.txt E:\Temp\Files\File_03.txt          1    False {TeST01}

	.EXAMPLE  
	.\Search-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Search "TEST01" -CaseSensitive

	Filename    Path                      LineNumber IsBinary Matches
	--------    ----                      ---------- -------- -------
	File_02.txt E:\Temp\Files\File_02.txt          1    False {TEST01}

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Search-StringInFiles.README.md
#>

[CmdletBinding()]
param(
  [Parameter(
		Position=0,
		Mandatory=$true,
		HelpMessage="String to find")]
	[String]$Search,

    [Parameter(
		Position=1,
		HelpMessage="Folder where the files are stored (search is recursive)")]
	[String]$Path = (Get-Location),
	
	[Parameter(
		Position=2,
		HelpMessage="String must be case sensitive (Default=false)")]
	[switch]$CaseSensitive=$false
)

Begin{
	# Helper function to test if a file is binary
	function Test-IsFileBinary
	{
		[CmdletBinding()]
		param(
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
				Write-Host "Checking a directory is not supported ($Path)" -ForegroundColor Yellow
				return
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
}

Process{
	# Files with string to find
	$Strings = Get-ChildItem -Path $Path -Recurse | Select-String -Pattern ([regex]::Escape($Search)) -CaseSensitive:$CaseSensitive | Group-Object Path 
	
	# Go through each file
	foreach($String in $Strings)
	{		
		$IsBinary = Test-IsFileBinary -Path $String.Name

		# Go through each group
		foreach($Group in $String.Group)
		{	
			$Result = [pscustomobject] @{
				Filename = $Group.Filename
				Path = $Group.Path
				LineNumber = $Group.LineNumber
				IsBinary = $IsBinary
				Matches = $Group.Matches
			}

			$Result
		}   
	}
}

End{
	
}