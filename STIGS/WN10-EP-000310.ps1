.SYNOPSIS
    Windows 10 Kernel (Direct Memory Access) DMA Protection must be enabled.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-EP-000310

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-EP-000310.ps1 

#CODE 

<# WN10-EP-000310: Enable Kernel DMA Protection #>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection"
$regName = "DeviceEnumerationPolicy"
$regValue = 0   # 0 = Block all external DMA devices until user logs on and device is unlocked

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: Kernel DMA Protection is enabled (DeviceEnumerationPolicy=$regValue)."






$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection"
$regName = "DeviceEnumerationPolicy"
$expected = 0

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: Kernel DMA Protection is enabled (DeviceEnumerationPolicy=0)."
        exit 0
    } else {
        Write-Host "FAIL: Kernel DMA Protection not properly configured. Found value: $val"
        exit 1
    }
} catch {
    Write-Host "FAIL: Registry key not set. Kernel DMA Protection is not enforced."
    exit 1
}
