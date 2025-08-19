.SYNOPSIS
    This STIG requires that local user accounts must not be listed on the logon screen of domain-joined Windows systems. Displaying local user accounts can provide attackers with information that may help in gaining unauthorized access.

.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197.ps1

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
This sets the EnumerateLocalUsers registry value to 0, which hides local user accounts on the sign-in screen of domain-joined machines.
   
    PS C:\> .\WN10-CC-000197.ps1 

#CODE 

# Turn off Microsoft consumer experiences (DisableWindowsConsumerFeatures = 1)
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1


# Check compliance for WN10-CC-000197 (DisableWindowsConsumerFeatures = 1)
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$regName = "DisableWindowsConsumerFeatures"

if (-not (Test-Path $regPath)) {
    Write-Output "❌ Non-compliant: registry path not found: $regPath"
    exit 1
}

$value = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue).$regName

if ($value -eq 1) {
    Write-Output "✅ Compliant: $regName = 1 (Microsoft consumer experiences turned off)."
    exit 0
} else {
    $shown = if ($null -eq $value) { "<missing>" } else { $value }
    Write-Output "❌ Non-compliant: $regName is $shown (expected 1)."
    exit 1
}
