.SYNOPSIS
    NTLM must be prevented from falling back to a Null session.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-SO-000180.ps1 

#CODE 

<# WN10-SO-000180: Prevent NTLM from falling back to a Null session #>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
$regName = "allownullsessionfallback"
$regValue = 0

# Create registry key if missing
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply required value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: NTLM will not fall back to Null sessions (allownullsessionfallback=0)."



$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
$regName = "allownullsessionfallback"
$expected = 0

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: NTLM fallback to Null session is prevented (allownullsessionfallback=0)."
        exit 0
    } else {
        Write-Host "FAIL: NTLM fallback setting incorrect. Found $val, expected $expected."
        exit 1
    }
} catch {
    Write-Host "FAIL: Registry key not found. NTLM may still allow Null session fallback."
    exit 1
}

