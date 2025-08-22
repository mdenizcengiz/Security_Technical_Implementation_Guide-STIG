.SYNOPSIS
    Attachments must be prevented from being downloaded from RSS feeds.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000295.ps1 

#CODE 

$regPath = "HKCU:\Software\Policies\Microsoft\Internet Explorer\Feeds"
$regName = "DisableEnclosureDownload"
$regValue = 1

# Create the registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the required value
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "Remediation applied: Attachments from RSS feeds cannot be downloaded (DisableEnclosureDownload=1)."






$regPath = "HKCU:\Software\Policies\Microsoft\Internet Explorer\Feeds"
$regName = "DisableEnclosureDownload"
$expected = 1

try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq $expected) {
        Write-Host "PASS: RSS feed attachment downloads are disabled (DisableEnclosureDownload=1)."
        exit 0
    } else {
        Write-Host "FAIL: RSS feed attachment downloads are NOT disabled. Found value: $val"
        exit 1
    }
} catch {
    Write-Host "FAIL: Setting not found. RSS feed attachments may still be downloadable."
    exit 1
}
