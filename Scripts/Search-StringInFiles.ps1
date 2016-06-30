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
       
	Filename    Path                      LineNumber Matches
	--------    ----                      ---------- -------
	File_01.txt E:\Temp\Files\File_01.txt          1 {Test01}
	File_02.txt E:\Temp\Files\File_02.txt          1 {TEST01}
	File_03.txt E:\Temp\Files\File_03.txt          1 {TeST01}

	.EXAMPLE  
	.\Search-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Search "TEST01" -CaseSensitive

	Filename    Path                      LineNumber Matches
	--------    ----                      ---------- -------
	File_02.txt E:\Temp\Files\File_02.txt          1 {TEST01}

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Search-StringInFiles.README.md
#>

[CmdletBinding()]
Param(
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

}

Process{
	# Files with string to find
	$Strings = Get-ChildItem -Path $Path -Recurse | Select-String -Pattern ([regex]::Escape($Search)) -CaseSensitive:$CaseSensitive | Group-Object Path 
	
	$Results = @()

	# Go through each file
	foreach($String in $Strings)
	{		
		# Go through each group
		foreach($Group in $String.Group)
		{	
			$Result = New-Object -TypeName PSObject
			Add-Member -InputObject $Result -MemberType NoteProperty -Name Filename -Value $Group.Filename
			Add-Member -InputObject $Result -MemberType NoteProperty -Name Path -Value $Group.Path
			Add-Member -InputObject $Result -MemberType NoteProperty -Name LineNumber -Value $Group.LineNumber
			Add-Member -InputObject $Result -MemberType NoteProperty -Name Matches -Value $Group.Matches
			$Results += $Result
		}   
	}

	return $Results
}

End{
	
}