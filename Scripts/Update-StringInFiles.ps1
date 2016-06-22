###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Update-StringInFiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Script to replace a string in multiple files
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Script to replace a string in one or multiple files
                 
    .DESCRIPTION         
    Script to replace a string in one or multiple files
    Binary files (*.zip, *.exe, etc.) are not touched by this script     
	                         
    .EXAMPLE
    .\Update-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Find "Computer" -ReplaceWith "Notebook" -CaseSensitive
       
	VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
	VERBOSE: Files with string found: 2
	VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_1.txt
	VERBOSE: Count: 3
	VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_4.txt
	VERBOSE: Count: 3   
	   
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

[CmdletBinding()]
Param(
	[Parameter(
		Position=0,
		Mandatory=$true,
		HelpMessage="String to find")]
	[String]$Find,
	
	[Parameter(
		Position=1,
		Mandatory=$true,
		HelpMessage="String to replace")]
	[String]$ReplaceWith,

    [Parameter(
		Position=2,
		HelpMessage="Folder where the files are stored (will search recursive)")]
	[String]$Path = (Get-Location),
	
    [Parameter(
		Position=3,
		HelpMessage="String must be case sensitive (Default=false)")]
	[switch]$CaseSensitive=$false
)

Begin{
	# Initialize function to ceck if file is binary or normal text (so i can make sure this script don't destroy for example .exe or .zip files)
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
}
Process{
	Write-Verbose "Binary files like (*.zip, *.exe, etc...) are ignored"

	$Files = Get-ChildItem -Path $Path -Recurse | Where-Object { ($_.PSIsContainer -eq $false) -and ((Test-IsFileBinary -Path $_.FullName) -eq $false) } | Select-String -Pattern ([regex]::Escape($Find)) -CaseSensitive:$CaseSensitive | Group-Object Path 
		
	Write-Verbose "Files with string found: $($Files.Count)"

	# Go through each file
	foreach($File in $Files)
	{
		Write-Verbose "File:`t$($File.Name)"
		Write-Verbose "Count:`t$($File.Count)"
    
		try
		{	
			# Replace string
			if($CaseSensitive)
			{
				(Get-Content -Path $File.Name) -creplace [regex]::Escape($Find), $ReplaceWith | Set-Content -Path $File.Name -Force
			}
			else
			{
				(Get-Content -Path $File.Name) -replace [regex]::Escape($Find), $ReplaceWith | Set-Content -Path $File.Name -Force
			}
		}
		catch
		{
			Write-Host "$($_.Exception.Message)" -ForegroundColor Red
		}
	}
}
End{}
