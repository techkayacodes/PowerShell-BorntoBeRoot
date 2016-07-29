###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Get-ConsoleColors.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Get all available console colors
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Get all available console colors 

    .DESCRIPTION
    Get all available console colors. A preview how they look (foreground and background) can be displayed with the parameter "-Preview".

    .EXAMPLE
    .\Get-ConsoleColors.ps1

    ConsoleColor
    ------------
           Black
        DarkBlue
       DarkGreen
        DarkCyan
         DarkRed
     DarkMagenta
      DarkYellow
            Gray
        DarkGray
            Blue
           Green
            Cyan
             Red
         Magenta
          Yellow
           White

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Get-ConsoleColors.README.md
#>

[CmdletBinding()]
param(
    [Parameter(
        Position=0,
        HelpMessage='Show a preview of all available console colors (foreground & background)')]
    [switch]$Preview
)

Begin{

}

Process{
    $Colors = [Enum]::GetValues([ConsoleColor])

    if($Preview)
    {
        foreach($Color in $Colors)
        {            
            Write-Host "$Color --> " -NoNewline
            Write-Host "Foreground" -ForegroundColor $Color -NoNewline
            Write-Host ", " -NoNewline
            Write-Host "Background" -BackgroundColor $Color            
        }
    }
   
    [System.Collections.ArrayList]$Results = @()

    foreach($Color in $Colors)
    {
        $Result = [pscustomobject] @{
            ConsoleColor = $Color
        }
     
        [void]$Results.Add($Result)
    }

    return $Results        
}

End{

}