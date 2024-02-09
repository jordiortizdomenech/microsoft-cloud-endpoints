$param($username="kiosklogon0@casarover.net",$password)
#https://www.reddit.com/r/Intune/comments/1ajh1lc/automatic_logon_broken_on_full_entra_joined/

$u = $username
$p = $password
$path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# You can make a Powershell remediation script that sets the following values in the registry in key 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon':
#   DefaultUserName (REG_SZ) : user account UPN (e.g. user@domain.com)
#   DefaultPassword (REG_SZ) : plain text version of the password (e.g. VeryS3cur3PW!)
#   DefaultDomainName (REG_SZ) : empty string (as no domain connectivity is required for Entra ID logins)
#   AutoAdminLogon (DWORD) : 0x1

if (-Not (Test-Path $path)) { New-Item -Path $path -Force -ErrorAction SilentlyContinue }

New-ItemProperty -Path $path -Name "DefaultUserName"   -Value $u   -PropertyType String -Force
New-ItemProperty -Path $path -Name "DefaultPassword"   -Value $p   -PropertyType String -Force
New-ItemProperty -Path $path -Name "DefaultDomainName" -Value ""   -PropertyType String -Force
#New-ItemProperty -Path $path -Name "DefaultDomainName" -Value "AzureAD"   -PropertyType String -Force
#New-ItemProperty -Path $path -Name "DefaultDomainName" -Value $null   -PropertyType String -Force
New-ItemProperty -Path $path -Name "AutoAdminLogon" -Value 1    -PropertyType DWord  -Force

#while (-not (test-connection www.msftconnecttest.com -verbose -count 1 )) { start-sleep 1 }
#Restart-Computer -Force
