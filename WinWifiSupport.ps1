# Script by Brett Verney (@wifiwizardofoz)
# Contributors - Felipe Binotto (@fbinotto)
# Version: v1.2

Write-Host "Script started..."

$driverFields = @(
    "Driver", "Vendor", "Provider", "Date", "Version", "Radio types supported",
    "FIPS 140-2 mode supported", "802.11w Management Frame Protection supported",
    "Number of supported bands"
)

$capabilityFields = @(
    "Firmware Version", "Network monitor mode", "Protected Management Frames",
    "DOT11k neighbor report", "Promiscuous Mode", "Extended Channel Switch Announcement",
    "MAC Randomization", "Fast Transition", "MU-MIMO", "BSS Transition (802.11v)",
    "SAE Authentication", "SAE Hash-to-Element Authentication", "WPA3 SUITE-B Authentication",
    "WPA3 SUITE-B FIPS Mode", "OWE Authentication", "FTM as Initiator", "MBO Support",
    "Number of Tx Spatial Streams", "Number of Rx Spatial Streams", "Co-existence Support"
)

# Parse selected netsh output lines using one generated pattern
function Get-NetshFields {
    param(
        [scriptblock]$Command,
        [string[]]$Fields
    )

    # Allow leading spaces because netsh output is padded
    $pattern = '^\s*(?<key>' + (($Fields | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')\s*:\s*(?<value>.*)$'

    & $Command |
        Select-String -Pattern $pattern |
        ForEach-Object {
            $m = $_.Matches[0]
            [PSCustomObject]@{
                Property = $m.Groups['key'].Value
                Value    = $m.Groups['value'].Value.Trim()
            }
        }
}

Write-Host "Extracting driver info..."
$driverData = Get-NetshFields { netsh wlan show drivers } $driverFields
Write-Host "Extracting capabilities info..."
$capabilitiesData = Get-NetshFields { netsh wlan show wirelesscapabilities } $capabilityFields

$orderedProperties = $driverFields + $capabilityFields

Write-Host "Ordering data..."
$orderedData = foreach ($property in $orderedProperties) {
    ($driverData + $capabilitiesData) | Where-Object { $_.Property -eq $property } | Select-Object -Last 1
}

Write-Host "Displaying data..."
$orderedData | Format-Table -Property Property, Value -AutoSize
Write-Host "Script completed."
