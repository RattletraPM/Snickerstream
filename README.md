# Snickerstream

Snickerstream is a completely new streaming client for NTR CFW. It aims to become
a complete NTRViewer replacement with lots of extra features, including stuff such
as better netcode, more screen layouts and less RAM usage. This is different than
kit-kat/NitroStream as the formers still uses NTRViewer as its internal streaming client while
Snickerstream has been completely written from scratch, making it the first real
NTR streaming client alternative (also, if you've tried UWPStreamer or cuteNTR then
you can say you've already tried Snickerstream in a way, as they used or have
previously used part of its code internally!)

Now, I hear you ask, why reinvent the wheel? Why make this if there's already something
that does a very similiar thing?

The reason is simple: I wanted to add some functions to NTRViewer, but some of the
stuff I had in mind simply wouldn't be possible without altering its source code, and
considering that NTRViewer wasn't properly updated in a while I took the opportunity
of making this complete rewrite.

Here are some of the improvements of Snickerstream over NTRViewer that are already
implemented:
- Real time screen scaling
- Pixel interpolation, which improves the image quality if the window has been scaled
- Way less RAM usage (about half less than NTRViewer and around a quarter of kit-kat)
- Better netcode, it will automatically try to recover any lost frames if needed
- No DLL files needed, as it uses the Windows API to draw the GUI and GDI+ to draw
the screens (keep in mind that kit-kat still uses DLLs, they just get extracted to a
temporary directory)
- Native x64 version for better performance on x64 computers
- MANY more screen layouts, such borderless fullscreen and inverted layouts (fullscreen
mode is currently experimental and might be very slow or not work at all on old computers.
If you want better performance, lower your desktop resolution.)
- More options that will make Snickerstream work better on crappy computers or networks
- Better default settings that will make streaming smoother on most networks
- Built-in screenshot function (press S while streaming to create a screenshot)

And here are some of the planned features:
- Command line arguments
- Built in NFC patching
- (Maybe) AVI recording function directly in the client

## Quick tutorial

This quick tutorial on how to use Snickerstream 0.6b PoC gives for granted that
you have installed NTR CFW on your New 3DS and you know how to get it up and running.

. Open NTR CFW. I strongly suggest you to use BootNTR, but anything that works for
you is going to be fine too.

. Make sure that you're connected to your Wi-Fi network and find your 3DS's local IP
address. There are a few ways to do this, for example:

- Open FTPD and look at the top screen (you don't need the port, aka the number after
the ":")
- Use FBI (go to Remote Install -> Recieve URLs over the network)
- Set a static IP address

. Insert your IP address and click on "Start remoteplay". 

. Click on connect!

Keep in mind that some games (such as Pokémon XY/ORAS/SUMO) require a NFC patch to be
streamed via NTR. You can apply this patch by downloading one for your game then
apply it via Luma CFW (or any other supported method) or by using NTR Debugger.

## Troubleshooting

* If you get a grey screen double check that Remoteplay has been started on your
3DS. Also double check that your 3DS's IP address is correct and that you've allowed
Snickerstream in Windows Firewall (or any firewall you may be using).

* If you get poor streaming performance try lowering the streaming quality or increasing
the QoS value.

* If you get poor performance while using fullscreen mode then lower your desktop
resolution. Please note that fullscreen is currently an experimental feature and might
not work well on old computers.

* If your antivirus detects it as a virus, be calm, it's a false positive. There's a reason
I made this tool open source and you can check by yourself that it isn't doing anything
nasty on your system (also, some crappy AVs see anything made with AutoIt as malicious.
If yours is doing that, then change your own to something that isn't Protegent-level,
pretty please =/ )

## Keyboard shortcuts

ESC: Close Snickerstream. You can also close the program by right-clicking on the
tray icon and selecting "Exit".

UP/DOWN ARROWS: Increase/Decrease scaling

LEFT/RIGHT ARROWS: Change interpolation settings

S: Take a screenshot

## How to compile
You need AutoIt v3.3.14.2 or later to compile Snickerstream.

After you've downloaded and installed AutoIt, clone this repo to your hard drive and
use Aut2Exe to compile SnickerstreamPOC.au3 to an EXE file or open it in SciTE to run
the script without compiling.

## Credits
Written by RattletraPM in AutoIt v3. Tested by Roman Sgarz and Silly Chip.
Donations aren't a necessity but they're highly appreciated! :D
Donations can be sent via:
* PayPal - lucapmATlive.it (replace AT with @)
* Bitcoin - 1MwsNoWiu2rHJbTNKWWhc25YpkZvmsFixN
* Monero - 439udJyDcr8hXrzjswx9pVEcefbph6osNU7mLAMpoabYZn77Bh9GtYBTNnVcjzvEHvdp9eTv7N8dmHUr6tyS5LXVLjaTEPp
