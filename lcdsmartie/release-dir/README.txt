

Please see our website for instructions and the latest information:
		http://lcdsmartie.sourceforge.net/

Alpha builds
============
These builds are believed to be stable but the developer(s) do not have access
to all supported LCD types and/or use all the features of LCD Smartie.

Increased error checking has been compiled in this build - so this build may
'fail' where the problem would have gone unnoticed in previous builds. By
reporting these bugs you will increase LCD Smartie's stability.

BUGS KNOWN
==========
See: http://sourceforge.net/tracker/?func=browse&group_id=122330&atid=693136

USB Palm users
==============
If you have any problems then email "usb <at> x5.me.uk" - 
stating your Palm make/model, PalmOS version and the usb.log file.

Changes
=======
5.3Beta1
	- Fixed screen timings, esp. when using GotoScreen action.
	- Fixed bug: only one $Chr was processed per a line.
5.3Alpha7
	- Fixed bug: action of GotoScreen(1) caused a crash.
	- Fixed some bugs in the action code.
	- Plugin support fixed.
	- Re-implemented HD44780 support [experimental - report all bugs].
	- Added switch to HD44780 section for alternative addressing used by
	  1 chip 1x16 displays (they are to be addressed like a 2x8 display).
5.3Alpha6
	- Crystalfontz: Experimental support for 631 & 633 displays; includes
	  keypad support.
	- Crystalfontz: new option, state if your display has a v1 or v2
	  cgrom. [Reduces wrongly mapped characters].
	- Rewritten serial code.
	- Fixed bug: Actions weren't being saved.
	- Fixed bug: Multiple presses of keys were being ignored.
	- Fixed bug: hanged when variable use had syntax error.
	- Improved: parameter checking of variables.
	- Fixed bug: Couldn't connect to some USB Palms.
5.3Alpha5
	- Removed delay when applying settings.
	- List only usable serial ports.
	- Fix closedown bug; where turing off the backlight, etc sometimes
	  didn't work.
	- USB Palm support rewritten.
5.3Alpha4
	- Fixed bug [1073921] Exception: Range Check (Rss)
	- Removed limit on the number of Rss feeds.
	- Fixed unwanted scrolling on Crystalfontz displays.
	- Fixed bug: duplicated USB Palm entries in COMport list.
	- Fixed bug: [1073684] Exception: Range check error (cpuspeed)
	- Fixed bug: asked for disk to be inserted when checking free space
	  of a removable drive.
	- Changed format of $UpTimes (from '12:34:56' to '12h 34m 56s'. Once
	  days appear it becomes '1d 3h 45m', etc).
	- Fixed bug: Uptimes wrapped every 7 days.
	- Extended uptime to work over 49.7 days.
5.3Alpha3
	- Actions moved from action.cfg to config.ini.
	- Fixed bug where some Crystalfontz display weren't working.
	- Fixed bug [1069517] Total downloaded limit at 4gb.
	- Fixed bug [1071793] Exception: Cannot focus a disabled or
	  invisible window.
	- Fixed bug [1070868] Minimise whilst in setup is broken.
	- Added config option to improve contrast fade; MinFadeContrast -
	  this defines the lowest point of the fade. LCDs often go blank
	  long before a contrast of 0 is reached and the fade can appear to
	  be doing nothing.
	- Support more USB Palms - needs PalmOrb 1.1a2 or above.
5.3Alpha2
	- Fixed 'Unable to locate the "Processor" performance object'
	  exception. [Also added FAQ entry for problem.]
	- Fixed hang when a screen has a syntax error.
5.3Alpha1
	- Fixed some Rss bugs also improved error reporting.
	- Fixed bug in contrast fade.
	- CPU speed is now live rather than fixed. [For speedstep, etc]
	- Fixed $PageU% - was always 0.
	- Fixed MO keypads.
	- USB Palms can now send keys.
5.3pAlpha4
	- Supports very large pagefiles and memory.
	- config.cfg/servers.cfg files replaced with config.ini file.
	  [actions.cfg is yet to be converted.]
	- fixed range error when selecting email account #10.
	- fixed -hide and -totalhide options.
	- support all network devices not just ethernet.
5.3pAlpha3
	- Added experimental USB Palm support (when used with PalmOrb)
	  [Serial Palm Support already existed.]
	- Fix range error with large pagefiles and/or memory; needs
          further work for memory/pagefiles over 4GB.
5.3pAlpha2
	- experimental support for Resuming after being in standby.
5.3pAlpha1
	- large internal code changes, to help make it more maintainable.
	- increased stability.
	- added Rss feed support.
	- added email last subject/from field.
	- fixed Seti/fold support.
	- added support for bug reports to be emailed.


ALPHA/Beta Releases
===================
It is advised that you backup your data before trying these builds.


FEEDBACK
========
The only way this program will get better is if you provide feedback. Tell
us if you find bugs - or find it to be bug free. Also tell us if there's a
feature you want, or if there's an existing feature that you don't like. 
Submit your feedback to the forums available on our website:
                      http://lcdsmartie.sourceforge.net/

Disclaimer
==========
We exclude ourselves from any liability howsoever arising for direct, indirect,
consequential, incidental, special or punitive damages of any kind or for loss
of revenue or profits, loss of business, loss of information or data or other
financial loss arising out of or in connection with use of LCD Smartie. Use of
LCD Smartie is expressly at users own risk.
