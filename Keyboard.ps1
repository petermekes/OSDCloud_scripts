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

#if ($GroupTag -eq 'TF-NL'){$Language = "nl-US"}
#if ($GroupTag -eq 'TF-BE'){$Language = "fr-BE"}
#if ($GroupTag -eq 'TF-DE'){$Language = "de-DE"}
#if ($GroupTag -eq 'TF-LU'){$Language = "lb"}

if ($GroupTag -eq 'TF-NL'){
        $Language = 'nl-US'
        $code = '0409:00000409' 
        $code2 = '0409'
        }
if ($GroupTag -eq 'TF-BE'){
        $Language = 'fr-BE'
        $code = '080C:0000080C' 
        $code2 = '080C'
        }
if ($GroupTag -eq 'TF-DE'){
        $Language = 'de-DE'
        $code = '0407:00000407' 
        $code2 = '0407'
        }
if ($GroupTag -eq 'TF-LU'){
        $Language = 'lb'
        $code = '046e:0000046e' 
        $code2 = '046e'
        }

Write-Host -ForegroundColor Green "Set keyboard language to $Language"

reg add "HKCU\Control Panel\International\User Profile\$Language" /v $code /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\International\User Profile" /v InputMethodOverride /t REG_SZ /d $code /f
reg delete "HKCU\Control Panel\International\User Profile System Backup\en-US" /va /f
reg add "HKCU\Control Panel\International\User Profile System Backup\$Language" /v $code /t REG_DWORD /d 1 /f
reg delete "HKCU\Keyboard Layout\Preload" /va /f
reg add "HKCU\Keyboard Layout\Preload" /v 1 /t REG_SZ /d $code2 /f


#$LanguageList = Get-WinUserLanguageList
#$LanguageList.Add("$Language")

#Set-WinUserLanguageList $LanguageList -Force

#$LanguageList = Get-WinUserLanguageList
#$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-US'))
#Set-WinUserLanguageList $LanguageList -Force
Start-Sleep -Seconds 5

