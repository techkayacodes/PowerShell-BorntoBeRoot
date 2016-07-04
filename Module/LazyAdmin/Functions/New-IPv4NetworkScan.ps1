###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  New-IPv4NetworkScan.ps1 
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Powerful asynchronus IPv4 Network Scanner
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

<#
    .SYNOPSIS
    Powerful asynchronus IPv4 Network Scanner

    .DESCRIPTION
    This powerful asynchronus IPv4 Network Scanner allows you to scan every IPv4-Range you want (172.16.1.47 to 172.16.2.5 would work). But there is also the possibility to scan an entire subnet based on an IPv4-Address withing the subnet and a the subnetmask/CIDR.

    The default result will contain the the IPv4-Address, Status (Up or Down) and the Hostname. Other values can be displayed via parameter (Try Get-Help for more details).

    .EXAMPLE
    New-IPv4NetworkScan -StartIPv4Address 192.168.178.0 -EndIPv4Address 192.168.178.20

    IPv4Address   Status Hostname
    -----------   ------ --------
    192.168.178.1 Up     fritz.box

    .EXAMPLE
    New-IPv4NetworkScan -IPv4Address 192.168.178.0 -Mask 255.255.255.0 -DisableDNSResolving

    IPv4Address    Status
    -----------    ------
    192.168.178.1  Up
    192.168.178.22 Up

    .EXAMPLE
    New-IPv4NetworkScan -IPv4Address 192.168.178.0 -CIDR 25 -EnableMACResolving

    IPv4Address    Status Hostname           MAC               Vendor
    -----------    ------ --------           ---               ------
    192.168.178.1  Up     fritz.box          XX-XX-XX-XX-XX-XX AVM Audiovisuelles Marketing und Computersysteme GmbH
    192.168.178.22 Up     XXXXX-PC.fritz.box XX-XX-XX-XX-XX-XX ASRock Incorporation

    .LINK
    https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/New-IPv4NetworkScan.README.md
#>

