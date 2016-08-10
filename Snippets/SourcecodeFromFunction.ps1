# Get the sourcecode of a function

(Get-Command Get-Test).Definition

# or

$function:Test

# or if function contains "-"

$(function:Get-Test)
