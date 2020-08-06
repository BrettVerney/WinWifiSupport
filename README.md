# WinWifiSupport
A simple Microsoft Windows command to determine a Wi-Fi adaptor's key capabilities

**Author:** Brett Verney</br>
**Version:** v0.1 | 6-08-2020

## Background
There are a number of key technologies that, if supported by a Wi-Fi adaptor may be explicitly enabled on the supporting Wi-Fi infrastructure. By filtering the ```netsh wlan show``` command we can outpout the key information that we require, without having to sift through all of the data.

## Command
```netsh&nbspwlan&nbspshow&nbspall&nbsp|&nbspfindstr&nbsp/c:"Firmware&nbspVersion"&nbsp/c:"DOT11k"&nbsp/c:"Transition"&nbsp/c:"MU-MIMO"&nbsp/c:"Spatial&nbspStreams"&nbsp/c:"Management&nbspFrames"&nbsp/c:"Driver&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:"&nbsp/c:"Vendor&nbsp&nbsp"&nbsp/c:"Provider"&nbsp/c:"Date"&nbsp/c:"Version&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:"&nbsp/c:"Radio&nbsptypes"```

## Output

You should see something similar to this:

![WinWifiSupport Output](https://github.com/wifiwizardofoz/WinWifiSupport/blob/master/winWifiSupport.PNG)