function New-IPv4NetworkScan
{
    [CmdletBinding(DefaultParameterSetName='Range')]
    Param(
        [Parameter(
            ParameterSetName='Range',
            Position=0,
            Mandatory=$true,
            HelpMessage='Start IPv4-Address like 192.168.1.10')]
        [IPAddress]$StartIPv4Address,

        [Parameter(
            ParameterSetName='Range',
            Position=1,
            Mandatory=$true,
            HelpMessage='End IPv4-Address like 192.168.1.100')]
        [IPAddress]$EndIPv4Address,
        
        [Parameter(
            ParameterSetName='CIDR',
            Position=0,
            Mandatory=$true,
            HelpMessage='IPv4-Address which is in the subnet')]
        [Parameter(
            ParameterSetName='Mask',
            Position=0,
            Mandatory=$true,
            HelpMessage='IPv4-Address which is in the subnet')]
        [IPAddress]$IPv4Address,

        [Parameter(
            ParameterSetName='CIDR',        
            Position=1,
            Mandatory=$true,
            HelpMessage='CIDR like /24 without "/"')]
        [ValidateRange(0,31)]
        [Int32]$CIDR,
    
        [Parameter(
            ParameterSetName='Mask',
            Position=1,
            Mandatory=$true,
            Helpmessage='Subnetmask like 255.255.255.0')]
        [ValidatePattern("^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(254|252|248|240|224|192|128|0)$")]
        [String]$Mask,

        [Parameter(
            Position=2,
            HelpMessage='Maxmium number of ICMP checks for each IPv4-Address (Default=2)')]
        [Int32]$Tries=2,

        [Parameter(
            Position=3,
            HelpMessage='Maximum number of threads at the same time (Default=256)')]
        [Int32]$Threads=256,
        
        [Parameter(
            Position=4,
            HelpMessage='Resolve DNS for each IP (Default=Enabled)')]
        [Switch]$DisableDNSResolving,

        [Parameter(
            Position=5,
            HelpMessage='Resolve MAC-Address for each IP (Default=Disabled)')]
        [Switch]$EnableMACResolving,

        [Parameter(
            Position=6,
            HelpMessage='Get extendend informations like BufferSize, ResponseTime and TTL (Default=Disabled)')]
        [Switch]$ExtendedInformations,

        [Parameter(
            Position=7,
            HelpMessage='Include inactive devices in result')]
        [Switch]$IncludeInactive,

        [Parameter(
            Position=8,
            HelpMessage='Update IEEE Standards Registration Authority from IEEE.org (https://standards.ieee.org/develop/regauth/oui/oui.csv)')]
        [Switch]$UpdateList
    )

    Begin{
        Write-Verbose "Script started at $(Get-Date)"
        
        # IEEE ->  The Public Listing For IEEE Standards Registration Authority -> CSV-File
        $IEEE_MACVendorList_WebUri = "http://standards.ieee.org/develop/regauth/oui/oui.csv"

        # MAC-Vendor list path
        $CSV_MACVendorList_Path = "$PSScriptRoot\IEEE_Standards_Registration_Authority.csv"
        $CSV_MACVendorList_BackupPath = "$PSScriptRoot\IEEE_Standards_Registration_Authority.csv.bak"

        # Function to update the list from IEEE (MAC-Vendor)
        function UpdateListFromIEEE
        {     
            # Try to download the MAC-Vendor list from IEEE
            try{
                Write-Verbose "Create backup of the IEEE Standards Registration Authority list..."
                
                # Save file, before download a new version     
                if([System.IO.File]::Exists($CSV_MACVendorList_Path))
                {
                    Rename-Item -Path $CSV_MACVendorList_Path -NewName $CSV_MACVendorList_BackupPath
                }

                Write-Verbose "Updating IEEE Standards Registration Authority from IEEE.org..."

                # Download csv-file from IEEE
                Invoke-WebRequest -Uri $IEEE_MACVendorList_WebUri -OutFile $CSV_MACVendorList_Path -ErrorAction Stop

                Write-Verbose "Remove backup of the IEEE Standards Registration Authority list..."

                # Remove Backup, if no error
                if([System.IO.File]::Exists($CSV_MACVendorList_BackupPath))
                {
                    Remove-Item -Path $CSV_MACVendorList_BackupPath
                }            
            }
            catch{            
                Write-Verbose "Cleanup downloaded file and restore backup..."

                # On error: cleanup downloaded file and restore backup
                if([System.IO.File]::Exists($CSV_MACVendorList_Path))
                {
                    Remove-Item -Path $CSV_MACVendorList_Path
                }

                if([System.IO.File]::Exists($CSV_MACVendorList_BackupPath))
                {
                    Rename-Item -Path $CSV_MACVendorList_BackupPath -NewName $CSV_MACVendorList_Path
                }

                $_.Exception.Message                        
            }        
        }  

        # Assign vendor to MAC
        function AssignVendorToMAC
        {
            param(
                [PSObject]$Result
            )

            Begin{

            }

            Process {
                $Vendor = [String]::Empty

                # Check if MAC is null or empty
                if(-not([String]::IsNullOrEmpty($Result.MAC)))
                {
                    # Split it, so we can search the vendor (XX-XX-XX-XX-XX-XX to XX-XX-XX)
                    $MACVendor_Search = $Job_Result.MAC.Replace("-","").Substring(0,6)
                    
                    try {
                        $Vendor = (($MAC_VendorList | Where-Object {$_.Assignment -eq $MACVendor_Search})[0])."Organization Name"
                    }
                    catch {}
                }

                $NewResult = New-Object -TypeName PSObject -ArgumentList $Result
                Add-Member -InputObject $NewResult -MemberType NoteProperty -Name Vendor -Value $Vendor

                return $NewResult
            }

            End {

            }
        }
    }

    Process{
        # Check for Update
        if($UpdateList.IsPresent)
        {
            UpdateListFromIEEE
        }
        elseif(($EnableMACResolving.IsPresent) -and (-Not([System.IO.File]::Exists($CSV_MACVendorList_Path))))
        {
            Write-Host 'No CSV-File to assign vendor with MAC-Address found! Use the parameter "-UpdateList" to download the latest version from IEEE.org. This warning doesn`t affect the scanning procedure.' -ForegroundColor Yellow
        }    

        # Check if it is possible to assign vendor to MAC and import CSV-File 
        if(($EnableMACResolving.IsPresent) -and ([System.IO.File]::Exists($CSV_MACVendorList_Path)))
        {
            $AssignVendorToMAC = $true

            # Import the CSV-File
            $MAC_VendorList = Import-Csv -Path $CSV_MACVendorList_Path | Select-Object "Assignment", "Organization Name"
        }
        else 
        {
            $AssignVendorToMAC = $false
        }

        # Calculate Subnet (Start and End IPv4-Address)
        if($PSCmdlet.ParameterSetName -eq 'CIDR' -or $PSCmdlet.ParameterSetName -eq 'Mask')
        {
            # Convert Subnetmask
            if($PSCmdlet.ParameterSetName -eq 'Mask')
            {
                $CIDR = (Convert-Subnetmask -Mask $Mask).CIDR     
            }

            # Create new subnet
            $Subnet = New-IPv4Subnet -IPv4Address $IPv4Address -CIDR $CIDR

            # Assign Start and End IPv4-Address
            $StartIPv4Address = $Subnet.NetworkID
            $EndIPv4Address = $Subnet.Broadcast
        }

        # Convert Start and End IPv4-Address to Int64
        $StartIPv4Address_Int64 = (Convert-IPv4Address -IPv4Address $StartIPv4Address.ToString()).Int64
        $EndIPv4Address_Int64 = (Convert-IPv4Address -IPv4Address $EndIPv4Address.ToString()).Int64

        # Check if range is valid
        if($StartIPv4Address_Int64 -gt $EndIPv4Address_Int64)
        {
            Write-Host "Invalid IP-Range... Check your input!" -ForegroundColor Red
            return
        }

        # Calculate IPs to scan (range)
        $IPsToScan = ($EndIPv4Address_Int64 - $StartIPv4Address_Int64)
        
        Write-Verbose "Scanning range from $StartIPv4Address to $EndIPv4Address ($($IPsToScan + 1) IPs)"
        Write-Verbose "Running with max $Threads threads"
        Write-Verbose "ICMP checks per IP is set to $Tries"
        
        # Scriptblock --> will run in runspaces (threads)...
        [System.Management.Automation.ScriptBlock]$ScriptBlock = {
            Param(
                $IPv4Address,
                $Tries,
                $DisableDNSResolving,
                $EnableMACResolving,
                $ExtendedInformations,
                $IncludeInactive
            )

            # Built custom PSObject
            $Result = New-Object -TypeName PSObject
            Add-Member -InputObject $Result -MemberType NoteProperty -Name IPv4Address -Value $IPv4Address

            # +++ Send ICMP requests +++
            $Status = [String]::Empty

            for($i = 0; $i -lt $Tries; i++)
            {
                try{
                    $PingObj = New-Object System.Net.NetworkInformation.Ping
                    
                    $Timeout = 1000
                    $Buffer = New-Object Byte[] 32
                    
                    $PingResult = $PingObj.Send($IPv4Address, $Timeout, $Buffer)

                    if($PingResult.Status -eq "Success")
                    {
                        $Status = "Up"
                        break # Exit loop, if host is reachable
                    }
                    else
                    {
                        $Status = "Down"
                    }
                }
                catch
                {
                    $Status = "Down"
                    break # Exit loop, if there is an error
                }
            }
            
            Add-Member -InputObject $Result -MemberType NoteProperty -Name Status -Value $Status

            # +++ Resolve DNS +++
            $Hostname = [String]::Empty     

            if((-not($DisableDNSResolving.IsPresent)) -and ($Status -eq "Up" -or $IncludeInactive.IsPresent))
            {   	
                try{ 
                    $Hostname = ([System.Net.Dns]::GetHostEntry($IPv4Address).HostName)
                } 
                catch { } # No DNS                    
                
                Add-Member -InputObject $Result -MemberType NoteProperty -Name Hostname -Value $Hostname 
            }
        
            # +++ Get MAC-Address +++
            $MAC = [String]::Empty 

            if(($EnableMACResolving.IsPresent) -and ($Status -eq "Up"))
            {
                $Arp_Result = (arp -a ).ToUpper()
                        
                foreach($Line in $Arp_Result)
                {
                    if($Line.TrimStart().StartsWith($IPv4Address))
                    {
                        $MAC = [Regex]::Matches($Line,"([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
                    }
                }

                # If the first function is not able to get the MAC-Address            
                if([String]::IsNullOrEmpty($MAC))
                {
                    try{              
                        $Nbtstat_Result = nbtstat -A $IPv4Address | Select-String "MAC"
                        $MAC = [Regex]::Matches($Nbtstat_Result, "([0-9A-F][0-9A-F]-){5}([0-9A-F][0-9A-F])").Value
                    }  
                    catch{ } # No MAC   
                }   

                Add-Member -InputObject $Result -MemberType NoteProperty -Name MAC -Value $MAC   
            }

            # +++ Get extended informations +++
            $BufferSize = [String]::Empty 
            $ResponseTime = [String]::Empty 
            
            if($ExtendedInformations.IsPresent -and ($Status -eq "Up"))
            {
                try{
                    $BufferSize =  $PingResult.Buffer.Length
                    $ResponseTime = $PingResult.RoundtripTime
                    $TTL = $PingResult.Options.Ttl
                }
                catch{} # Failed to get extended informations	

                Add-Member -InputObject $Result -MemberType NoteProperty -Name BufferSize -Value $BufferSize
                Add-Member -InputObject $Result -MemberType NoteProperty -Name ResponseTime -Value $ResponseTime
                Add-Member -InputObject $Result -MemberType NoteProperty -Name TTL -Value $TTL		
            }	
        
            if($Status -eq "Up" -or $IncludeInactive.IsPresent)
            {
                return $Result
            }      
            else 
            {
                return $null
            }
        } 

        Write-Verbose "Setting up RunspacePool..."

        # Create RunspacePool and Jobs
        $RunspacePool = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspacePool(1, $Threads, $Host)
        $RunspacePool.Open()
        [System.Collections.ArrayList]$Jobs = @()

        Write-Verbose "Setting up Jobs..."

        # Set up Jobs for each IP
        for ($i = $StartIPv4Address_Int64; $i -le $EndIPv4Address_Int64; $i++) 
        { 
            # Convert IP back from Int64
            $IPv4Address = (Convert-IPv4Address -Int64 $i).IPv4Address                

            # Create hashtable to pass parameters
            $ScriptParams = @{
                IPv4Address = $IPv4Address
                Tries = $Tries
                DisableDNSResolving = $DisableDNSResolving
                EnableMACResolving = $EnableMACResolving
                ExtendedInformations = $ExtendedInformations
                IncludeInactive = $IncludeInactive
            }       

            # Catch when trying to divide through zero
            try {
                $Progress_Percent = (($i - $StartIPv4Address_Int64) / $IPsToScan) * 100 
            } 
            catch { 
                $Progress_Percent = 100 
            }

            Write-Progress -Activity "Setting up jobs..." -Id 1 -Status "Current IP-Address: $IPv4Address" -PercentComplete $Progress_Percent
                            
            # Create new job
            $Job = [System.Management.Automation.PowerShell]::Create().AddScript($ScriptBlock).AddParameters($ScriptParams)
            $Job.RunspacePool = $RunspacePool
            
            $JobObj = New-Object PSObject -Property @{
                RunNum = $i - $StartIPv4Address_Int64
                Pipe = $Job
                Result = $Job.BeginInvoke()
            }

            # Add Job to collection
            $Jobs.Add($JobObj) | Out-Null
        }

        Write-Verbose "Waiting for jobs to complete & starting to process results..."
        
        # Process results (that are finished), while waiting for other jobs
        Do {
            Write-Progress -Activity "Waiting for jobs to complete... ($($Threads - $($RunspacePool.GetAvailableRunspaces())) of $Threads threads running)" -Id 1 -PercentComplete (($Jobs.count - $($($Jobs | Where-Object {$_.Result.IsCompleted -eq $false}).Count)) / $Jobs.Count * 100) -Status "$(@($($Jobs | Where-Object {$_.Result.IsCompleted -eq $false})).Count) remaining..."

            # Get all complete jobs
            $Jobs_ToProcess = $Jobs | Where {$_.Result.IsCompleted -eq $true}

            # If no jobs finished yet, wait 500 ms and try again
            if($Jobs_ToProcess -eq $null)
            {
                Write-Verbose "No jobs completed, wait 500ms..."

                Start-Sleep -Milliseconds 500
                continue
            }

            Write-Verbose "Processing $($Jobs_ToProcess.Count + 1) job(s)..."

            # Processing completed jobs
            foreach($Job in $Jobs_ToProcess)
            {       
                # Get the result...     
                $Job_Result = $Job.Pipe.EndInvoke($Job.Result)
                $Job.Pipe.Dispose()

                # Remove job from collection
                $Jobs.Remove($Job)
            
                # Check if result is null --> if not, return it
                if($Job_Result -ne $null)
                {        
                    if($AssignVendorToMAC)
                    {                   
                        AssignVendorToMAC($Job_Result)
                    }
                    else 
                    {
                        $Job_Result
                    }                            
                }
            } 

        } While ($Jobs.Count -gt 0)

        Write-Verbose "Closing RunspacePool and free resources..."

        # Close the RunspacePool and free resources
        $RunspacePool.Close()
        $RunspacePool.Dispose()

        Write-Verbose "Script finished at $(Get-Date)"
    }

    End{
        
    }
}
