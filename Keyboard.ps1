<#
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
#>

if ($GroupTag -eq 'TF-NL'){$Language = "nl-US"}
if ($GroupTag -eq 'TF-BE'){$Language = "fr-BE"}
if ($GroupTag -eq 'TF-DE'){$Language = "de-DE"}
if ($GroupTag -eq 'TF-LU'){$Language = "lb"}

Write-Host -ForegroundColor Green "Set keyboard language to $Language"

$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("$Language")

Set-WinUserLanguageList $LanguageList -Force

$LanguageList = Get-WinUserLanguageList
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-US'))
Set-WinUserLanguageList $LanguageList -Force
Start-Sleep -Seconds 5

