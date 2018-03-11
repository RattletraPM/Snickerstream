# Snickerstream

Snickerstream is a completely new streaming client for NTR CFW. It aims to become a complete NTRViewer replacement with lots of extra features, including stuff such as better netcode, more screen layouts and less RAM usage. This is different than kit-kat/NitroStream as the formers still uses NTRViewer as its internal streaming client while Snickerstream has been completely written from scratch, making it the first real NTR streaming client alternative (also, if you've tried UWPStreamer or cuteNTR then you can say you've already tried Snickerstream in a way, as they used or have previously used part of its code internally!)

Now, I hear you ask, why reinvent the wheel? Why make this if there's already something that does a very similiar thing?

The reason is simple: I wanted to add some functions to NTRViewer, but some of the stuff I had in mind simply wouldn't be possible without altering its source code, and considering that NTRViewer wasn't properly updated in a while I took the opportunity of making this complete rewrite.

Here are some of the improvements of Snickerstream over NTRViewer that are already implemented:
- Real time screen scaling
- Pixel interpolation, which improves the image quality if the window has been scaled
- Two rendering libraries are supported: Direct2D (hardware accelerated if available) and GDI+ (software only)
- Way less resource usage under Direct2D
- Better netcode, it will automatically try to recover any lost frames if needed
- No DLL files needed, as it uses the Windows API to draw the GUI and Direct2D/GDI+ to draw the screens (keep in mind that kit-kat still uses DLLs, they just get extracted to a temporary directory)
- Native x64 version for better performance on x64 computers
- MANY more screen layouts, such borderless fullscreen and inverted layouts
- More options that will make Snickerstream work better on crappy computers or networks
- Better default settings that will make streaming smoother on most networks
- Built-in screenshot function (press S while streaming to create a screenshot)
- Built in NFC patching
- 7 different remoteplay presets are available
- Automatic remoteplay init, so you only need to click connect and Snickerstream will care about everything else
- Auto-disconnects if the 3DS has stopped streaming (was shutdown/rebooted/etc, can be customized or disabled)
- Has a built-in frame limiter (disabled by default) if you wish to have a smoother stream
- It  will try allow itself through Windows Firewall if ran as admin

And here are some of the planned features:
- Command line arguments
- Some user-requested features
- (Maybe) AVI recording function directly in the client

## Quick tutorial

This quick tutorial on how to use Snickerstream 0.85b gives for granted that you have installed NTR CFW on your New 3DS and you know how to get it up and running.

* Open NTR CFW. I strongly suggest you to use BootNTR, but anything that works for you is going to be fine too.
* Make sure that you're connected to your Wi-Fi network and find your 3DS's local IP address. There are a few ways to do this, for example:
* Open FTPD and look at the top screen (you don't need the port, aka the number after
the ":")
* Use FBI (go to Remote Install -> Recieve URLs over the network)
* Click on connect!

Keep in mind that some games (such as Pokémon XY/ORAS/SUMO) require a NFC patch to be streamed via NTR. In order to stream these games make sure that your 3DS is connnected to the Wi-Fi network, click the "Send NFC patch" button and choose your firmware version. The NFC patch should work even if the game isn't running yet (as long as the 3DS didn't reboot/soft reset) but in case it doesn't, reach an area of the game that initializes the NFC routine (for example, after loading your savegame in the Pokémon games), press the home button, wait until your 3DS reconnects and then send the NFC patch again.

## Troubleshooting

* If you get a grey/black screen double check that Remoteplay has been started on your 3DS. Also double check that your 3DS's IP address is correct and that you've allowed Snickerstream in Windows Firewall (or any firewall you may be using).
* If you get poor streaming performance try lowering the streaming quality or increasing the QoS value.
* If your antivirus detects it as a virus, be calm, it's a false positive. There's a reason I made this tool open source and you can check by yourself that it isn't doing anything nasty on your system (also, some crappy AVs see anything made with AutoIt as malicious. If yours is doing that, then change your own to something that isn't Protegent-level, pretty please =/ )

## Keyboard shortcuts

ESC: Close Snickerstream. You can also close the program by right-clicking on the tray icon and selecting "Exit".

UP/DOWN ARROWS: Increase/Decrease scaling

LEFT/RIGHT ARROWS: Change interpolation settings

S: Take a screenshot

ENTER: Go back to the connection window

## How to compile
You need AutoIt v3.3.14.2 or later to compile Snickerstream.

After you've downloaded and installed AutoIt, clone this repo to your hard drive and use Aut2Exe to compile Snickerstream.au3 to an EXE file or open it in SciTE to run the script without compiling.

## F.A.Q.
You can see the F.A.Q. here: https://github.com/RattletraPM/Snickerstream/blob/master/FAQ.md
(It's a pretty long list, so that's why I'm not writing here directly)

## Credits
Written by RattletraPM in AutoIt v3. Tested by Roman Sgarz and Silly Chip.
Snickerstream uses the Direct2D and WIC UDFs written by trancexx and Eukalyptus.
Donations aren't a necessity but they're highly appreciated! :D
(Donations can be sent via
* PayPal - lucapm@live.it
* Bitcoin - 1MwsNoWiu2rHJbTNKWWhc25YpkZvmsFixN
* Monero - 439udJyDcr8hXrzjswx9pVEcefbph6osNU7mLAMpoabYZn77Bh9GtYBTNnVcjzvEHvdp9eTv7N8dmHUr6tyS5LXVLjaTEPp
