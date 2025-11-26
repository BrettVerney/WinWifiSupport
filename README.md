[![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/wifiwizardofoz/WinWifiSupport)

# WinWifiSupport
A simple Windows PowerShell script to determine a Wi-Fi adaptor's key capabilities

**Author:** Brett Verney (@wifiwizardofooz)</br>
**Version:** v1.3 | 27-11-2025

## Background
There are a number of key technologies that, if supported by a Wi-Fi adaptor may be explicitly enabled on the supporting Wi-Fi infrastructure. By filtering through the ```netsh wlan show``` command on a Windows machine, we can find the capabilities of the Wireless adaptor. This script simply finds the data that we need, and applies a little formatting to present it a little nicer.

## Usage
If not already set, enable PowerShell to run scripts by bypassing the default execution policy for the current user:<br>
```Set-ExecutionPolicy Bypass -Scope CurrentUser -Force```

Alternatively, you can bypass the execution policy for the current PowerShell session only:<br>
```Set-ExecutionPolicy Bypass -Scope Process -Force```

Execute the script:<br>
```.\WinWifiSupport.ps1```

## Output

You should see something similar to this:

![WinWifiSupport Output](https://github.com/wifiwizardofoz/WinWifiSupport/blob/master/winWifiSupport.PNG)

## Special Thanks
[Felipe Binotto](https://github.com/fbinotto) for helping me understand hashtables.
