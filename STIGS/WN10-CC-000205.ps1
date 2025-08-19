.SYNOPSIS
    Authentication must be required when resuming from sleep to prevent unauthorized access. This STIG ensures that the system prompts for a password when waking from sleep while plugged in (AC power).

.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-17
    Last Modified   : 2025-08-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000205.ps1
#CODE 
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 1
gpupdate /target:computer /force



#TEST

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$regName = "AllowTelemetry"

if (Test-Path $regPath) {
    $value = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue).$regName
    if ($value -eq 1) {
        Write-Output "✅ STIG WN10-CC-000205 is compliant (AllowTelemetry = 1, Basic)."
    }
    else {
        Write-Output "❌ Non-compliant. AllowTelemetry is set to $value (expected 1)."
    }
} else {
    Write-Output "❌ Non-compliant. Registry path does not exist."
}

✅ STIG WN10-CC-000205 is compliant (AllowTelemetry = 1, Basic).

PS C:\Users\mdclabuser> 
