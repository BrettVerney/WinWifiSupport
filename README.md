# WinWifiSupport
A simple Windows PowerShell script to determine a Wi-Fi adaptor's key capabilities

**Author:** Brett Verney</br>
**Version:** v0.2 | 17-09-2020

## Background
There are a number of key technologies that, if supported by a Wi-Fi adaptor may be explicitly enabled on the supporting Wi-Fi infrastructure. By filtering the ```netsh wlan show``` command we can outpout the key information that we require, without having to sift through all of the data. This script filters that data and applies a little formatting.

## Usage
Within PowerShell, simply run the script:<br>
```.\WinWifiSupport.ps1```


## Output

You should see something similar to this:

![WinWifiSupport Output](https://github.com/wifiwizardofoz/WinWifiSupport/blob/master/winWifiSupport.PNG)
