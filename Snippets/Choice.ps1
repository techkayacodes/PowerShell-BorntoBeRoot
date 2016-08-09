$Title = "Continue"
$Info = "Would you like to continue?"
 
$Options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
[int]$defaultchoice = 0
$Opt =  $host.UI.PromptForChoice($Title , $Info , $Options,$defaultchoice)

switch($Opt)
{
	0 { 
		Write-Host "Yes" -ForegroundColor Green
	}
	1 { 
		Write-Host "No" -ForegroundColor Green
	}
}