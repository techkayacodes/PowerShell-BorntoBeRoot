###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Update-StringInFiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Replace a string in multiple files
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Replace a string in one or multiple files
                 
    .DESCRIPTION         
    Replace a string in one or multiple files.
	
    Binary files (*.zip, *.exe, etc.) are not touched by this script.
	                         
    .EXAMPLE
    Update-StringInFiles -Path E:\Temp\Files\ -Search "Test1" -ReplaceWith "Test2" -Verbose
       
	VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
	VERBOSE: Total files with string to replace found: 3
	VERBOSE: Current file: E:\Temp\Files\File_01.txt
	VERBOSE: Number of strings to replace in current file: 1
	VERBOSE: Current file: E:\Temp\Files\File_02.txt
	VERBOSE: Number of strings to replace in current file: 1
	VERBOSE: Current file: E:\Temp\Files\File_03.txt
	VERBOSE: Number of strings to replace in current file: 2
	   
    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Update-StringInFiles.README.md
#>

function Update-StringInFiles
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
			Mandatory=$true,
			HelpMessage="String to find")]
		[String]$Search,
	
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

	}

	Process{
		Write-Verbose "Binary files like (*.zip, *.exe, etc...) are ignored"

		$Files = Get-ChildItem -Path $Path -Recurse | Where-Object { ($_.PSIsContainer -eq $false) -and ((Test-IsFileBinary -Path $_.FullName) -eq $false) } | Select-String -Pattern ([regex]::Escape($Search)) -CaseSensitive:$CaseSensitive | Group-Object Path 
		
		Write-Verbose "Total files with string to replace found: $($Files.Count)"

		# Go through each file
		foreach($File in $Files)
		{
			Write-Verbose "File:`t$($File.Name)"
			Write-Verbose "Number of strings to replace in current file:`t$($File.Count)"
    
			try
			{	
				# Replace string
				if($CaseSensitive)
				{
					(Get-Content -Path $File.Name) -creplace [regex]::Escape($Search), $ReplaceWith | Set-Content -Path $File.Name -Force
				}
				else
				{
					(Get-Content -Path $File.Name) -replace [regex]::Escape($Search), $ReplaceWith | Set-Content -Path $File.Name -Force
				}
			}
			catch
			{
				Write-Host "$($_.Exception.Message)" -ForegroundColor Red
			}
		}
	}

	End{

	}
}