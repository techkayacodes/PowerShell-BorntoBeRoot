$colors = [Enum]::GetValues([ConsoleColor])

Write-Host "-- Foreground colors --"

foreach($color in $colors)
{
    Write-Host "$color" -ForegroundColor $color
}

Write-Host "-- Background colors --"

foreach($color in $colors)
{
	Write-Host "$color" -BackgroundColor $color
}