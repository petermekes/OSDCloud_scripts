# Webhook URL
$webhook = "https://13ba3236-2802-4923-854b-47bf3e4e203f.webhook.we.azure-automation.net/webhooks?token=M3jirVSnkIgIIUxM0v6n6j4fDs00Yn0c5SDPU%2fc7Y3I%3d"

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
