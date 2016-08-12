$Title = "Continue"
$Info = "Would you like to continue?"
 
$Options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
[int]$Defaultchoice = 0
$Opt =  $host.UI.PromptForChoice($Title , $Info, $Options, $Defaultchoice)

switch($Opt)
{
	0 { 
		Write-Host "Yes" -ForegroundColor Green
	}
	1 { 
		Write-Host "No" -ForegroundColor Green
	}
}
