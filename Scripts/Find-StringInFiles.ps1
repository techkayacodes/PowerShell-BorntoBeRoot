###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Find-StringInFiles.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Script to find a string in multiple files
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Script to find a string in one or multiple files
                 
    .DESCRIPTION         
    Script to find a string in one ormultiple files
                                 
    .EXAMPLE
    .\Find-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Find "Computer" -CaseSensitive
       
	Filename      Path                                     LineNumber Matches
	--------      ----                                     ---------- -------
	PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          1 {Computer}
	PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          3 {Computer}
	PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          6 {Computer}
	PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          1 {Computer}
	PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          3 {Computer}
	PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          6 {Computer}   
	   
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell
#>

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
		HelpMessage="String must be case sensitive (Default=false)")]
	[switch]$CaseSensitive=$false
)

Begin{}
Process{
	# Files with string to find
	$Strings = Get-ChildItem -Path $Path -Recurse | Select-String -Pattern ([regex]::Escape($Find)) -CaseSensitive:$CaseSensitive | Group-Object Path 
	
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
End{}