.SYNOPSIS
    This policy controls whether a domain user can sign in using a convenience PIN to prevent enabling (Password Stuffer).
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it, it will setup the valuo 0.
   
    PS C:\> .\WN10-CC-000370.ps1 

#CODE 

New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Force
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "AllowDomainPINLogon" -Type DWord -Value 0
