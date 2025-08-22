.SYNOPSIS
    Printing over HTTP must be prevented.
.NOTES
    Author          : M. Deniz Cengiz
    LinkedIn        : linkedin.com/in/mdenizcengiz/
    GitHub          : github.com/mdenizcengiz
    Date Created    : 2025-08-22
    Last Modified   : 2025-08-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Enter below command into powershell and execute it.
   
    PS C:\> .\WN10-CC-000110.ps1 

#CODE 

<# WN10-CC-000110: Printing over HTTP must be prevented
   Enforce policy: Computer Config > Administrative Templates > Printers > "Turn off printing over HTTP" = Enabled
   Registry: HKLM\Software\Policies\Microsoft\Windows NT\Printers\DisableHTTPPrinting = 1
#>

# --- Enforce the GPO-backed registry key ---
$regPath = 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers'
$regName = 'DisableHTTPPrinting'
$regValue = 1

New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

# (Optional but recommended) disable the Windows feature that enables Internet Printing Client
# Comment out if you prefer to leave the feature installed.
try {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Internet-Print-Client' -NoRestart -ErrorAction Stop
} catch {
    Write-Verbose "Internet-Print-Client may already be disabled or not present: $($_.Exception.Message)"
}

# Optionally refresh policy (harmless if no domain GPOs)
# gpupdate /target:computer /force | Out-Null
Write-Host "Remediation for WN10-CC-000110 applied."


<# Simple compliance check for WN10-CC-000110
   PASS if DisableHTTPPrinting = 1
   BONUS PASS if Internet-Print-Client feature is not Enabled
   Exits 0 on PASS, 1 on FAIL
#>

$regPath = 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers'
$regName = 'DisableHTTPPrinting'
$pass = $false

# Check registry policy
try {
    $val = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop).$regName
    if ($val -eq 1) { $pass = $true }
} catch {
    $pass = $false
}

# Optional: also check the feature state (not strictly required by the STIG, but strengthens the control)
try {
    $feature = Get-WindowsOptionalFeature -Online -FeatureName 'Internet-Print-Client' -ErrorAction Stop
    $featureBlocked = ($feature.State -ne 'Enabled')
} catch {
    # If query fails, don't fail the whole test—treat as unknown/neutral
    $featureBlocked = $true
}

if ($pass) {
    if ($featureBlocked) {
        Write-Host "PASS: Printing over HTTP is prevented (DisableHTTPPrinting=1) and Internet Printing Client is not enabled."
    } else {
        Write-Host "PASS: Printing over HTTP is prevented (DisableHTTPPrinting=1). (Note: Internet Printing Client is still enabled.)"
    }
    exit 0
} else {
    Write-Host "FAIL: Printing over HTTP is NOT prevented. Expected DisableHTTPPrinting=1 under HKLM:\Software\Policies\Microsoft\Windows NT\Printers."
    exit 1
}

