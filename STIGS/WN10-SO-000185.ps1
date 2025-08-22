.SYNOPSIS
    PKU2U authentication using online identities must be prevented.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000185
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-SO-000185.ps1 

<# WN10-SO-000185: Disable PKU2U online identity authentication #>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA\pku2u"
$regName = "AllowOnlineID"
$regValue = 0

# Create registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the required value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: PKU2U online identity authentication is disabled (AllowOnlineID=0)."



$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA\pku2u"
$regName = "AllowOnlineID"
$expected = 0

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: PKU2U online identity authentication is prevented (AllowOnlineID=0)."
        exit 0
    } else {
        Write-Host "FAIL: Found AllowOnlineID=$val, expected $expected."
        exit 1
    }
} catch {
    Write-Host "FAIL: Registry key not found. PKU2U online identity authentication may still be enabled."
    exit 1
}
