###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Edit-StringInFiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Function to replace a string in multiple files
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Function to replace a string in one or multiple files
                 
    .DESCRIPTION         
    Function to replace a string in one or multiple files
    Binary files (*.zip, *.exe, etc.) are not touched by this script     
	                         
    .EXAMPLE
    .\Edit-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Find "Computer" -ReplaceWith "Notebook" -CaseSensitive
       
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

function Edit-StringInFiles
{
	[CmdletBinding()]
	Param(
		[Parameter(
			Position=0,
			Mandatory=$true,
			HelpMessage="Folder where the files are stored (will search recursive)")]
		[String]$Path,

		[Parameter(
			Position=1,
			Mandatory=$true,
			HelpMessage="String to find")]
		[String]$Find,
	
		[Parameter(
			Position=2,
			Mandatory=$true,
			HelpMessage="String to replace")]
		[String]$ReplaceWith,

		[Parameter(
			Position=3,
			HelpMessage="String must be case sensitive (Default=false)")]
		[switch]$CaseSensitive=$false
	)

	Begin{}
	Process{
		Write-Verbose "Binary files like (*.zip, *.exe, etc...) are ignored"

		$Files = Get-ChildItem -Path $Path -Recurse | Where-Object { (Test-IsFileBinary -Path $_.FullName) -eq $false } | Select-String -Pattern ([regex]::Escape($Find)) -CaseSensitive:$CaseSensitive | Group-Object Path 
		
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
}