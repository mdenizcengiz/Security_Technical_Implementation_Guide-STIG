.SYNOPSIS
   Administrator accounts must not be enumerated during elevation.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000200

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000200.ps1 

#CODE 

<# WN10-CC-000200: Prevent administrator account enumeration during elevation #>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$regName = "EnumerateAdministrators"
$regValue = 0

# Create the registry key if missing
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: Administrator accounts will NOT be enumerated during elevation (EnumerateAdministrators=0)."




$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$regName = "EnumerateAdministrators"
$expected = 0

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: Administrator account enumeration is disabled (EnumerateAdministrators=0)."
        exit 0
    } else {
        Write-Host "FAIL: Administrator accounts may still be enumerated. Found value: $val"
        exit 1
    }
} catch {
    Write-Host "FAIL: Setting not found. Administrator accounts may still be enumerated."
    exit 1
}
