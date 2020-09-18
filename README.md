# WinWifiSupport
A simple Windows PowerShell script to determine a Wi-Fi adaptor's key capabilities

**Author:** Brett Verney</br>
**Version:** v0.2 | 17-09-2020

## Background
There are a number of key technologies that, if supported by a Wi-Fi adaptor may be explicitly enabled on the supporting Wi-Fi infrastructure. By filtering through the ```netsh wlan show``` command on a Windows machine, we can find the capabilities of the Wireless adaptor. This script simply finds the data that we need, and applies a little formatting to present it a little nicer.

## Usage
Within PowerShell, simply run the script:<br>
```.\WinWifiSupport.ps1```


## Output

You should see something similar to this:

![WinWifiSupport Output](https://github.com/wifiwizardofoz/WinWifiSupport/blob/master/winWifiSupport.PNG)

## Special Thanks
Felipe Binotto(https://github.com/fbinotto) for helping me with the text alignment/columns
