$Title = "Continue"
$Info = "Would you like to continue?"
 
$Options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
[int]$Defaultchoice = 0
$Opt =  $host.UI.PromptForChoice($Title , $Info, $Options, $Defaultchoice)

switch($Opt)
{
	0 { 
		Write-Verbose -Message "Yes"
	}
	1 { 
		Write-Verbose -Message "No" 
	}
}
