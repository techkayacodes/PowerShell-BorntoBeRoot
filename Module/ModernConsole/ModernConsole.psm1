##################################################################################################################
### Set some Variables
##################################################################################################################

# Check if console was started as admin
if(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] “Administrator”))
{
	$Admin = "**Admin** "
	$AdminTitle = "Administrator: "
}

# Get IPv4 Address
$ipaddress = [System.Net.DNS]::GetHostByName($null)
foreach($ip in $ipaddress.AddressList)
{
	if ($ip.AddressFamily -eq 'InterNetwork')
	  {
		$ModernConsole_IPv4Address = $ip.IPAddressToString
		break
	}
}

##################################################################################################################
### Setup Console Window
##################################################################################################################

$Shell = $Host.UI.RawUI
$Shell.WindowTitle = $AdminTitle + "Modern PowerShell by BornToBeRoot"

$Size = $Shell.WindowSize
$Size.width=120
$Size.height=35
$Shell.WindowSize = $Size

$Size = $Shell.BufferSize
$Size.width=120
$Size.height=5000
$Shell.BufferSize = $Size

$Shell.BackgroundColor = "Black"
$Shell.ForegroundColor = "Gray"

##################################################################################################################
### Console Startup / Clear-Host text
##################################################################################################################  
function Write-Startup {
	$EmptyConsoleText = @"
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
|                                    ____                 _____     ____       ____             _     |
|    SS                             | __ )  ___  _ __ _ _|_   _|__ | __ )  ___|  _ \ ___   ___ | |_   |
|    SSSSS                          |  _ \ / _ \| '__| '_ \| |/ _ \|  _ \ / _ \ |_) / _ \ / _ \| __|  |
|    SSSSSSSS                       | |_) | (_) | |  | | | | | (_) | |_) |  __/  _ < (_) | (_) | |_   |
|    SSSSSSSSSSS                    |____/ \___/|_|  |_| |_|_|\___/|____/ \___|_| \_\___/ \___/ \__|  |
|       SSSSSSSSSSS                                                                                   |
|          SSSSSSSSSSS              +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
|             SSSSSSSSSSS           |  
|              SSSSSSSSSS           |   Domain\Username    :    $env:USERDOMAIN\$env:USERNAME
|             SSSSSSSSSSS           |   ComputerName       :    $env:COMPUTERNAME
|          SSSSSSSSSSS              |   IPv4-Address       :    $ModernConsole_IPv4Address  
|       SSSSSSSSSSS                 |   PSVersion          :    $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)
|    SSSSSSSSSSS                    |   Date & Time        :    $(Get-Date -Format g)  
|    SSSSSSSS                       |
|    SSSSS      SSSSSSSSSSSSSSS     +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
|    SS      SSSSSSSSSSSSSSS                                              Follow me on GitHub         |
|                                                                  [https://GitHub.com/BornToBeRoot]  |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+

"@

	Write-Host $EmptyConsoleText
}

##################################################################################################################
### Overwrite default function "Clear-Host"
##################################################################################################################
function Clear-Host {
	$space = New-Object System.Management.Automation.Host.BufferCell
	$space.Character = ' '
	$space.ForegroundColor = $host.ui.rawui.ForegroundColor
	$space.BackgroundColor = $host.ui.rawui.BackgroundColor
	$rect = New-Object System.Management.Automation.Host.Rectangle
	$rect.Top = $rect.Bottom = $rect.Right = $rect.Left = -1
	$origin = New-Object System.Management.Automation.Host.Coordinates
	$Host.UI.RawUI.CursorPosition = $origin
	$Host.UI.RawUI.SetBufferContents($rect, $space)

	Write-Startup
}

Clear-Host

##################################################################################################################
### Overwrite default function "prompt"
##################################################################################################################
function prompt {
    $Path = Get-Location
    $CurrentFolder = Split-Path -Leaf -Path $Path

    # Is path a netowrk share?
    if($Path.ToString().StartsWith("Microsoft.PowerShell.Core\FileSystem"))
    {
        $NetworkShare = $Path.ToString().Split(":")[2].Replace("\\","")
        
        $Hostname = $NetworkShare.Split('\')[0]
        $Share = $NetworkShare.Split('\')[1]
                      
        $RootPath = "\\$Hostname\$Share"
    }
    else
    {
        $DriveLetter = Split-Path -Path $Path -Qualifier
        $RootPath = "$DriveLetter"
    }
		
    if(([String]::IsNullOrEmpty($CurrentFolder)) -or ($CurrentFolder.EndsWith('\')))
    {
        $Folder = "\"
    }    
	else
	{    
        $Folder = "$CurrentFolder"
    }
    
	
	Write-Host "$Admin" -NoNewline -ForegroundColor Red
	Write-Host "[" -NoNewline -ForegroundColor Gray
    Write-Host "$RootPath" -NoNewline -ForegroundColor Green
    Write-Host "] " -NoNewline -ForegroundColor Gray
    Write-Host "$Folder" -NoNewline -ForegroundColor Yellow
    Write-Host " ~#" -NoNewline -ForegroundColor Gray
	return " "
}