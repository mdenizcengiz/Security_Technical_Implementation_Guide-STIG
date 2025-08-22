.SYNOPSIS
    The use of a hardware security device with Windows Hello for Business must be enabled.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000255.ps1 

#CODE 

<# WN10-CC-000255: Enforce hardware security device for Windows Hello for Business #>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"
$regName = "RequireHardwareSecurityDevice"
$regValue = 1

# Create path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply required value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: Windows Hello for Business requires a hardware security device."



$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"
$regName = "RequireHardwareSecurityDevice"
$expected = 1

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: Windows Hello for Business is configured to require a hardware security device."
        exit 0
    } else {
        Write-Host "FAIL: Registry found but incorrect value ($val). Should be $expected."
        exit 1
    }
} catch {
    Write-Host "FAIL: Setting not found. Hardware security device requirement may not be enforced."
    exit 1
}

