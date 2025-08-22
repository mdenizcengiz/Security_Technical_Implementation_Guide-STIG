.SYNOPSIS
    The password history must be configured to 24 passwords remembered.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it, it will create registry that will set the maximum size for the event logs for Windows Application.
   
    PS C:\> .\WN10-AC-000020.ps1 

#CODE 

# STIG: WN10-AC-000020
# Enforce workstation lock after 15 minutes of inactivity

$regPath = "HKCU:\Control Panel\Desktop"

# Set screensaver timeout to 900 seconds (15 min)
Set-ItemProperty -Path $regPath -Name "ScreenSaveTimeOut" -Value "900"

# Enable screensaver (must be enabled for timeout to apply)
Set-ItemProperty -Path $regPath -Name "ScreenSaveActive" -Value "1"

# Force lock on resume
Set-ItemProperty -Path $regPath -Name "ScreenSaverIsSecure" -Value "1"



$path = "HKCU:\Control Panel\Desktop"

$timeout = (Get-ItemProperty -Path $path -Name "ScreenSaveTimeOut" -ErrorAction SilentlyContinue).ScreenSaveTimeOut
$active = (Get-ItemProperty -Path $path -Name "ScreenSaveActive" -ErrorAction SilentlyContinue).ScreenSaveActive
$secure = (Get-ItemProperty -Path $path -Name "ScreenSaverIsSecure" -ErrorAction SilentlyContinue).ScreenSaverIsSecure

if ($timeout -eq "900" -and $active -eq "1" -and $secure -eq "1") {
    Write-Output "Compliant: Screen saver lock is enforced after 15 minutes of inactivity."
    exit 0
} else {
    Write-Output " Non-compliant:"
    Write-Output "  ScreenSaveTimeOut = $timeout (expected: 900)"
    Write-Output "  ScreenSaveActive = $active (expected: 1)"
    Write-Output "  ScreenSaverIsSecure = $secure (expected: 1)"
    exit 1
}
