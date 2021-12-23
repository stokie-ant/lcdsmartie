# LCD Smartie
### From [wikipedia.org/wiki/LCD_Smartie](https://wikipedia.org/wiki/LCD_Smartie)
>LCD Smartie is open-source software for Microsoft Windows which allows a character LCD to be used as an auxiliary display device for a PC.
Supported devices include displays based on the Hitachi HD44780 Controller, the Matrix Orbital Serial/USB LCD, and Palm OS devices (when used in conjunction with PalmOrb).
The program has built in support for many systems statistics (i.e. cpu load, network utilization, free disk space...), downloading RSS feeds, Winamp integration and support for several other popular applications.
To support less common applications LCD Smartie uses a powerful plugin system.

### About This Repo
After having no updates for a little over 10 years and very little activity on the lcd smartie forums it seems that the original project has been abandoned by its developers.
I have therefore forked from the original project and have added some fixes and improvements.

### Issues
While there is much information on the lcd smartie forums, any issues with this fork should be reported here. It's high likely you wouldn't get a reply over there anyway.

### New Features and Fixes
- More screens - You can now have up to 99 - It was annoying getting an idea for another screen then realising that an old one had to go
- More Email accounts - Up to 99 can be monitored - once upon a time 10 email addresses were enough for me too
- Email SSL is now working - Tested with Gmail and Outlook
- Fixed the SSL code for HTTPS RSS feeds too - With the last official release, the only default feed still working was BBC News
- Custom character editor - It wasn't that difficult before but now it's even easier to create custom characters
- Stats for more network adapters - latest versions of windows install many virtual network adapters my windows 10 computer has over 40 but there was a limit of 10 adapters stats that could be used now it's 99. Also - 
- A Button to list the index of network adapters - beats going through them one by one to find the one you want
- Fetching local ip address has been fixed - Before it would just fetch the first one it found which was a problem if a virtual adapter with an address assigned has a lower index than the physical interface. Now it's per adapter
- Detect if screen saver is active - Can be used with actions to turn off the display or show another screen or theme
- Detect if a full screen app is running - Again as above can be used with actions to set another screen
- Detect if a full screen 3D game is running - maybe use actions to set a screen or theme showing temperatures
- Buttons to rearrange screens - Copy to/move to/swap with another screen
- Remote screen function - Network receive screen data from another smartie
- Folding@home stats fixed - Added some new stats too
- Many more under the hood fixes

### Roadmap
As I'm only one man that does this in my spare time I probably will not get to work on it as much as I'd like but, I will try to bring fixes and updates as often as i can.  
Seti@home is currently in hibernation. I don't know if it will ever return but I'll look at converting its code to support boinc in general. 
The URL fetch code is limited to just HTTP GET. I will be looking to add support for POST requests too.

### Get LCDSmartie
download here - [latest](https://github.com/stokie-ant/lcdsmartie/releases/tag/v5.5.0.0-alpha)

### Building
see the file [BUILDING.txt](BUILDING.txt)

