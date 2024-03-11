$userName = "wmsadmin"
$userexist = (Get-LocalUser).Name -Contains $userName
if($userexist -eq $false) {
  try{ 
     New-LocalUser -Name $username -Description "WingMen Solutions local admin account" -NoPassword
     Exit 0
   }   
  Catch {
     Write-error $_
     Exit 1
   }
}