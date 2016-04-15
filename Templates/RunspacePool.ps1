###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  
# Repository   :  https://github.com/BornToBeRoot/
###############################################################################################################

<#
    .SYNOPSIS
    Template to create a RunspacePool to run code asynchronus
    
    .DESCRIPTION
      
    If you found a bug or have some ideas to improve this script... Let me know. You find my Github profile in 
    the links below.  
        
    .EXAMPLE
        
    .EXAMPLE
    
    .LINK
    Github Profil:         https://github.com/BornToBeRoot
    Github Repository:     https://github.com/BornToBeRoot/PowerShell_Scripts
#>

Param(
	# number concurrent threads --> depens on what code you are running / which hardware you are using
	[Parameter(
		Position=0,
		HelpMessage='Maximum number of threads at the same time (Default=100)')]
	[Int32]$Threads=100
)

Begin{
    Write-Host "This is only an example, without any output / test values..." -ForegroundColor Yellow
}
Process{
	### Scriptblock (this code will run asynchron in the RunspacePool)
	[System.Management.Automation.ScriptBlock]$ScriptBlock = {
		Param(
			### ScriptBlock Parameter
			$Parameter1,
			$Parameter2
		)

		#######################################
		## Enter
		## code
		## here,
		## which
		## should
		## run
		## asynchron
		#######################################
		
		### Built custom PSObject which get returned
		$Result = New-Object -TypeName PSObject
		Add-Member -InputObject $Result -MemberType NoteProperty -Name Parameter1 -Value Result1
		Add-Member -InputObject $Result -MemberType NoteProperty -Name Parameter2 -Value Result2

		### Return result 
		return $Result
	}
	
	# Create the RunspacePool and open it
	$RunspacePool = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspacePool(1, $Threads, $Host)
	$RunspacePool.Open()

	# Create array for jobs
	$Jobs = @()
	
	# Setting up jobs
	for($i = $StartRange; $i -le $EndRange; $i++)
	{
		# Hashtable to pass parameters
		$ScriptParams = @{
			Parameter1 = $Parameter1
			Parameter2 = $Parameter2
		}

		# Write-Progress...

		# Create job
		$Job = [System.Management.Automation.PowerShell]::Create().AddScript($ScriptBlock).AddParameters($ScriptParams)
        $Job.RunspacePool = $RunspacePool
        $Jobs += New-Object PSObject -Property @{
            RunNum = $i - $StartRange # Depens on your for-loop... it should count 0,1,2,3,...
            Pipe = $Job
            Result = $Job.BeginInvoke()
        }		
	}

	# Wait until all jobs are finished
	Do {
		Start-Sleep -Milliseconds 500 # Maybe wait 1 or 2 seconds

		# Write-Progress...
	} While ($Jobs.Result.IsCompleted -contains $false)


	# Creat array for result 
    	$Jobs_Result = @()

    	# Get results and fill the array
    	foreach($Job in $Jobs)
    	{
        	$Jobs_Result += $Job.Pipe.EndInvoke($Job.Result)
		$Job.Pipe.Dispose() # Release memory -> else Memory Leak (you have to close the PowerShell-Console)
	}

	# Its important to close the RunspacePool
	$RunspacePool.Close()

	# Return result
	return $Jobs_Result
}
End{}
