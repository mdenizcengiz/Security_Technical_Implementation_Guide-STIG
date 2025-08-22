.SYNOPSIS
    Virtualization-based protection of code integrity must be enabled.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000080

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000080.ps1 

#CODE 

<# WN10-SO-000080: Configure legal banner title #>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "LegalNoticeCaption"
$regValue = "Notice and Consent Banner"   # <-- Replace with your organization's required title

# Ensure path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType String -Force | Out-Null

Write-Host "Remediation applied: Legal banner title set to '$regValue'."



$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "LegalNoticeCaption"
$expected = "Notice and Consent Banner"   # <-- Replace with your required title

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: Legal banner title is correctly configured as '$val'."
        exit 0
    } else {
        Write-Host "FAIL: Legal banner title is set to '$val', expected '$expected'."
        exit 1
    }
} catch {
    Write-Host "FAIL: Legal banner title not configured."
    exit 1
}
