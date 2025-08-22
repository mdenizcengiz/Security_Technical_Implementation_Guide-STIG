.SYNOPSIS
    The system must be configured to audit Detailed Tracking - Process Creation successes.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000050

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-AU-000050.ps1 

#CODE 

# WN10-CC-000005: Disable camera on the lock screen
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "NoLockScreenCamera" -Type DWord -Value 1
gpupdate /target:computer /force | Out-Null
Write-Output "Set NoLockScreenCamera=1 (camera disabled on the lock screen)."
