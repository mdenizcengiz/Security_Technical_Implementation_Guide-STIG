.SYNOPSIS
    PowerShell remediation and a compliance test for WN10-CC-000275

.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000275

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Preventing users from sharing the local drives on their client computers to Remote Session Hosts that they access helps reduce possible exposure of sensitive data.
   
    PS C:\> .\WN10-CC-000275.ps1

#CODE 

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
New-Item -Path $path -Force | Out-Null
Set-ItemProperty -Path $path -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
# Optional: refresh policy processing for good measure
gpupdate /target:computer /force | Out-Null


$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$name = "NoAutoRebootWithLoggedOnUsers"

if (-not (Test-Path $path)) {
    Write-Output "❌ Non-compliant: $path does not exist."
    exit 1
}

$value = (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name

if ($value -eq 1) {
    Write-Output "✅ Compliant: $name = 1 (no auto-restart with logged-on users)."
    exit 0
} else {
    $shown = if ($null -eq $value) { "<missing>" } else { $value }
    Write-Output "❌ Non-compliant: $name is $shown (expected 1)."
    exit 1
}
