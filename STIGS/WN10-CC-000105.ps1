.SYNOPSIS
    This PowerShell script ensures users are prompted for a password when resuming from sleep while on battery, you must set a specific Windows Registry value.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000105

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it, it will create registry that will set the maximum size for the event logs for Windows Application.
   
    PS C:\> .\WN10-CC-000105.ps1 

#CODE 

# Set audit policy for logon events to Success and Failure
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
Write-Output " Audit policy updated: Logon events now log both Success and Failure."

# Get current audit policy for Logon events
$audit = auditpol /get /subcategory:"Logon" 2>$null | Select-String "Logon"

if ($audit -match "Success\s+Failure" -or $audit -match "Failure\s+Success") {
    Write-Output " Compliant: 'Logon' auditing includes both Success and Failure."
    exit 0
} else {
    Write-Output " Non-compliant: 'Logon' auditing does not include both Success and Failure."
    Write-Output $audit
    exit 1
}
$audit = auditpol /get /subcategory:"Logon" 2>$null | Select-String "Logon"

