.SYNOPSIS
    Windows 10 account lockout duration must be configured to 15 minutes or greater.
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
   
    PS C:\> .\WN10-CC-000005.ps1 

#CODE 

# WN10-AC-000005: Set Account Lockout Duration to at least 15 minutes

# Set lockout duration to 15 minutes (minimum requirement)
net accounts /lockoutduration:15

Write-Host "Remediation applied: Account lockout duration set to 15 minutes."




# Test the account lockout duration
$duration = (net accounts) | Select-String "Lockout duration"
$minutes = ($duration -split ":")[1].Trim() -as [int]

if ($minutes -ge 15) {
    Write-Host "PASS: Account lockout duration is $minutes minutes (>=15)."
    exit 0
} else {
    Write-Host "FAIL: Account lockout duration is $minutes minutes (<15)."
    exit 1
}
