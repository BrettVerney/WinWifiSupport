# Script by Brett Verney (@wifiwizardofoz)
# Contributors - Felipe Binotto (@fbinotto)
# Version: v1.5 | Updated to handle duplicate entries

Write-Host "Script started..."

# Function to parse 'netsh wlan show drivers' output
function Get-WlanDriversInfo {
    Write-Host "Extracting driver info..."
    $driverInfo = netsh wlan show drivers | Select-String -Pattern "Driver\s*:|Vendor\s*:|Provider\s*:|Date\s*:|Version\s*:|Radio types supported\s*:|FIPS 140-2 mode supported\s*:|802.11w Management Frame Protection supported\s*:|Number of supported bands\s*:"
    
    $driverObjs = @()
    foreach ($line in $driverInfo) {
        if ($line -match "^(.*?):\s*(.*)$") {
            $property = $matches[1].Trim()
            $value = $matches[2].Trim()

            $newobj = [PSCustomObject]@{
                Property = $property
                Value    = $value
            }
            $driverObjs += $newobj
        }
    }
    Write-Host "Driver info extracted."
    return $driverObjs
}

# Function to parse 'netsh wlan show wirelesscapabilities' output
function Get-WlanCapabilitiesInfo {
    Write-Host "Extracting capabilities info..."
    $capabilitiesInfo = netsh wlan show wirelesscapabilities | Select-String -Pattern "Firmware Version\s*:|Network monitor mode\s*:|Protected Management Frames\s*:|DOT11k neighbor report\s*:|Promiscuous Mode\s*:|Extended Channel Switch Announcement\s*:|MAC Randomization\s*:|Fast Transition\s*:|MU-MIMO\s*:|BSS Transition \(802.11v\)\s*:|SAE Authentication\s*:|SAE Hash-to-Element Authentication\s*:|WPA3 SUITE-B Authentication\s*:|WPA3 SUITE-B FIPS Mode\s*:|OWE Authentication\s*:|FTM as Initiator\s*:|MBO Support\s*:|Number of Tx Spatial Streams\s*:|Number of Rx Spatial Streams\s*:|Co-existence Support\s*:"

    $capabilitiesObjs = @()
    $seenProperties = @{}
    foreach ($line in $capabilitiesInfo) {
        if ($line -match "^(.*?):\s*(.*)$") {
            $property = $matches[1].Trim()
            $value = $matches[2].Trim()

            if ($seenProperties.ContainsKey($property)) {
                # Update the value if the property already exists
                foreach ($obj in $capabilitiesObjs) {
                    if ($obj.Property -eq $property) {
                        $obj.Value = $value
                    }
                }
            } else {
                $newobj = [PSCustomObject]@{
                    Property = $property
                    Value    = $value
                }
                $capabilitiesObjs += $newobj
                $seenProperties[$property] = $true
            }
        }
    }
    Write-Host "Capabilities info extracted."
    return $capabilitiesObjs
}

# Get Driver and Capabilities Information
$driverData = Get-WlanDriversInfo
$capabilitiesData = Get-WlanCapabilitiesInfo

# Combine Data and maintain order
$combinedData = $driverData + $capabilitiesData

# Custom ordering
$orderedProperties = @(
    "Driver", "Vendor", "Provider", "Date", "Version", "Firmware Version", "Radio types supported", 
    "FIPS 140-2 mode supported", "802.11w Management Frame Protection supported", "Number of supported bands", 
    "Network monitor mode", "Protected Management Frames", "DOT11k neighbor report", "Promiscuous Mode", 
    "Extended Channel Switch Announcement", "MAC Randomization", "Fast Transition", "MU-MIMO", 
    "BSS Transition (802.11v)", "SAE Authentication", "SAE Hash-to-Element Authentication", 
    "WPA3 SUITE-B Authentication", "WPA3 SUITE-B FIPS Mode", "OWE Authentication", "FTM as Initiator", 
    "MBO Support", "Number of Tx Spatial Streams", "Number of Rx Spatial Streams", "Co-existence Support"
)

Write-Host "Ordering data..."
$orderedData = @()
foreach ($property in $orderedProperties) {
    $orderedData += $combinedData | Where-Object { $_.Property -eq $property }
}

Write-Host "Displaying data..."
# Display Data
$orderedData | Format-Table -Property Property, Value -AutoSize
Write-Host "Script completed."
