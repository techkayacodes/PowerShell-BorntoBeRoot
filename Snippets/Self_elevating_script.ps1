# Restart script/console as admin with parameters
if(-not([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
	$Arguments = "& '" + $MyInvocation.MyCommand.Definition + "'"
	Start-Process powershell -Verb RunAs -ArgumentList $Arguments
	Break
}