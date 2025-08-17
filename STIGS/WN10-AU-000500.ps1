.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-17
    Last Modified   : 2025-08-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it, it will create registry that will set the maximum size for the event logs for Windows Application.
   
    PS C:\> .\WN10-AU-000500.ps1 

#CODE 

$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'; New-Item -Path $path -Force | Out-Null; New-ItemProperty -Path $path -Name MaxSize -PropertyType DWord -Value 0x00008000 -Force | Out-Null; Restart-Service -Name EventLog -Force
