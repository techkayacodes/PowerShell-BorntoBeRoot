###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  LazyAdmin.psm1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  PowerShell-Module for lazy admins
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

# Include all functions, outsourced in script-files
Get-ChildItem -Path $PSScriptRoot | Where-Object {$_.Name.EndsWith(".ps1")} | ForEach-Object {. $_.FullName}