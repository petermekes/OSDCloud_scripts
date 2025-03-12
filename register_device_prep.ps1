# Webhook URL
if (!($GroupTag)){
$webhook = "https://63f47c38-570a-4db2-b9bd-ca91bd1b022b.webhook.we.azure-automation.net/webhooks?token=Y%2f6JUVkYmuE%2bsGR5xZrUwiDOPLF3rSG0fK5kVhlSo30%3d"

# Get the computer system and BIOS information
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$bios = Get-CimInstance -ClassName Win32_BIOS

# Create the JSON payload
$webhookData = @{
    manufacturer = $computerSystem.Manufacturer
    model = $computerSystem.Model
    serialNumber = $bios.SerialNumber
} | ConvertTo-Json

# Upload the device identity
Invoke-WebRequest -Method POST -Uri $webhook -Body $webhookData -UseBasicParsing
Write-host "APv2 is done" 
}
sleep -Seconds 5
