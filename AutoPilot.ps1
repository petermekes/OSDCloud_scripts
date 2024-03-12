#===============================================
#  Params AutoPilot
#===============================================
$grouptag = "AEF-Personal"
$tenant = 'c3e96bd4-6b32-4bf0-9770-c830983b5d7a'
$clientid = '41271e57-378c-4210-b274-7c08282f68d2'
$clientSecret = 'kg88Q~dwe6G0e-NIyvEhKIupdZKlWk36hs43fbkw'
Set-ExecutionPolicy -ExecutionPolicy Bypass
Install-Script -Name Get-WindowsAutoPilotInfo 

Get-WindowsAutoPilotInfo.ps1 -Online -Assign -groupTag $grouptag -TenantId $tenant -AppId $clientid -AppSecret $clientSecret