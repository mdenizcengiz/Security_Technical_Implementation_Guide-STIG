.SYNOPSIS
    Internet Explorer 11 (IE11) is no longer supported on Windows 10 semi-annual channel.

.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000391
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it, This implements the “Disable Internet Explorer 11 as a standalone browser” policy via registry (ADMX-backed under inetres.admx), and selects Never for the notification option.
    PS C:\> .\WN10-CC-000391
#CODE 

# Run as Administrator
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
New-Item -Path $regPath -Force | Out-Null
# Enable the policy and choose the "Never" notify option
# 0 = Never, 1 = Always, 2 = Once per user
Set-ItemProperty -Path $regPath -Name "NotifyDisableIEOptions" -Type DWord -Value 0
gpupdate /target:computer /force | Out-Null
