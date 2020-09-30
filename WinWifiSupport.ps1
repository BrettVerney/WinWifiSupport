# Script by Brett Verney (@wifiwizardofoz)
# Contributors - Felipe Binotto (@fbinotto)
# Version: v1.0 | 30-09-2020
$wifi = (netsh wlan show all | findstr /c:"Firmware Version" /c:"DOT11k" /c:"Transition" /c:"MU-MIMO" /c:"Spatial Streams" /c:"Management Frames" /c:"Driver                    :" /c:"Vendor  " /c:"Provider" /c:"Date" /c:"Version                   :" /c:"Radio types"  /c:"SAE Authentication" /c:"WPA3 SUITE-B Authentication" /c:"WPA3 SUITE-B FIPS Mode" /c:"OWE Authentication").trim()
$objs = @()
foreach ($_ in $wifi) {
    $newobj = New-Object pscustomobject
    $newobj = $newobj | Select-Object Property, Value
    $newobj.Property = $_.split(":")[0]
    $newobj.Value = $_.split(":")[1].trim()
    $objs += $newobj
}
$objs
