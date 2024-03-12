$Global:Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Set-KeyboardLanguage.log"
Start-Transcript -Path (Join-Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\OSD\" $Global:Transcript) -ErrorAction Ignore

Write-Host -ForegroundColor Green "Set keyboard language to NL-us"
Start-Sleep -Seconds 5

$LanguageList = Get-WinUserLanguageList

$LanguageList.Add("nl-us")
Set-WinUserLanguageList $LanguageList -Force

Start-Sleep -Seconds 5

$LanguageList = Get-WinUserLanguageList
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'de-DE'))
Set-WinUserLanguageList $LanguageList -Force

$LanguageList = Get-WinUserLanguageList
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-US'))
Set-WinUserLanguageList $LanguageList -Force

Stop-Transcript
